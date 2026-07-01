-- Post Management + Proposal Management CRUD permissions (phpMyAdmin / live deploy)
SET @admin_user := (SELECT id FROM users WHERE isSystemUser = 1 LIMIT 1);
SET @admin_user := IFNULL(@admin_user, (SELECT id FROM users ORDER BY createdDate LIMIT 1));

-- Proposal Management page
INSERT INTO pages (id, name, `order`, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e', 'Proposal Management', 52, @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM pages WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e');

-- Post Management CRUD (VIEW + ALL_CANDIDATES already exist)
INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'Create Post Management', 3, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_CREATE', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_CREATE');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'Edit Post Management', 4, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_EDIT', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_EDIT');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'Delete Post Management', 5, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_DELETE', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_DELETE');

-- Proposal Management CRUD
INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'View Proposal Management', 1, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e', 'PROPOSAL_MANAGEMENT_VIEW', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'PROPOSAL_MANAGEMENT_VIEW');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'Create Proposal Management', 2, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e', 'PROPOSAL_MANAGEMENT_CREATE', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'PROPOSAL_MANAGEMENT_CREATE');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f40', 'Edit Proposal Management', 3, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e', 'PROPOSAL_MANAGEMENT_EDIT', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'PROPOSAL_MANAGEMENT_EDIT');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4051', 'Delete Proposal Management', 4, 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e', 'PROPOSAL_MANAGEMENT_DELETE', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'PROPOSAL_MANAGEMENT_DELETE');

-- Super Admin role claims
INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'POST_MANAGEMENT_CREATE', ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'POST_MANAGEMENT_CREATE');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'POST_MANAGEMENT_EDIT', ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'POST_MANAGEMENT_EDIT');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'POST_MANAGEMENT_DELETE', ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'POST_MANAGEMENT_DELETE');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'PROPOSAL_MANAGEMENT_VIEW', ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'PROPOSAL_MANAGEMENT_VIEW');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'PROPOSAL_MANAGEMENT_CREATE', ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'PROPOSAL_MANAGEMENT_CREATE');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f40', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'PROPOSAL_MANAGEMENT_EDIT', ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'PROPOSAL_MANAGEMENT_EDIT');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4051', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'PROPOSAL_MANAGEMENT_DELETE', ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'PROPOSAL_MANAGEMENT_DELETE');
