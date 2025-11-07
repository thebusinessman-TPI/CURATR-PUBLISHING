# Canva MCP Installation Guide for NUC2

**Created:** November 6, 2025  
**Target System:** NUC2 (Windows)  
**Purpose:** Enable automated Canva design generation for CURATR-PUBLISHING workflow

---

## Overview

This guide provides step-by-step instructions for installing and configuring the **Canva Model Context Protocol (MCP) server** on NUC2. The Canva MCP will enable automated template population, bulk design generation, and export capabilities for the CURATR publishing workflow.

---

## What is Canva MCP?

The Canva MCP is an official integration that gives AI models the ability to:

- **Create designs** using AI prompts
- **Autofill templates** with content (hooks, captions, videos)
- **Search and manage** existing designs
- **Export designs** in various formats (PDF, PNG, JPG)
- **Organize content** in folders
- **Collaborate** with comments and feedback

This is the **first design platform with native MCP integration**, enabling design automation through conversational AI rather than manual clicking.

---

## Prerequisites

Before installing the Canva MCP on NUC2, ensure the following are installed:

### Required Software

| Software | Version | Check Command | Installation |
|----------|---------|---------------|--------------|
| **Node.js** | v20 or later | `node --version` | [Download](https://nodejs.org/) |
| **npm** | Latest | `npm --version` | Included with Node.js |
| **Git** | Latest | `git --version` | [Download](https://git-scm.com/) |

### Required Accounts

- **Canva Account** (Free or Paid)
  - Sign up at [canva.com](https://www.canva.com/)
  - Ensure you can create designs and access templates

### MCP Client Options

You need an MCP-compatible client. Choose one of the following:

| Client | Best For | Download |
|--------|----------|----------|
| **Claude Desktop** | General AI assistance | [Download](https://claude.ai/download) |
| **Cursor** | Code-focused AI | [Download](https://cursor.sh/) |
| **Jan Desktop** | Local AI with MCP | [Download](https://jan.ai/) |
| **VS Code** | Development environment | [Download](https://code.visualstudio.com/) |

**Recommended for NUC2:** **Claude Desktop** or **Jan Desktop** (for local control)

---

## Installation Steps

### Step 1: Verify Prerequisites

Open **PowerShell** or **Command Prompt** on NUC2 and run:

```powershell
# Check Node.js version
node --version
# Should show v20.x.x or later

# Check npm version
npm --version
# Should show 10.x.x or later

# Check Git version
git --version
# Should show git version 2.x.x or later
```

If any of these are missing or outdated, install/update them before proceeding.

---

### Step 2: Install MCP Client (Choose One)

#### Option A: Claude Desktop (Recommended)

1. Download Claude Desktop from [claude.ai/download](https://claude.ai/download)
2. Install the application
3. Sign in with your Anthropic account
4. Proceed to Step 3

#### Option B: Jan Desktop (Local AI)

1. Download Jan from [jan.ai](https://jan.ai/)
2. Install the application
3. Open Jan and complete initial setup
4. Go to **Settings** > **MCP Servers**
5. Toggle **Allow All MCP Tool Permission** ON
6. Proceed to Step 3

#### Option C: Cursor (For Developers)

1. Download Cursor from [cursor.sh](https://cursor.sh/)
2. Install the application
3. Open Cursor and sign in
4. Proceed to Step 3

---

### Step 3: Configure Canva MCP Server

The configuration process differs slightly based on your MCP client.

#### For Claude Desktop

1. **Locate Configuration File**

   The Claude Desktop configuration file is located at:
   ```
   %APPDATA%\Claude\claude_desktop_config.json
   ```

   Full path example:
   ```
   C:\Users\YourUsername\AppData\Roaming\Claude\claude_desktop_config.json
   ```

2. **Open Configuration File**

   - Press `Win + R`
   - Type: `%APPDATA%\Claude`
   - Press Enter
   - Open `claude_desktop_config.json` in a text editor (Notepad++ or VS Code)

3. **Add Canva MCP Configuration**

   Add the following configuration to the file:

   ```json
   {
     "mcpServers": {
       "canva": {
         "command": "npx",
         "args": [
           "-y",
           "mcp-remote@latest",
           "https://mcp.canva.com/mcp"
         ]
       }
     }
   }
   ```

   **If the file already has other MCP servers**, add the `"canva"` entry inside the existing `"mcpServers"` object:

   ```json
   {
     "mcpServers": {
       "supabase": {
         "command": "...",
         "args": [...]
       },
       "canva": {
         "command": "npx",
         "args": [
           "-y",
           "mcp-remote@latest",
           "https://mcp.canva.com/mcp"
         ]
       }
     }
   }
   ```

4. **Save the File**

5. **Restart Claude Desktop**

   - Close Claude Desktop completely
   - Reopen the application

#### For Jan Desktop

1. **Open Jan Application**

2. **Navigate to MCP Servers**
   - Go to **Settings**
   - Select **MCP Servers**

3. **Add New Server**
   - Click the **+** button in the MCP Servers section

4. **Enter Configuration**

   | Field | Value |
   |-------|-------|
   | **Server Name** | `Canva` |
   | **Command** | `npx` |
   | **Arguments** | `-y mcp-remote@latest https://mcp.canva.com/mcp` |
   | **Environment Variables** | Leave empty |

5. **Save Configuration**

6. **Restart Jan** (if required)

#### For Cursor

1. **Navigate to Project Directory**

   Open PowerShell and navigate to your CURATR-PUBLISHING directory:
   ```powershell
   cd C:\Development\CURATR-PUBLISHING
   ```

2. **Create MCP Configuration Directory**

   ```powershell
   mkdir -p .cursor
   ```

3. **Create Configuration File**

   Create a file named `.cursor\mcp.json` with the following content:

   ```json
   {
     "mcpServers": {
       "canva": {
         "command": "npx",
         "args": [
           "-y",
           "mcp-remote@latest",
           "https://mcp.canva.com/mcp"
         ]
       }
     }
   }
   ```

4. **Restart Cursor**

---

### Step 4: Authenticate with Canva

The first time you use Canva tools, you'll need to authenticate:

1. **Trigger Authentication**

   In your MCP client (Claude Desktop, Jan, or Cursor), send a message like:
   ```
   "Create a simple Instagram post design"
   ```

2. **Browser Opens Automatically**

   - Your default browser will open to Canva's authentication page
   - If it doesn't open automatically, look for an authentication URL in the MCP client

3. **Log In to Canva**

   - Enter your Canva credentials
   - If you don't have an account, create one at [canva.com](https://www.canva.com/)

4. **Select Team (if applicable)**

   - If you have multiple Canva teams, select the one you want to use
   - For personal accounts, this step may be skipped

5. **Review Permissions**

   The AI will request the following permissions:
   - Reading your profile and designs
   - Creating new designs
   - Managing folders and content
   - Accessing team brand templates
   - Commenting on designs

6. **Click "Allow"**

   - Grant access to the MCP server
   - You should see a confirmation message

7. **Return to MCP Client**

   - The authentication is now complete
   - Your MCP client should confirm the connection

---

### Step 5: Verify Installation

To confirm the Canva MCP is working correctly:

1. **Check MCP Server Status**

   In Claude Desktop:
   - Click the **Search and tools** button near the prompt
   - You should see "Canva" listed as an available MCP server

   In Jan Desktop:
   - Go to **Settings** > **MCP Servers**
   - Verify "Canva" shows as active/connected

2. **Test Basic Functionality**

   Send a simple test prompt:
   ```
   "Search my Canva designs"
   ```

   Or:
   ```
   "Create a simple test design with the text 'Hello CURATR'"
   ```

3. **Verify Tool Invocation**

   - You should see a tool invocation prompt
   - The AI should successfully execute the Canva MCP tool
   - You should receive a response with design information or a link

---

## Available Canva MCP Tools

Once installed, the following tools are available:

### Design Operations

| Tool | Description |
|------|-------------|
| `generate-design` | Create new designs using AI prompts |
| `search-designs` | Search docs, presentations, videos, whiteboards |
| `get-design` | Get detailed information about a Canva design |
| `get-design-pages` | List pages in multi-page designs |
| `get-design-content` | Extract content from designs |
| `resize-design` | Adapt designs to different dimensions |
| `get-design-resize-status` | Check resize operation status |
| `get-design-generation-job` | Track AI generation progress |

### Import/Export

| Tool | Description |
|------|-------------|
| `import-design-from-url` | Import files from URLs as new designs |
| `get-design-import-from-url` | Check import status |
| `export-design` | Export designs in various formats |
| `get-export-formats` | List available export options |
| `get-design-export-status` | Track export progress |

### Organization

| Tool | Description |
|------|-------------|
| `create-folder` | Create folders in Canva |
| `move-item-to-folder` | Organize designs and assets |
| `list-folder-items` | Browse folder contents |

### Collaboration

| Tool | Description |
|------|-------------|
| `comment-on-design` | Add comments to designs |
| `list-comments` | View design comments |
| `list-replies` | See comment threads |
| `reply-to-comment` | Respond to feedback |

---

## Integration with CURATR-PUBLISHING

### Use Cases for CURATR Workflow

Now that Canva MCP is installed, you can use it for:

1. **Bulk Template Generation**
   - Automatically create Instagram/TikTok posts from the 217 collections
   - Populate templates with hooks, captions, and hashtags
   - Generate multiple design variations

2. **Automated Content Population**
   - Read data from `publishing_manifest_complete_217.json`
   - Autofill Canva templates with collection-specific content
   - Export platform-ready designs

3. **Design Management**
   - Organize designs by brand or platform
   - Search and retrieve existing designs
   - Track design generation progress

4. **Export Automation**
   - Export designs as PNG/JPG for social media
   - Batch export multiple designs
   - Download designs programmatically

### Example Workflow

Here's how the Canva MCP integrates with the CURATR publishing workflow:

```
1. Read Collection Data (publishing_manifest_complete_217.json)
   ↓
2. Send to Canva MCP: "Create Instagram post with this content..."
   ↓
3. Canva MCP generates design with autofilled template
   ↓
4. Export design as PNG
   ↓
5. Download to local folder
   ↓
6. Post to Instagram using manual posting tool or API
```

---

## Automation Script Example

Here's a basic example of how to use the Canva MCP in a Node.js automation script:

```javascript
// Example: Automated Canva design generation for CURATR collections
// This would be integrated with your MCP client

const fs = require('fs');

// Load publishing manifest
const manifest = JSON.parse(
  fs.readFileSync('./data/manifests/publishing_manifest_complete_217.json', 'utf8')
);

// Example prompt for Canva MCP
function generateDesignPrompt(collection, platform) {
  const content = collection.platforms[platform];
  
  return `
    Create a ${platform} post design (1080x1920px) with the following content:
    
    Hook: ${content.hook}
    Caption: ${content.caption}
    Hashtags: ${content.hashtags}
    
    Use CURATR brand colors:
    - Primary: #667eea
    - Secondary: #764ba2
    - Accent: #f59e0b
    
    Include the CURATR logo in the top-right corner.
    Use a clean, modern sans-serif font (Inter or Montserrat).
    
    Export as PNG when complete.
  `;
}

// Generate design for first collection
const firstCollection = manifest[0];
const prompt = generateDesignPrompt(firstCollection, 'instagram');

console.log('Send this prompt to your MCP client:');
console.log(prompt);
```

---

## Troubleshooting

### Authentication Issues

**Problem:** Browser doesn't open for OAuth flow

**Solutions:**
- Manually navigate to the authentication URL (check MCP client logs)
- Ensure pop-ups aren't blocked in your browser
- Try a different browser
- Check that you're logged into Canva in your browser

---

**Problem:** "Authentication failed" error

**Solutions:**
- Clear browser cookies for Canva
- Log out and back into Canva
- Verify your Canva account is active
- Check team admin permissions (if using team account)

---

### Connection Issues

**Problem:** MCP server not showing in client

**Solutions:**
- Verify configuration file syntax (valid JSON)
- Check that Node.js and npm are installed correctly
- Restart the MCP client application
- Review MCP client logs for errors

---

**Problem:** "npx command not found"

**Solutions:**
- Reinstall Node.js (includes npm and npx)
- Add Node.js to system PATH
- Open a new PowerShell window after installation
- Verify with: `npx --version`

---

### Design Generation Issues

**Problem:** Design generation fails or times out

**Solutions:**
- Verify you have creation rights in your Canva account
- Check Canva subscription limits (free accounts have limits)
- Try simpler design prompts first
- Ensure stable internet connection
- Wait a few moments and retry

---

**Problem:** "Tool not available" error

**Solutions:**
- Some tools require specific Canva plans (Pro, Teams, Enterprise)
- Verify your account has the necessary permissions
- Check that the MCP server is active
- Restart the MCP client

---

### Export Issues

**Problem:** Export fails or produces incorrect format

**Solutions:**
- Use `get-export-formats` tool to see available formats
- Verify export permissions in Canva account
- Check that the design is fully loaded before exporting
- Try exporting manually in Canva to test

---

## Best Practices

### Design Generation

1. **Be Specific in Prompts**
   - Include exact dimensions (1080x1920 for Instagram/TikTok)
   - Specify brand colors and fonts
   - Mention logo placement
   - Request specific design elements

2. **Request Multiple Variations**
   - Ask for 2-3 design options
   - Compare and select the best one
   - Iterate on the selected design

3. **Use Consistent Branding**
   - Reference CURATR brand guidelines
   - Use the same color palette across all designs
   - Maintain consistent typography

### Organization

1. **Create Folders Before Bulk Generation**
   - Organize by platform (Instagram, TikTok, YouTube)
   - Create subfolders by brand or campaign
   - Use descriptive folder names

2. **Name Designs Consistently**
   - Use collection IDs in design names
   - Include platform identifier
   - Add date or version number

3. **Track Generation Progress**
   - Use `get-design-generation-job` to monitor status
   - Keep a log of generated designs
   - Mark completed designs in your manifest

### Automation

1. **Start Small**
   - Test with 5-10 collections first
   - Verify quality and consistency
   - Refine prompts based on results

2. **Batch Processing**
   - Generate designs in batches of 10-20
   - Allow time between batches to avoid rate limits
   - Export and download before next batch

3. **Error Handling**
   - Implement retry logic for failed generations
   - Log errors for review
   - Have fallback options for critical designs

---

## Security Considerations

### OAuth Token Storage

- OAuth tokens are stored securely by the MCP client
- Tokens are encrypted and not accessible to other applications
- Tokens expire and require re-authentication periodically

### Permissions Management

- Review permissions carefully before granting access
- Only grant access to the Canva team you need
- Revoke access if no longer needed (in Canva account settings)

### API Rate Limits

- Canva MCP has rate limits to prevent abuse
- Free accounts have stricter limits than paid accounts
- Implement delays between bulk operations

---

## Next Steps

Now that Canva MCP is installed on NUC2, you can:

1. **Create Master Templates in Canva**
   - Follow the specifications in `CANVA_TEMPLATE_SPECIFICATIONS.md`
   - Create templates for Instagram, TikTok, and YouTube
   - Test templates with sample content

2. **Develop Automation Scripts**
   - Build scripts to read from `publishing_manifest_complete_217.json`
   - Implement Canva MCP tool calls
   - Create export and file management workflows

3. **Test with Sample Collections**
   - Generate designs for 5-10 collections
   - Verify quality and brand consistency
   - Refine prompts and templates

4. **Scale to Full Production**
   - Automate generation for all 217 collections
   - Integrate with posting workflow
   - Monitor performance and engagement

---

## Additional Resources

### Official Documentation

- [Canva MCP Official Docs](https://www.canva.dev/docs/connect/mcp-server/)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [Canva Connect APIs](https://www.canva.dev/docs/connect/)

### CURATR-PUBLISHING Documentation

- `README.md` - Repository overview
- `CANVA_TEMPLATE_SPECIFICATIONS.md` - Template design guidelines
- `MANUAL_POSTING_WORKFLOW.md` - Manual posting process
- `PUBLISHING_WORKFLOW_SUMMARY.md` - Complete workflow roadmap
- `CREDENTIALS_README.md` - Social media credentials management

### Community & Support

- [Canva Developers Community](https://www.canva.dev/community/)
- [MCP Discord Server](https://discord.gg/mcp)
- [CURATR Team Slack](#) - Internal support channel

---

## Maintenance

### Regular Updates

- Keep Node.js updated to the latest LTS version
- Update MCP client applications regularly
- Check for Canva MCP server updates

### Token Refresh

- Re-authenticate if you see authentication errors
- OAuth tokens may expire after extended periods
- Keep Canva account credentials up to date

### Monitoring

- Monitor Canva API usage in your account dashboard
- Track design generation success rates
- Review error logs regularly

---

## Conclusion

The Canva MCP integration is a powerful tool for automating the CURATR publishing workflow. By following this guide, you've successfully installed and configured the Canva MCP on NUC2, enabling:

✅ Automated design generation  
✅ Template autofill capabilities  
✅ Bulk export functionality  
✅ Design organization and management  
✅ Integration with CURATR-PUBLISHING workflow

You're now ready to move from manual posting to semi-automated publishing, significantly reducing the time and effort required to post all 217 collections across Instagram, TikTok, and YouTube.

---

**Document Created:** November 6, 2025  
**Created By:** Manus AI  
**For:** CURATR-PUBLISHING Project  
**Last Updated:** November 6, 2025
