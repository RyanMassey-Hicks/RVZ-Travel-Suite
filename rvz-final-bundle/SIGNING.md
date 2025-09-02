Signing & Dry-run Guide
=======================

This repo contains a signing-ready release workflow. The workflow expects the following GitHub Secrets for Windows signing (osslsigncode):
- WIN_CERT_PFX (base64 of your .pfx)
- WIN_CERT_PASS

For mac signing/electron-builder notarization, set:
- MAC_CODESIGN_P12 (base64 of .p12)
- MAC_CERT_PASSWORD
- APPLE_ID
- APPLE_APP_SPECIFIC_PASSWORD
- TEAM_ID

Dry-run (no real certs):
1. In your GitHub repo go to Settings -> Secrets -> Actions.
2. Create secrets with placeholder values, for example:
   - WIN_CERT_PFX = ZHVtbXktcGZ4LWJhc2U2NA==
   - WIN_CERT_PASS = test123
3. Tag a test release: git tag v0.9.0-beta && git push origin v0.9.0-beta
4. The workflow will run; Windows signing step will attempt to use the placeholder and fail, which verifies wiring.

When ready, replace placeholder secrets with real base64-encoded certs and passwords.
