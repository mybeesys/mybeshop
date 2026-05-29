# Deploy to Cloudflare Workers (static Flutter web)

## Cloudflare dashboard settings

| Setting | Value |
|---------|--------|
| **Build command** | *(leave empty)* |
| **Deploy command** | `bash scripts/cloudflare-deploy.sh` |

Do **not** pass `--assets` on the wrangler CLI — it overrides `wrangler.jsonc` and breaks SPA routing (`/apple` returns Chrome 404).

## Local deploy

```bash
npm install
npm run deploy
```

Requires `CLOUDFLARE_API_TOKEN` or `wrangler login`.

## Store URLs

| URL | Meaning |
|-----|---------|
| `https://mybeshop.mybeeerp.workers.dev/apple` | Production |
| `https://ali-mybeshop.mybeeerp.workers.dev/apple` | Preview for Git branch `ali` |

`apple` = store slug (change per store). Path shape: `/{slug}` not `/shop/apple`.

## Two different “404” errors

| What you see | Cause | Fix |
|--------------|-------|-----|
| Chrome gray page: “This page can’t be found” on `/apple` | Production Worker missing SPA config | Redeploy with `bash scripts/cloudflare-deploy.sh`, then **Promote** latest version |
| Flutter 404 Lottie + Arabic text on `/error` | App redirected to `/error` (old deploy or bad slug) | Open `/apple` (your slug), redeploy latest code, use Incognito |

## After deploy

1. Cloudflare Dashboard → **Workers** → **mybeshop** → **Deployments** → **Promote** latest to production.
2. Test: `https://mybeshop.mybeeerp.workers.dev/apple` must return **200** (not Chrome 404).
