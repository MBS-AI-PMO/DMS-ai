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

Replace on server `public_html/` (or your Laravel root):

| Upload from project | To live |
|---------------------|---------|
| `app/Models/` | `app/Models/` |
| `app/Http/Controllers/` | `app/Http/Controllers/` |
| `app/Repositories/` | `app/Repositories/` |
| `app/Support/TableName.php` | `app/Support/` |
| `app/Traits/ResolvesTableName.php` | `app/Traits/` |
| `app/Models/BaseModel.php` | `app/Models/` |
| `app/helpers.php` | `app/helpers.php` |
| `composer.json` | `composer.json` (if helpers autoload added) |

**Do not upload** `vendor/`, `node_modules/`, `.env` (edit live `.env` only).

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
