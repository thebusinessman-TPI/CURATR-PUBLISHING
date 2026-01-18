---
name: social-publishing-ops
description: Manual social media publishing workflow for Instagram Reels, TikTok, and YouTube Shorts. Covers the 216 collection backlog, platform requirements, caption/hashtag strategies, and status tracking.
---

# Social Publishing Operations

You are guiding Ryan through the manual social media publishing workflow for CURATR. The goal is to efficiently post 216 ready-to-publish collections across Instagram Reels, TikTok, and YouTube Shorts while tracking progress and preparing for future automation.

## Current State

| Metric | Value |
|--------|-------|
| **Total Collections Ready** | 216 |
| **Posted** | 0 (track via dashboard) |
| **Platforms** | Instagram Reels, TikTok, YouTube Shorts |
| **Workflow** | Manual via `manual_posting_tool.html` |

---

## Manual Posting Tool

**Location:** `C:\Development\repositories\CURATR-PUBLISHING\tools\manual_posting_tool.html`

Open in browser (Chrome recommended) to access the dashboard.

### Dashboard Features

| Feature | Description |
|---------|-------------|
| **Platform Tabs** | Switch between Instagram, TikTok, YouTube |
| **Brand Filter** | Focus on specific brands |
| **Status Filter** | Pending / Posted |
| **Search** | Find collections by ID or keywords |
| **Copy Content** | One-click copy hook + caption + hashtags |
| **Download Video** | Download video file for upload |
| **Mark as Posted** | Track completion status |

### Status Tracking

Status is stored in **browser localStorage**:
- Persists on refresh
- Does NOT sync between computers
- Use one computer for tracking, or manually update both

**Status Flow:** `Pending` --> `Posted`

---

## Platform Specifications

### Universal Video Specs

| Spec | Value |
|------|-------|
| **Dimensions** | 1080 x 1920 pixels |
| **Aspect Ratio** | 9:16 (vertical) |
| **Format** | MP4 |
| **Resolution** | Full HD |

### Instagram Reels

| Spec | Requirement |
|------|-------------|
| **Duration** | 15-90 seconds (shorter performs better) |
| **Aspect Ratio** | 9:16 |
| **Safe Zones** | Keep text/logos away from edges (UI overlays) |
| **Captions** | Enabled by default, ensure text is readable |
| **Audio** | Add trending audio for better reach |

**Caption Format:**
```
[HOOK - Bold opening statement]

[CAPTION - 2-3 sentences about the outfit]

[HASHTAGS - 10 hashtags]

[CTA - "Link in bio" + affiliate disclosure]
```

**Example:**
```
Classic edge, built for heat & hustle

Golf isn't separate from your life--it's stitched into it. This trifecta delivers heat-defying confidence whether you're chasing birdies or hitting brunch. Style that steps out of the cart and keeps walking.

#AshworthGolf #PumaGolf #GolfStyle #HotWeatherGolf #GolfTrifecta #MensGolfFashion #SpikelessSunday #FairwayFit #PerformanceEdge #CURATR

Step into summer with performance pieces built for real life. Link in bio | We earn from qualifying purchases
```

### TikTok

| Spec | Requirement |
|------|-------------|
| **Duration** | 15-60 seconds (under 60s optimal) |
| **Aspect Ratio** | 9:16 |
| **Safe Zones** | Avoid bottom/right edges (UI overlays) |
| **Sounds** | Add trending sounds for algorithm boost |
| **Hashtags** | Keep minimal (1-3 max) |

**Caption Format:**
```
[HOOK - Bold opening statement]

[CAPTION - 2-3 sentences, conversational tone]
```

**TikTok Differences:**
- NO hashtag dump (algorithm prefers clean captions)
- Add trending sounds manually
- More conversational, less promotional

**Example:**
```
Classic edge, built for heat & hustle

Golf isn't separate from your life--it's stitched into it. This trifecta delivers heat-defying confidence whether you're chasing birdies or hitting brunch. Style that steps out of the cart and keeps walking.
```

### YouTube Shorts

| Spec | Requirement |
|------|-------------|
| **Duration** | Up to 60 seconds (strict limit) |
| **Aspect Ratio** | 9:16 |
| **Safe Zones** | Avoid bottom (channel info overlay) |
| **Description** | Narrative story format |

**Caption Format:**
```
[HOOK - Title-worthy opening]

[COORDINATION STORY - Narrative about how pieces work together]
```

