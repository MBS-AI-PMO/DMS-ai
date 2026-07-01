-- Candidate Portal role, page, permissions (run once on live DB, then logout/login).

SET @admin_user = COALESCE(
  (SELECT id FROM users WHERE isSystemUser = 1 LIMIT 1),
  (SELECT id FROM users LIMIT 1)
);

INSERT INTO roles (id, isDeleted, name, createdBy, modifiedBy, createdDate, modifiedDate)
SELECT 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58', 0, 'Candidate', @admin_user, @admin_user, NOW(), NOW()
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE id = 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58');

INSERT INTO pages (id, name, `order`, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'd2b3c4d5-e6f7-4a8b-9c0d-1e2f3a4b5c59', 'Candidate Portal', 60, @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM pages WHERE id = 'd2b3c4d5-e6f7-4a8b-9c0d-1e2f3a4b5c59');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b60', 'View Candidate Portal', 1, 'd2b3c4d5-e6f7-4a8b-9c0d-1e2f3a4b5c59', 'CANDIDATE_PORTAL_VIEW', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'CANDIDATE_PORTAL_VIEW');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c71', 'Edit Candidate Profile', 2, 'd2b3c4d5-e6f7-4a8b-9c0d-1e2f3a4b5c59', 'CANDIDATE_PORTAL_EDIT_PROFILE', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'CANDIDATE_PORTAL_EDIT_PROFILE');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d82', 'Browse Recommended Jobs', 3, 'd2b3c4d5-e6f7-4a8b-9c0d-1e2f3a4b5c59', 'CANDIDATE_PORTAL_BROWSE_JOBS', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'CANDIDATE_PORTAL_BROWSE_JOBS');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b60', 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58', 'CANDIDATE_PORTAL_VIEW', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58' AND claimType = 'CANDIDATE_PORTAL_VIEW'
);

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c71', 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58', 'CANDIDATE_PORTAL_EDIT_PROFILE', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58' AND claimType = 'CANDIDATE_PORTAL_EDIT_PROFILE'
);

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d82', 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58', 'CANDIDATE_PORTAL_BROWSE_JOBS', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58' AND claimType = 'CANDIDATE_PORTAL_BROWSE_JOBS'
);

-- Super Admin: Candidate Portal
INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b60', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'CANDIDATE_PORTAL_VIEW', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'CANDIDATE_PORTAL_VIEW'
);

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c71', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'CANDIDATE_PORTAL_EDIT_PROFILE', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'CANDIDATE_PORTAL_EDIT_PROFILE'
);

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d82', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'CANDIDATE_PORTAL_BROWSE_JOBS', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'CANDIDATE_PORTAL_BROWSE_JOBS'
);
