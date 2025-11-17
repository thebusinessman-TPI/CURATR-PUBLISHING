# PRE-COMMIT CHECKLIST - Protect Production Workflows

## ⚠️ MANDATORY CHECKLIST BEFORE COMMITTING ANY CODE CHANGES

This checklist MUST be completed before committing changes to ANY production-grade files. **No exceptions.**

---

## Step 1: Documentation Review (REQUIRED)

Before writing ANY code:

- [ ] Read `PROTECTED_WORKFLOWS.md` to verify this file is not protected
- [ ] Read workflow-specific documentation (e.g., `MANUAL_POSTING_TOOL.md`)
- [ ] Check git log for recent changes to understand context
- [ ] Verify current working state before making changes

**Commands**:
```bash
# View recent commits
git log --oneline -10

# Check what changed recently in this file
git log -p --follow <file_path>

# View current file diff before editing
git diff <file_path>
```

---

## Step 2: Read Before Edit (REQUIRED)

- [ ] Read the ENTIRE file you're about to modify (use Read tool)
- [ ] Understand the full context and all dependencies
- [ ] Identify all functions/sections that depend on what you're changing
- [ ] Map out potential side effects of your change

**Why This Matters**:
- Prevents breaking dependent code you didn't know existed
- Reveals configuration dependencies (URLs, keys, etc.)
- Shows you the established patterns and conventions
- Helps you spot related code that also needs updating

---

## Step 3: Impact Analysis (REQUIRED)

- [ ] List ALL files being modified in this commit
- [ ] Identify ALL systems that depend on these files
- [ ] Document potential breaking changes
- [ ] Plan rollback strategy (which commit to revert to if needed)

**Questions to Answer**:
1. What files are being changed?
2. What workflows use these files?
3. What external services do these files depend on?
4. What will break if this change fails?
5. Can I rollback easily?

---

## Step 4: Dependency Verification (REQUIRED)

For ANY changes involving external services:

### If changing URLs:
- [ ] Verify new URL is accessible (curl test)
- [ ] Confirm required files exist at new location
- [ ] Test with sample data before switching
- [ ] Keep old URL as fallback if possible

### If changing API endpoints:
- [ ] Test new endpoint with real credentials
- [ ] Verify response format matches expectations
- [ ] Check rate limits and quotas
- [ ] Confirm API key/secret is valid

### If changing manifest/data files:
- [ ] Verify file exists in storage (R2, S3, etc.)
- [ ] Check file structure matches code expectations
- [ ] Confirm file count/size is correct
- [ ] Test parsing with sample data

### If changing environment variables/secrets:
- [ ] Verify secret is set in deployment environment
- [ ] Test with actual secret value (not placeholder)
- [ ] Confirm secret has required permissions
- [ ] Document secret name and where it's used

**Commands**:
```bash
# Test URL accessibility
curl -I <url>

# Test API endpoint
curl -X POST <api_url> -H "Content-Type: application/json" -d '{"test":"data"}'

# Test R2/S3 file exists
aws s3 ls s3://<bucket>/<path> --endpoint-url <endpoint>

# Verify Cloudflare Worker secret
wrangler secret list --name <worker_name>
```

---

## Step 5: Testing (REQUIRED)

### A. Unit Testing (Code-Level)
- [ ] Test the specific function/component you modified
- [ ] Test with valid inputs
- [ ] Test with invalid/edge case inputs
- [ ] Test error handling

### B. Integration Testing (System-Level)
- [ ] Test the EXACT user workflow end-to-end
- [ ] Verify all existing functionality still works
- [ ] Test on actual production data (not mock data)
- [ ] Test in same environment as production (browser, OS, etc.)

### C. Regression Testing (Workflow-Level)
For Manual Posting Tool changes:
- [ ] Load page → Verify 276 collections load
- [ ] Click collection → Verify modal opens
- [ ] Check Instagram tab → Verify HTML content displays
- [ ] Check TikTok tab → Verify AI content generates
- [ ] Check X.com tab → Verify different AI content
- [ ] Check Facebook tab → Verify different AI content
- [ ] Refresh page → Verify AI content persists
- [ ] Test "Copy Content" buttons work
- [ ] Test "Regenerate" button works
- [ ] Test "Mark as Posted" works

For Content Engine changes:
- [ ] Run step in dry-run mode first
- [ ] Test with single item before batch
- [ ] Verify output files are created correctly
- [ ] Check no existing files are overwritten incorrectly

For Platform changes:
- [ ] Test collection detail page loads
- [ ] Test Style Story displays correctly
- [ ] Test Share button works
- [ ] Test affiliate links generate correctly

### D. Error Scenario Testing
- [ ] Test with missing dependencies (e.g., offline)
- [ ] Test with invalid inputs
- [ ] Test with missing files/data
- [ ] Verify graceful error handling (no crashes)

