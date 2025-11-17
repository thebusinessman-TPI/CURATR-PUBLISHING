# PROTECTED WORKFLOWS - DO NOT BREAK

## ⚠️ CRITICAL: Production-Grade Systems That Must NEVER Regress

This document lists all production-critical workflows that are currently working and generating revenue. **ANY changes to these systems require explicit user approval and thorough testing.**

---

## 🚫 MANDATORY RULES BEFORE TOUCHING ANY PROTECTED WORKFLOW

### 1. READ FIRST, CODE SECOND
- ✅ Read the ENTIRE file before making ANY changes
- ✅ Read all related documentation files
- ✅ Check git history to understand recent changes
- ✅ Verify the current working state

### 2. TEST BEFORE COMMIT
- ✅ Test the EXACT user workflow end-to-end
- ✅ Verify no existing functionality is broken
- ✅ Document what you tested and the results
- ✅ Get user approval before committing

### 3. NEVER ASSUME ANYTHING
- ❌ Don't assume APIs still work - test them
- ❌ Don't assume files are uploaded - verify in R2
- ❌ Don't assume manifests are current - check versions
- ❌ Don't make "improvements" without explicit request

### 4. WHEN IN DOUBT
- Ask the user for clarification
- Check existing documentation first
- Look at git history for last working version
- Test in isolation before touching production

---

## 🔒 PROTECTED WORKFLOW #1: Manual Posting Tool

**Status**: ✅ PRODUCTION - GENERATING REVENUE
**Location**: `C:/Development/repositories/CURATR-PUBLISHING/tools/manual_posting_tool.html`
**Last Known Good**: Git commit `37010fa` (2025-11-17)

### What It Does
Enables social media publishing of golf style collections across 5 platforms (TikTok, Instagram, Facebook, X.com, YouTube) with platform-specific AI-enhanced content.

### Critical Dependencies

#### Files (DO NOT MODIFY WITHOUT APPROVAL)
- `tools/manual_posting_tool.html` - Main tool interface
- `cloudflare-worker/openai-proxy.js` - AI content generation proxy
- `cloudflare-worker/wrangler.toml` - Worker configuration

#### External Services (VERIFY BEFORE CHANGING)
- **Cloudflare R2 Bucket**: `curatr-content-archive`
  - Public URL: `https://pub-de854dc1e16444499a966af3528a083c.r2.dev`
  - Must contain: videos/, content/, metadata/, manifests/
- **Cloudflare Worker**: `curatr-openai-proxy`
  - URL: `https://curatr-openai-proxy.curatr.workers.dev`
  - Secret: `OPENAI_API_KEY` (must be valid)
- **OpenAI API**: `gpt-4o-mini` model
  - Endpoint: `https://api.openai.com/v1/chat/completions`
  - Must have valid API key in Worker

#### Data Files (MUST EXIST IN R2)
- **Manifest**: `manifests/publishing_manifest_complete_276.json` (276 collections)
- **Videos**: `videos/{content_id}_merged.mp4` (276 files)
- **HTML Files**: `content/{content_id}.html` (276 files with hook/caption/hashtags)

### How It Works
1. Loads 276-collection manifest from R2
2. For each collection, fetches HTML file from R2 and parses hook/caption/hashtags
3. Displays collections in searchable grid with platform content tabs
4. Generates platform-specific content:
   - **TikTok**: AI-generated POV-style casual content
   - **X.com**: AI-generated punchy thread-ready content
   - **Facebook**: AI-generated conversational content with CTA
   - **Instagram**: HTML hook + caption + hashtags (NOT AI-generated)
   - **YouTube**: HTML coordination story (NOT AI-generated)
5. Caches AI-generated content in localStorage for persistence
6. Provides copy-to-clipboard functionality for each platform

### Critical Code Sections (DO NOT BREAK)

#### Line 371: Manifest URL
```javascript
const MANIFEST_URL = `${R2_PUBLIC_URL}/manifests/publishing_manifest_complete_276.json`;
```
**Why Critical**: Must point to current manifest with all collections. Changing this breaks access to collections.

