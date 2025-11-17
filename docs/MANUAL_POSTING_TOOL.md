# Manual Posting Tool - Complete Workflow Documentation

## Overview

The Manual Posting Tool is a browser-based application that enables social media content publishing for CURATR golf style collections across 5 platforms with platform-specific AI-enhanced content.

**Status**: ✅ PRODUCTION - REVENUE GENERATING
**Location**: `C:/Development/repositories/CURATR-PUBLISHING/tools/manual_posting_tool.html`
**Last Updated**: 2025-11-17 (Git commit: 37010fa)

---

## Table of Contents

1. [System Architecture](#system-architecture)
2. [Data Flow](#data-flow)
3. [Dependencies](#dependencies)
4. [Platform Content Strategy](#platform-content-strategy)
5. [AI Enhancement System](#ai-enhancement-system)
6. [Caching & Persistence](#caching--persistence)
7. [User Workflow](#user-workflow)
8. [Technical Implementation](#technical-implementation)
9. [Testing & Validation](#testing--validation)
10. [Troubleshooting](#troubleshooting)

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                 Manual Posting Tool (Browser)               │
│  Location: tools/manual_posting_tool.html                   │
└─────────────────────────────────────────────────────────────┘
                            │
                            ├─────────────────────────┐
                            │                         │
                            ▼                         ▼
┌──────────────────────────────────┐   ┌──────────────────────────────────┐
│  Cloudflare R2 Storage           │   │  Cloudflare Worker               │
│  curatr-content-archive          │   │  curatr-openai-proxy             │
│  ├── manifests/                  │   │  Location: cloudflare-worker/    │
│  │   └── publishing_manifest_... │   │  openai-proxy.js                 │
│  ├── videos/                     │   └──────────────────────────────────┘
│  │   └── {id}_merged.mp4         │                 │
│  └── content/                    │                 ▼
│      └── {id}.html               │   ┌──────────────────────────────────┐
└──────────────────────────────────┘   │  OpenAI API                      │
                                       │  Model: gpt-4o-mini              │
                                       │  Platform-specific prompts       │
                                       └──────────────────────────────────┘
```

---

## Data Flow

### 1. Initial Load
```
User opens manual_posting_tool.html
    ↓
Fetch publishing_manifest_complete_276.json from R2
    ↓
Parse 276 collection entries
    ↓
Display collections in searchable grid
```

### 2. Collection Click
```
User clicks collection
    ↓
Fetch {content_id}.html from R2
    ↓
Parse HTML using DOMParser
    ↓
Extract: .hook, .caption, .hashtags
    ↓
Display collection modal with 5 platform tabs
```

### 3. Platform Content Generation

#### Instagram & YouTube (HTML-based)
```
User clicks Instagram or YouTube tab
    ↓
Display parsed HTML content directly:
- Instagram: hook + caption + hashtags
- YouTube: coordination_story
    ↓
NO AI GENERATION
```

#### TikTok, Facebook, X.com (AI-enhanced)
```
User clicks platform tab
    ↓
Check localStorage cache for {collection_id}_{platform}
    ↓
If cached: Display cached content
    ↓
If not cached:
    ↓
Call generatePlatformContent()
    ↓
Send prompt to Cloudflare Worker
    ↓
Worker forwards to OpenAI API with OPENAI_API_KEY
    ↓
Receive platform-specific content
    ↓
Cache in localStorage
    ↓
Trigger renderCollections() to update UI
    ↓
Display generated content
```

---

## Dependencies

### External Services

#### 1. Cloudflare R2 (Object Storage)
- **Bucket**: `curatr-content-archive`
- **Account ID**: `3c7ffdc93a2c1ecf4e4d116df98c7852`
- **Public URL**: `https://pub-de854dc1e16444499a966af3528a083c.r2.dev`
- **Access**: Public read, authenticated write
- **Regions**: Auto (global distribution)

**Required Files**:
- `manifests/publishing_manifest_complete_276.json` - Master collection list
- `videos/{content_id}_merged.mp4` - 276 merged videos
- `content/{content_id}.html` - 276 HTML files with hook/caption/hashtags

**Verification**:
```bash
# Check manifest exists
curl -I https://pub-de854dc1e16444499a966af3528a083c.r2.dev/manifests/publishing_manifest_complete_276.json

# Check specific HTML file
curl -I https://pub-de854dc1e16444499a966af3528a083c.r2.dev/content/StitchGolf_outfit_cinco_20251103_171824.html

# Check video file
curl -I https://pub-de854dc1e16444499a966af3528a083c.r2.dev/videos/StitchGolf_outfit_cinco_20251103_171824_merged.mp4
```

#### 2. Cloudflare Worker (AI Proxy)
- **Name**: `curatr-openai-proxy`
- **URL**: `https://curatr-openai-proxy.curatr.workers.dev`
- **Location**: `cloudflare-worker/openai-proxy.js`
- **Purpose**: Proxy OpenAI API calls, hide API key from browser
- **Secret**: `OPENAI_API_KEY` (stored in Cloudflare)

**How to Update Secret**:
```bash
cd C:/Development/repositories/CURATR-PUBLISHING/cloudflare-worker
export CLOUDFLARE_API_TOKEN="<workers_api_token>"
echo "<openai_api_key>" | wrangler secret put OPENAI_API_KEY --name curatr-openai-proxy --env=""
```

**How to Deploy Worker**:
```bash
cd C:/Development/repositories/CURATR-PUBLISHING/cloudflare-worker
wrangler deploy
```

**Testing Worker**:
```bash
# Test worker is responding
curl -X POST "https://curatr-openai-proxy.curatr.workers.dev" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o-mini","messages":[{"role":"user","content":"Say hello in 5 words"}],"max_tokens":20}'

# Should return: {"choices":[{"message":{"content":"Hello! How are you today?"}}]}
# Should NOT return: {"error":"API request failed"}
```

#### 3. OpenAI API
- **Endpoint**: `https://api.openai.com/v1/chat/completions`
- **Model**: `gpt-4o-mini`
- **Temperature**: 0.8
- **Max Tokens**: 200
- **Authentication**: Bearer token (stored in Worker)

**API Key Location**: Cloudflare Worker secret `OPENAI_API_KEY`

### Local Files

#### 1. manual_posting_tool.html
**Location**: `C:/Development/repositories/CURATR-PUBLISHING/tools/manual_posting_tool.html`
**Size**: ~1200 lines
**Type**: Single-file HTML + CSS + JavaScript application

**Critical Configuration** (Lines 367-373):
```javascript
// R2 Configuration
const R2_PUBLIC_URL = 'https://pub-de854dc1e16444499a966af3528a083c.r2.dev';
const R2_CDN_URL = 'https://3c7ffdc93a2c1ecf4e4d116df98c7852.r2.cloudflarestorage.com/curatr-content-archive';
const OPENAI_API_URL = 'https://curatr-openai-proxy.curatr.workers.dev';

// Manifest Configuration
const MANIFEST_URL = `${R2_PUBLIC_URL}/manifests/publishing_manifest_complete_276.json`;
```

⚠️ **DO NOT CHANGE** these URLs without verifying:
1. New URLs are accessible
2. Required files exist at new locations
3. Full workflow still works end-to-end

#### 2. openai-proxy.js (Cloudflare Worker)
**Location**: `C:/Development/repositories/CURATR-PUBLISHING/cloudflare-worker/openai-proxy.js`
**Size**: ~60 lines
**Type**: Cloudflare Worker JavaScript

**Critical Configuration** (Line 32):
```javascript
const openaiResponse = await fetch('https://api.openai.com/v1/chat/completions', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${env.OPENAI_API_KEY}`,
  },
  body: JSON.stringify(body),
});
```

⚠️ **NEVER CHANGE** OpenAI endpoint without:
1. Verifying new endpoint is compatible
2. Testing with real API key
3. Confirming all 3 platforms still work

---

## Platform Content Strategy

The tool generates content for 5 social media platforms with different strategies:

### 1. TikTok (AI-Generated)
**Character Limit**: ~300 characters
**Tone**: Casual, conversational, POV-style
**Style**: Short-form, emoji-friendly, hook-focused
**Model Prompt**: "Create a fun, conversational TikTok caption (150 words max)..."

**Example Output**:
```
POV: You pull up to the course and instantly turn heads. 🏌️‍♂️
When your golf gear looks this good, it's not just about the game—
it's about making a statement. Luxury vibes and tournament-ready
feels? Yeah, that's the vibe! 🔥
```

### 2. X.com / Twitter (AI-Generated)
**Character Limit**: 280 characters (strict)
**Tone**: Punchy, thread-ready, attention-grabbing
**Style**: Concise, high-impact, quotable
**Model Prompt**: "Create a punchy X.com/Twitter post (280 characters max)..."

**Example Output**:
```
🚨 Game changer alert! The Stitch Golf Signature Travel Collection
is here! When investment-grade golf gear meets luxury aesthetics,
you're not just carrying clubs; you're making a statement. Timeless
design + tournament-ready functionality = your new favorite travel
companion. ⛳️✨
```

### 3. Facebook (AI-Generated)
**Character Limit**: ~500 characters
**Tone**: Conversational, engaging, community-focused
**Style**: Longer-form, question-based, CTA-driven
**Model Prompt**: "Create a conversational Facebook post (200 words max)..."

**Example Output**:
```
🌟 Have you ever felt that thrill of stepping onto the course with
gear that just screams sophistication? The Stitch Golf Signature
Travel Collection perfectly blends investment-grade quality with
luxury aesthetics, ensuring you not only carry your clubs but also
announce your presence! It's all about that timeless design and
tournament-ready functionality that keeps you looking sharp on and
off the course. What's your favorite golf accessory that makes you
feel like a pro? Share in the comments below! ⛳️✨ And if you're
ready to elevate your golf game, check out the collection!
```

### 4. Instagram (HTML-Based, NOT AI)
**Character Limit**: ~2200 characters
**Tone**: Professional, branded, hashtag-optimized
**Style**: Hook + Caption + Hashtags + CTA
**Content Source**: Parsed from HTML file `.hook`, `.caption`, `.hashtags`

**Example Output**:
```
The Stitch Golf Signature Travel Collection

When investment-grade golf gear meets luxury aesthetics. Stitch Golf's
premium lineup doesn't just carry your clubs—it announces your arrival.
Timeless design meets tournament-ready functionality.

#StitchGolf #GolfStyle #LuxuryGolf #GolfTravel #TourGear #GolfLifestyle
#GolfEssentials #PremiumGolf #CURATR

Elevate your golf travel game with the complete Stitch collection.
Link in bio | We earn from qualifying purchases
```

### 5. YouTube (HTML-Based, NOT AI)
**Character Limit**: ~5000 characters
**Tone**: Informative, storytelling, SEO-optimized
**Style**: Full coordination story with context
**Content Source**: Parsed from HTML file `.coordination_story` or `.caption`

**Example Output**:
```
When investment-grade golf gear meets luxury aesthetics. Stitch Golf's
premium lineup doesn't just carry your clubs—it announces your arrival.
Timeless design meets tournament-ready functionality.
```

---

## AI Enhancement System

### How It Works

1. **User triggers AI generation** by clicking TikTok, Facebook, or X.com tab
2. **Check cache first**: `localStorage.getItem('platformContentCache')`
3. **If cached**: Display immediately, no API call
4. **If not cached**: Call `generatePlatformContent(collection, platform)`

### generatePlatformContent() Flow

**Location**: manual_posting_tool.html:530-558

```javascript
async function generatePlatformContent(collection, platform) {
    // 1. Check cache
    const cacheKey = `${collection.id}_${platform}`;
    if (platformContentCache[cacheKey]) {
        return platformContentCache[cacheKey];
    }

    // 2. Build platform-specific prompt
    const systemPrompt = "You are a professional golf content creator...";
    const prompts = {
        'tiktok': "Create a fun, conversational TikTok caption...",
        'xcom': "Create a punchy X.com/Twitter post...",
        'facebook': "Create a conversational Facebook post..."
    };

    // 3. Call Cloudflare Worker (which calls OpenAI)
    const response = await fetch(OPENAI_API_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            model: 'gpt-4o-mini',
            messages: [
                { role: 'system', content: systemPrompt },
                { role: 'user', content: prompts[platform] }
            ],
            temperature: 0.8,
            max_tokens: 200
        })
    });

    // 4. Parse response
    const data = await response.json();
    const generatedContent = data.choices[0].message.content.trim();

    // 5. Cache result
    platformContentCache[cacheKey] = generatedContent;
    localStorage.setItem('platformContentCache', JSON.stringify(platformContentCache));

    // 6. CRITICAL: Refresh UI to show cached content
    renderCollections();

    return generatedContent;
}
```

### Why Line 559 (renderCollections) Is Critical

**Problem**: After generating AI content and caching it, the UI doesn't update to show the cached content until page refresh.

**Solution**: Call `renderCollections()` after caching to immediately re-render the UI with the new cached content.

**Before Fix** (BROKEN):
```javascript
platformContentCache[cacheKey] = generatedContent;
localStorage.setItem('platformContentCache', JSON.stringify(platformContentCache));
return generatedContent;  // UI shows content, but doesn't persist on next click
```

**After Fix** (WORKING):
```javascript
platformContentCache[cacheKey] = generatedContent;
localStorage.setItem('platformContentCache', JSON.stringify(platformContentCache));

renderCollections();  // ← THIS LINE FIXES PERSISTENCE

return generatedContent;
```

### Regenerate Content Feature

**Location**: manual_posting_tool.html:670-690

Users can regenerate AI content by clicking "Regenerate" button:

```javascript
async function regenerateContent(collectionId, platform) {
    // 1. Clear existing cache
    const cacheKey = `${collectionId}_${platform}`;
    delete platformContentCache[cacheKey];
    localStorage.setItem('platformContentCache', JSON.stringify(platformContentCache));

    // 2. CRITICAL: Refresh UI to clear old content
    renderCollections();

    // 3. Generate fresh content
    const collection = collections.find(c => c.id === collectionId);
    const newContent = await generatePlatformContent(collection, platform);

    // 4. Update UI (renderCollections already called in generatePlatformContent)
    return newContent;
}
```

---

## Caching & Persistence

### localStorage Structure

```javascript
{
  "platformContentCache": {
    "StitchGolf_outfit_cinco_20251103_171824_tiktok": "POV: You pull up...",
    "StitchGolf_outfit_cinco_20251103_171824_xcom": "🚨 Game changer...",
    "StitchGolf_outfit_cinco_20251103_171824_facebook": "🌟 Have you ever...",
    // ... all cached AI content
  },
  "postedStatus": {
    "StitchGolf_outfit_cinco_20251103_171824_tiktok": true,
    "StitchGolf_outfit_cinco_20251103_171824_instagram": true,
    // ... all posted status flags
  }
}
```

### Cache Keys
Format: `{collection_id}_{platform}`
Example: `StitchGolf_outfit_cinco_20251103_171824_tiktok`

### Cache Lifetime
- **Duration**: Indefinite (until user clears browser data or clicks "Regenerate")
- **Scope**: Per-browser (not synced across devices)
- **Size Limit**: ~5-10MB (browser localStorage limit)

### Why Caching Matters

1. **Cost Savings**: Avoid redundant OpenAI API calls ($0.15 per 1M tokens)
2. **Speed**: Instant content display (no network latency)
3. **Consistency**: Same content shown every time (important for scheduled posts)
4. **Offline**: Works without internet after initial cache

---

## User Workflow

### Step-by-Step User Journey

#### 1. Open Manual Posting Tool
```
User: Opens manual_posting_tool.html in browser
System: Loads 276 collections from R2 manifest
Display: Grid of collection thumbnails with search bar
```

#### 2. Search for Collection (Optional)
```
User: Types "stitch" in search bar
System: Filters collections by matching ID or name
Display: Filtered results (e.g., "StitchGolf_outfit_cinco_20251103_171824")
```

#### 3. Click Collection
```
User: Clicks collection thumbnail
System:
  - Fetches {collection_id}.html from R2
  - Parses hook, caption, hashtags using DOMParser
  - Opens modal with 5 platform tabs
Display: Modal with collection details and platform tabs
```

#### 4. View Instagram Content (Default)
```
User: Modal opens on Instagram tab by default
System: Displays HTML-based content (hook + caption + hashtags)
Display:
  [Hook]
  [Caption]
  [Hashtags]
  [CTA]
  [Copy Content button]
```

#### 5. Switch to TikTok (AI Generation Triggered)
```
User: Clicks "TikTok" tab
System:
  - Checks cache for StitchGolf_..._tiktok
  - If not cached: Calls generatePlatformContent()
  - Shows loading spinner
  - Calls Cloudflare Worker → OpenAI API
  - Receives AI-generated TikTok content
  - Caches in localStorage
  - Refreshes UI via renderCollections()
Display: TikTok-specific AI content with [Copy Content] button
```

#### 6. Copy Content to Clipboard
```
User: Clicks "Copy Content" button
System: navigator.clipboard.writeText(content)
Display: Button text changes to "Copied!" for 2 seconds
User: Pastes content into TikTok mobile app or desktop scheduler
```

#### 7. Mark as Posted (Optional)
```
User: Clicks "Mark as Posted" button
System:
  - Saves to postedStatus localStorage
  - Updates UI to show checkmark badge
Display: Collection thumbnail shows ✓ badge for TikTok platform
```

#### 8. Regenerate Content (If Needed)
```
User: Clicks "Regenerate" button next to platform tab
System:
  - Clears cache for that platform
  - Calls generatePlatformContent() again
  - Gets fresh AI content
Display: New AI-generated content (different from before)
```

---

## Technical Implementation

### File Structure
```
manual_posting_tool.html (1200 lines)
├── HTML (Lines 1-100)
│   ├── Header with logo
│   ├── Search bar
│   ├── Collections grid container
│   └── Collection modal template
│
├── CSS (Lines 100-350)
│   ├── Global styles
│   ├── Grid layout
│   ├── Modal styles
│   ├── Platform tab styles
│   └── Button animations
│
└── JavaScript (Lines 350-1200)
    ├── Configuration (Lines 367-373)
    │   ├── R2_PUBLIC_URL
    │   ├── R2_CDN_URL
    │   ├── OPENAI_API_URL
    │   └── MANIFEST_URL
    │
    ├── State Management (Lines 375-380)
    │   ├── collections = []
    │   ├── platformContentCache = {}
    │   └── postedStatus = {}
    │
    ├── Data Loading (Lines 382-440)
    │   ├── loadCollections()
    │   ├── fetchHTMLContent()
    │   └── parseHTMLContent()
    │
    ├── UI Rendering (Lines 450-520)
    │   ├── renderCollections()
    │   ├── showCollectionModal()
    │   └── switchPlatformTab()
    │
    ├── AI Generation (Lines 530-690)
    │   ├── generatePlatformContent()
    │   └── regenerateContent()
    │
    ├── Clipboard & Posting (Lines 700-800)
    │   ├── copyToClipboard()
    │   └── markAsPosted()
    │
    └── Search & Filtering (Lines 810-850)
        └── filterCollections()
```

### Key Functions

#### loadCollections() - Lines 382-402
**Purpose**: Fetch manifest from R2 and populate collections array

```javascript
async function loadCollections() {
    try {
        const response = await fetch(MANIFEST_URL);
        const data = await response.json();
        collections = data.map(item => ({
            id: item.content_id,
            videoUrl: `${R2_CDN_URL}/videos/${item.content_id}_merged.mp4`,
            htmlUrl: `${R2_PUBLIC_URL}/content/${item.content_id}.html`,
            // ... other fields
        }));
        renderCollections();
    } catch (error) {
        console.error('Error loading collections:', error);
        alert('Failed to load collections. Check R2 connection.');
    }
}
```

**Dependencies**:
- MANIFEST_URL must be accessible
- Manifest JSON must have correct structure
- R2_CDN_URL and R2_PUBLIC_URL must be valid

**Error Handling**:
- Shows alert if fetch fails
- Logs error to console
- Does NOT crash entire app

#### fetchHTMLContent() - Lines 410-420
**Purpose**: Fetch HTML file from R2 for a specific collection

```javascript
async function fetchHTMLContent(collection) {
    try {
        const response = await fetch(collection.htmlUrl);
        if (!response.ok) throw new Error('HTML not found');
        const htmlText = await response.text();
        return parseHTMLContent(htmlText);
    } catch (error) {
        console.error('Error fetching HTML:', error);
        return { hook: '', caption: '', hashtags: '' };
    }
}
```

**Dependencies**:
- collection.htmlUrl must point to valid HTML file in R2
- HTML file must exist and be accessible

**Error Handling**:
- Returns empty strings if fetch fails
- Does NOT crash modal
- Logs error for debugging

#### parseHTMLContent() - Lines 404-408
**Purpose**: Extract hook, caption, hashtags from HTML using DOMParser

```javascript
function parseHTMLContent(htmlText) {
    const parser = new DOMParser();
    const doc = parser.parseFromString(htmlText, 'text/html');

    const hook = doc.querySelector('.hook, [class*="hook"]')?.textContent?.trim() || '';
    const caption = doc.querySelector('.caption, [class*="caption"]')?.textContent?.trim() || '';
    const hashtags = doc.querySelector('.hashtags, [class*="hashtag"]')?.textContent?.trim() || '';

    return { hook, caption, hashtags };
}
```

**Expected HTML Structure**:
```html
<div class="hook">The Stitch Golf Signature Travel Collection</div>
<div class="caption">When investment-grade golf gear meets luxury aesthetics...</div>
<div class="hashtags">#StitchGolf #GolfStyle #LuxuryGolf...</div>
```

**Why It Works**:
- `.querySelector()` is flexible (matches `.hook` or any class containing "hook")
- `?.textContent?.trim()` safely handles missing elements
- Returns empty string if element not found (graceful degradation)

#### generatePlatformContent() - Lines 530-558
**Purpose**: Generate AI content for TikTok, Facebook, or X.com

See [AI Enhancement System](#ai-enhancement-system) section above for full details.

**Critical Success Factors**:
1. ✅ Cloudflare Worker must be deployed and responding
2. ✅ Worker must have valid OPENAI_API_KEY secret
3. ✅ OpenAI API must be accessible
4. ✅ Platform prompts must be well-crafted
5. ✅ Cache must be saved to localStorage
6. ✅ renderCollections() must be called after caching (LINE 559)

---

## Testing & Validation

### Pre-Deployment Checklist

Before deploying ANY changes to manual_posting_tool.html:

#### 1. Verify R2 Dependencies
```bash
# Check manifest exists and is accessible
curl -I https://pub-de854dc1e16444499a966af3528a083c.r2.dev/manifests/publishing_manifest_complete_276.json
# Should return: HTTP/2 200

# Check sample HTML file
curl https://pub-de854dc1e16444499a966af3528a083c.r2.dev/content/StitchGolf_outfit_cinco_20251103_171824.html
# Should return: HTML with .hook, .caption, .hashtags

# Check sample video
curl -I https://pub-de854dc1e16444499a966af3528a083c.r2.dev/videos/StitchGolf_outfit_cinco_20251103_171824_merged.mp4
# Should return: HTTP/2 200
```

#### 2. Verify Cloudflare Worker
```bash
# Test worker responds
curl -X POST "https://curatr-openai-proxy.curatr.workers.dev" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o-mini","messages":[{"role":"user","content":"Say hello"}],"max_tokens":10}'

# Should return: {"choices":[{"message":{"content":"Hello! How can I..."}}]}
# Should NOT return: {"error":"API request failed"}
```

#### 3. Test Full User Workflow

Open `manual_posting_tool.html` in browser and complete this checklist:

- [ ] **Load Test**: Page loads without errors
- [ ] **Manifest Test**: Collections grid populates with 276 items
- [ ] **Search Test**: Type "stitch" → filtered results appear
- [ ] **Modal Test**: Click collection → modal opens
- [ ] **HTML Parse Test**: Instagram tab shows hook, caption, hashtags
- [ ] **AI Test (TikTok)**: Click TikTok tab → AI content generates
- [ ] **AI Test (X.com)**: Click X.com tab → Different AI content generates
- [ ] **AI Test (Facebook)**: Click Facebook tab → Different AI content generates
- [ ] **Persistence Test**: Refresh page → Click same collection → AI content still there
- [ ] **Copy Test**: Click "Copy Content" on each platform → Clipboard works
- [ ] **Regenerate Test**: Click "Regenerate" → New AI content appears
- [ ] **Posted Status Test**: Click "Mark as Posted" → Badge appears on thumbnail

#### 4. Test Error Scenarios

- [ ] **Offline Test**: Disconnect internet → Cached content still works
- [ ] **Missing HTML Test**: Manually break HTML URL → Modal shows empty strings (no crash)
- [ ] **Worker Down Test**: Stop worker → AI generation fails gracefully with error message
- [ ] **Invalid Manifest Test**: Break manifest URL → Shows error alert (no crash)

### Test Collections

Use these collections for testing (verified working as of 2025-11-17):

| Collection ID | Brand | Type | Status |
|--------------|-------|------|--------|
| `StitchGolf_outfit_cinco_20251103_171824` | Stitch Golf | Travel gear | ✅ Working |
| `AshworthGolfFairwayGreeneSeamusGolf_outfit_cinco_20251022_133318` | Multi-brand | Outfit | ✅ Working |

### Performance Benchmarks

| Operation | Expected Time | Acceptable Range |
|-----------|---------------|------------------|
| Load collections | 500ms | 200ms - 2s |
| Open modal | 200ms | 100ms - 500ms |
| Fetch HTML | 300ms | 100ms - 1s |
| Generate AI content | 2s | 1s - 5s |
| Copy to clipboard | 50ms | 10ms - 200ms |

---

## Troubleshooting

### Problem: Collections Don't Load

**Symptoms**: Empty grid, no thumbnails, console error

**Diagnosis**:
```javascript
// Check browser console for errors
// Look for: "Error loading collections"
```

**Solutions**:
1. ✅ Verify MANIFEST_URL is accessible (curl test)
2. ✅ Check R2_PUBLIC_URL is correct
3. ✅ Verify manifest JSON structure matches expected format
4. ✅ Check CORS headers on R2 bucket (should allow browser access)

**Rollback**:
```bash
git checkout <last-working-commit> tools/manual_posting_tool.html
```

---

### Problem: HTML Content Missing (Empty Hook/Caption/Hashtags)

**Symptoms**: Modal opens but Instagram/YouTube tabs show empty content

**Diagnosis**:
```javascript
// Check browser console for errors
// Look for: "Error fetching HTML" or "HTML not found"
```

**Solutions**:
1. ✅ Verify HTML file exists in R2: `curl https://pub-de854dc1e16444499a966af3528a083c.r2.dev/content/{collection_id}.html`
2. ✅ Check HTML file has correct structure (.hook, .caption, .hashtags classes)
3. ✅ Verify parseHTMLContent() function is working (check console logs)
4. ✅ Upload missing HTML files to R2 using upload script

**Upload Missing Files**:
```powershell
cd C:/curatr/CURATR_Content_Engine
.\upload_html_files.ps1
```

---

### Problem: AI Content Not Generating

**Symptoms**: TikTok/Facebook/X.com tabs show loading spinner indefinitely or error message

**Diagnosis**:
```bash
# Test Cloudflare Worker
curl -X POST "https://curatr-openai-proxy.curatr.workers.dev" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o-mini","messages":[{"role":"user","content":"test"}],"max_tokens":10}'
```

**Solutions**:

#### If Worker Returns `{"error":"API request failed"}`:
1. ✅ Check OPENAI_API_KEY secret in Cloudflare Worker:
```bash
cd C:/Development/repositories/CURATR-PUBLISHING/cloudflare-worker
export CLOUDFLARE_API_TOKEN="<workers_token>"
echo "<valid_openai_key>" | wrangler secret put OPENAI_API_KEY --name curatr-openai-proxy --env=""
```

2. ✅ Verify OpenAI API key is valid at platform.openai.com

3. ✅ Check Worker code is using correct OpenAI endpoint:
```javascript
// Should be:
const openaiResponse = await fetch('https://api.openai.com/v1/chat/completions', ...)

// Should NOT be:
const openaiResponse = await fetch('https://api.manus.im/api/llm-proxy/v1/chat/completions', ...)
```

4. ✅ Re-deploy Worker:
```bash
wrangler deploy
```

#### If Worker Returns Network Error:
1. ✅ Check Worker URL in manual_posting_tool.html:
```javascript
const OPENAI_API_URL = 'https://curatr-openai-proxy.curatr.workers.dev';
```

2. ✅ Verify Worker is deployed: Visit https://dash.cloudflare.com > Workers

---

### Problem: AI Content Not Persisting

**Symptoms**: AI content generates but disappears when switching tabs or refreshing page

**Diagnosis**:
```javascript
// Check browser localStorage
console.log(localStorage.getItem('platformContentCache'));
// Should show cached content

// Check if renderCollections() is called after caching
// manual_posting_tool.html:559 should have: renderCollections();
```

**Solutions**:
1. ✅ Verify Line 559 has `renderCollections();` call after cache save
2. ✅ Verify Line 679 has `renderCollections();` call after cache clear
3. ✅ Check browser localStorage is not disabled
4. ✅ Clear localStorage and regenerate content

**Fix**:
```javascript
// manual_posting_tool.html:555-559
platformContentCache[cacheKey] = generatedContent;
localStorage.setItem('platformContentCache', JSON.stringify(platformContentCache));

// THIS LINE IS CRITICAL:
renderCollections();

return generatedContent;
```

---

### Problem: Content Truncated or Cut Off

**Symptoms**: AI-generated content ends abruptly (e.g., "...Timeles...")

**Root Cause**: OpenAI API call is failing, falling back to truncated caption

**Diagnosis**:
```bash
# Check if Worker is actually calling OpenAI successfully
# Look for error responses from Worker
```

**Solutions**:
1. ✅ Test Worker endpoint (see "AI Content Not Generating" above)
2. ✅ Check OpenAI API key is valid
3. ✅ Verify Worker is using direct OpenAI API (not Manus proxy)
4. ✅ Check max_tokens is sufficient (should be 200)

**Expected Behavior**:
- TikTok: ~150-300 characters of unique content
- X.com: ~200-280 characters of unique content
- Facebook: ~300-500 characters of unique content

**NOT Expected**:
- All platforms showing identical truncated text
- Content ending mid-word (e.g., "Timeles...")

---

### Problem: Wrong Manifest Loading (Missing Recent Collections)

**Symptoms**: Tool shows 216 collections instead of 276, recent collections missing

**Diagnosis**:
```javascript
// Check manual_posting_tool.html:371
const MANIFEST_URL = `${R2_PUBLIC_URL}/manifests/publishing_manifest_complete_276.json`;
// Should point to 276, NOT 216
```

**Solutions**:
1. ✅ Update MANIFEST_URL to point to current manifest
2. ✅ Verify new manifest exists in R2
3. ✅ Upload new manifest if missing:
```powershell
cd C:/Development/repositories/CURATR-PUBLISHING
aws s3 cp publishing_manifest_complete_276.json s3://curatr-content-archive/manifests/publishing_manifest_complete_276.json --endpoint-url https://3c7ffdc93a2c1ecf4e4d116df98c7852.r2.cloudflarestorage.com
```

---

## Maintenance

### Regular Checks (Weekly)

1. ✅ Verify manifest count matches expected collections
2. ✅ Test AI generation on 2-3 random collections
3. ✅ Check Cloudflare Worker logs for errors
4. ✅ Verify R2 storage usage isn't approaching limits

### When Adding New Collections

1. ✅ Generate merged video (`{content_id}_merged.mp4`)
2. ✅ Generate HTML file with hook/caption/hashtags
3. ✅ Upload video to R2 `videos/` folder
4. ✅ Upload HTML to R2 `content/` folder
5. ✅ Update manifest JSON with new collection entry
6. ✅ Upload updated manifest to R2 `manifests/` folder
7. ✅ Update MANIFEST_URL in manual_posting_tool.html (if manifest name changed)
8. ✅ Test new collection in tool

### When Updating AI Prompts

1. ✅ Edit prompts in generatePlatformContent() function
2. ✅ Test on 3-5 collections to verify improved output
3. ✅ Clear localStorage cache to force regeneration: `localStorage.clear()`
4. ✅ Commit changes with descriptive message
5. ✅ Document prompt changes in git commit

---

## Version History

| Version | Date | Commit | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-17 | 37010fa | Fix: Replace Manus proxy with direct OpenAI API |
| 0.9 | 2025-11-17 | c720ced | Fix: AI enhancement persistence with renderCollections() |
| 0.8 | 2025-11-17 | c6b40e8 | Restore: Working AI enhancement version |
| 0.7 | 2025-11-17 | b28ae75 | Update: Load 276-item manifest |

---

## Support

### Contacts

- **Primary Maintainer**: User (business owner)
- **AI Assistant**: Claude Code (this conversation)
- **Documentation**: This file

### Resources

- **Git Repository**: `C:/Development/repositories/CURATR-PUBLISHING`
- **R2 Dashboard**: https://dash.cloudflare.com > R2
- **Workers Dashboard**: https://dash.cloudflare.com > Workers & Pages
- **OpenAI Dashboard**: https://platform.openai.com

### Getting Help

1. ✅ Check this documentation first
2. ✅ Check PROTECTED_WORKFLOWS.md
3. ✅ Check git history for last working version
4. ✅ Test workflow step-by-step using Testing Checklist
5. ✅ Review browser console for specific errors
6. ✅ Ask Claude Code with full error context

---

**Last Updated**: 2025-11-17
**Last Verified Working**: 2025-11-17 (Git commit 37010fa)
**Next Review Due**: 2025-12-01
