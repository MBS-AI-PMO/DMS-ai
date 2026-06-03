-- phpMyAdmin: permissions for Post Management (admin) + Assigned Interviews (interviewer)
-- Run once on live DB, then users must logout/login (or wait for token refresh).

SET @admin_user = (SELECT id FROM users ORDER BY createdDate LIMIT 1);

-- Pages
INSERT INTO pages (id, name, `order`, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'Post Management', 50, @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM pages WHERE id = '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40');

INSERT INTO pages (id, name, `order`, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b', 'Interviews', 51, @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM pages WHERE id = 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b');

-- Actions
INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT '8a03d1c7-3b1d-4f14-9a7e-9b44f1b3a2a1', 'View Post Management', 1, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_VIEW', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_VIEW');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'b2a1c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d', 'View Assigned Interviews', 1, 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b', 'INTERVIEWS_VIEW_ASSIGNED', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'INTERVIEWS_VIEW_ASSIGNED');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'c3d4e5f6-7a8b-4c9d-0e1f-2a3b4c5d6e7f', 'Update Assigned Interviews', 2, 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b', 'INTERVIEWS_UPDATE_ASSIGNED', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'INTERVIEWS_UPDATE_ASSIGNED');

-- Super Admin: Post Management + interviews (if admin is also interviewer)
INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), '8a03d1c7-3b1d-4f14-9a7e-9b44f1b3a2a1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'POST_MANAGEMENT_VIEW', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'POST_MANAGEMENT_VIEW'
);

-- Super Admin: only Post Management (not Assigned Interviews tab)
DELETE FROM roleclaims
WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4'
  AND claimType IN ('INTERVIEWS_VIEW_ASSIGNED', 'INTERVIEWS_UPDATE_ASSIGNED');

-- Employee role: Assigned Interviews
INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'b2a1c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'INTERVIEWS_VIEW_ASSIGNED', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'ff635a8f-4bb3-4d70-a3ed-c7749030696c' AND claimType = 'INTERVIEWS_VIEW_ASSIGNED'
);

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'c3d4e5f6-7a8b-4c9d-0e1f-2a3b4c5d6e7f', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'INTERVIEWS_UPDATE_ASSIGNED', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'ff635a8f-4bb3-4d70-a3ed-c7749030696c' AND claimType = 'INTERVIEWS_UPDATE_ASSIGNED'
);

-- Optional: grant interview permissions to one interviewer user immediately (replace USER_UUID)
-- INSERT INTO userclaims (id, userId, actionId, claimType, claimValue)
-- SELECT UUID(), 'USER_UUID', a.id, a.code, ''
-- FROM actions a
-- WHERE a.code IN ('INTERVIEWS_VIEW_ASSIGNED', 'INTERVIEWS_UPDATE_ASSIGNED')
-- AND NOT EXISTS (
--   SELECT 1 FROM userclaims uc WHERE uc.userId = 'USER_UUID' AND uc.claimType = a.code
-- );
