# Canva MCP Setup Checklist for NUC1 & NUC2

**Created:** November 7, 2025  
**Purpose:** Quick reference for adding Canva MCP to both NUCs

---

## Pre-Setup Checklist

Before you begin, ensure you have:

- [ ] Manus account access on both NUC1 and NUC2
- [ ] Canva account (free or paid) - [canva.com](https://www.canva.com/)
- [ ] Admin access to Manus Connectors
- [ ] Internet connection on both NUCs

---

## NUC1 Setup

### Step 1: Access Manus Connectors
- [ ] Open browser and go to [manus.im](https://manus.im/)
- [ ] Log in to Manus account
- [ ] Navigate to **Connectors** section

### Step 2: Add Canva MCP
- [ ] Click "+ Connect" or "Add Connector"
- [ ] Select "Custom MCP" option
- [ ] Enter configuration:
  - **Name:** `Canva`
  - **Server URL:** `https://mcp.canva.com/mcp`
  - **Transport:** `Streamable HTTP` (if asked)
  - **Auth:** `OAuth` (if asked)
- [ ] Save configuration

### Step 3: Authenticate
- [ ] Click "Connect" or "Authenticate" on Canva connector
- [ ] Browser opens to Canva OAuth page
- [ ] Log in to Canva
- [ ] Select team (if applicable)
- [ ] Review and grant all permissions
- [ ] Click "Allow" or "Authorize"
- [ ] Confirm "Successfully installed connector" message

### Step 4: Verify
- [ ] Start new conversation in Manus
- [ ] Test prompt: `"Search my Canva designs"`
- [ ] Verify Manus returns results or confirms connection
- [ ] Test prompt: `"Create a simple test design with text 'NUC1 Test'"`
- [ ] Verify design is created in Canva

### Step 5: Mark Complete
- [ ] ✅ NUC1 Canva MCP is configured and working

---

## NUC2 Setup

### Step 1: Access Manus Connectors
- [ ] Open browser and go to [manus.im](https://manus.im/)
- [ ] Log in to Manus account (same account as NUC1)
- [ ] Navigate to **Connectors** section

### Step 2: Add Canva MCP
- [ ] Click "+ Connect" or "Add Connector"
- [ ] Select "Custom MCP" option
- [ ] Enter configuration:
  - **Name:** `Canva`
  - **Server URL:** `https://mcp.canva.com/mcp`
  - **Transport:** `Streamable HTTP` (if asked)
  - **Auth:** `OAuth` (if asked)
- [ ] Save configuration

### Step 3: Authenticate
- [ ] Click "Connect" or "Authenticate" on Canva connector
- [ ] Browser opens to Canva OAuth page
- [ ] Log in to Canva (same account as NUC1)
- [ ] Select team (if applicable)
- [ ] Review and grant all permissions
- [ ] Click "Allow" or "Authorize"
- [ ] Confirm "Successfully installed connector" message

### Step 4: Verify
- [ ] Start new conversation in Manus
- [ ] Test prompt: `"Search my Canva designs"`
- [ ] Verify Manus returns results or confirms connection
- [ ] Test prompt: `"Create a simple test design with text 'NUC2 Test'"`
- [ ] Verify design is created in Canva

### Step 5: Mark Complete
- [ ] ✅ NUC2 Canva MCP is configured and working

---

## Post-Setup Verification

### Check Both NUCs
- [ ] Both NUCs show Canva connector as "Active" or "Connected"
- [ ] Both NUCs can search Canva designs
- [ ] Both NUCs can create new designs
- [ ] Both NUCs authenticated with the same Canva account
- [ ] Test designs from both NUCs appear in the same Canva account

### Test Advanced Features
- [ ] Export a design as PNG
- [ ] Create a folder in Canva
- [ ] Move a design to a folder
- [ ] Search for specific designs by keyword
- [ ] Get design content/details

---

## Troubleshooting Quick Fixes

### If authentication fails:
1. Clear browser cookies for Canva
2. Try different browser
3. Ensure pop-ups not blocked
4. Log out and back into Canva

### If connector doesn't appear:
1. Refresh Manus page
2. Log out and back into Manus
3. Check internet connection
4. Contact Manus support

### If tools don't work:
1. Verify connector shows as "Active"
2. Re-authenticate
3. Restart browser
4. Check Canva account permissions

---

## Configuration Details

**Canva MCP Server URL:**
```
https://mcp.canva.com/mcp
```

**Transport Type:**
```
Streamable HTTP
```

**Authentication:**
```
OAuth (automatic flow)
```

**Required Permissions:**
- Read profile and designs
- Create new designs
- Manage folders and content
- Access team brand templates
- Comment on designs

---

## Next Steps After Setup

Once both NUCs are configured:

1. [ ] Create CURATR master templates in Canva
2. [ ] Test design generation with 5-10 sample collections
3. [ ] Refine prompts for brand consistency
4. [ ] Develop automation workflow
5. [ ] Scale to all 217 collections

---

## Support

**Full Guide:** `ADDING_CANVA_MCP_TO_MANUS.md`

**Manus Help:** [help.manus.im](https://help.manus.im/)

**Canva Docs:** [canva.dev/docs/connect/mcp-server](https://www.canva.dev/docs/connect/mcp-server/)

---

**Last Updated:** November 7, 2025
