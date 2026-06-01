-- Import in phpMyAdmin (dms-ahi naming: lowercase tables)

CREATE TABLE IF NOT EXISTS `proposalcategories` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdBy` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `proposaldepartments` (
  `id` char(36) NOT NULL,
  `categoryId` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `basicQuestions` text,
  `intermediateQuestions` text,
  `expertQuestions` text,
  `createdBy` char(36) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proposaldepartments_categoryId` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `proposalposts`
  ADD COLUMN IF NOT EXISTS `departmentId` char(36) NULL AFTER `department`;
