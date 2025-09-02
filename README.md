name: Full Desktop CI/CD

on:
  push:
    tags:
      - 'v*' # Triggers on version tags like v1.0.0

jobs:
  build-and-release:
    runs-on: ubuntu-latest
    env:
      GITHUB_OWNER: ${{ github.repository_owner }}
      GITHUB_REPO: ${{ github.event.repository.name }}
      APP_NAME: "RVZ Travel Suite"
      APP_ID: "co.rvzgroup.travel"
      DOCKER_USER: "rvzdocker"
      FTP_SERVER: ftp.rvzgroup.co.za
      FTP_DIR: /public_html/downloads/

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'

      - name: Install frontend dependencies
        run: |
          cd frontend
          npm install

      - name: Install desktop dependencies
        run: |
          cd desktop
          npm install

      - name: Run placeholder replacement (auto-icons)
        run: |
          chmod +x desktop/replace-placeholders-auto-icons.sh
          ./desktop/replace-placeholders-auto-icons.sh \
            $GITHUB_OWNER \
            $GITHUB_REPO \
            "$APP_NAME" \
            "$APP_ID" \
            "$DOCKER_USER"

      - name: Build and Package Desktop App
        run: |
          cd desktop
          npm run build
          npm run package

      - name: Sign Windows App (Optional)
        if: ${{ secrets.WIN_CERT_PFX && secrets.WIN_CERT_PASS }}
        run: |
          echo ${{ secrets.WIN_CERT_PFX }} | base64 --decode > windows-cert.pfx
          signtool sign /f windows-cert.pfx /p ${{ secrets.WIN_CERT_PASS }} /tr http://timestamp.digicert.com /td sha256 /fd sha256 "desktop/dist/*.exe"

      - name: Sign Mac App (Optional)
        if: ${{ secrets.MAC_CERT }}
        run: |
          echo ${{ secrets.MAC_CERT }} | base64 --decode > mac-certificate.p12
          codesign --deep --force --verbose --sign "Developer ID Application: RVZ Group" "desktop/dist/*.app"

      - name: Generate SHA256 checksums
        run: |
          cd desktop/dist
          sha256sum * > SHA256SUMS.txt

      - name: Generate Release Notes from CHANGELOG.md
        id: changelog
        run: |
          NEW_TAG=${GITHUB_REF##*/}
          awk "/^## \[$NEW_TAG\]/,/^## \[/" ../../CHANGELOG.md | sed '$d' > RELEASE_NOTES.md || echo "No notes found for this tag"

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v1
        with:
          tag_name: ${{ github.ref_name }}
          name: "Release ${{ github.ref_name }}"
          body_path: RELEASE_NOTES.md
          draft: false
          prerelease: false
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Upload Release Artifacts
        uses: softprops/action-gh-release@v1
        with:
          files: desktop/dist/*

      - name: Deploy to FTP server
        if: ${{ secrets.FTP_USERNAME && secrets.FTP_PASSWORD }}
        run: |
          lftp -e "
            set ftp:ssl-allow no;
            open -u ${{ secrets.FTP_USERNAME }},${{ secrets.FTP_PASSWORD }} $FTP_SERVER;
            mirror -R ./desktop/dist $FTP_DIR;
            quit
          "

      - name: Cleanup
        run: |
          rm -f desktop/windows-cert.pfx desktop/mac-certificate.p12
