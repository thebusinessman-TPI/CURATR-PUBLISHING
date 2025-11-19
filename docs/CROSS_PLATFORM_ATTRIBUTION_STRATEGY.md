# Cross-Platform Attribution Strategy
**Date:** November 19, 2025
**Status:** ✅ Implemented for Manual Publishing

---

## 🎯 Strategic Rationale

**Problem:** You wouldn't attribute an Instagram handle on TikTok and vice versa.

**Solution:** UGC attribution is limited to the user's **primary social platform** only, while admin/staff collections get attribution across ALL platforms.

---

## 📋 Business Rules

### For UGC Collections:
- User has `primary_social_platform` set in profile (Instagram, TikTok, YouTube, Facebook)
- **Attribution ONLY appears on their primary platform**
- Other platforms: No attribution OR generic "Curated by CURATR Community"

**Example:**
- User: @ryanngormann
- Primary Platform: Instagram
- Publishing:
  - ✅ Instagram post: "Curated by @ryanngormann"
  - ❌ TikTok post: No attribution (or "CURATR Community")
  - ❌ YouTube Short: No attribution (or "CURATR Community")
  - ❌ Facebook post: No attribution (or "CURATR Community")

### For Admin Collections (Staff Influencers):
- **Attribution appears on ALL platforms**
- Staff are building personal brands across multiple channels
- Example: @thebusinessman gets credit on Instagram, TikTok, YouTube, Facebook

---

## ✅ Current Implementation (Manual Publishing)

### What's Been Built:

**1. Manual Posting Tool Updates**
- ✅ Queries Supabase `user_profiles` table
- ✅ Fetches `primary_social_platform` for each collection
- ✅ Displays next to attribution handle

**Display Example:**
```
RADMOR_outfit_sixy_20251117_144705
👤 @thebusinessman
📱 Primary Platform: Instagram  ← NEW!

Hook: Six pieces that redefine...
```

**2. Decision Support**
The manual publisher can now see:
- The user's handle (@username)
- Their primary platform
- Make the decision: "Only include attribution when posting to Instagram"

**3. Database Schema**
Already exists in `user_profiles`:
- `primary_social_platform` (instagram | tiktok | youtube | facebook)
- `instagram_handle`
- `tiktok_handle`
- `youtube_handle`
- `twitter_handle`

---

## 🔮 Future Implementation (Automated Publishing)

### When Building Automation:

**Logic Flow:**
```javascript
async function publishCollection(collection, targetPlatforms) {
  // Determine collection source
  const isUGC = collection.source === 'ugc';
  const isAdmin = collection.source === 'admin';

  for (const platform of targetPlatforms) {
    let attribution = null;

    if (isAdmin) {
      // Staff collections: ALWAYS include attribution
      attribution = `Curated by ${collection.user_name}`;
    } else if (isUGC) {
      // UGC collections: ONLY on primary platform
      const userPrimaryPlatform = collection.user_profile.primary_social_platform;

      if (platform === userPrimaryPlatform) {
        // Get platform-specific handle
        const handleField = `${platform}_handle`;
        attribution = `Curated by ${collection.user_profile[handleField]}`;
      } else {
        // Other platforms: generic or no attribution
        attribution = null; // or "Curated by CURATR Community"
      }
    }

    // Build and publish post with appropriate attribution
    await publishToplatform(platform, collection, attribution);
  }
}
```

---

## 🔧 Technical Implementation

### Manual Posting Tool (Current)

**File:** `CURATR-PUBLISHING/tools/manual_posting_tool.html`

**Key Functions:**

1. **Supabase Integration:**
```javascript
const supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
```

2. **User Profile Lookup:**
```javascript
async function getUserPrimaryCPlatform(userName) {
  // Queries user_profiles by matching handle or display_name
  // Returns primary_social_platform
}
```

3. **Collection Loading:**
```javascript
// After loading HTML from R2
await Promise.all(collections.map(async (collection) => {
  if (collection.userName) {
    collection.primaryPlatform = await getUserPrimaryCPlatform(collection.userName);
  }
}));
```

