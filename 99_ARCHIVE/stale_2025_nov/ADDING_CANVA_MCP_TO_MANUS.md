# Adding Canva MCP to Manus - Complete Guide

**Created:** November 7, 2025  
**Target Systems:** NUC1 and NUC2  
**Purpose:** Enable Canva design automation through Manus Connectors

---

## Overview

This guide provides step-by-step instructions for adding the **Canva MCP (Model Context Protocol) server** to your Manus installation on both NUC1 and NUC2. This will enable Manus to directly create, autofill, search, and export Canva designs for the CURATR-PUBLISHING workflow.

---

## What You'll Achieve

Once configured, Manus will be able to:

✅ **Create Canva designs** using AI prompts  
✅ **Autofill templates** with hooks, captions, and hashtags  
✅ **Search existing designs** in your Canva account  
✅ **Export designs** as PNG, JPG, or PDF  
✅ **Organize designs** in folders  
✅ **Manage design workflows** programmatically

---

## Prerequisites

Before you begin, ensure you have:

- ✅ **Manus account** with access to both NUC1 and NUC2
- ✅ **Canva account** (Free or Paid) - [Sign up here](https://www.canva.com/)
- ✅ **Admin access** to Manus Connectors settings
- ✅ **Internet connection** on both NUCs

---

## Step-by-Step Installation

### Step 1: Access Manus Connectors

**On NUC1:**

1. Open your web browser
2. Navigate to [manus.im](https://manus.im/)
3. Log in to your Manus account
4. Click on **Connectors** (usually in the sidebar or settings)

**On NUC2:**

1. Repeat the same steps as NUC1
2. Ensure you're logged into the same Manus account

---

### Step 2: Add Custom MCP Connector

According to Manus documentation, you can create a custom MCP connector. Here's how:

1. **In the Connectors section**, look for an option to add a new connector
   - This might be labeled as:
     - "+ Connect"
     - "+ Add Connector"
     - "Custom MCP"
     - "Add Custom Connector"

2. **Select "Custom MCP" or "MCP Connector"** option

3. **Enter the Canva MCP Server Information:**

   | Field | Value |
   |-------|-------|
   | **Name** | `Canva` or `Canva MCP` |
   | **Server URL** | `https://mcp.canva.com/mcp` |
   | **Transport Type** | `Streamable HTTP` (if asked) |
   | **Authentication** | `OAuth` (if asked) |

4. **Save the Configuration**

---

### Step 3: Authenticate with Canva

After adding the connector:

1. **Click "Connect" or "Authenticate"** on the Canva MCP connector

2. **Browser OAuth Flow:**
   - A new browser window/tab will open
   - You'll be redirected to Canva's authentication page

3. **Log in to Canva:**
   - Enter your Canva credentials
   - If you don't have an account, create one at [canva.com](https://www.canva.com/)

4. **Select Team (if applicable):**
   - If you have multiple Canva teams, select the one you want to use
   - For personal accounts, this step may be skipped

5. **Review and Grant Permissions:**
   
   The Canva MCP will request the following permissions:
   - ✅ Read your profile and designs
   - ✅ Create new designs
   - ✅ Manage folders and content
   - ✅ Access team brand templates
   - ✅ Comment on designs

6. **Click "Allow" or "Authorize"**

7. **Confirmation:**
   - You should see a message: "Successfully installed connector"
   - The browser window will close or redirect back to Manus

---

### Step 4: Verify Installation

To confirm the Canva MCP is working:

1. **In Manus**, start a new conversation or task

2. **Send a test prompt:**
   ```
   "Search my Canva designs"
   ```
   
   Or:
   ```
   "Create a simple Instagram post design with the text 'Hello CURATR'"
   ```

3. **Expected Result:**
   - Manus should recognize the Canva connector
   - You should see tool invocation or connector activity
   - Manus should return design information or a link to the created design

4. **If successful:**
   - ✅ Canva MCP is properly configured
   - ✅ Authentication is working
   - ✅ You can proceed to use Canva tools in Manus

---

### Step 5: Repeat for Second NUC

**Important:** You need to configure the Canva MCP on **both NUC1 and NUC2** separately.

1. **Switch to the other NUC**
2. **Repeat Steps 1-4** exactly as above
3. **Authenticate again** (each NUC needs its own authentication)
4. **Verify** that both NUCs can access Canva MCP

---

## Alternative: Using Manus MCP CLI (If Applicable)

If Manus provides a CLI-based MCP configuration method (similar to how Supabase and Vercel are configured), you may be able to add Canva MCP using the `manus-mcp-cli` tool:

```bash
# This is a hypothetical command - verify with Manus documentation
manus-mcp-cli connector add \
  --name "canva" \
  --url "https://mcp.canva.com/mcp" \
  --type "remote" \
  --auth "oauth"
```

**Note:** This approach is speculative. Please use the Manus web interface (Steps 1-5 above) as the primary method.

---

## Available Canva MCP Tools

Once configured, you can use the following tools through Manus:

### Design Operations

| Tool | Description | Example Prompt |
|------|-------------|----------------|
| `generate-design` | Create new designs | "Create an Instagram post with..." |
| `search-designs` | Search existing designs | "Find designs with 'CURATR' in the title" |
| `get-design` | Get design details | "Show me details of design ID 12345" |
| `get-design-content` | Extract content from design | "Get the text from this design" |
| `resize-design` | Change design dimensions | "Resize this to 1080x1080" |

### Import/Export

| Tool | Description | Example Prompt |
|------|-------------|----------------|
| `export-design` | Export as PNG/PDF | "Export this design as PNG" |
| `get-export-formats` | List available formats | "What export formats are available?" |
| `import-design-from-url` | Import from URL | "Import design from [URL]" |

### Organization

| Tool | Description | Example Prompt |
|------|-------------|----------------|
| `create-folder` | Create folders | "Create a folder called 'Instagram Posts'" |
| `move-item-to-folder` | Organize designs | "Move this design to the Instagram folder" |
| `list-folder-items` | Browse folders | "Show me all designs in the Instagram folder" |

### Collaboration

| Tool | Description | Example Prompt |
|------|-------------|----------------|
| `comment-on-design` | Add comments | "Add a comment: 'Looks great!'" |
| `list-comments` | View comments | "Show me all comments on this design" |

---

## Integration with CURATR-PUBLISHING Workflow

### Use Case: Automated Design Generation

With Canva MCP configured in Manus, you can now automate the design generation for your 217 collections:

**Example Workflow:**

1. **Read collection data** from `publishing_manifest_complete_217.json`
2. **Send prompt to Manus:**
   ```
   Create an Instagram Reel post (1080x1920px) with:
   
   Hook: [collection.platforms.instagram.hook]
   Caption: [collection.platforms.instagram.caption]
   Hashtags: [collection.platforms.instagram.hashtags]
   
   Use CURATR brand colors:
   - Primary: #667eea
   - Secondary: #764ba2
   - Accent: #f59e0b
   
   Include CURATR logo in top-right corner.
   Use Inter or Montserrat font.
   
   Export as PNG when complete.
   ```

3. **Manus uses Canva MCP** to generate the design
4. **Export and download** the design
5. **Post to Instagram** using manual posting tool or API
6. **Mark as posted** in the manifest

---

## Troubleshooting

### Issue: Cannot Find Custom MCP Option

**Solution:**
- Look for "Add Connector" or "+ Connect" button
- Check if there's a "Custom" or "Advanced" section
- Try searching for "MCP" in the Connectors interface
- Contact Manus support if the option is not visible

---

### Issue: Authentication Fails

**Solution:**
- Clear browser cookies for Canva
- Try a different browser
- Ensure pop-ups are not blocked
- Log out of Canva and log back in
- Check that your Canva account is active

---

### Issue: "Successfully installed" but tools don't work

**Solution:**
- Restart your browser
- Log out and back into Manus
- Try a simple test prompt again
- Check Manus Connectors settings to ensure Canva is "Active"
- Verify internet connection

---

### Issue: Permission Denied Errors

**Solution:**
- Review the permissions you granted to Canva MCP
- Re-authenticate and ensure all permissions are accepted
- Check Canva account settings for connected apps
- Verify you have the necessary permissions in your Canva team

---

### Issue: Different Results on NUC1 vs NUC2

**Solution:**
- Ensure both NUCs are logged into the same Manus account
- Verify both NUCs authenticated with the same Canva account
- Check that both NUCs have the same Canva MCP configuration
- Synchronize settings if Manus provides a sync option

---

## Security & Privacy

### OAuth Token Management

- OAuth tokens are stored securely by Manus
- Tokens are encrypted and not accessible to other applications
- Tokens may expire and require re-authentication periodically

### Permissions

- Review permissions carefully before granting access
- Only grant access to the Canva team you need
- Revoke access in Canva account settings if no longer needed

### Shared Sessions

- Manus automatically redacts sensitive information in shared sessions
- Connector output is hidden in shared sessions
- Be cautious about what content you share

---

## Testing Checklist

After installation, verify the following on **both NUC1 and NUC2**:

- [ ] Canva MCP connector appears in Manus Connectors list
- [ ] Connector status shows as "Connected" or "Active"
- [ ] Test prompt: "Search my Canva designs" returns results
- [ ] Test prompt: "Create a simple test design" creates a design
- [ ] Can access the created design in Canva
- [ ] Can export a design as PNG
- [ ] Can create a folder in Canva
- [ ] Can search for specific designs

---

## Next Steps

Once Canva MCP is configured on both NUCs:

1. **Create Master Templates in Canva**
   - Follow specifications in `CANVA_TEMPLATE_SPECIFICATIONS.md`
   - Create templates for Instagram, TikTok, YouTube

2. **Test with Sample Collections**
   - Use Manus to generate designs for 5-10 collections
   - Verify quality and brand consistency
   - Refine prompts as needed

3. **Develop Automation Workflow**
   - Create a process to batch-generate designs
   - Implement export and download automation
   - Integrate with posting workflow

4. **Scale to Full Production**
   - Generate designs for all 217 collections
   - Monitor performance and quality
   - Track engagement metrics

---

## Support Resources

### Manus Documentation

- [Manus Help Center](https://help.manus.im/)
- [Manus Connectors Guide](https://help.manus.im/en/articles/12231777-how-can-i-use-manus-connectors)

### Canva Documentation

- [Canva MCP Official Docs](https://www.canva.dev/docs/connect/mcp-server/)
- [Canva Connect APIs](https://www.canva.dev/docs/connect/)

### CURATR-PUBLISHING Documentation

- `CANVA_TEMPLATE_SPECIFICATIONS.md` - Template design guidelines
- `MANUAL_POSTING_WORKFLOW.md` - Manual posting process
- `PUBLISHING_WORKFLOW_SUMMARY.md` - Complete workflow roadmap
- `CREDENTIALS_README.md` - Social media credentials

---

## Summary

**What We're Adding:**
- Canva MCP connector to Manus on NUC1 and NUC2

**How to Add It:**
1. Access Manus Connectors
2. Add Custom MCP with URL: `https://mcp.canva.com/mcp`
3. Authenticate via OAuth
4. Verify with test prompts
5. Repeat on both NUCs

**What It Enables:**
- Automated Canva design generation through Manus
- Template autofill for 217 collections
- Bulk export and organization
- Streamlined publishing workflow

**Expected Result:**
- Manus can create, manage, and export Canva designs
- Significant time savings for CURATR-PUBLISHING workflow
- Consistent brand quality across all designs

---

**Document Created:** November 7, 2025  
**Created By:** Manus AI  
**For:** CURATR-PUBLISHING Project  
**Last Updated:** November 7, 2025
