Signing & Deployment Guide
==========================

1) No certificates are included in this repository. Use the scripts to base64-encode certs and upload to GitHub Secrets.
2) Required GitHub Secrets (minimum for full pipeline):
   - WIN_CERT_PFX (base64 .pfx) - optional for Windows signing
   - WIN_CERT_PASS
   - MAC_CODESIGN_P12 (base64 .p12) - optional for Mac signing/notarization
   - MAC_CERT_PASSWORD
   - APPLE_ID
   - APPLE_APP_SPECIFIC_PASSWORD
   - AWS_S3_BUCKET (optional if using S3)
   - AWS_ACCESS_KEY_ID
   - AWS_SECRET_ACCESS_KEY
   - FTP_USERNAME (for direct deploy to rvzgroup.co.za)
   - FTP_PASSWORD
   - GITHUB_TOKEN (automatically provided in Actions)
3) For testing: set WIN_CERT_PFX to a short base64 string to simulate presence of a cert; signing will fail but workflow wiring can be verified.