#### Lines 404-406: HTML Parsing
```javascript
const hook = doc.querySelector('.hook, [class*="hook"]')?.textContent?.trim() || '';
const caption = doc.querySelector('.caption, [class*="caption"]')?.textContent?.trim() || '';
const hashtags = doc.querySelector('.hashtags, [class*="hashtag"]')?.textContent?.trim() || '';
```
**Why Critical**: Extracts Instagram/YouTube content from HTML files. Changes break content display.

#### Lines 530-558: AI Content Generation
```javascript
async function generatePlatformContent(collection, platform) {
    // Caching logic
    // Platform-specific prompts
    // OpenAI API call
    // localStorage persistence
    // UI refresh
}
```
**Why Critical**: Generates unique platform-specific content. Breaking this loses AI enhancement functionality.

#### Line 559 & 679: UI Refresh After Cache Update
```javascript
renderCollections();
```
**Why Critical**: Updates UI to show cached content. Without this, AI content doesn't persist in UI.

### Known Working State (November 17, 2025)
- ✅ All 276 collections accessible
- ✅ All HTML files populated with hook/caption/hashtags
- ✅ All videos accessible in R2
- ✅ AI enhancement producing unique platform-specific content
- ✅ Content persisting in UI after generation
- ✅ No truncated captions
- ✅ Cloudflare Worker using direct OpenAI API (not Manus proxy)

### Testing Checklist Before ANY Changes
1. ✅ Load manual_posting_tool.html in browser
2. ✅ Verify 276 collections load
3. ✅ Click on a recent collection (e.g., StitchGolf_outfit_cinco_20251103_171824)
4. ✅ Verify HTML content displays (hook, caption, hashtags)
5. ✅ Click TikTok tab - verify unique AI content generates
6. ✅ Click X.com tab - verify different AI content generates
7. ✅ Click Facebook tab - verify different AI content generates
8. ✅ Click Instagram tab - verify HTML content displays
9. ✅ Click YouTube tab - verify coordination story displays
10. ✅ Refresh page - verify all AI content persists
11. ✅ Test "Copy Content" buttons work for all platforms

### What Broke Today (November 17, 2025) - NEVER REPEAT
1. ❌ Changed manifest URL without verifying new manifest was uploaded to R2
2. ❌ Cloudflare Worker was using broken Manus proxy instead of OpenAI API
3. ❌ HTML files for 59 new collections weren't uploaded to R2
4. ❌ Videos for 59 new collections weren't uploaded to R2
5. ❌ AI content wasn't persisting in UI due to missing renderCollections() calls

**Root Cause**: Didn't read documentation, didn't test workflow, didn't verify external dependencies.

**Time Lost**: 6 hours of regression fixes.

### Rollback Procedure If Broken
```bash
# Revert to last known good commit
cd C:/Development/repositories/CURATR-PUBLISHING
git log --oneline  # Find last working commit
git checkout <commit-hash> tools/manual_posting_tool.html
git checkout <commit-hash> cloudflare-worker/openai-proxy.js

# Re-deploy Cloudflare Worker if needed
cd cloudflare-worker
wrangler deploy
```

---

## 🔒 PROTECTED WORKFLOW #2: Content Engine Video Generation Pipeline

**Status**: ✅ PRODUCTION - GENERATING CONTENT
**Location**: `C:/curatr/CURATR_Content_Engine/`
**Documentation**: `C:/curatr/CURATR_Content_Engine/docs/PHASE1_AUDIT.md`

### What It Does
Generates AI-powered golf style videos from product images using multi-step automation pipeline.

### Pipeline Steps (DO NOT BREAK)
1. **Step 1**: Nano Banana image enhancement (94% success rate)
2. **Step 2**: AI video generation via Kling/VEO3 APIs (81% approval rate)
3. **Step 3**: Video merging of AI video + product carousel (93.9% success rate)
4. **Step 4**: Upload merged videos to R2 (newly implemented)
5. **Step 5**: Publish metadata to Supabase admin_curations (newly implemented)

