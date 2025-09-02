RVZ Travel Suite - Complete Release Bundle
=========================================

This bundle contains the full application (backend, frontend, desktop), Helm charts, and a complete release & deploy GitHub Actions workflow.
The workflow will build installers, generate SHA256 checksums, generate a downloads.html page for the latest release, upload artifacts to GitHub Releases,
and deploy both the installers and downloads.html to your website via FTP/SFTP.

IMPORTANT:
- CHANGELOG.md is intentionally empty for you to fill in.
- Do NOT commit certificates to the repo. Use GitHub Secrets as documented in SIGNING.md.
