-- =============================================================================
-- LIVE deploy — Candidate Portal + all session permissions (run once)
-- Includes: tables, V58 Candidate Portal, V56 Post/Proposal CRUD, V57 Assigned
-- Docs, Post Management view, All Candidates, Interviews (Employee role)
-- After run: logout/login all users (JWT claims refresh)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- STEP 1: Tables
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `candidateprofiles` (
  `id` char(36) NOT NULL,
  `userId` char(36) NOT NULL,
  `candidateCode` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `experienceYears` int DEFAULT NULL,
  `workMode` varchar(20) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `preferredCategory` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `candidateprofiles_userid_unique` (`userId`),
  UNIQUE KEY `candidateprofiles_candidatecode_unique` (`candidateCode`),
  UNIQUE KEY `candidateprofiles_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add candidateUserId column only if missing
SET @cp_col_exists = (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'proposalcandidates'
    AND COLUMN_NAME = 'candidateUserId'
);

SET @cp_sql_col = IF(
  @cp_col_exists = 0,
  'ALTER TABLE `proposalcandidates` ADD COLUMN `candidateUserId` char(36) DEFAULT NULL AFTER `postId`',
  'SELECT ''candidateUserId column already exists'' AS info'
);
PREPARE cp_stmt_col FROM @cp_sql_col;
EXECUTE cp_stmt_col;
DEALLOCATE PREPARE cp_stmt_col;

-- Add index only if missing
SET @cp_idx_exists = (
  SELECT COUNT(*) FROM information_schema.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'proposalcandidates'
    AND INDEX_NAME = 'proposalcandidates_candidateuserid_index'
);

SET @cp_sql_idx = IF(
  @cp_idx_exists = 0,
  'ALTER TABLE `proposalcandidates` ADD INDEX `proposalcandidates_candidateuserid_index` (`candidateUserId`)',
  'SELECT ''candidateUserId index already exists'' AS info'
);
PREPARE cp_stmt_idx FROM @cp_sql_idx;
EXECUTE cp_stmt_idx;
DEALLOCATE PREPARE cp_stmt_idx;

-- Mark migrations as done (safe if artisan migrate used later)
SET @cp_batch = (SELECT IFNULL(MAX(`batch`), 0) + 1 FROM `migrations`);

INSERT INTO `migrations` (`migration`, `batch`)
SELECT '2026_06_30_000001_create_candidate_profiles_table', @cp_batch
WHERE NOT EXISTS (
  SELECT 1 FROM `migrations` WHERE `migration` = '2026_06_30_000001_create_candidate_profiles_table'
);

INSERT INTO `migrations` (`migration`, `batch`)
SELECT '2026_06_30_000002_add_candidate_user_id_to_proposal_candidates', @cp_batch
WHERE NOT EXISTS (
  SELECT 1 FROM `migrations` WHERE `migration` = '2026_06_30_000002_add_candidate_user_id_to_proposal_candidates'
);

-- -----------------------------------------------------------------------------
-- STEP 2: Role, page, permissions
-- -----------------------------------------------------------------------------

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

-- Candidate role claims
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

-- Super Admin: Candidate Portal (admin can test / access all portal features)
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

-- -----------------------------------------------------------------------------
-- STEP 3: Job Portal — Post Management view + All Candidates (if missing)
-- -----------------------------------------------------------------------------

INSERT INTO pages (id, name, `order`, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'Post Management', 50, @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM pages WHERE id = '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT '8a03d1c7-3b1d-4f14-9a7e-9b44f1b3a2a1', 'View Post Management', 1, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_VIEW', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_VIEW');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'd4e5f6a7-8b9c-4d0e-1f2a-3b4c5d6e7f8a', 'View All Candidates', 2, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'ALL_CANDIDATES_VIEW', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'ALL_CANDIDATES_VIEW');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), '8a03d1c7-3b1d-4f14-9a7e-9b44f1b3a2a1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'POST_MANAGEMENT_VIEW', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'POST_MANAGEMENT_VIEW'
);

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'd4e5f6a7-8b9c-4d0e-1f2a-3b4c5d6e7f8a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_CANDIDATES_VIEW', ''
FROM DUAL
WHERE NOT EXISTS (
  SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'ALL_CANDIDATES_VIEW'
);

-- -----------------------------------------------------------------------------
-- STEP 4: Post Management + Proposal Management CRUD (PermissionSeederV56)
-- -----------------------------------------------------------------------------

INSERT INTO pages (id, name, `order`, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e', 'Proposal Management', 52, @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM pages WHERE id = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'Create Post Management', 3, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_CREATE', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_CREATE');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'Edit Post Management', 4, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_EDIT', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_EDIT');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'Delete Post Management', 5, '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40', 'POST_MANAGEMENT_DELETE', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'POST_MANAGEMENT_DELETE');

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

-- -----------------------------------------------------------------------------
-- STEP 5: Assigned Documents view (PermissionSeederV57)
-- -----------------------------------------------------------------------------

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b5c', 'View Assigned Documents', 1, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b5c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS', ''
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4' AND claimType = 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS');

INSERT INTO roleclaims (id, actionId, roleId, claimType, claimValue)
SELECT UUID(), 'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b5c', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS', ''
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM roleclaims WHERE roleId = 'ff635a8f-4bb3-4d70-a3ed-c7749030696c' AND claimType = 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS');

-- -----------------------------------------------------------------------------
-- STEP 6: Assigned Interviews — Employee role (if missing)
-- -----------------------------------------------------------------------------

INSERT INTO pages (id, name, `order`, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b', 'Interviews', 51, @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM pages WHERE id = 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'b2a1c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d', 'View Assigned Interviews', 1, 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b', 'INTERVIEWS_VIEW_ASSIGNED', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'INTERVIEWS_VIEW_ASSIGNED');

INSERT INTO actions (id, name, `order`, pageId, code, createdBy, modifiedBy, createdDate, modifiedDate, isDeleted)
SELECT 'c3d4e5f6-7a8b-4c9d-0e1f-2a3b4c5d6e7f', 'Update Assigned Interviews', 2, 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b', 'INTERVIEWS_UPDATE_ASSIGNED', @admin_user, @admin_user, NOW(), NOW(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM actions WHERE code = 'INTERVIEWS_UPDATE_ASSIGNED');

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

-- Done
SELECT 'Candidate Portal + all session permissions deployed' AS status;
