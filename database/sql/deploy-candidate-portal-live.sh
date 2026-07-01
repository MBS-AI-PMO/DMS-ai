#!/bin/bash
# Candidate Portal — LIVE server deploy via SSH
# Run from project root: bash database/sql/deploy-candidate-portal-live.sh

set -e

echo "=== Candidate Portal Live Deploy ==="

php artisan migrate --path=database/migrations/2026_06_30_000001_create_candidate_profiles_table.php --force
php artisan migrate --path=database/migrations/2026_06_30_000002_add_candidate_user_id_to_proposal_candidates.php --force
php artisan db:seed --class=PermissionSeederV58 --force

php artisan config:clear
php artisan route:clear
php artisan cache:clear

echo ""
echo "=== SUCCESS ==="
echo "Logout and login again for updated permissions."
