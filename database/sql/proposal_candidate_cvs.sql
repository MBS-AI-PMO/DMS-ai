-- CV vault for public apply form (max 5 CVs per candidate, FIFO)
CREATE TABLE IF NOT EXISTS `proposalcandidatecvs` (
  `id` char(36) NOT NULL,
  `createdBy` char(36) NOT NULL,
  `candidateCode` varchar(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cvOriginalName` varchar(255) DEFAULT NULL,
  `cvPath` varchar(500) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
