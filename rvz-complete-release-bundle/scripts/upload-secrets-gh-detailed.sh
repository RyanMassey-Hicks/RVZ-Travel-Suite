#!/usr/bin/env bash
# Usage: ./upload-secrets-gh-detailed.sh OWNER REPO
OWNER=${1:-YOUR_GITHUB_ORG}
REPO=${2:-YOUR_REPO}
if [ "$OWNER" = "YOUR_GITHUB_ORG" ] || [ "$REPO" = "YOUR_REPO" ]; then echo "Usage: $0 OWNER REPO"; exit 1; fi
echo "Upload secrets using gh CLI. Example:"
echo "gh secret set WIN_CERT_PFX --repo $OWNER/$REPO --body "$(cat win_sign.pfx.base64 2>/dev/null || echo 'placeholder')""
echo "gh secret set WIN_CERT_PASS --repo $OWNER/$REPO --body 'yourpassword'"
echo "gh secret set FTP_USERNAME --repo $OWNER/$REPO --body 'ftpuser'"
echo "gh secret set FTP_PASSWORD --repo $OWNER/$REPO --body 'ftppass'"
