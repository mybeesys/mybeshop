#!/usr/bin/env bash
# Full Cloudflare deploy: build Flutter web, then upload to Workers.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> Building Flutter web..."
bash scripts/cloudflare-build.sh

if [ ! -d build/web ] || [ ! -f build/web/index.html ]; then
  echo "ERROR: build/web is missing. Flutter build did not produce output." >&2
  exit 1
fi

echo "==> Uploading to Cloudflare Workers..."
npx wrangler versions upload \
  --cwd "$ROOT_DIR" \
  --config "$ROOT_DIR/wrangler.jsonc" \
  --assets "$ROOT_DIR/build/web" \
  --name mybeshop \
  --compatibility-date 2025-05-25
