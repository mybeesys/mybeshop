#!/usr/bin/env bash
# Full Cloudflare deploy: build Flutter web, then deploy Worker with SPA routing.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> Installing npm dependencies (wrangler)..."
npm install --no-audit --no-fund

echo "==> Deploying to Cloudflare Workers (build + SPA routing via wrangler.jsonc)..."
npm run deploy:worker

echo ""
echo "Done. Test:"
echo "  Preview (branch builds): https://<branch>-mybeshop.mybeeerp.workers.dev/apple"
echo "  Production:              https://mybeshop.mybeeerp.workers.dev/apple"
echo "Replace 'apple' with your store slug."
