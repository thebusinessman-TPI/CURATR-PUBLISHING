# CURATR Content Archive - R2 Upload Script
# Uploads 216 video/HTML pairs to Cloudflare R2
# Location: Save this to C:\Development\scripts\Upload-ContentToR2.ps1

param(
    [switch]$DryRun = $false,
    [switch]$VideosOnly = $false,
    [switch]$HTMLOnly = $false
)

# Configuration
$R2_ACCOUNT_ID = "3c7ffdc93a2c1ecf4e4d116df98c7852"
$R2_ACCESS_KEY_ID = "35930bc87a2f3ebf43ff79c76c8dd69f"
$R2_SECRET_ACCESS_KEY = "b56cac2ab8a5c1703c7aef20407d952d70850210ef206c4db569762b67ac40e0"
$R2_ENDPOINT = "https://$R2_ACCOUNT_ID.r2.cloudflarestorage.com"
$BUCKET_NAME = "curatr-content-archive"

$VIDEO_PATH = "C:\curatr\CURATR_Content_Engine\outputs\videos\merged"
$HTML_PATH_GDRIVE = "G:\Shared drives\CURATR Content-Marketing\Content Output\2025\09-September\approved"
$MANIFEST_URL = "https://$R2_ENDPOINT/$BUCKET_NAME/metadata/matching_results.json"

Write-Host "`n" ("="*80) -ForegroundColor Cyan
Write-Host "CURATR CONTENT ARCHIVE - R2 UPLOAD SCRIPT" -ForegroundColor Cyan
Write-Host ("="*80) "`n" -ForegroundColor Cyan

# Check if AWS CLI is installed
Write-Host "Checking for AWS CLI..." -ForegroundColor Yellow
$awsInstalled = Get-Command aws -ErrorAction SilentlyContinue

if (-not $awsInstalled) {
    Write-Host "ERROR: AWS CLI is not installed!" -ForegroundColor Red
    Write-Host "`nPlease install AWS CLI:" -ForegroundColor Yellow
    Write-Host "  1. Download from: https://aws.amazon.com/cli/" -ForegroundColor White
    Write-Host "  2. Or use winget: winget install Amazon.AWSCLI" -ForegroundColor White
    Write-Host "  3. Restart PowerShell after installation`n" -ForegroundColor White
    exit 1
}

Write-Host "  AWS CLI found!" -ForegroundColor Green

# Configure AWS CLI for R2
Write-Host "`nConfiguring AWS CLI for Cloudflare R2..." -ForegroundColor Yellow
$env:AWS_ACCESS_KEY_ID = $R2_ACCESS_KEY_ID
$env:AWS_SECRET_ACCESS_KEY = $R2_SECRET_ACCESS_KEY
$env:AWS_DEFAULT_REGION = "auto"

# Download matching results from R2
Write-Host "Downloading matching results from R2..." -ForegroundColor Yellow
$matchingResultsPath = "$env:TEMP\matching_results.json"

try {
    aws s3api get-object `
        --bucket $BUCKET_NAME `
        --key "metadata/matching_results.json" `
        $matchingResultsPath `
        --endpoint-url $R2_ENDPOINT | Out-Null
    
    Write-Host "  Downloaded matching results" -ForegroundColor Green
} catch {
    Write-Host "  ERROR: Could not download matching results: $_" -ForegroundColor Red
    exit 1
}

# Load matching results
$matchingResults = Get-Content $matchingResultsPath | ConvertFrom-Json
$matchedPairs = $matchingResults.matched_pairs

Write-Host "`nMatched pairs to upload: $($matchedPairs.Count)" -ForegroundColor Cyan

if ($DryRun) {
    Write-Host "`n[DRY RUN MODE - No files will be uploaded]`n" -ForegroundColor Yellow
}

