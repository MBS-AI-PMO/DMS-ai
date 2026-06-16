-- All Candidates permission (Roles → Post Management → View All Candidates)
-- Run once on live DB, then logout/login for updated JWT claims.

SET @admin_user = COALESCE(
  (SELECT id FROM users WHERE isSystemUser = 1 LIMIT 1),
  (SELECT id FROM users LIMIT 1)
);

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'd4e5f6a7-8b9c-4d0e-1f2a-3b4c5d6e7f8a', 'View All Candidates', 2, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'ALL_CANDIDATES_VIEW', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'ALL_CANDIDATES_VIEW');

-- Super Admin: default access
INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'd4e5f6a7-8b9c-4d0e-1f2a-3b4c5d6e7f8a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_CANDIDATES_VIEW', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'ALL_CANDIDATES_VIEW'
);
