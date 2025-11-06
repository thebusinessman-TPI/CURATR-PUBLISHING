# CURATR Publishing

**Central repository for all CURATR social media publishing, content management, and automation.**

This repository consolidates all publishing-related assets, tools, and workflows for CURATR's social media presence across Instagram, TikTok, and YouTube.

---

## 📁 Repository Structure

```
CURATR-PUBLISHING/
├── data/
│   ├── manifests/          # Publishing manifest JSON files
│   └── videos/             # Generated video assets for posts
├── tools/                  # Manual posting tools and utilities
├── assets/
│   └── templates/          # Canva templates and design assets
├── docs/
│   └── planning/           # Documentation and planning materials
└── workflows/              # Automation scripts (future)
```

---

## 🎯 Current Status

**Collections Ready:** 217  
**Posted:** 0  
**Pending:** 217

**Platforms:**
- Instagram
- TikTok
- YouTube (future)

---

## 🚀 Quick Start: Manual Posting

Until automation is complete, use the manual posting tool:

1. Open `tools/manual_posting_tool.html` in your browser
2. Browse the 217 collections
3. Click platform buttons (Instagram/TikTok) to switch content
4. Click "Copy Content" to get the full Hook, Caption, and Hashtags
5. Download the video from `data/videos/`
6. Create post in Canva using templates (see below)
7. Post to social media
8. Click "Mark Posted" to track progress

---

## 🎨 Canva Templates

**Coming Soon:** Streamlined templates for Instagram and TikTok posts.

**Template Features:**
- Pre-formatted text areas for Hook, Caption, Hashtags
- Video placeholder for easy drag-and-drop
- Brand-consistent styling
- Platform-specific dimensions (Instagram: 1080x1920, TikTok: 1080x1920)

---

## ⚠️ Important Reminders

### 1. Local Sync Script Update Required

The local PowerShell sync script needs to be updated to include this repository:

**Location:** `C:\Development\scripts\sync_all_repositories.ps1`

**Action:** Add `CURATR-PUBLISHING` to the repository list and run:
```powershell
cd C:\Development\scripts
.\sync_all_repositories.ps1 -Verbose
```

### 2. Protect Existing Workflows

**CRITICAL:** When migrating assets from `CURATR_Content_Engine` or other repositories, ensure:
- Original files remain in place if referenced by existing workflows
- Copy (don't move) files initially to avoid breaking dependencies
- Test all existing workflows after migration
- Document any changes to file paths or references

**Affected Repositories:**
- `CURATR_Content_Engine` - Content generation workflows
- `curatr-platform` - Web platform and database
- `CURATR-Collections-Platform` - Collection management

---

## 📊 Publishing Manifest

The complete publishing manifest is located at:
```
data/manifests/publishing_manifest_complete_217.json
```

**Structure:**
```json
{
  "collection_id": "...",
  "title": "...",
  "description": "...",
  "brand": "...",
  "video_path": "...",
  "platforms": {
    "instagram": {
      "hook": "...",
      "caption": "...",
      "hashtags": "..."
    },
    "tiktok": {
      "hook": "...",
      "caption": "...",
      "hashtags": "..."
    },
    "youtube": {
      "hook": "...",
      "caption": "...",
      "hashtags": "..."
    }
  },
  "posted": false,
  "posted_date": null
}
```

---

## 🔄 Workflow Roadmap

### Phase 1: Manual Posting (Current)
- ✅ Consolidated repository created
- ✅ Manual posting tool built
- 🔄 Canva templates in progress
- 🔄 Posting workflow documentation

### Phase 2: Semi-Automation
- ⏳ Canva API integration
- ⏳ Bulk content export
- ⏳ Posting tracking system

### Phase 3: Full Automation
- ⏳ Instagram API integration
- ⏳ TikTok API integration
- ⏳ Scheduled posting
- ⏳ Analytics tracking

---

## 📝 Contributing

This repository is actively being developed. Please coordinate with the team before making changes to ensure alignment with ongoing work.

---

## 🔗 Related Repositories

- [curatr-platform](https://github.com/thebusinessman-TPI/curatr-platform) - Main web platform
- [CURATR_Content_Engine](https://github.com/thebusinessman-TPI/CURATR_Content_Engine) - Content generation
- [CURATR-Collections-Platform](https://github.com/thebusinessman-TPI/CURATR-Collections-Platform) - Collection management

---

**Last Updated:** November 6, 2025  
**Maintained by:** CURATR Team
