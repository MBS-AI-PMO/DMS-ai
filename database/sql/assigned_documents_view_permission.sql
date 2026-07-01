-- Assigned Documents: View permission (complete CRUD with existing Create/Edit/Delete)
SET @admin_user := (SELECT id FROM users WHERE isSystemUser = 1 LIMIT 1);
SET @admin_user := IFNULL(@admin_user, (SELECT id FROM users ORDER BY createdDate LIMIT 1));

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
