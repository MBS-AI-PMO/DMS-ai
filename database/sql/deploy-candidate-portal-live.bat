@echo off
REM Candidate Portal — LIVE server deploy via SSH/terminal
REM Run this from project root on live server (where artisan exists)

echo === Candidate Portal Live Deploy ===
echo.

php artisan migrate --path=database/migrations/2026_06_30_000001_create_candidate_profiles_table.php --force
if errorlevel 1 goto :error

php artisan migrate --path=database/migrations/2026_06_30_000002_add_candidate_user_id_to_proposal_candidates.php --force
if errorlevel 1 goto :error

php artisan db:seed --class=PermissionSeederV58 --force
if errorlevel 1 goto :error

php artisan config:clear
php artisan route:clear
php artisan cache:clear

echo.
echo === SUCCESS ===
echo Logout and login again for updated permissions.
goto :end

:error
echo.
echo === FAILED — check errors above ===
echo If migrate fails, use phpMyAdmin: database/sql/candidate_portal_live_deploy.sql
exit /b 1

:end