4. **Display:**
```html
<!-- Shows both handle and primary platform -->
👤 @username
📱 Primary Platform: Instagram
```

---

## 🎨 User Experience

### For Manual Publishers (NOW):
1. Open manual posting tool
2. See collection with attribution info:
   - `👤 @ryanngormann`
   - `📱 Primary Platform: Instagram`
3. When posting to Instagram: Include attribution
4. When posting to TikTok/YouTube/Facebook: Omit attribution

### For Automated System (FUTURE):
1. System detects UGC collection
2. Checks user's `primary_social_platform`
3. Automatically includes attribution ONLY on that platform
4. Other platforms post without user attribution

---

## 📊 Data Sources

### Primary Data Flow:
```
User Profile (Supabase)
  ↓ primary_social_platform
Manual Posting Tool
  ↓ Display to publisher
Manual Decision
  ↓ Include/exclude attribution
Social Media Post
```

### Future Automated Flow:
```
User Profile (Supabase)
  ↓ primary_social_platform
Automation Script
  ↓ Conditional logic
Platform-Specific Posts
  ↓ Attribution on primary only
Social Media APIs
```

---

## 🧪 Testing Scenarios

### Test Case 1: UGC - Instagram Primary
- User: @ryanngormann
- Primary: Instagram
- Expected:
  - ✅ Instagram: "Curated by @ryanngormann"
  - ❌ TikTok: No attribution
  - ❌ YouTube: No attribution
  - ❌ Facebook: No attribution

### Test Case 2: Admin - Multi-Platform
- User: @thebusinessman
- Type: Admin/Staff
- Expected:
  - ✅ Instagram: "Curated by @thebusinessman"
  - ✅ TikTok: "Curated by @thebusinessman"
  - ✅ YouTube: "Curated by @thebusinessman"
  - ✅ Facebook: "Curated by @thebusinessman"

### Test Case 3: UGC - TikTok Primary
- User: @golfstyle_tk
- Primary: TikTok
- Expected:
  - ❌ Instagram: No attribution
  - ✅ TikTok: "Curated by @golfstyle_tk"
  - ❌ YouTube: No attribution
  - ❌ Facebook: No attribution

---

## 🎯 Benefits

### For UGC Creators:
- ✅ Attribution drives followers to their PRIMARY platform
- ✅ Respects platform-specific audience building
- ✅ Prevents confusion (no Instagram handle shown on TikTok)

### For CURATR:
- ✅ Professional, platform-appropriate content
- ✅ Builds trust with creators
- ✅ Supports multi-platform publishing at scale

### For Staff Influencers:
- ✅ Multi-platform brand building
- ✅ Consistent attribution across channels
- ✅ Grows personal influence in golf fashion space

---

## 📝 Next Steps

### Phase 1: Manual Publishing (✅ COMPLETE)
- ✅ Display primary platform in tool
- ✅ Enable informed manual decisions
- ✅ Document strategy

### Phase 2: Semi-Automated Helper
- 🔲 Add "Recommended Attribution" indicator
- 🔲 Highlight when posting to primary platform
- 🔲 Warning when posting UGC to non-primary platform

### Phase 3: Full Automation
- 🔲 Build automated publishing pipeline
- 🔲 Implement conditional attribution logic
- 🔲 Test across all platforms
- 🔲 Monitor attribution accuracy

---

## 🔐 Privacy & Permissions

### User Profiles Access:
- Manual tool uses Supabase anon key (read-only)
- Only fetches: `primary_social_platform`, handle fields, `display_name`
- No sensitive data exposed in browser

### Future Automation:
- Will use service role key (server-side only)
- Never expose user data in client-side code

---

## ✅ Acceptance Criteria - ALL MET

- ✅ Primary platform displayed in manual posting tool
- ✅ Publisher can see which platform gets attribution
- ✅ Data flows from user_profiles to tool
- ✅ Handles both @handles and full names
- ✅ Works for UGC and Admin collections
- ✅ Schema already supports all platforms
- ✅ Documentation complete for automation

---

**Status:** ✅ Manual Implementation Complete
**Ready For:** Automated publishing pipeline development
**Impact:** Professional, platform-appropriate UGC attribution at scale
