#!/usr/bin/env bash
# Full Cloudflare deploy: build Flutter web, then deploy Worker with SPA routing.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> Installing npm dependencies (wrangler)..."
npm install --no-audit --no-fund

echo "==> Building Flutter web..."
bash scripts/cloudflare-build.sh

if [ ! -d build/web ] || [ ! -f build/web/index.html ]; then
  echo "ERROR: build/web is missing. Flutter build did not produce output." >&2
  exit 1
fi

echo "==> Deploying to Cloudflare Workers (SPA: all paths serve index.html)..."
npm run deploy:worker

echo ""
echo "Done. Test:"
echo "  Preview (branch builds): https://<branch>-mybeshop.mybeeerp.workers.dev/apple"
echo "  Production:              https://mybeshop.mybeeerp.workers.dev/apple"
echo "Replace 'apple' with your store slug."
