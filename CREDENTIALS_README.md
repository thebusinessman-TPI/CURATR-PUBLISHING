# CURATR Social Media Credentials Management

**Created:** November 6, 2025  
**Location:** `.env.local`

---

## Overview

Social media credentials for CURATR's publishing accounts are stored securely in the `.env.local` file in this repository. This file is **automatically excluded from Git commits** via `.gitignore` to prevent accidental exposure.

---

## Stored Credentials

The `.env.local` file contains credentials for the following platforms:

- **Instagram** (@curatr.store)
- **TikTok** (@curatr.store)
- **X/Twitter** (@curatrstore)
- **YouTube** (@curatrstore)

---

## Security Measures

### Git Protection

The `.env.local` file is protected by `.gitignore` and will **never be committed** to the repository. This ensures credentials remain private and secure.

### File Location

```
CURATR-PUBLISHING/.env.local
```

### Access Control

- Only authorized team members should have access to this file
- The file is stored locally on your machine only
- Never share this file via email, Slack, or other communication channels

---

## Usage in Automation Scripts

To use these credentials in automation scripts:

### Node.js / JavaScript

```javascript
// Install dotenv package
// npm install dotenv

require('dotenv').config({ path: '.env.local' });

const instagramUsername = process.env.INSTAGRAM_USERNAME;
const instagramPassword = process.env.INSTAGRAM_PASSWORD;
```

### Python

```python
# Install python-dotenv package
# pip install python-dotenv

from dotenv import load_dotenv
import os

load_dotenv('.env.local')

instagram_username = os.getenv('INSTAGRAM_USERNAME')
instagram_password = os.getenv('INSTAGRAM_PASSWORD')
```

### PowerShell

```powershell
# Load environment variables from .env.local
Get-Content .env.local | ForEach-Object {
    if ($_ -match '^([^=]+)=(.+)$') {
        $name = $matches[1]
        $value = $matches[2]
        [Environment]::SetEnvironmentVariable($name, $value, 'Process')
    }
}

$instagramUsername = $env:INSTAGRAM_USERNAME
$instagramPassword = $env:INSTAGRAM_PASSWORD
```

---

## Available Environment Variables

| Variable | Platform | Description |
|----------|----------|-------------|
| `INSTAGRAM_USERNAME` | Instagram | Account username |
| `INSTAGRAM_PASSWORD` | Instagram | Account password |
| `TIKTOK_USERNAME` | TikTok | Account username |
| `TIKTOK_PASSWORD` | TikTok | Account password |
| `X_USERNAME` | X (Twitter) | Account username |
| `X_PASSWORD` | X (Twitter) | Account password |
| `YOUTUBE_USERNAME` | YouTube | Account username |
| `YOUTUBE_PASSWORD` | YouTube | Account password |

---

## Best Practices

1. **Never commit `.env.local`** - Always verify it's in `.gitignore`
2. **Use environment variables** - Load credentials programmatically, never hardcode
3. **Rotate passwords regularly** - Update credentials periodically for security
4. **Enable 2FA where possible** - Add two-factor authentication for additional security
5. **Monitor account activity** - Watch for unauthorized access attempts

---

## Troubleshooting

### File Not Found

If automation scripts can't find `.env.local`:

```bash
# Verify file exists
ls -la .env.local

# Check you're in the correct directory
pwd
# Should show: /path/to/CURATR-PUBLISHING
```

### Credentials Not Loading

If environment variables aren't loading:

1. Verify the `.env.local` file format (no spaces around `=`)
2. Check that your script is loading from the correct path
3. Ensure the dotenv package is installed

---

## Emergency Procedures

### If Credentials Are Compromised

1. **Immediately change passwords** on all affected platforms
2. **Review account activity** for unauthorized access
3. **Update `.env.local`** with new credentials
4. **Notify the team** of the security incident

### If `.env.local` Is Accidentally Committed

1. **Remove the file from Git history** immediately:
   ```bash
   git rm --cached .env.local
   git commit -m "Remove accidentally committed credentials"
   git push
   ```
2. **Change all passwords** immediately
3. **Verify `.gitignore`** is properly configured

---

## Contact

For questions or issues with credentials management, contact the CURATR team lead.

---

**Last Updated:** November 6, 2025