# Upload videos
if (-not $HTMLOnly) {
    Write-Host "`n" ("="*80) -ForegroundColor Cyan
    Write-Host "UPLOADING VIDEOS" -ForegroundColor Cyan
    Write-Host ("="*80) "`n" -ForegroundColor Cyan
    
    $videoCount = 0
    $videoErrors = 0
    
    foreach ($pair in $matchedPairs) {
        $videoFile = $pair.video_filename
        $localVideoPath = Join-Path $VIDEO_PATH $videoFile
        $s3Key = "videos/$videoFile"
        
        if (-not (Test-Path $localVideoPath)) {
            Write-Host "  [SKIP] Video not found: $videoFile" -ForegroundColor Yellow
            $videoErrors++
            continue
        }
        
        $videoCount++
        $progress = [math]::Round(($videoCount / $matchedPairs.Count) * 100, 1)
        Write-Host "[$videoCount/$($matchedPairs.Count)] ($progress%) Uploading: $videoFile" -ForegroundColor White
        
        if (-not $DryRun) {
            try {
                aws s3 cp $localVideoPath "s3://$BUCKET_NAME/$s3Key" `
                    --endpoint-url $R2_ENDPOINT `
                    --content-type "video/mp4" `
                    --no-progress 2>&1 | Out-Null
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "    Uploaded successfully" -ForegroundColor Green
                } else {
                    Write-Host "    ERROR uploading video" -ForegroundColor Red
                    $videoErrors++
                }
            } catch {
                Write-Host "    ERROR: $_" -ForegroundColor Red
                $videoErrors++
            }
        }
    }
    
    Write-Host "`nVideo Upload Summary:" -ForegroundColor Cyan
    Write-Host "  Uploaded: $($videoCount - $videoErrors)" -ForegroundColor Green
    Write-Host "  Errors: $videoErrors" -ForegroundColor $(if ($videoErrors -gt 0) { "Red" } else { "Green" })
}

# Upload HTML files
if (-not $VideosOnly) {
    Write-Host "`n" ("="*80) -ForegroundColor Cyan
    Write-Host "UPLOADING HTML FILES" -ForegroundColor Cyan
    Write-Host ("="*80) "`n" -ForegroundColor Cyan
    
    $htmlCount = 0
    $htmlErrors = 0
    
    foreach ($pair in $matchedPairs) {
        $htmlFileName = $pair.html_file.name
        $localHTMLPath = Join-Path $HTML_PATH_GDRIVE $htmlFileName
        $s3Key = "content/$htmlFileName"
        
        if (-not (Test-Path $localHTMLPath)) {
            Write-Host "  [SKIP] HTML not found: $htmlFileName" -ForegroundColor Yellow
            $htmlErrors++
            continue
        }
        
        $htmlCount++
        $progress = [math]::Round(($htmlCount / $matchedPairs.Count) * 100, 1)
        Write-Host "[$htmlCount/$($matchedPairs.Count)] ($progress%) Uploading: $htmlFileName" -ForegroundColor White
        
        if (-not $DryRun) {
            try {
                aws s3 cp $localHTMLPath "s3://$BUCKET_NAME/$s3Key" `
                    --endpoint-url $R2_ENDPOINT `
                    --content-type "text/html" `
                    --no-progress 2>&1 | Out-Null
                
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "    Uploaded successfully" -ForegroundColor Green
                } else {
                    Write-Host "    ERROR uploading HTML" -ForegroundColor Red
                    $htmlErrors++
                }
            } catch {
                Write-Host "    ERROR: $_" -ForegroundColor Red
                $htmlErrors++
            }
        }
    }
    
    Write-Host "`nHTML Upload Summary:" -ForegroundColor Cyan
    Write-Host "  Uploaded: $($htmlCount - $htmlErrors)" -ForegroundColor Green
    Write-Host "  Errors: $htmlErrors" -ForegroundColor $(if ($htmlErrors -gt 0) { "Red" } else { "Green" })
}

# Final summary
Write-Host "`n" ("="*80) -ForegroundColor Cyan
Write-Host "UPLOAD COMPLETE!" -ForegroundColor Cyan
Write-Host ("="*80) "`n" -ForegroundColor Cyan

if (-not $DryRun) {
    Write-Host "Total collections uploaded: $($matchedPairs.Count)" -ForegroundColor Green
    Write-Host "Bucket: $BUCKET_NAME" -ForegroundColor White
    Write-Host "Endpoint: $R2_ENDPOINT" -ForegroundColor White
} else {
    Write-Host "[DRY RUN] No files were uploaded" -ForegroundColor Yellow
}

Write-Host "`n" ("="*80) "`n" -ForegroundColor Cyan