### Critical Files (DO NOT MODIFY WITHOUT APPROVAL)
- `scripts/nano_banana_batch_processor.ps1` - Step 1 orchestration
- `scripts/kling_api_production.py` - Step 2 video generation
- `scripts/video_merger.py` - Step 3 video merging
- `automation/step4_r2_uploader.py` - Step 4 R2 upload (NEW)
- `automation/step5_manifest_updater.py` - Step 5 Supabase publishing (NEW)
- `automation/step4_config.yaml` - R2 configuration
- `automation/step5_config.yaml` - Supabase configuration

### Known Working State
- ✅ 217 total videos generated
- ✅ 130 approved and merged videos ready for publishing
- ✅ R2 upload script implemented and tested
- ✅ Supabase publishing script implemented and tested

### Testing Checklist Before ANY Changes
1. ✅ Run step in dry-run mode first
2. ✅ Verify input files exist and are accessible
3. ✅ Test with single item before batch processing
4. ✅ Check output files are created correctly
5. ✅ Verify no existing files are overwritten incorrectly

---

## 🔒 PROTECTED WORKFLOW #3: CURATR Platform User Collections

**Status**: ✅ PRODUCTION - LIVE ON WEB
**Location**: `C:/Development/repositories/curatr-platform/`

### What It Does
Allows users to create and share golf style collections on the CURATR platform.

### Critical Pages (DO NOT MODIFY WITHOUT TESTING)
- `app/collections/[id]/page.tsx` - Collection detail page with Style Story
- `app/profile/page.tsx` - User profile with collections
- `app/api/collections/[id]/story/route.ts` - API for fetching HTML stories from R2

### Critical Features (DO NOT BREAK)
- ✅ Collection detail pages display correctly
- ✅ Style Story section shows AI-generated or default content
- ✅ Share button works on collection pages
- ✅ Affiliate links generate correctly for products
- ✅ Collections sync with Supabase database

### Testing Checklist Before ANY Changes
1. ✅ Visit live collection page (e.g., /collections/[id])
2. ✅ Verify Style Story displays
3. ✅ Verify Share button works
4. ✅ Verify product links are affiliate links
5. ✅ Test on mobile and desktop

---

## 📋 PRE-COMMIT CHECKLIST FOR PROTECTED WORKFLOWS

Before committing ANY changes to files in protected workflows:

### Step 1: Documentation Review
- [ ] Read this PROTECTED_WORKFLOWS.md file
- [ ] Read workflow-specific documentation
- [ ] Check git log for recent changes
- [ ] Verify current working state

### Step 2: Impact Analysis
- [ ] List all files being modified
- [ ] Identify all dependent systems
- [ ] Document potential breaking changes
- [ ] Plan rollback strategy

### Step 3: Testing
- [ ] Test the EXACT user workflow end-to-end
- [ ] Verify all existing functionality still works
- [ ] Test edge cases and error scenarios
- [ ] Document test results

### Step 4: Approval
- [ ] Show user what you're changing and why
- [ ] Get explicit approval before committing
- [ ] Commit with descriptive message
- [ ] Verify commit succeeded

### Step 5: Verification
- [ ] Test again after commit
- [ ] Verify no regressions introduced
- [ ] Update documentation if needed
- [ ] Tag as production-ready if major milestone

---

## 🚨 EMERGENCY ROLLBACK CONTACTS

If a protected workflow breaks:

1. **Stop immediately** - Don't make it worse
2. **Check git history** for last working commit
3. **Rollback to last known good state**
4. **Document what broke and why**
5. **Inform user of rollback**

---

## 📝 CHANGELOG

### 2025-11-17: Manual Posting Tool Crisis
- **What Broke**: AI enhancement, manifest loading, HTML parsing, content persistence
- **Root Cause**: Didn't verify dependencies, didn't test workflow, didn't read docs
- **Time Lost**: 6 hours
- **Fixes Applied**: 4 commits (b28ae75, c6b40e8, c720ced, 37010fa)
- **Lesson Learned**: ALWAYS read docs and test BEFORE touching production code

---

## 🎯 GOLDEN RULE

**"If it's working in production and generating value, DON'T TOUCH IT without explicit approval, thorough testing, and a rollback plan."**

This document is your safety net. Use it. Follow it. Protect the user's investment.
