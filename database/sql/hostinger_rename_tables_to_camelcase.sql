-- ONLY if hostinger_check_tables.sql shows lowercase names (userroles, roleclaims...)
-- and Laravel still fails AFTER deploying BaseModel + TableName resolver.
-- Run one RENAME at a time; skip if that name already exists.

-- RENAME TABLE `userroles` TO `userRoles`;
-- RENAME TABLE `roleclaims` TO `roleClaims`;
-- RENAME TABLE `userclaims` TO `userClaims`;
-- RENAME TABLE `usernotifications` TO `userNotifications`;
-- RENAME TABLE `loginaudits` TO `loginAudits`;
-- RENAME TABLE `allowfileextensions` TO `allowFileExtensions`;