**Document Test Results**:
```
Tested:
- [ ] Feature X: ✅ Working
- [ ] Feature Y: ✅ Working
- [ ] Feature Z: ❌ Broken (reverted change)

Test Environment:
- Browser: Chrome 119
- OS: Windows 11
- Date: 2025-11-17
```

---

## Step 6: User Approval (REQUIRED for Production Files)

Before committing changes to protected workflows:

- [ ] Show user what you're changing and why
- [ ] Explain potential risks and rollback plan
- [ ] Demonstrate working test results
- [ ] Get explicit "YES, COMMIT IT" approval

**Template Message to User**:
```
I'm ready to commit the following changes:

Files Modified:
- <file1>: <what changed>
- <file2>: <what changed>

Reason:
<why this change is necessary>

Testing Completed:
✅ <test 1 passed>
✅ <test 2 passed>
✅ <test 3 passed>

Rollback Plan:
If this breaks, I will revert to commit <hash> using:
git checkout <hash> <file_path>

May I commit these changes?
```

---

## Step 7: Commit with Quality Message (REQUIRED)

- [ ] Write descriptive commit message (not "fix stuff" or "update")
- [ ] Include WHAT changed, WHY, and IMPACT
- [ ] Reference any related issues or docs
- [ ] Use consistent commit message format

**Commit Message Template**:
```
<Type>: <Short summary in imperative mood>

<Detailed description of what changed and why>

## Changes Made
- Changed <file> to <what>
- Updated <component> to <what>
- Fixed <issue> by <how>

## Testing
- Tested <scenario 1>: ✅ Passed
- Tested <scenario 2>: ✅ Passed

## Impact
- ✅ <positive impact>
- ⚠️ <warning or consideration>

## Rollback
Revert to commit <hash> if needed

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Commit Types**:
- `Fix:` - Bug fix
- `Update:` - Non-breaking change to existing feature
- `Add:` - New feature or file
- `Remove:` - Deletion of feature or file
- `Refactor:` - Code restructuring without behavior change
- `Docs:` - Documentation only
- `Test:` - Test-related changes

**Commands**:
```bash
# Stage specific files only (not everything)
git add <file1> <file2>

# Commit with detailed message
git commit -m "$(cat <<'EOF'
<commit message here>
EOF
)"

# Verify commit before pushing
git log -1 --stat
```

---

## Step 8: Post-Commit Verification (REQUIRED)

After committing:

- [ ] Test again after commit to ensure nothing broke
- [ ] Verify git status is clean (no untracked changes)
- [ ] Push to remote if ready for deployment
- [ ] Update documentation if behavior changed
- [ ] Tag as production-ready if major milestone

**Commands**:
```bash
# Test workflow again
<run same tests as Step 5>

# Check git status
git status

# View what was committed
git show HEAD

# Push to remote
git push origin main

# Tag production release (if applicable)
git tag -a production-<name>-v1.0 -m "Production-ready version"
git push origin production-<name>-v1.0
```

---

## Step 9: Monitor for Issues (REQUIRED)

After deploying:

- [ ] Monitor for errors in first 30 minutes
- [ ] Check browser console for JS errors
- [ ] Check server logs for API errors
- [ ] Verify user reports no issues

**If Issues Detected**:
1. ❌ **STOP IMMEDIATELY**
2. ❌ Document the error
3. ❌ Rollback to last working commit
4. ❌ Inform user of rollback
5. ❌ Fix issue in separate branch, test thoroughly, then re-deploy

---

## Emergency Rollback Procedure

If something breaks after commit:

```bash
# 1. Find last working commit
git log --oneline

# 2. Revert specific file to last working version
git checkout <last-working-commit-hash> <file_path>

# 3. Test to confirm it works again
<run tests>

# 4. Commit the revert
git commit -m "Revert: Rollback <file> to working version due to <issue>"

# 5. Push immediately
git push origin main

# 6. Inform user
# "Rolled back to commit <hash> due to <issue>.
#  Workflow is working again. Will fix properly and re-test."
```

---

## Common Mistakes to Avoid

### ❌ DON'T:
- Don't commit without reading the file first
- Don't change URLs without verifying they work
- Don't update dependencies without testing
- Don't modify production code without user approval
- Don't commit with vague messages ("fix", "update")
- Don't skip testing "because it's a small change"
- Don't assume external services still work
- Don't make "improvements" without explicit request

### ✅ DO:
- Read ENTIRE file before editing
- Test EXACT user workflow before committing
- Verify ALL external dependencies
- Get user approval for production changes
- Write descriptive commit messages
- Test edge cases and error scenarios
- Document what you tested and results
- Plan rollback strategy before deploying

---

## Checklist Summary (Print and Check Off)

```
Pre-Commit Checklist for: _______________________________

Date: ____________  Files Modified: ____________________

