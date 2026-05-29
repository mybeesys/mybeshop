#!/usr/bin/env bash
# Full Cloudflare deploy: build Flutter web, then deploy Worker with SPA routing.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> Building Flutter web..."
bash scripts/cloudflare-build.sh

if [ ! -d build/web ] || [ ! -f build/web/index.html ]; then
  echo "ERROR: build/web is missing. Flutter build did not produce output." >&2
  exit 1
fi

echo "==> Deploying to Cloudflare Workers (SPA: all paths serve index.html)..."
# Use wrangler.jsonc only — do NOT pass --assets on CLI or not_found_handling is dropped.
npx wrangler deploy --config "$ROOT_DIR/wrangler.jsonc"

echo ""
echo "Done. Test:"
echo "  Preview (branch builds): https://<branch>-mybeshop.mybeeerp.workers.dev/apple"
echo "  Production:              https://mybeshop.mybeeerp.workers.dev/apple"
echo "Replace 'apple' with your store slug."