**YouTube Differences:**
- Uses "Coordination Story" - more editorial, less promotional
- Narrative focus on how pieces complement each other
- Hook serves as video title

**Example:**
```
Classic edge, built for heat & hustle

The belt's textured finish grounds the elevated utility of the Ashworth Tech Vest--precise but relaxed. Anchor it with Puma's AP Classic G shoes for a lightweight boost that translates from fairway to city streets. Clean lines. Heat-ready. Always in play.
```

---

## Hashtag Strategy

### Instagram Hashtags (10 per post)

**Structure:**
- 2-3 Brand hashtags (e.g., #AshworthGolf, #PumaGolf)
- 3-4 Category hashtags (e.g., #GolfStyle, #MensGolfFashion)
- 2-3 Niche hashtags (e.g., #SpikelessSunday, #FairwayFit)
- 1 CURATR hashtag (#CURATR)

**High-Performing Golf Hashtags:**
| Category | Hashtags |
|----------|----------|
| **Style** | #GolfStyle #GolfFashion #GolfOOTD #FairwayFashion |
| **Performance** | #GolfGear #GolfApparel #PerformanceGolf |
| **Lifestyle** | #GolfLife #GolfAddict #GolfDaily #WeekendGolfer |
| **Weather** | #HotWeatherGolf #SummerGolf #AllWeatherGolf |
| **Format** | #GolfReel #GolfReels #GolfContent |

### TikTok Hashtags (1-3 max)

Keep it minimal and relevant:
- #GolfTok
- #GolfStyle
- Brand hashtag if trending

### YouTube Shorts Hashtags

Add to description:
- #Shorts
- #GolfStyle
- Brand hashtags

---

## Optimal Posting Times

### Instagram

| Day | Best Times (EST) |
|-----|------------------|
| **Weekdays** | 6-9 AM, 12-2 PM, 7-9 PM |
| **Saturday** | 9-11 AM |
| **Sunday** | 10 AM - 2 PM |

**Peak Engagement:** Tuesday-Thursday mornings

### TikTok

| Day | Best Times (EST) |
|-----|------------------|
| **Weekdays** | 7-9 AM, 12-3 PM, 7-11 PM |
| **Weekend** | 9 AM - 12 PM |

**TikTok Note:** More flexible, algorithm-driven discovery

### YouTube Shorts

| Day | Best Times (EST) |
|-----|------------------|
| **Weekdays** | 12-3 PM, 7-9 PM |
| **Weekend** | 9-11 AM |

---

## Daily Posting Workflow

### Recommended Cadence

| Platform | Posts/Day | Time Investment |
|----------|-----------|-----------------|
| **Instagram** | 2-3 | 10-15 min |
| **TikTok** | 3-5 | 15-20 min |
| **YouTube Shorts** | 1-2 | 5-10 min |
| **Total** | 6-10 | 30-45 min |

### Step-by-Step Process

#### 1. Open Dashboard
```
C:\Development\repositories\CURATR-PUBLISHING\tools\manual_posting_tool.html
```

#### 2. Select Collection
- Use Brand Filter if focusing on specific brand
- Filter by "Pending" status
- Pick collection to post

#### 3. Prepare Content
1. Click platform tab (Instagram/TikTok/YouTube)
2. Click **Copy Content** button
3. Click **Download Video** button

#### 4. Post to Platform

**Instagram:**
1. Open Instagram app
2. Create new Reel
3. Upload downloaded video
4. Paste content into caption
5. Add trending audio (optional)
6. Tag brand accounts (optional)
7. Post

**TikTok:**
1. Open TikTok app
2. Create new video
3. Upload downloaded video
4. Paste content (hook + caption only)
5. Add trending sound
6. Post

**YouTube:**
1. Open YouTube app
2. Create new Short
3. Upload downloaded video
4. Paste content into title/description
5. Post

#### 5. Update Status
Return to dashboard and click **Mark as Posted**

---

## Batching Strategy

For efficiency, batch your work:

### Option 1: Platform Focus
Post all collections to one platform before moving to next:
1. Post 5 to Instagram
2. Post 5 to TikTok
3. Post 5 to YouTube Shorts

### Option 2: Collection Focus
Post each collection to all platforms before moving to next:
1. Collection A --> Instagram, TikTok, YouTube
2. Collection B --> Instagram, TikTok, YouTube

### Option 3: Download-First
Download all videos first, then post:
1. Download 10 videos
2. Batch upload to Instagram
3. Batch upload to TikTok
4. Batch upload to YouTube

---

## 216 Collection Backlog Plan

### Sprint Strategy

| Week | Collections | Daily Target | Platform Distribution |
|------|-------------|--------------|----------------------|
| 1-2 | 50 | 5/day | Focus Instagram, add TikTok |
| 3-4 | 70 | 5/day | All three platforms |
| 5-6 | 70 | 5/day | All three platforms |
| 7-8 | 26 | 3/day | Clear backlog |

### Brand Rotation

Rotate through brands for variety:
- BadBirdie (6 collections)
- BettinardiGolf (8 collections)
- BirdsOfCondor (14 collections)
- Callaway (4 collections)
- Coolibar (4 collections)
- Criquet (4 collections)
- GFORE (2 collections)
- MalbonGolf (8 collections)
- MUNICIPAL (4 collections)
- PumaGolf (6 collections)
- StitchGolf (2 collections)
- SwagGolfCo (6 collections)
- TRUElinkswear (4 collections)
- Vice (2 collections)
- YETI (2 collections)
- Multi-brand collections (146+ collections)

### Progress Tracking

Track weekly progress:

```
Week of: [DATE]
Collections Posted: [X] / 216
Platforms Completed:
- Instagram: [X]
- TikTok: [X]
- YouTube Shorts: [X]

Top Performers: [Note which content gets best engagement]
```

---

## Content Quality Checklist

Before posting each collection:

- [ ] Video plays correctly (no corruption)
- [ ] Caption is appropriate for platform
- [ ] Hashtags included (Instagram only)
- [ ] No typos in hook/caption
- [ ] CTA and disclosure present (Instagram)
- [ ] Video duration within platform limits

---

## Engagement Best Practices

### First Hour After Posting

- Respond to comments quickly
- Like early comments
- Check for any issues with post

### Ongoing

- Monitor analytics weekly
- Note top-performing content types
- Adjust posting times based on data
- Engage with golf community accounts

---

## Future Automation (Agent Fleet Phase 2)

### Current Manual Workflow Limitations

- Time-intensive (30-45 min/day)
- Status doesn't sync across devices
- No scheduling capability
- No analytics integration

### Phase 2 Goals

| Feature | Description |
|---------|-------------|
| **API Posting** | Direct integration with Instagram, TikTok, YouTube APIs |
| **Scheduling** | Queue posts for optimal times |
| **Cloud Status** | Sync posting status via Supabase |
| **Analytics** | Track performance metrics automatically |
| **Auto-Generation** | Generate new collections automatically |

### Preparation Steps

1. Document what works in manual workflow
2. Track high-performing content patterns
3. Build posting time database
4. Identify API requirements per platform

---

## Troubleshooting

### Dashboard Issues

| Problem | Solution |
|---------|----------|
| Collections not loading | Check internet connection, refresh page |
| Video won't download | Right-click and "Save As", check Downloads folder |
| Copy not working | Click again, or manually select and copy |
| Status not saving | Check localStorage isn't blocked |

### Platform Issues

| Problem | Solution |
|---------|----------|
| Video rejected | Check aspect ratio (9:16), duration, format (MP4) |
| Caption too long | Shorten caption, remove some hashtags |
| Poor engagement | Test different posting times, add trending audio |
| Account restricted | Wait 24-48 hours, reduce posting frequency |

---

## Quick Reference

### File Locations

| Resource | Path |
|----------|------|
| Manual Posting Tool | `CURATR-PUBLISHING/tools/manual_posting_tool.html` |
| Manifest | `CURATR-PUBLISHING/data/manifests/publishing_manifest_complete_217.json` |
| Sample Videos | `CURATR-PUBLISHING/data/videos/` |
| Workflow Docs | `CURATR-PUBLISHING/docs/` |

### Key Metrics

| Metric | Target |
|--------|--------|
| Daily Posts | 6-10 across all platforms |
| Weekly Collections | 10-15 complete |
| Backlog Completion | 8 weeks |
| Engagement Rate | 3-5% (industry average) |

### Brand Colors

| Element | Hex Code |
|---------|----------|
| Primary | #667eea |
| Secondary | #764ba2 |
| Accent | #f59e0b |

---

*Skill Version: 1.0*
*Created: January 18, 2026*