□ Read PROTECTED_WORKFLOWS.md
□ Read workflow-specific docs
□ Checked git log for context
□ Read ENTIRE file before editing
□ Identified all dependencies
□ Verified external services work
□ Tested unit level
□ Tested integration level
□ Tested regression scenarios
□ Tested error scenarios
□ Documented test results
□ Got user approval (if production file)
□ Wrote descriptive commit message
□ Committed changes
□ Tested again after commit
□ Pushed to remote
□ Monitoring for issues

Rollback Plan: git checkout _______ <file>

Approved by: ________________  Date: ________
```

---

## Examples

### Example 1: Updating Manifest URL (Manual Posting Tool)

**Scenario**: Need to update manifest from 216 to 276 collections

**Checklist**:
- ✅ Read PROTECTED_WORKFLOWS.md → Manual Posting Tool is protected
- ✅ Read MANUAL_POSTING_TOOL.md → Understand manifest dependency
- ✅ Read manual_posting_tool.html → Found MANIFEST_URL on line 371
- ✅ Verify new manifest exists in R2:
  ```bash
  curl -I https://pub-de854dc1e16444499a966af3528a083c.r2.dev/manifests/publishing_manifest_complete_276.json
  # Returns: HTTP/2 200 ✅
  ```
- ✅ Test manifest loads correctly:
  ```bash
  curl https://pub-de854dc1e16444499a966af3528a083c.r2.dev/manifests/publishing_manifest_complete_276.json | jq 'length'
  # Returns: 276 ✅
  ```
- ✅ Make change: Update line 371 to point to 276 manifest
- ✅ Test workflow: Load page → Verify 276 collections load ✅
- ✅ Get user approval: "May I update the manifest URL to load 276 collections?"
- ✅ User approves: "YES"
- ✅ Commit:
  ```bash
  git add tools/manual_posting_tool.html
  git commit -m "Update: Load 276-collection manifest in manual posting tool"
  git push origin main
  ```
- ✅ Test again: Collections still load ✅
- ✅ Monitor: No errors in console ✅

**Result**: ✅ Successful deployment, no regressions

---

### Example 2: Fixing AI Enhancement Persistence (Manual Posting Tool)

**Scenario**: AI content generates but doesn't persist in UI

**Checklist**:
- ✅ Read PROTECTED_WORKFLOWS.md → Manual Posting Tool is protected
- ✅ Read MANUAL_POSTING_TOOL.md → Understand caching system
- ✅ Read manual_posting_tool.html → Found generatePlatformContent()
- ✅ Identified issue: localStorage saves but UI doesn't refresh
- ✅ Identified solution: Call renderCollections() after cache save
- ✅ Made change: Added renderCollections() on line 559
- ✅ Test workflow:
  - Load page ✅
  - Click collection ✅
  - Click TikTok tab → AI generates ✅
  - Switch to Instagram tab ✅
  - Switch back to TikTok tab → Content still there ✅ (PERSISTENCE WORKS!)
  - Refresh page ✅
  - Click same collection → TikTok content still there ✅ (CACHE WORKS!)
- ✅ Get user approval: "Persistence fix tested and working. May I commit?"
- ✅ User approves: "YES"
- ✅ Commit:
  ```bash
  git add tools/manual_posting_tool.html
  git commit -m "Fix: AI enhancement persistence in manual posting tool

  Added renderCollections() call after caching AI-generated content to
  immediately update UI and persist content across tab switches.

  Tested:
  - AI generation: ✅ Working
  - Tab switching: ✅ Content persists
  - Page refresh: ✅ Content cached

  🤖 Generated with [Claude Code](https://claude.com/claude-code)

  Co-Authored-By: Claude <noreply@anthropic.com>"
  git push origin main
  ```
- ✅ Test again: Persistence still works ✅
- ✅ Monitor: No console errors ✅

**Result**: ✅ Successful deployment, no regressions

---

### Example 3: FAILED Deployment (What NOT to Do)

**Scenario**: "Improving" AI prompts without testing

**What Went Wrong**:
- ❌ Didn't read PROTECTED_WORKFLOWS.md first
- ❌ Didn't test before committing
- ❌ Didn't verify OpenAI API was still working
- ❌ Didn't get user approval
- ❌ Changed API endpoint from OpenAI to Manus proxy without testing
- ❌ Committed with vague message: "update AI"

**Result**:
- ❌ AI generation completely broken
- ❌ All platforms returning identical truncated text
- ❌ 6 hours wasted fixing regressions
- ❌ User frustrated: "VERY DISSAPOINTING REGRESSIONS TODAY CLAUDE"

**Lesson Learned**:
- ✅ ALWAYS read protection docs first
- ✅ ALWAYS test before committing
- ✅ NEVER change external services without verification
- ✅ ALWAYS get user approval for production changes

---

## Final Reminder

**"The most important thing you can do is NOT REGRESS production workflows."**

When in doubt:
1. Read the docs
2. Test thoroughly
3. Ask the user
4. Plan rollback
5. Monitor closely

If you follow this checklist, you will NEVER break production again.

---

**Last Updated**: 2025-11-17
**Version**: 1.0
