# Deploy to Cloudflare Workers (static Flutter web)

## Cloudflare dashboard settings

Your logs show **only** the deploy command runs. Use **one** of these setups.

### Option A (recommended): single deploy command

| Setting | Value |
|---------|--------|
| **Build command** | *(leave empty)* |
| **Deploy command** | `bash scripts/cloudflare-deploy.sh` |

This builds `build/web` then runs `wrangler versions upload`.

### Option B: separate build + deploy

| Step | Command |
|------|---------|
| **Build command** | `bash scripts/cloudflare-build.sh` |
| **Deploy command** | `npx wrangler versions upload --config wrangler.jsonc` |

**Important:** Commit and push `wrangler.jsonc`, `package.json`, and `scripts/` before deploying.

## Local deploy

```bash
npm install
npm run build
npm run deploy
```

## Worker name

The worker name in `wrangler.jsonc` is `mybeshop`. Change it if your Cloudflare Worker uses a different name.

## URLs

| URL | Meaning |
|-----|---------|
| `https://mybeshop.mybeeerp.workers.dev/apple` | Production — `apple` is the store slug |
| `https://ali-mybeshop.mybeeerp.workers.dev/apple` | Preview for Git branch `ali` only (not the store name) |

Store links use `/{slug}` (e.g. `/apple`), not `/shop/apple`.

Promote the latest Worker version in the Cloudflare dashboard so production uses `mybeshop.*` without the `ali-` prefix.
