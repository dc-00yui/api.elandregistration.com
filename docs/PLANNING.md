# REST API for elandregistration.com (Third-Party Partners) — Planning

Status: **planning only — no implementation started.** Do not build against this until explicitly approved.

## Context

Goal: expose a RESTful API to the eLandRegistration database for **third-party partners** to integrate with.

Decision on placement: **PHP, on a subdomain, same server/DB as the main app** — `api.elandregistration.com` — rather than a path under the existing site (`elandregistration.com/api/*`), and rather than a different host/stack entirely.

**Key environment facts** (from the main app's codebase and from Dave directly):
- **Dev/stage** (main app, `stage.elandregistration.com`): Windows, IIS, PHP 8.5 via FastCGI. One IIS site, no URL-rewrite rules.
- **Production** (elandregistration.com): a **separate Linux server, Apache, PHP 8.2** — different OS, web server, and PHP version than the dev box. This repo's code must run correctly on **both**, targeting **PHP 8.2 as the compatibility floor** even though it'll often be edited/tested on a PHP 8.5 dev box.
- The main app centralizes DB access in `v2/elandadmin/func/func.db.php` (in the `stage.elandregistration.com` repo), which switches credentials by `$_SERVER['SERVER_ADDR']`. This API project is a **separate repo and a separate codebase** — it cannot share that file by filesystem include (no shared path exists between the Windows dev box and the Linux prod box, and it shouldn't be coupled to the main app's repo anyway). This repo needs its **own** DB config, following the same credential-switch *idea* but as independent config (ideally environment variables / an uncommitted local config file, not hardcoded values copied into source).
- There is **no existing API-key/token auth** in the main app — just PHP session cookies. Not reusable for machine-to-machine partner calls.
- Explicitly **not** a reference for this project: the LRMS mobile-app integration code in the main app's repo (`lrms/services/*.php`). Per Dave's instruction, none of that code or its patterns should inform this API's design (deprecated `mysql_*` calls, string-concatenated SQL, plaintext password comparisons — all things to avoid, not emulate).

**Prior work found in this repo's git history** (⚠️ flag for Dave, not yet acted on):
- Commit `46fe507` — "Add eLand Registration API with OAuth 2.0 support and soft delete functionality" — a fairly complete prior scaffold: `.htaccess`, `Database.php`, `BaseGateway.php`, `OAuth.php`, `config.php`, a `gateways/` folder with a dedicated Gateway class per DB table, plus `README.md`, `SETUP.md`, `TESTING.md`, `Instructions.md`.
- Commit `3aa0c36` — "Clear existing work" — removed all of the above back to an empty tree.
- **This planning doc does not assume anything about reusing or discarding that prior attempt.** Before building anything, confirm with Dave whether:
  - it should be resurrected/adapted (it already has per-table gateways and OAuth2), or
  - it's intentionally abandoned (e.g. OAuth2 was more machinery than wanted — Dave's answer below favors simple API keys, which is a lighter-weight choice than OAuth2), or
  - specific pieces (e.g. the `.htaccess`, the Gateway pattern) are worth salvaging even if auth/approach changes.

## Recommendation

New, independent PHP codebase in this repo (`api.elandregistration.com`):
- **Dev**: IIS site + app pool on the Windows dev box, own `web.config` (PHP 8.5 FastCGI handler, same pattern as the main app's).
- **Production**: Apache vhost on the Linux box, PHP 8.2 (mod_php or PHP-FPM — match whatever the existing prod Apache setup already uses for elandregistration.com, don't assume).
- **Database**: same MySQL server/database as the main app, reached via this repo's own small connection file — not a shared include with the main app's repo.

Coding conventions to hold to, given the dev/prod split:
- PHP 8.2-compatible syntax only (no 8.3+-only features), even though dev runs 8.5.
- Explicit `<?php` tags everywhere — don't rely on `short_open_tag`.
- `__DIR__`-relative includes, forward slashes.
- Be deliberate about file/folder name casing — Linux (prod) is case-sensitive, Windows (dev) is not, so a casing mismatch can work in dev and 404 in prod.

## Implementation Steps (for when approved)

### A. Infrastructure
1. Dev (Windows/IIS): new IIS site + app pool at `C:\inetpub\wwwroot\api.elandregistration.com`, `web.config` with just the PHP FastCGI handler block.
2. Production (Linux/Apache): new vhost for `api.elandregistration.com`, DocumentRoot at the deployed repo, PHP 8.2 handler matching the existing prod setup.
3. DNS + TLS cert for the subdomain.
4. Confirm the new site/vhost (both environments) can reach the same MySQL instance the main app uses.

### B. Application skeleton
- `index.php` — front controller/router. Hand-rolled (no Composer framework — consistent with the main app's style of vendoring libraries directly rather than using Composer-managed dependencies).
- `config/database.php` — this repo's own DB connection file (credential-switch by `SERVER_ADDR` or env vars; not shared with the main app's repo).
- `lib/auth.php` — API-key auth via `Authorization: Bearer <key>` header, keys **hashed** at rest in a new `api_partner` table. Per Dave: simplest provisioning to start — generate and insert a key directly (small one-off script), no self-service UI yet.
- First endpoints (per Dave):
  - `GET /v1/events/{eventID}/attendees?limit=N&offset=N` — attendee list for an event, paginated (enforce a sane default/max limit).
  - `GET /v1/attendees/{id}` — single attendee by ID.
  - mysqli prepared statements throughout; explicit allow-listed output fields (decide with Dave which attendee fields are partner-safe).
- Structured JSON error responses (consistent shape for 400/401/404/429/500) and a basic request log.

### C. Security considerations for third-party exposure
- HTTPS-only in production.
- API keys scoped per partner, hashed, revocable.
- Basic rate limiting per key.
- Allow-listed endpoints/fields per partner — never a generic "query any table/field" dispatcher.
- Separate audit log for partner API calls.

## Open items to resolve before/while building
1. **Prior OAuth2 scaffold** (see above) — reuse, adapt, or discard?
2. Exact attendee fields that are partner-safe to expose in the two endpoints.
3. Confirm prod Apache's current PHP handler (mod_php vs PHP-FPM) so the new vhost matches.

## Verification (once building starts)
- `curl` the two endpoints locally with a test partner key; confirm 401 on missing/bad key, 200 + correct JSON shape on valid requests, correct pagination and not-found handling.
- Confirm `config/database.php` resolves the correct DB in each environment.
- Check case-sensitive paths/includes before first prod deploy.
- Confirm PHP 8.2 compatibility before deploying to production.
- Sanity-check that partner API traffic doesn't degrade the main site once live.
