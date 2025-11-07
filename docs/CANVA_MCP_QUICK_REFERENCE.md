# Canva MCP Quick Reference Card

**For:** NUC2 Installation  
**Created:** November 6, 2025

---

## Quick Install Commands

### 1. Verify Prerequisites

```powershell
node --version    # Should be v20+
npm --version     # Should be 10+
git --version     # Should be 2.x+
```

---

## Configuration Files

### Claude Desktop Configuration

**Location:** `%APPDATA%\Claude\claude_desktop_config.json`

**Configuration:**
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

### Jan Desktop Configuration

**Settings Path:** Settings > MCP Servers > Click `+`

| Field | Value |
|-------|-------|
| Server Name | `Canva` |
| Command | `npx` |
| Arguments | `-y mcp-remote@latest https://mcp.canva.com/mcp` |
| Environment Variables | Leave empty |

### Cursor Configuration

**Location:** `.cursor/mcp.json` (in project directory)

**Configuration:**
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

---

## Authentication

### First-Time Setup

1. Send test prompt: `"Create a simple Instagram post design"`
2. Browser opens automatically to Canva OAuth page
3. Log in to Canva
4. Select team (if applicable)
5. Review and approve permissions
6. Return to MCP client

### Permissions Granted

- Read profile and designs
- Create new designs
- Manage folders and content
- Access team brand templates
- Comment on designs

---

## Testing

### Verify Installation

```
Test Prompt 1: "Search my Canva designs"
Test Prompt 2: "Create a test design with text 'Hello CURATR'"
Test Prompt 3: "List available export formats"
```

### Expected Results

- Tool invocation prompt appears
- Canva MCP executes successfully
- Design link or information returned

---

## Most Used Tools

| Tool | Purpose | Example Prompt |
|------|---------|----------------|
| `generate-design` | Create new designs | "Create an Instagram post with..." |
| `search-designs` | Find existing designs | "Search for designs with 'CURATR'" |
| `export-design` | Export as PNG/PDF | "Export this design as PNG" |
| `create-folder` | Organize designs | "Create a folder called 'Instagram Posts'" |
| `resize-design` | Change dimensions | "Resize this design to 1080x1080" |

---

## CURATR Brand Guidelines

### Colors

- **Primary:** `#667eea`
- **Secondary:** `#764ba2`
- **Accent:** `#f59e0b`

### Typography

- **Font:** Inter or Montserrat
- **Style:** Clean, modern, sans-serif

### Logo

- **Placement:** Top-right corner
- **File:** Use approved CURATR logo

### Dimensions

| Platform | Size | Aspect Ratio |
|----------|------|--------------|
| Instagram | 1080 x 1920 px | 9:16 |
| TikTok | 1080 x 1920 px | 9:16 |
| YouTube Shorts | 1080 x 1920 px | 9:16 |

---

## Common Issues

### "npx command not found"

**Solution:** Reinstall Node.js, restart PowerShell

### Authentication fails

**Solution:** Clear Canva cookies, try different browser

### MCP server not showing

**Solution:** Check JSON syntax, restart MCP client

### Design generation fails

**Solution:** Check Canva account limits, simplify prompt

---

## Example Design Prompt

```
Create an Instagram Reel post (1080x1920px) with:

Hook: "Transform Your Golf Style"
Caption: "Discover curated golf fashion collections from top brands. Elevate your game with style."
Hashtags: #GolfFashion #GolfStyle #CURATR

Use CURATR brand colors:
- Primary: #667eea
- Secondary: #764ba2
- Accent: #f59e0b

Include CURATR logo in top-right corner.
Use Inter or Montserrat font.
Modern, clean design aesthetic.

Export as PNG when complete.
```

---

## Automation Workflow

```
1. Read collection data from publishing_manifest_complete_217.json
2. Generate design prompt with collection content
3. Send prompt to Canva MCP
4. Wait for design generation (use get-design-generation-job)
5. Export design as PNG
6. Download to local folder
7. Post to social media
8. Mark as posted in manifest
```

---

## Support Resources

- **Full Guide:** `CANVA_MCP_INSTALLATION_GUIDE.md`
- **Template Specs:** `CANVA_TEMPLATE_SPECIFICATIONS.md`
- **Canva Docs:** [canva.dev/docs/connect/mcp-server](https://www.canva.dev/docs/connect/mcp-server/)
- **MCP Docs:** [modelcontextprotocol.io](https://modelcontextprotocol.io/)

---

**Last Updated:** November 6, 2025
