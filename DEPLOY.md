# Deploy to Cloudflare Workers (static Flutter web)

## Cloudflare dashboard settings

Configure **two** steps (build, then deploy). Do not run deploy alone.

| Step | Command |
|------|---------|
| **Build command** | `npm run build` |
| **Deploy command** | `npm run deploy` |

Or without npm scripts:

| Step | Command |
|------|---------|
| **Build command** | `bash scripts/cloudflare-build.sh` |
| **Deploy command** | `npx wrangler versions upload` |

The build must produce `build/web/` before Wrangler uploads. That directory is configured in `wrangler.jsonc`.

## Local deploy

```bash
npm install
npm run build
npm run deploy
```

## Worker name

The worker name in `wrangler.jsonc` is `mybeshop`. Change it if your Cloudflare Worker uses a different name.
