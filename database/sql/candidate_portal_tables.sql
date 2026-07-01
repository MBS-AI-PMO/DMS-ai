-- Candidate Portal tables (run once on live DB before permissions SQL).

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

-- Skip if column/index already exists (safe re-run via candidate_portal_live_deploy.sql).
ALTER TABLE `proposalcandidates`
  ADD COLUMN `candidateUserId` char(36) DEFAULT NULL AFTER `postId`;

ALTER TABLE `proposalcandidates`
  ADD INDEX `proposalcandidates_candidateuserid_index` (`candidateUserId`);
