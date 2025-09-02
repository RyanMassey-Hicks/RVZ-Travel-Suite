#!/usr/bin/env bash
set -euo pipefail
if [ -z "${1:-}" ]; then echo "Usage: $0 path/to/cert.pfx"; exit 2; fi
base64 -w0 "$1"
