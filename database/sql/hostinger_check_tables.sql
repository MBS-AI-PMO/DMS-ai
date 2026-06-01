-- Run in phpMyAdmin on LIVE database (same DB as .env DB_DATABASE).
-- Shows exact table names (case) Laravel must match.

SELECT DATABASE() AS connected_database;

SELECT TABLE_NAME
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND LOWER(TABLE_NAME) IN (
    'userroles', 'roles', 'roleclaims', 'userclaims', 'users',
    'allowfileextensions', 'loginaudits'
  )
ORDER BY TABLE_NAME;

-- If userRoles missing but userroles exists, rename (pick ONE that matches your list above):
-- RENAME TABLE `userroles` TO `userRoles`;
-- RENAME TABLE `roleclaims` TO `roleClaims`;
-- RENAME TABLE `userclaims` TO `userClaims`;
