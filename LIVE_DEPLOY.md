# Live (Hostinger) — manual deploy (no sync script on server)

## 1. Database (phpMyAdmin)

- Import **`dms-ahi.sql`** into the database used in `.env` → `DB_DATABASE`
- Confirm `.env` on live:

```env
DB_DATABASE=u983827262_dms
DB_HOST=...
DB_USERNAME=...
DB_PASSWORD=...
JWT_SECRET=...   # must be set
APP_DEBUG=false
```

## 2. Upload these folders/files (FTP / File Manager)

**GitHub push alone does not update live.** You must either `git pull` on the server (if repo is cloned there) or FTP/upload the files below.

Replace on server `public_html/` (or your Laravel root):

| Upload from project | To live | Why |
|---------------------|---------|-----|
| `public/assets/angular/browser/` | `public/assets/angular/browser/` | **All UI** (Post Management, pagination, forms) — built JS/CSS |
| `resources/views/angular.blade.php` | `resources/views/angular.blade.php` | Loads new `main-*.js` / chunks from build |
| `app/Http/Controllers/ProposalManagementController.php` | same | Post / category / department API |
| `app/Http/Controllers/ClientController.php` | same | Add client fix |
| `app/Models/ProposalCategory.php` | `app/Models/` | New model |
| `app/Models/ProposalDepartment.php` | `app/Models/` | New model |
| `app/Models/ProposalPost.php` | `app/Models/` | If changed |
| `app/Models/ProposalCandidate.php` | `app/Models/` | If changed |
| `app/Models/Clients.php` | `app/Models/` | Client create fix |
| `routes/api.php` | `routes/api.php` | New routes (`post-board`, categories, departments) |
| `app/Models/` (rest) | `app/Models/` | TableName / BaseModel fixes |
| `app/Support/TableName.php` | `app/Support/` | Live table names |
| `app/Traits/ResolvesTableName.php` | `app/Traits/` | |
| `app/Models/BaseModel.php` | `app/Models/` | |
| `app/helpers.php` | `app/helpers.php` | |
| `composer.json` | `composer.json` (if helpers autoload added) | |

**Do NOT upload (useless on live):**

- `resources/frontend/angular/src/` — source only; must **build locally** first
- `node_modules/`, `vendor/` (run composer on server if needed)
- `.env` (edit live `.env` only)

### Post Management — build on PC, then upload UI

On your PC:

```bash
cd resources/frontend/angular
npm run build
```

Then upload **entire** folder:

`public/assets/angular/browser/` → live `public/assets/angular/browser/`

And:

`resources/views/angular.blade.php` → live `resources/views/angular.blade.php`

### Post Management — database (phpMyAdmin)

Import once: `database/sql/proposal_categories_departments.sql`

Creates `proposalcategories`, `proposaldepartments`, adds `departmentId` on `proposalposts`.

### After upload — browser

Hard refresh: **Ctrl + F5** (or clear cache). Old `main-XXXX.js` is cached easily.

Check DevTools → Network → `main-*.js` — filename should match new build (e.g. `main-FCFBVGMW.js` in latest local build).

## 3. On live terminal (SSH) or local then upload vendor

```bash
composer dump-autoload -o
php artisan config:clear
php artisan cache:clear
php artisan route:clear
```

## 4. Table names (dms-ahi.sql)

All MySQL tables are **lowercase**, e.g.:

- `userroles`, `roleclaims`, `userclaims`
- `loginaudits`, `allowfileextensions`
- `companyprofile`, `documentworkflow`

**Case-insensitive tables:** `TableName` + `BaseModel` auto-match `userRoles` / `userroles` / `USERROLES` to the real table on your server. Upload `app/Support/TableName.php`, `app/Providers/AppServiceProvider.php`, `app/helpers.php`.

## 5. Login test

- Email + password from `users` table
- If 401: check `storage/logs/laravel.log` for `[LOGIN_FAIL]`

## 6. Assign Super Admin to your user (SQL)

```sql
INSERT IGNORE INTO userroles (id, userId, roleId)
VALUES (UUID(), 'YOUR-USER-UUID', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4');
```

Get role id: `SELECT id, name FROM roles;`
