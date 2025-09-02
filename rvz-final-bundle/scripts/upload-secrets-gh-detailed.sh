#!/usr/bin/env bash
# Usage: ./upload-secrets-gh-detailed.sh OWNER REPO
OWNER=${1:-YOUR_GITHUB_ORG}
REPO=${2:-YOUR_REPO}
if [ "$OWNER" = "YOUR_GITHUB_ORG" ] || [ "$REPO" = "YOUR_REPO" ]; then echo "Usage: $0 OWNER REPO"; exit 1; fi
echo "Use gh CLI to set secrets, e.g.:"
echo "gh secret set WIN_CERT_PFX --repo $OWNER/$REPO --body "$(cat mac_codesign.p12.base64 2>/dev/null || echo 'placeholder')""
