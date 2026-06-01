-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table dms_ai.actions
CREATE TABLE IF NOT EXISTS `actions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL,
  `pageId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `actions_pageid_foreign` (`pageId`),
  CONSTRAINT `actions_pageid_foreign` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.actions: ~103 rows (approximately)
INSERT INTO `actions` (`id`, `name`, `order`, `pageId`, `code`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('0478e8b6-7d52-4c26-99e1-657a1c703e8b', 'DELETE_FILE_REQUEST', 4, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_DELETE_FILE_REQUEST', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('07ad64e9-9a43-40d0-a205-2adb81e238b1', 'Storage Settings', 2, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_STORAGE_SETTINGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('086ce19f-5f1b-42ec-98ac-dea2d92901a3', 'Archive Document', 1, 'c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'EXPIRED_DOCUMENTS_ARCHIVE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', 'Edit User', 3, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_EDIT_USER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('0f70cc17-26a9-43b1-922e-01fefb248d3c', 'VIEW_WORKFLOW_LIST', 1, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_VIEW_WORKFLOW_SETTINGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('165505b2-ad31-42c7-aafe-f66f291cb5a9', 'Manage Comment', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_MANAGE_COMMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', 'Delete Role', 4, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_DELETE_ROLE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('18d07817-4b47-4c84-b21f-abe05da5e1ba', 'Archive Document', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_ARCHIVE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('1ae728c8-58df-4e9f-b284-132dc3c8ff89', 'REJECT_FILE_REQUEST', 6, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_REJECT_FILE_REQUEST', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', 'View Document Audit Trail', 1, '2396f81c-f8b5-49ac-88d1-94ed57333f49', 'DOCUMENT_AUDIT_TRAIL_VIEW_DOCUMENT_AUDIT_TRAIL', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('1d768490-d67d-40b6-b610-22b17cc7ce2d', 'Add Indexing', 2, '0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'DEEP_SEARCH_ADD_INDEXING', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('1e5fc904-5f70-4b07-8914-242703da5702', 'View Email Logs', 3, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGS_VIEW_EMAIL_LOGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('229150ef-9007-4c62-9276-13dd18294370', 'Restore Version', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_RESTORE_VERSION', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('229ad778-c7d3-4f5f-ab52-24b537c39514', 'Delete Document', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_DELETE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('239035d5-cd44-475f-bbc5-9ef51768d389', 'Create Document', 2, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_CREATE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('260d1089-46c7-4f53-83e6-f80b9b3fb823', 'Archive Document', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_ARCHIVE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('26e383c9-7f7f-4ed0-b78d-a2941f5b4fe7', 'Add Reminder', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_ADD_REMINDER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('2e71e9d6-2302-44d8-b0f6-747b98d89125', 'UPDATE_FILE_REQUEST', 3, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_UPDATE_FILE_REQUEST', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('2ea6ba08-eb36-4e34-92d9-f1984c908b31', 'Share Document', 6, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_SHARE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('2f264576-2d7f-44a2-beeb-97c53847ad70', 'Update Email Log Settings', 5, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'EMAIL_LOG_SET_RETENTION_PERIOD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('31ba8e74-8fa0-4c34-82ac-950e73a4c18e', 'Activate Document', 1, 'c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'EXPIRED_DOCUMENTS_ACTIVATE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('31cb6438-7d4a-4385-8a34-b4e8f6096a48', 'View Users', 1, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_VIEW_USERS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('322c388d-0ab4-4617-9bee-a8c79906e738', 'Update Archive Document Settings', 4, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_SET_RETENTION_PERIOD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('324192f0-a319-4228-ba06-f1ce10189822', 'Update Login Audit Settings', 7, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGIN_AUDIT_SET_RETENTION_PERIOD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('374d74aa-a580-4928-848d-f7553db39914', 'Delete User', 4, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_DELETE_USER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('37db8a21-e552-466d-bcf4-f90f5e4e1008', 'VIEW_DETAIL', 9, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_VIEW_DETAIL', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('391c1739-1045-4dd4-9705-4a960479f0a0', 'Upload New Version', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_UPLOAD_NEW_VERSION', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('3ccaf408-8864-4815-a3e0-50632d90bcb6', 'Edit Reminder', 3, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_EDIT_REMINDER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('3da78b4d-d263-4b13-8e81-7aa164a3688c', 'Add Reminder', 5, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_ADD_REMINDER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('4071ed2e-56fb-4c5a-887d-8a175cac8d71', 'Restore Document', 4, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_RESTORE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('41f65d07-9023-4cfb-9c7c-0e3247a012e0', 'Manage SMTP Settings', 1, '2e3c07a4-fcac-4303-ae47-0d0f796403c9', 'EMAIL_MANAGE_SMTP_SETTINGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('44ecbcaf-6d4a-4fc2-911c-e96be65bffb2', 'Manage Comment', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_MANAGE_COMMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('4cce3cb4-5179-4fc7-b59c-7b15afc747f7', 'MANAGE_CLIENTS', 1, '34328287-3a37-4c70-ac61-b291c3ef5ade', 'CLIENTS_MANAGE_CLIENTS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('4f0e8a83-8a01-415e-88f5-c204369290de', 'Deep Search', 1, '0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'DEEP_SEARCH_DEEP_SEARCH', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('538c081b-2e14-4f0d-bc34-5f26ad2f77cf', 'Delete Email Log', 4, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGS_DELETE_EMAIL_LOG', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('57216dcd-1a1c-4f94-a33d-83a5af2d7a46', 'View Roles', 1, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_VIEW_ROLES', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('57f0b2ef-eeba-44a6-bd88-458003f013ef', 'Upload New Version', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_UPLOAD_NEW_VERSION', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('595a769d-f7ef-45f3-9f9e-60c58c5e1542', 'Send Email', 8, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_SEND_EMAIL', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', 'Delete Reminder', 4, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_DELETE_REMINDER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('5f24c3d8-94d8-4e57-adb3-bef3e000e7d0', 'View Expired Documents', 1, 'c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'EXPIRED_DOCUMENTS_VIEW_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('5f7c13fd-3c5d-4e69-9e21-a263924d273b', 'Change PDF Signature Settings', 6, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_CHANGE_PDF_SETTINGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('61de0ba3-f41f-4ca8-9af6-ec8dc456c16b', 'CREATE_FILE_REQUEST', 2, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_CREATE_FILE_REQUEST', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('63355376-2650-4949-9580-fc8c888353f0', 'Manage Open AI API Key', 2, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_MANAGE_OPEN_AI_API_KEY', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('63ed1277-1db5-4cf7-8404-3e3426cb4bc5', 'View Documents', 1, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_VIEW_DOCUMENTS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('6719a065-8a4a-4350-8582-bfc41ce283fb', 'Download Document', 7, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_DOWNLOAD_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('6b0fe007-1b92-4568-a4b7-6d105eb5c48c', 'PERFORM_TRANSITION', 1, '5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'WORKFLOW_ALL_PERFORM_TRANSITION', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('6bc0458e-22f5-4975-b387-4d6a4fb35201', 'Create Reminder', 2, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_CREATE_REMINDER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('6f2717fc-edef-4537-916d-2d527251a5c1', 'View Reminders', 1, '97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'REMINDER_VIEW_REMINDERS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('707c447d-5e0b-454a-abdf-550d8923eabc', 'START_WORKFLOW', 7, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_START_WORKFLOW', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('72ca5c91-b415-4997-a234-b4d71ba03253', 'Manage Languages', 1, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTING_MANAGE_LANGUAGE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('72ce114a-d299-4d7d-aeee-598167a4fabc', 'Generate AI Powered Summary', 5, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOC_GENERATE_SUMMARY', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('7562978b-155a-4fb1-bc3f-6153f62ed565', 'VIEW_FILE_REQUEST', 1, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_VIEW_FILE_REQUEST', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('78d881d1-1da5-42d9-a97b-a6ad71e27ebc', 'Add Watermark', 15, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOC_WATERMARK', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('79ce78a8-0716-4850-a40b-cdc36f3579e4', 'VIEW_WORKFLOW_LOGS', 1, 'b2c3d4e5-6f7g-8h9i-0j1k-2l3m4n5o6p7q', 'WORKFLOW_VIEW_WORKFLOW_LOGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('7ba630ca-a9d3-42ee-99c8-766e2231fec1', 'View Dashboard', 1, '42e44f15-8e33-423a-ad7f-17edc23d6dd3', 'DASHBOARD_VIEW_DASHBOARD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('86ce1382-a2b1-48ed-ae81-c9908d00cf3b', 'Create User', 2, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_CREATE_USER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('8b63ccd0-616a-4b97-8af6-aa49066a0a9e', 'Generate AI Powered Summary', 6, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOC_GENERATE_SUMMARY', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('8d7e1668-ab2d-4aa5-b8d1-0358906d6995', 'VIEW_DETAIL', 9, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_VIEW_DETAIL', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('8e3fbe21-0225-44e2-a537-bb50ddffb95c', 'MANAGE_ALLOW_FILE_EXTENSIONS', 4, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_MANAGE_ALLOW_FILE_EXTENSIONS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('92596605-e49a-4ab6-8a39-60116eba8abe', 'Delete Document', 6, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_DELETE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('96865813-77f0-40cf-968d-8b9c023d810e', 'ADD_WORKFLOW', 2, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_ADD_WORKFLOW', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('9a086704-b7c2-4dff-9088-dde29ad259ef', 'Remove Indexing', 3, '0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'DEEP_SEARCH_REMOVE_INDEXING', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('9ac0f6f5-0731-49d9-a7b9-6fbd92291241', 'Update Cron Job Log Settings', 6, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'CRON_JOB_LOG_SET_RETENTION_PERIOD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'START_WORKFLOW', 7, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_START_WORKFLOW', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('a57b1ad5-8fbc-429b-b776-fbb468e5c6a4', 'Manage Company Profile', 2, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTING_MANAGE_PROFILE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('a5b485ac-8c7b-4a4f-a62d-6f839d77e91f', 'View Version History', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_VIEW_VERSION_HISTORY', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('a737284a-e43b-481d-9fdd-07e1680ffe11', 'Edit Document', 2, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_EDIT_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('a74e0f79-bc3c-4582-a2ea-008d568e6a8b', 'View Cron Job Logs', 2, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGS_VIEW_CRON_JOBS_LOGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('a8dd972d-e758-4571-8d39-c6fec74b361b', 'Edit Document', 3, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_EDIT_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('aa712002-aa9a-4656-9835-34278487a848', 'Add Signature', 5, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGN_ADD_SIGNATURE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('ac6d6fbc-6348-4149-9c0c-154ab79d1166', 'Share Document', 3, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_SHARE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('b0f2a1c4-3d8e-4b5c-9f6d-7a0e5f3b8c1d', 'DELETE_AI_GENERATED_DOCUMENTS', 3, '637f010e-3397-41a9-903a-21d54db5e49a', 'DELETE_AI_GENERATED_DOCUMENTS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('b1c5f8d2-3e4f-4b0a-9c6d-7e8f9a0b1c2d', 'UPDATE_WORKFLOW', 3, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_UPDATE_WORKFLOW', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('b36cf0a4-ad53-4938-aac5-fb7fbfc2cfcf', 'Restore Version', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_RESTORE_VERSION', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('b4d722d6-755c-4be4-8f0d-2283c9394e18', 'APPROVE_FILE_REQUEST', 5, '55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST_APPROVE_FILE_REQUEST', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('bc515aea-ef66-4d8d-9cdb-47477cb74145', 'MANAGE_AI_PROMPT_TEMPLATES', 4, '637f010e-3397-41a9-903a-21d54db5e49a', 'MANAGE_AI_PROMPT_TEMPLATES', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('bf3ec13f-1e81-40f3-ad7a-05523608e85c', 'Manage Google Gemini API', 4, '8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'SETTINGS_MANAGE_GEMINI_API_KEY', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('c04a1094-f289-4de7-b788-9f21ee3fe32a', 'Send Email', 5, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_SEND_EMAIL', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('c18e4105-e9d7-4c5d-b396-a2854bcb8e21', 'View Version History', 4, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_VIEW_VERSION_HISTORY', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('c288b5d3-419d-4dc0-9e5a-083194016d2c', 'Edit Role', 3, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_EDIT_ROLE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('c2d3e4f5-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'DELETE_WORKFLOW', 4, '869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_DELETE_WORKFLOW', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('c6e2e9f8-1ee4-4c1d-abd1-721ff604c8b8', 'Add Reminder', 4, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_ADD_REMINDER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('cb988c3a-7487-4366-9521-c0c5adf9b5a6', 'BULK_DOCUMENT_UPLOAD', 1, '8384e302-eaf1-4a0b-b293-a921b1e9e36a', 'BULK_DOCUMENT_UPLOAD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('cd46a3a4-ede5-4941-a49b-3df7eaa46428', 'Manage Document Category', 1, '5a5f7cf8-21a6-434a-9330-db91b17d867c', 'DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('d4d724fc-fd38-49c4-85bc-73937b219e20', 'Reset Password', 5, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_RESET_PASSWORD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('d57ff519-1448-4336-8d76-98d43a9ada2c', 'CANCEL_WORKFLOW', 1, '5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'WORKFLOW_ALL_CANCEL_WORKFLOW', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('d9067d75-e3b9-4d2d-8f82-567ad5f2b9ca', 'View Documents', 1, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_VIEW_DOCUMENTS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('db8825b1-ee4e-49f6-9a08-b0210ed53fd4', 'Create Role', 2, '090ea443-01c7-4638-a194-ad3416a5ea7a', 'ROLE_CREATE_ROLE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('dba2e7bf-6bac-4620-a9e6-d4eaa2c8480f', 'Manage Page Helper', 1, 'cfa38ae7-b5ba-4881-9199-d2914d7fd58e', 'PAGE_HELPER_MANAGE_PAGE_HELPER', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('e017d419-8080-4b2d-ac89-4e966182a12f', 'MANAGE_DOCUMENT_STATUS', 1, '8740dd7a-7bca-442f-b50f-6cdf0fcaf7bd', 'MANAGE_DOCUMENT_STATUS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('e3fcd910-3f9b-4035-9bbb-312c5b599d52', 'GENERATE_AI_DOCUMENTS', 1, '637f010e-3397-41a9-903a-21d54db5e49a', 'GENERATE_AI_DOCUMENTS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('e506ec48-b99a-45b4-9ec9-6451bc67477b', 'Assign Permission', 7, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_ASSIGN_PERMISSION', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('e9ff854b-23f7-46c2-9029-efba3d8587b5', 'Manage Sharable Link', 7, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_MANAGE_SHARABLE_LINK', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('ef979f76-027c-4b20-9330-5c81a3dc5869', 'Add Watermark', 15, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOC_WATERMARK', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', '84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('f165f5a2-fe26-490a-91bc-08a736096fed', 'VIEW_ALL_WORKFLOW', 1, '5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'WORKFLOW_VIEW_ALL_WORKFLOWS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('f4d8a768-151d-4ec9-a8e3-41216afe0ec0', 'Delete Document', 4, '05edb281-cddb-4281-9ab3-fb90d1833c82', 'ARCHIVE_DOCUMENT_DELETE_DOCUMENTS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('f508f793-5d4c-4e03-889c-2c62b6cf484f', 'VIEW_MY_WORKFLOW', 1, '655f0bcd-676d-49fc-ba30-24c39c853e16', 'WORKFLOW_VIEW_MY_WORKFLOWS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('f5829228-ea73-4389-8aee-e2dc8ef6934a', 'Add Signature', 5, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOC_ADD_SIGNATURE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('f9ec1096-b798-4623-bbf8-4f5d4fe775e9', 'Manage Sharable Link', 10, 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'ALL_DOCUMENTS_MANAGE_SHARABLE_LINK', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('fa5b07a4-e8c4-40e2-b5cf-f1a562087783', 'VIEW_AI_GENERATED_DOCUMENTS', 2, '637f010e-3397-41a9-903a-21d54db5e49a', 'VIEW_AI_GENERATED_DOCUMENTS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('fa91ffd9-61ee-4bb1-bf86-6a593cdc7be9', 'Create Document', 1, 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'ASSIGNED_DOCUMENTS_CREATE_DOCUMENT', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('fbe77c07-3058-4dbe-9d56-8c75dc879460', 'Assign User Role', 6, '324bdc51-d71f-4f80-9f28-a30e8aae4009', 'USER_ASSIGN_USER_ROLE', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', 'View Login Audit Logs', 1, 'f042bbee-d15f-40fb-b79a-8368f2c2e287', 'LOGIN_AUDIT_VIEW_LOGIN_AUDIT_LOGS', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL);

-- Dumping structure for table dms_ai.aiprompttemplates
CREATE TABLE IF NOT EXISTS `aiprompttemplates` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `promptInput` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.aiprompttemplates: ~30 rows (approximately)
INSERT INTO `aiprompttemplates` (`id`, `name`, `description`, `promptInput`, `modifiedDate`, `deleted_at`) VALUES
	('0e832c07-8a82-4a5b-b415-cc4b466a9056', 'Generate tags and keywords for youtube video', 'Generate tags and keywords for youtube video', 'Generate tags and keywords about **title** for youtube video.', '2025-04-24 08:06:48', NULL),
	('18849032-284e-4ea5-adaf-35ee52e4ddc4', 'Generate testimonial', 'Generate testimonial', 'Generate testimonial for **subject**. Include details about how it helped you and what you like best about it.', '2025-04-24 07:57:12', NULL),
	('1a4e4a31-f197-4e6f-a58a-e599f216f6ce', 'Generate blog post conclusion', 'Generate blog post conclusion', 'Write blog post conclusion about title: **title**. And the description is **description**.', '2025-04-24 08:03:29', NULL),
	('20804416-cb1b-4016-840d-6f6d625ac210', 'Write Problem Agitate Solution', 'Write Problem Agitate Solution', 'Write Problem-Agitate-Solution copy for the **description**.', '2025-04-24 07:57:56', NULL),
	('30d72e36-1ef7-4ba9-8a8d-db119c013157', 'Generate Google ads headline for product.', 'Generate Google ads headline for product.', 'Write Google ads headline product name: **product name**. Description is **description**. Audience is **audience**.', '2025-04-24 08:47:44', NULL),
	('3b28ed3a-88e3-4d04-8537-039202c28977', 'Write me blog section', 'Write me blog section', 'Write me blog section about **description**.', '2025-04-24 07:58:20', NULL),
	('3bbe9346-2d34-4f43-8510-ab0f2b290459', 'Generate Instagram post caption', 'Generate Instagram post caption', 'Write Instagram post caption about **title**.', '2025-04-24 08:07:26', NULL),
	('3bc3216e-f5c2-4e93-ae40-50100b166f65', 'Post Generator', 'Generator Post using Open AI.', 'Write a post about **description**.', '2025-04-23 13:51:27', NULL),
	('6e80ce92-ebad-4fbe-a466-d26273695fc7', 'Article Generator', 'Instantly create unique articles on any topic. Boost engagement, improve SEO, and save time.', 'Generate article about **article title**', '2025-04-23 13:36:00', NULL),
	('783724b2-f4ed-473b-af76-6952724aa880', 'Generate instagram hastags.', 'Generate instagram hastags.', 'Write instagram hastags for **keywords**.', '2025-04-24 08:07:57', NULL),
	('8650d81b-2cf3-4fa3-9123-7426bbbd4d94', 'Write product description for Product name', 'Write product description for Product name', 'Write product description for **product name**.', '2025-04-24 07:55:55', NULL),
	('8985b3bb-c69d-4d3b-a8bc-6baecef2c358', 'Generate google ads description for product.', 'Generate google ads description for product.', 'Write google ads description product name: **product name**. Description is **description**. Audience is **audience**.', '2025-04-24 08:49:24', NULL),
	('8a361cde-138b-4fcd-950b-8e759983a3ac', 'Grammar Correction', 'Grammar Correction', 'Correct the grammar. Text is **description**.', '2025-04-24 08:55:42', NULL),
	('8c288cf3-1ff0-4d40-a98c-2744b954e54f', 'Generate pros & cons', 'Generate pros & cons', 'Generate pros & cons about title:  **title**. Description is **description**.', '2025-04-24 08:50:36', NULL),
	('8c94a143-a07e-4c9d-947c-6a1168c68647', 'Email Generator', 'Email Generator', 'Write email about title: **subject**, description: **description**.', '2025-04-24 08:51:56', NULL),
	('913a8628-b4f2-41e2-a1aa-f44331afcf00', 'Newsletter Generator', 'Newsletter Generator', 'generate newsletter template about product title: **title**, reason: **subject** description: **description**.', '2025-04-24 08:53:00', NULL),
	('98511559-7b1a-42f6-b924-2430a1bdfd5a', 'Generate Facebook ads title', 'Generate Facebook ads title', 'Write Facebook ads title about title: **title**. And description is **description**.', '2025-04-24 08:46:58', NULL),
	('a72ce7d0-720f-48ac-b7f7-7ab25d73a72c', 'Summarize Text', 'Summarize Text', 'Summarize the following text: **text**.', '2026-04-16 10:44:07', NULL),
	('b9e114c7-a2f1-4777-b43a-e36b1e146dbc', 'FAQ Generator', 'FAQ Generator', 'Answer like faq about subject: **title** Description is **description**.', '2025-04-24 08:51:34', NULL),
	('c1804540-d86a-48c6-a321-05f13630f262', 'Generate website meta description', 'Generate website meta description', 'Generate website meta description site name: **title** Description is **description**.', '2025-04-24 08:51:04', NULL),
	('ca26c30b-e537-4c9f-a4b9-ec4cc7b95a1b', 'Rewrite content', 'Rewrite content', 'Rewrite content:  **contents**.', '2025-04-24 08:49:45', NULL),
	('d35d6c5d-9146-464e-bfa9-196f9db0b251', 'Generate one paragraph', 'Generate one paragraph', 'Generate one paragraph about:  **description**. Keywords are **keywords**.', '2025-04-24 08:50:11', NULL),
	('d8d81df2-2859-4c6d-99aa-eb6dabb9cc01', 'Post Title Generator', 'Generator a Post Title from Post Description.', 'Generate Post title about **description**', '2025-04-23 13:55:24', NULL),
	('ddf9b4d8-1ffc-4582-92f7-6e4adc667c95', 'Generate  company social media post', 'Generate  company social media post', 'Write in company social media post, company name: **company name**. About: **description**.', '2025-04-24 08:44:33', NULL),
	('e884ec96-547c-4f81-99e9-40eed842f8b5', 'Generate youtube video description', 'Generate youtube video description', 'write youtube video description about **title**.', '2025-04-24 08:05:13', NULL),
	('ea82c689-ad2a-4b54-b11b-4545af7a236d', 'Generate YouTube video titles', 'Generate YouTube video titles', 'Craft captivating, attention-grabbing video titles about **description** for YouTube rankings.', '2025-04-24 08:06:08', NULL),
	('f3431223-1eba-4f47-b1f5-8a990a3022af', 'Email Answer Generator', 'Email Answer Generator', 'answer this email content: **description**.', '2025-04-24 08:52:18', NULL),
	('f7057b73-0db5-4fe6-bc5e-44cb9e1b35e4', 'Generate blog post introduction', 'Generate blog post introduction', 'Write blog post intro about title: **title**. And the description is **description**.', '2025-04-24 08:02:27', NULL),
	('fd71e2b4-427f-40d9-8ab3-b616fc0cf09b', 'Generate Facebook ads text', 'Generate Facebook ads text', 'Write facebook ads text about title: **title**. And the description is **description**.', '2025-04-24 08:04:16', NULL),
	('fe9b5264-64a2-4772-a033-00088cf11d07', 'Generate blog post idea', 'Generate blog post idea', 'Write blog post article ideas about **description**.', '2025-04-24 08:01:51', NULL);

-- Dumping structure for table dms_ai.allowfileextensions
CREATE TABLE IF NOT EXISTS `allowfileextensions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileType` tinyint NOT NULL,
  `extensions` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.allowfileextensions: ~7 rows (approximately)
INSERT INTO `allowfileextensions` (`id`, `fileType`, `extensions`) VALUES
	('0c0be0a9-0a4e-4f05-8742-3a5d6d74acf0', 2, 'png,jpg,jpge,gif,bmp,tiff,tif,svg,webp,ico,heif,heic,avif,apng,jfif,pjpeg,pjp,svgz,wmf,emf,djv,djvu,eps,ps,ai,indd,idml,psd,tga,dds'),
	('13a28d05-d6be-4e6b-87fe-b784642e2a95', 3, 'txt'),
	('3257c50c-a128-4c98-8809-cc2564b7db2a', 1, 'pdf'),
	('64dac07d-9072-4661-b537-053a09d42d6e', 0, 'doc,docx,ppt,pptx,xls,xlsx,csv'),
	('9eaf6b33-0cef-45a4-bf92-7c525e2ed536', 4, '3gp,aa,aac,aax,act,aiff,alac,amr,ape,au,awb,dss,dvf,flac,gsm,iklx,ivs,m4a,m4b,m4p,mmf,mp3,mpc,msv,nmf,ogg,oga,mogg,opus,org,ra,rm,raw,rf64,sln,tta,voc,vox,wav,wma,wv'),
	('ab5db62f-1fc7-49ed-895f-6ac4be6db33a', 6, 'zip'),
	('cb1612ef-8e3c-4823-af2b-469f4b0010b8', 5, 'webm,flv,vob,ogv,ogg,drc,avi,mts,m2ts,wmv,yuv,viv,mp4,m4p,3pg,f4v,f4a');

-- Dumping structure for table dms_ai.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `parentId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parentid_foreign` (`parentId`),
  CONSTRAINT `categories_parentid_foreign` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.categories: ~14 rows (approximately)
INSERT INTO `categories` (`id`, `name`, `description`, `parentId`, `isDeleted`, `createdBy`, `modifiedBy`, `deletedBy`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('14d8e7d0-522e-4eb5-a804-8f0f977ab14a', 'IT', 'IT', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-08 11:14:20', '2026-04-08 11:14:20', NULL),
	('2fccc230-c6fd-4aea-9b8a-d2ab6460fc4c', 'Test category', 'This is a test category', NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-29 05:18:13', '2026-04-29 05:18:13', NULL),
	('46dd7355-eef9-4b66-b674-59ada48ae4b1', 'PDF BYRC', NULL, NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-01-20 12:35:08', '2026-01-20 12:35:08', NULL),
	('5691f221-b482-4bb7-a2fd-697144f55349', 'Test child category', NULL, '2fccc230-c6fd-4aea-9b8a-d2ab6460fc4c', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-29 05:18:49', '2026-04-29 05:18:49', NULL),
	('583d6d1f-bcd8-4df5-bf1f-e8ca23ba9458', 'QA Test', NULL, NULL, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-20 06:12:39', '2026-04-20 06:12:49', '2026-04-20 06:12:49'),
	('5eff5eb6-f72e-4bb9-ad68-6126cfd06027', 'Tender', 'RFP', NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-08 11:05:40', '2026-04-08 11:05:40', NULL),
	('699936fe-f8d2-4e68-b000-fdd2c17083a1', 'QA TESTING', NULL, NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-14 07:59:56', '2026-04-14 07:59:56', NULL),
	('715b710b-ba5c-430a-9e74-e9587feeb8e4', 'Teachers', 'Teachers', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-08 11:14:10', '2026-04-08 11:14:10', NULL),
	('7ee128f6-ccc7-4634-a2cc-00aae239544c', 'Test child category', NULL, '80239261-a7ea-4088-950f-542d2aec31cf', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-29 05:13:05', '2026-04-29 05:13:05', NULL),
	('80239261-a7ea-4088-950f-542d2aec31cf', 'Test category', 'This is a test category', NULL, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-29 05:12:26', '2026-04-29 05:17:51', '2026-04-29 05:17:51'),
	('a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'CVs CLRMIS Team', 'This category contains CVs of the CLRMIS team', NULL, 0, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, '2026-04-13 08:35:39', '2026-04-13 08:39:56', NULL),
	('dc62dc82-1600-43c4-a7e0-ad450e003d93', 'Tender 1', NULL, '5eff5eb6-f72e-4bb9-ad68-6126cfd06027', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-08 11:05:50', '2026-04-08 11:05:50', NULL),
	('eaed08b2-c406-4ed8-b1cd-99fdd8a8cb1d', 'SC Educational Docs', 'This category contains the degrees of solochoicez employees', NULL, 0, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, '2026-04-13 09:24:47', '2026-04-13 09:24:47', NULL),
	('fe1cdbba-9936-433b-be75-ae3200c5aa9c', 'Resumes', 'Multiple Resumes', NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-08 11:14:01', '2026-04-08 11:14:01', NULL);

-- Dumping structure for table dms_ai.clients
CREATE TABLE IF NOT EXISTS `clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `companyName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contactPerson` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_createdby_foreign` (`createdBy`),
  CONSTRAINT `clients_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.clients: ~3 rows (approximately)
INSERT INTO `clients` (`id`, `companyName`, `contactPerson`, `email`, `phoneNumber`, `address`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('8210ce6a-5666-4955-91bc-c06482002e1a', 'MOCC', 'Sabeel', 'sabeel@gmail.com', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-29 06:40:42', '2026-04-29 06:40:57', NULL),
	('8a1d7165-8106-47e8-9a72-0946f8ca9a30', 'abc', 'sss', 'ssss@comnwwwsdas', 'erfasdzgfsdz', 'cccf', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-02 13:17:31', '2026-05-02 13:17:54', NULL),
	('e4256832-9bbf-45a3-86d5-880b909cbb40', 'HAZECO', 'Muhammad ashfaq', 'INFO@HAZECO.COM', '1234567890', 'ISLAMABAD', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:03:38', '2026-04-29 06:37:18', NULL);

-- Dumping structure for table dms_ai.companyprofile
CREATE TABLE IF NOT EXISTS `companyprofile` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logoUrl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bannerUrl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'local',
  `smallLogoUrl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `licenseKey` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchaseCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archiveDocumentRetensionPeriod` int DEFAULT NULL,
  `allowPdfSignature` tinyint(1) NOT NULL DEFAULT '1',
  `emailLogRetentionPeriod` int DEFAULT '30',
  `cronJobLogRetentionPeriod` int DEFAULT '30',
  `loginAuditRetentionPeriod` int DEFAULT '30',
  PRIMARY KEY (`id`),
  KEY `companyprofile_createdby_foreign` (`createdBy`),
  CONSTRAINT `companyprofile_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.companyprofile: ~1 rows (approximately)
INSERT INTO `companyprofile` (`id`, `title`, `logoUrl`, `bannerUrl`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`, `location`, `smallLogoUrl`, `licenseKey`, `purchaseCode`, `archiveDocumentRetensionPeriod`, `allowPdfSignature`, `emailLogRetentionPeriod`, `cronJobLogRetentionPeriod`, `loginAuditRetentionPeriod`) VALUES
	('60b4472d-9d28-4e1d-b959-b3242407431e', 'Document Management System', 'images/eaa5186f-9da9-48db-ab4d-71886a9ffb87.png', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 09:56:45', '2026-01-20 13:10:17', NULL, 'local', NULL, 'c29sb2Rtcy5zb2xvY2hvaWNlenouY29tfDglMmJqS1A1M3FQNGhZTkM2S2syQXBGSUV3R21LS0JNNVcxZkc0MGhHT0ljVSUzZA==', '10e03ae7-5565-49de-a979-4e3c4e98ad38', NULL, 1, 30, 30, 30);

-- Dumping structure for table dms_ai.cronjoblogs
CREATE TABLE IF NOT EXISTS `cronjoblogs` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jobName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('success','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success',
  `output` text COLLATE utf8mb4_unicode_ci,
  `executionTime` int DEFAULT NULL,
  `startedAt` timestamp NULL DEFAULT NULL,
  `endedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.cronjoblogs: ~0 rows (approximately)

-- Dumping structure for table dms_ai.dailyreminders
CREATE TABLE IF NOT EXISTS `dailyreminders` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminderId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dayOfWeek` int NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dailyreminders_reminderid_foreign` (`reminderId`),
  CONSTRAINT `dailyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.dailyreminders: ~14 rows (approximately)
INSERT INTO `dailyreminders` (`id`, `reminderId`, `dayOfWeek`, `isActive`) VALUES
	('1e97a5ce-1ed5-4e44-86a1-f9f18119b3cc', '24d22983-9d23-4f3f-a308-e79181dab154', 5, 1),
	('26021d52-8c74-4823-8553-0f4240ec74a2', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 5, 1),
	('321f8ba1-c20c-4365-9d95-f36f5449cd0c', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 0, 1),
	('3feeb994-797e-439c-a6b3-929a5e4fa23e', '24d22983-9d23-4f3f-a308-e79181dab154', 1, 1),
	('463b5650-d0b2-41b9-8f54-0a853a63f331', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 1, 1),
	('7a470682-0b24-4796-9208-f5e8973eba87', '24d22983-9d23-4f3f-a308-e79181dab154', 2, 1),
	('839d0e97-00fd-4583-bca7-4121266f9b60', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 3, 1),
	('95fbd230-5e9f-4d11-86e8-88008d8cce8c', '24d22983-9d23-4f3f-a308-e79181dab154', 0, 0),
	('af9ebda4-1b65-4d9c-9d3e-302c5cda1b2a', '24d22983-9d23-4f3f-a308-e79181dab154', 6, 1),
	('bbe45645-89a4-4ed0-bee2-bdb5c02575dd', '24d22983-9d23-4f3f-a308-e79181dab154', 4, 1),
	('c89e7e6e-7fd2-4522-9ec9-103af455ca7a', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 4, 1),
	('d1947c83-c6bc-4406-923e-25a456307a1b', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 6, 1),
	('d93cd20f-2ed5-4a07-a637-aa94e18a4dc1', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 2, 1),
	('f32b1790-171d-44f7-814c-a253e92a507b', '24d22983-9d23-4f3f-a308-e79181dab154', 3, 1);

-- Dumping structure for table dms_ai.documentaudittrails
CREATE TABLE IF NOT EXISTS `documentaudittrails` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operationName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `assignToUserId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assignToRoleId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentaudittrails_documentid_foreign` (`documentId`),
  KEY `documentaudittrails_assigntouserid_foreign` (`assignToUserId`),
  KEY `documentaudittrails_assigntoroleid_foreign` (`assignToRoleId`),
  KEY `documentaudittrails_createdby_foreign` (`createdBy`),
  CONSTRAINT `documentaudittrails_assigntoroleid_foreign` FOREIGN KEY (`assignToRoleId`) REFERENCES `roles` (`id`),
  CONSTRAINT `documentaudittrails_assigntouserid_foreign` FOREIGN KEY (`assignToUserId`) REFERENCES `users` (`id`),
  CONSTRAINT `documentaudittrails_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentaudittrails_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentaudittrails: ~151 rows (approximately)
INSERT INTO `documentaudittrails` (`id`, `documentId`, `operationName`, `assignToUserId`, `assignToRoleId`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('0286be6d-5410-437c-8da9-71a7f375311b', '03528d7e-23d5-402d-985a-fbff279e281e', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-24 12:50:22', '2026-04-24 12:50:22', NULL),
	('0518c8bd-12b4-4ec7-b65f-ecda0c89a87f', 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:49', '2026-04-08 11:16:49', NULL),
	('05567886-3190-4376-844e-52278edfd8b2', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'Modified', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:08:38', '2026-04-08 11:08:38', NULL),
	('0864a3aa-a16e-4b3c-9886-c572bd311533', 'd65bd38e-b74f-46d8-9705-1f1782c3fd10', 'Remove_Permission', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 07:01:30', '2026-04-28 07:01:30', NULL),
	('09424550-282f-4db3-b342-891d827fa269', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:08:10', '2026-04-08 11:08:10', NULL),
	('0da52744-9f32-4f4a-8821-d34eb080720f', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 09:36:11', '2026-05-04 09:36:11', NULL),
	('137c6d2b-de16-4690-8d7e-be0e85353f11', '6d9607d1-cb69-4dc1-a9a3-69f01a6f0d3f', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:01:08', '2026-05-02 11:01:08', NULL),
	('15582057-19ee-47fe-bd8b-588b3d1cc008', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:57:43', '2026-05-05 04:57:43', NULL),
	('1643d9a8-ddf4-4c9b-89b3-abca5923497b', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 09:20:43', '2026-04-27 09:20:43', NULL),
	('19dccaa2-439a-45e8-a712-615b1154dfc9', '8421054e-8053-4117-b594-dbe8475eec48', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 13:11:20', '2026-01-20 13:11:20', NULL),
	('1a63738b-d725-47f0-8dd8-9ab64b99e454', '03528d7e-23d5-402d-985a-fbff279e281e', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 12:36:46', '2026-05-02 12:36:46', NULL),
	('1a869054-cc52-4036-8659-204ddd6efbc9', '18689c70-7f0c-4e1d-9035-39018fa036d8', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:39', '2026-04-08 11:16:39', NULL),
	('1c85f284-a087-4712-ba66-2ba6ea7b2548', 'fb85eda5-dd77-4a23-997f-58dc5a1ad472', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:01:03', '2026-05-02 11:01:03', NULL),
	('1ff2e973-7a42-43ef-9ae7-c2e6b2f11f3b', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Add_Permission', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:40:07', '2026-04-30 04:40:07', NULL),
	('21d92eec-f591-4933-a365-e3b55528fcbd', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:35:47', '2026-01-20 12:35:47', NULL),
	('223d3270-8d24-4e8b-adb0-64f10a1ea202', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:58:14', '2026-05-05 04:58:14', NULL),
	('2381905a-f6a7-497f-a2fc-6e7b7af4e4c3', '6d9607d1-cb69-4dc1-a9a3-69f01a6f0d3f', 'Created', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:24:57', '2026-04-30 04:24:57', NULL),
	('23b01f45-6b48-41c8-bc88-a7fdbc9fdb27', '6d9607d1-cb69-4dc1-a9a3-69f01a6f0d3f', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:01:38', '2026-05-02 11:01:38', NULL),
	('24490c96-011a-4774-854f-486e1b9186e8', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Download', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 07:05:39', '2026-04-27 07:05:39', NULL),
	('24ffbaf0-3898-4b5d-ac66-17f7c44c0ba9', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:56:29', '2026-05-05 04:56:29', NULL),
	('26905b90-7bdb-4753-8919-2eb7789bb26e', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 05:26:41', '2026-05-05 05:26:41', NULL),
	('27cd10f1-f99c-4a99-b802-ec76ff0f0300', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Add_Permission', NULL, 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 06:05:50', '2026-05-04 06:05:50', NULL),
	('280c85d6-41ee-46c9-b00f-356057d4badd', '5185699f-9bec-48c4-bd53-725dd9883437', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:05:56', '2026-05-05 04:05:56', NULL),
	('2af24a43-cf0c-4c8f-b915-ec9d59ec30b1', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:35:48', '2026-01-20 12:35:48', NULL),
	('2c774bf1-f20f-44ca-a9e1-09d7f153f41a', 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:49', '2026-04-08 11:16:49', NULL),
	('2d3b152a-e86a-4605-8606-10e463fe3c29', '85ad34f3-c30b-43b1-bc0c-578b3bcd5e44', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:31', '2026-04-13 08:39:31', NULL),
	('2dd28aa1-a289-450c-9c61-5ec9c21d4d23', '18689c70-7f0c-4e1d-9035-39018fa036d8', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:40', '2026-04-08 11:16:40', NULL),
	('2f940485-68fe-4d5c-9aaf-f5ad0030463b', 'fb85eda5-dd77-4a23-997f-58dc5a1ad472', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:38', '2026-04-13 08:39:38', NULL),
	('36d61506-f2cf-41ba-a917-81c49de0d03d', '3a0d5b28-af9b-40a8-bc5a-a4a594163a0b', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-23 10:43:20', '2026-04-23 10:43:20', NULL),
	('372c5097-9772-4bbb-a6d5-d01cc4b8c7af', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 10:32:42', '2026-04-27 10:32:42', NULL),
	('3832b1e5-0ff5-4eb0-900a-9addd6b036e7', '8421054e-8053-4117-b594-dbe8475eec48', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 10:43:15', '2026-04-08 10:43:15', NULL),
	('395d5552-cae1-4b39-9329-49926c674ad5', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Archived', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 06:03:57', '2026-04-28 06:03:57', NULL),
	('397199e9-9392-43f6-89e2-c877560d2d75', '03528d7e-23d5-402d-985a-fbff279e281e', 'Modified', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-29 06:52:26', '2026-04-29 06:52:26', NULL),
	('3975ae86-177d-4723-8e0e-60c336d6f368', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 07:06:32', '2026-04-27 07:06:32', NULL),
	('39eee525-f0c5-41e4-8294-d7321c78a07e', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 05:25:28', '2026-05-05 05:25:28', NULL),
	('3e4f4409-94ab-43f4-8792-9a6339c08218', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Remove_Permission', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 09:33:57', '2026-04-27 09:33:57', NULL),
	('3edfafef-1351-40d1-b201-74892781bb30', '03528d7e-23d5-402d-985a-fbff279e281e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-02 12:55:20', '2026-05-02 12:55:20', NULL),
	('3ee5c04a-4014-4659-a20a-0ebc3bcc5995', '5185699f-9bec-48c4-bd53-725dd9883437', 'Created', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 08:22:49', '2026-05-04 08:22:49', NULL),
	('3fdf50bc-afbd-4af3-848b-31744291c212', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:09:08', '2026-04-08 11:09:08', NULL),
	('403a36b9-fee2-4283-9288-55dcf8d8a892', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:56:39', '2026-05-05 04:56:39', NULL),
	('4171340c-331f-4e7c-af09-fa2a69fbae5f', 'fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:44', '2026-04-08 11:16:44', NULL),
	('43714d04-a7b1-4268-b9d5-3f4ef2bef8e7', 'd6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', 'Add_Permission', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-14 08:02:41', '2026-04-14 08:02:41', NULL),
	('446de2f4-fa67-4143-89e5-fadc41456275', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 10:34:14', '2026-04-27 10:34:14', NULL),
	('46566cc3-3358-4fa7-ae0c-de9cd6bfddf5', '8421054e-8053-4117-b594-dbe8475eec48', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:58:07', '2026-01-20 12:58:07', NULL),
	('47a07915-5302-4448-be53-70e6c9d1b6d4', 'fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:44', '2026-04-08 11:16:44', NULL),
	('4a988354-ea01-479c-8192-1a262603b8bf', 'd65bd38e-b74f-46d8-9705-1f1782c3fd10', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 09:23:15', '2026-04-27 09:23:15', NULL),
	('4b5c5df5-9339-45bd-a4f9-db34a756196b', '95633ac1-dc51-42fc-afc3-ffc68367fa43', 'Created', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 07:51:46', '2026-05-04 07:51:46', NULL),
	('4ed8fc0c-ca79-48b6-b673-709bb6364804', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Add_Permission', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-27 07:05:13', '2026-04-27 07:05:13', NULL),
	('4eeca2af-2669-4100-a208-f6e107ecca0b', 'b3de4c93-91a1-4728-95ba-5590031c2ca1', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 13:00:21', '2026-01-20 13:00:21', NULL),
	('509ac5d1-cc49-4eba-89cb-ac772dd78dd6', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-23 11:43:47', '2026-04-23 11:43:47', NULL),
	('5152611c-bd17-4e3a-833c-ba62add18b2e', '9abd17d8-e8f8-43e1-8bc8-665172f2db01', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:41', '2026-04-08 11:16:41', NULL),
	('51e2b88a-04a7-47ab-af45-5bd13ae4d591', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-27 07:05:14', '2026-04-27 07:05:14', NULL),
	('54169319-7872-42be-8d1e-255c32cbc56a', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Add_Permission', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:13:32', '2026-04-30 11:13:32', NULL),
	('56f8d46d-a647-4336-96ac-c33b78425e44', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:57:26', '2026-05-05 04:57:26', NULL),
	('57f3020a-261e-450a-a578-f52141e9eb98', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Modified', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 07:18:08', '2026-04-28 07:18:08', NULL),
	('5894783a-e988-43d5-b26f-e93a14e53b6e', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Archived', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-29 06:43:55', '2026-04-29 06:43:55', NULL),
	('5ab44c95-6b77-4e1d-a5e9-b6c879d2dab3', 'a2ccbe92-08ea-4ef6-80ce-24d057beb2d0', 'Created', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-29 07:49:58', '2026-04-29 07:49:58', NULL),
	('5ac2d493-4079-48ec-b029-846ecb62e449', '50854eef-8641-4426-a744-8c6711d4193b', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:38', '2026-04-08 11:16:38', NULL),
	('5e99a1d5-467c-4b51-8c30-0dd6162c383a', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:57:37', '2026-05-05 04:57:37', NULL),
	('5f99d6da-339e-4260-b963-d1b038b26312', '18689c70-7f0c-4e1d-9035-39018fa036d8', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:39', '2026-04-08 11:16:39', NULL),
	('6014ae65-487a-4022-92c9-3ce58b82b3a4', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 05:08:46', '2026-04-28 05:08:46', NULL),
	('60c6bfe3-ed89-4fdb-aad8-394ff9648726', '8421054e-8053-4117-b594-dbe8475eec48', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:58:07', '2026-01-20 12:58:07', NULL),
	('61aec490-d61f-4d6c-9029-7e8b31eef709', '95633ac1-dc51-42fc-afc3-ffc68367fa43', 'Remove_Permission', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 08:21:17', '2026-05-04 08:21:17', NULL),
	('62094229-8f76-407c-9376-61ba314301c5', '6d9607d1-cb69-4dc1-a9a3-69f01a6f0d3f', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:20:23', '2026-05-05 04:20:23', NULL),
	('621967da-2226-41fd-b906-2c524a914fe6', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 07:16:36', '2026-04-28 07:16:36', NULL),
	('62d9f58c-01b3-4436-acc2-e9307e2f3665', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:18:20', '2026-04-30 11:18:20', NULL),
	('64d7f866-0649-4755-8efc-6bce3b008ded', '03528d7e-23d5-402d-985a-fbff279e281e', 'Add_Permission', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:07:02', '2026-05-02 11:07:02', NULL),
	('65dcac48-c5a0-48e5-8572-dd58c6766c5e', 'ff66d604-877c-4f3c-90cc-3b94957c19d9', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-14 06:04:26', '2026-04-14 06:04:26', NULL),
	('66044d02-3177-4916-b3ce-d657f4a570ed', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Add_Permission', NULL, '707626ee-6bb3-4a75-8508-9f0500611e28', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:41:31', '2026-04-30 04:41:31', NULL),
	('678f379f-3527-42b6-aa47-d604960984bf', 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:50', '2026-04-08 11:16:50', NULL),
	('6840558c-99d2-48f7-8647-f259b0aa2d25', '50854eef-8641-4426-a744-8c6711d4193b', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:37', '2026-04-08 11:16:37', NULL),
	('68dfaf4c-be47-48f8-a2aa-75e2401c9123', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Remove_Permission', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 06:10:12', '2026-05-04 06:10:12', NULL),
	('69f533ba-b7f1-48b6-a874-5ebd98029fac', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:59:30', '2026-01-20 12:59:30', NULL),
	('6d3d9749-92f5-4bda-bea6-a978009e1d18', '8421054e-8053-4117-b594-dbe8475eec48', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:58:08', '2026-01-20 12:58:08', NULL),
	('6e3dc2d5-4c7a-4e8e-83bc-7e8bd8ef46ea', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:36:41', '2026-01-20 12:36:41', NULL),
	('7260adf3-6f9f-43bf-b4c9-4c66c7d21c94', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:08:11', '2026-04-08 11:08:11', NULL),
	('74804abf-de25-4c78-a366-efe60f4543e8', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 09:36:03', '2026-05-04 09:36:03', NULL),
	('755316d5-0fd6-454f-a50a-40d9536e333c', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 09:20:57', '2026-04-27 09:20:57', NULL),
	('7572fbc7-2c4a-48ad-8d11-1cd2445e3d61', '7f38e78c-79fa-4d4b-859d-a18946f18768', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:22', '2026-04-13 08:39:22', NULL),
	('78d73a93-93f4-43b4-94f6-f488d41d38ab', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:05:30', '2026-05-05 04:05:30', NULL),
	('7dca2c01-3256-4d6d-b61e-b03d7989584c', '50854eef-8641-4426-a744-8c6711d4193b', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:37', '2026-04-08 11:16:37', NULL),
	('7e220094-71e2-4acc-ae1b-a0cb5b4aafe1', '03528d7e-23d5-402d-985a-fbff279e281e', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 12:39:09', '2026-05-02 12:39:09', NULL),
	('7e87cd9c-7dab-4849-a9b7-0d7493f9415b', 'd6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', 'Read', NULL, NULL, '1744effe-9859-4a80-9159-23d4aad48098', '1744effe-9859-4a80-9159-23d4aad48098', '', 0, '2026-04-14 08:04:28', '2026-04-14 08:04:28', NULL),
	('7f9a9e4c-8557-4c39-bfdd-25595c02e685', 'b3de4c93-91a1-4728-95ba-5590031c2ca1', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 13:00:23', '2026-01-20 13:00:23', NULL),
	('815e7aa7-bb37-4156-bc59-f7031d7706b3', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Created', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:24:55', '2026-04-30 04:24:55', NULL),
	('81b32295-cdf1-448d-a85b-b5928aaf13ff', 'a0ba8ac1-da25-4578-a3d8-58ac7fb86dd4', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:35', '2026-04-13 08:39:35', NULL),
	('82a324a6-1c77-4a42-b4ae-dc0bff054969', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:45:38', '2026-01-20 12:45:38', NULL),
	('833344ec-08da-4721-9d33-0f26b88a8f31', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 05:04:47', '2026-04-28 05:04:47', NULL),
	('866cf71f-71e8-4240-8342-d3f2667c6dd9', '8421054e-8053-4117-b594-dbe8475eec48', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 13:00:33', '2026-01-20 13:00:33', NULL),
	('8737b474-29ab-429e-8170-b1d5f307d693', 'd65bd38e-b74f-46d8-9705-1f1782c3fd10', 'Created', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-23 11:04:36', '2026-04-23 11:04:36', NULL),
	('87dcd278-7e15-4373-85b0-d659dda7bef7', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:58:27', '2026-05-05 04:58:27', NULL),
	('8999cac8-5d92-42e4-867c-23d422cf4f37', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 10:41:04', '2026-04-30 10:41:04', NULL),
	('8b14cb45-3ede-4d08-9c0a-d31d2d82df1b', '0823e58a-d496-48fd-a01c-ace165443da7', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:10:27', '2026-04-08 11:10:27', NULL),
	('8cc5d321-bef8-47fd-952f-ceec1e378fe8', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Add_Permission', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 06:05:05', '2026-05-04 06:05:05', NULL),
	('8dda5d96-388e-4f97-882c-07ea0aec3c00', '1c0fdb1d-3577-462b-afc2-e4ef7ebbb679', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:34', '2026-04-13 08:39:34', NULL),
	('8df9acb0-8598-4eed-a4a3-b122fb57500a', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:05:07', '2026-05-05 04:05:07', NULL),
	('8eaf9d76-c807-4d7a-b45a-90b2c2bc0f0b', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:59:48', '2026-01-20 12:59:48', NULL),
	('9083c199-19d5-477a-a605-2b80de5e8210', '97213385-7ef2-4a64-a290-181d3157da2c', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:33', '2026-04-13 08:39:33', NULL),
	('91921ea1-f41d-4d00-acc9-fe4a757de298', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:58:49', '2026-05-05 04:58:49', NULL),
	('92274943-7273-4664-a7c1-20b32947daef', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 09:43:27', '2026-05-04 09:43:27', NULL),
	('9529dcd2-952a-4274-bcd2-747ac68a4032', 'e8d27f72-443b-42a1-8d3e-5185ede59cc7', 'Created', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 07:51:19', '2026-05-04 07:51:19', NULL),
	('96c5bf86-b1d4-408d-8491-277c8e817daa', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 09:35:12', '2026-05-04 09:35:12', NULL),
	('9ca479ff-f116-4408-9578-ddc82d816724', 'fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:44', '2026-04-08 11:16:44', NULL),
	('9d8ff848-9b7d-4a44-830c-c311c7563b64', '92894d35-014b-4e76-a147-127e8edc8efb', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:24', '2026-04-13 08:39:24', NULL),
	('9ef88467-1ef8-4297-8921-13c13953c503', '03528d7e-23d5-402d-985a-fbff279e281e', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:01:43', '2026-05-02 11:01:43', NULL),
	('a079fa1e-aa60-4d83-9fc9-ea3cfe10e680', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:49:37', '2026-04-30 04:49:37', NULL),
	('a1681df0-d7fc-4515-bf38-7c707698911b', 'b318cded-3b9b-4298-81f9-532621a426cb', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:01:50', '2026-05-02 11:01:50', NULL),
	('a173ca79-9aee-4de2-9915-7913d38427f1', 'a2ccbe92-08ea-4ef6-80ce-24d057beb2d0', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:20:25', '2026-05-05 04:20:25', NULL),
	('a2370284-79eb-47ee-b088-95b990ce1152', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:58:39', '2026-05-05 04:58:39', NULL),
	('a4349c2b-825e-4c86-aed6-7594743f5615', '5b0991a1-bd84-425f-8b98-2022402f7e33', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:20', '2026-04-13 08:39:20', NULL),
	('a6615184-e782-427e-a129-9c360ceade5f', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Add_Permission', NULL, '707626ee-6bb3-4a75-8508-9f0500611e28', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:15:35', '2026-04-30 11:15:35', NULL),
	('a7dd9809-e8bc-4eb0-bd41-e22a36b162b1', '8421054e-8053-4117-b594-dbe8475eec48', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 10:43:28', '2026-04-08 10:43:28', NULL),
	('ab066062-7fe3-497c-bcad-16f37799dba7', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 10:35:17', '2026-04-27 10:35:17', NULL),
	('afa4e0ca-f4ad-49c3-82da-01c183b238f4', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:17:48', '2026-04-30 11:17:48', NULL),
	('b4d0d965-a8c5-4db0-ae9a-10bf35039c7b', '9abd17d8-e8f8-43e1-8bc8-665172f2db01', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:41', '2026-04-08 11:16:41', NULL),
	('bac5a839-c8d0-4fb6-8fcc-b145265756e5', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:08:10', '2026-04-08 11:08:10', NULL),
	('bc9a313d-e256-4a54-b1bd-97acca49d577', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-23 11:09:34', '2026-04-23 11:09:34', NULL),
	('be611bc9-3c79-46ad-be40-7051df8af88e', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:18:25', '2026-04-30 11:18:25', NULL),
	('bf392a3a-d6b5-43d5-8eaf-45a573b07a02', '8421054e-8053-4117-b594-dbe8475eec48', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 10:42:55', '2026-04-08 10:42:55', NULL),
	('bfea6d6c-6b48-44ed-b274-e089de9e82d6', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Add_Permission', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 06:09:56', '2026-05-04 06:09:56', NULL),
	('bfebd725-7859-43ab-a71c-258f74862386', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-29 06:50:19', '2026-04-29 06:50:19', NULL),
	('c15102bc-8113-4238-adb3-f9d83f376964', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Remove_Permission', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:12:48', '2026-04-30 11:12:48', NULL),
	('c26ded59-6b4c-43f3-a3ed-f75e15eb3ede', 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:17:29', '2026-04-08 11:17:29', NULL),
	('c2a75a17-4167-43e2-b9f5-e4292d981083', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Added_Watermark', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:36:37', '2026-01-20 12:36:37', NULL),
	('c5593027-6ede-40a0-ad06-10872afcd7ef', '3cc3ea3a-e8a2-4a77-a5eb-16de9d5f6d58', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:36', '2026-04-13 08:39:36', NULL),
	('c6a6d2a1-b5d1-4688-ae55-59981ec976d8', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:58:58', '2026-01-20 12:58:58', NULL),
	('c73861e5-06f5-43f4-b1ed-edd74ccbd9c7', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Add_Permission', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-23 11:09:33', '2026-04-23 11:09:33', NULL),
	('d2c27237-7fad-48d1-9aac-c00995fd5f98', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Add_Permission', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 09:33:37', '2026-04-27 09:33:37', NULL),
	('d64e6fcf-f337-4c63-acca-92158ac67681', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:37:24', '2026-01-20 12:37:24', NULL),
	('d781ecaa-7b3c-4b4d-985c-f85c32450b6b', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 10:26:31', '2026-04-27 10:26:31', NULL),
	('d81e4dd7-6b93-4b51-b6ed-27efb13e6020', '89a0436a-f211-42c6-91d6-73a0de44189e', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 07:05:30', '2026-04-27 07:05:30', NULL),
	('d9d9d3bf-60b6-44a4-8a67-b4faf9844a28', 'a2ccbe92-08ea-4ef6-80ce-24d057beb2d0', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:26:10', '2026-04-30 11:26:10', NULL),
	('dafabdf4-6d8f-4614-83e7-922e537a3c46', '9abd17d8-e8f8-43e1-8bc8-665172f2db01', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:41', '2026-04-08 11:16:41', NULL),
	('dafb8a12-8a71-45eb-bef2-d104019d61a0', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Remove_Permission', NULL, '707626ee-6bb3-4a75-8508-9f0500611e28', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 05:14:42', '2026-05-04 05:14:42', NULL),
	('dbb8fdf1-f4e6-45db-ac3a-383ab01ded9c', '03528d7e-23d5-402d-985a-fbff279e281e', 'Remove_Permission', NULL, 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:05:45', '2026-05-02 11:05:45', NULL),
	('dd63b62b-59ce-4143-a859-f281c8a0df2b', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Add_Permission', NULL, 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:15:35', '2026-04-30 11:15:35', NULL),
	('e0dc2bd4-9367-4128-ac46-4102954b5ce1', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Add_Permission', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:35:47', '2026-01-20 12:35:47', NULL),
	('e2c01b3a-daa5-43e9-9127-e362aedb4a8d', '9a83809a-beea-479a-90a6-d1816ae68e23', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:37:07', '2026-01-20 12:37:07', NULL),
	('e3acc182-7d01-4a62-9a9b-16cc529fd6e5', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:17:38', '2026-04-30 11:17:38', NULL),
	('ed7e2e59-e985-4be9-890f-380425446991', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-05 04:05:23', '2026-05-05 04:05:23', NULL),
	('efc95b0b-9c33-4b49-9fd1-506b5e7163d1', 'd6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-14 08:02:41', '2026-04-14 08:02:41', NULL),
	('f0359061-eafb-48ca-9aa4-2043e287a360', '03528d7e-23d5-402d-985a-fbff279e281e', 'Add_Permission', NULL, 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-20 06:14:35', '2026-04-20 06:14:35', NULL),
	('f0fe25d2-cf57-4042-b551-d0dc22889c0f', '3a0d5b28-af9b-40a8-bc5a-a4a594163a0b', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:26', '2026-04-13 08:39:26', NULL),
	('f16ef759-3117-4ef7-9820-6def8bec394a', 'ff66d604-877c-4f3c-90cc-3b94957c19d9', 'Modified', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:36:05', '2026-04-08 11:36:05', NULL),
	('f209b142-f874-4e21-b0e1-3be8dd5ed752', 'd65bd38e-b74f-46d8-9705-1f1782c3fd10', 'Add_Permission', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-23 11:04:36', '2026-04-23 11:04:36', NULL),
	('f2be875c-8f59-4487-8a55-ff923c361da0', 'b3de4c93-91a1-4728-95ba-5590031c2ca1', 'Add_Permission', NULL, 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 13:00:21', '2026-01-20 13:00:21', NULL),
	('f4ab5b42-ebdb-46e3-8ba4-633d43805bd4', '03528d7e-23d5-402d-985a-fbff279e281e', 'Created', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-20 06:14:36', '2026-04-20 06:14:36', NULL),
	('f9a8d825-18d0-4a80-ba80-3b2bcec49af5', '5d25cf1c-c637-45f3-be36-687b68638bcd', 'Created', NULL, NULL, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:28', '2026-04-13 08:39:28', NULL),
	('fcac591a-64b2-4415-9478-cf107eae09ff', '8421054e-8053-4117-b594-dbe8475eec48', 'Read', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 10:11:21', '2026-04-08 10:11:21', NULL),
	('fe13945a-2350-4fd3-8da6-fb84f9e75a2e', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Restored', NULL, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-29 06:43:34', '2026-04-29 06:43:34', NULL),
	('ff406923-ab32-47d8-9944-3f7d0124bfcd', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Read', NULL, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-23 11:44:30', '2026-04-23 11:44:30', NULL);

-- Dumping structure for table dms_ai.documentcomments
CREATE TABLE IF NOT EXISTS `documentcomments` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentcomments_documentid_foreign` (`documentId`),
  KEY `documentcomments_createdby_foreign` (`createdBy`),
  CONSTRAINT `documentcomments_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentcomments_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentcomments: ~1 rows (approximately)
INSERT INTO `documentcomments` (`id`, `documentId`, `comment`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('d8614dc6-1054-462c-9158-c03cc61a67be', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'this is RFP', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:12:12', '2026-04-08 11:12:12', NULL);

-- Dumping structure for table dms_ai.documentmetadatas
CREATE TABLE IF NOT EXISTS `documentmetadatas` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metatag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentmetadatas_documentid_foreign` (`documentId`),
  CONSTRAINT `documentmetadatas_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentmetadatas: ~5 rows (approximately)
INSERT INTO `documentmetadatas` (`id`, `documentId`, `metatag`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('44a6d73b-cdeb-4c33-84a9-ca4c5356054a', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'Test1', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-23 11:09:33', '2026-04-23 11:09:33', NULL),
	('5ba89bb4-c653-4583-b2de-7f33aa7053b9', '89a0436a-f211-42c6-91d6-73a0de44189e', 'linux', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 07:18:06', '2026-04-28 07:18:06', NULL),
	('6338f827-a8ae-4888-8161-d9497bf29aad', 'd65bd38e-b74f-46d8-9705-1f1782c3fd10', 'Test', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-23 11:04:35', '2026-04-23 11:04:35', NULL),
	('89798b27-07e4-4e10-8169-95064eb22c4e', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'hazeco', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:08:37', '2026-04-08 11:08:37', NULL),
	('d2c9adb8-f5a3-4d8b-bc70-40899e5fb61d', '5185699f-9bec-48c4-bd53-725dd9883437', '"QA, Testinng"', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 08:22:48', '2026-05-04 08:22:48', NULL);

-- Dumping structure for table dms_ai.documentrolepermissions
CREATE TABLE IF NOT EXISTS `documentrolepermissions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roleId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `isTimeBound` tinyint(1) NOT NULL,
  `isAllowDownload` tinyint(1) NOT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentrolepermissions_documentid_foreign` (`documentId`),
  KEY `documentrolepermissions_roleid_foreign` (`roleId`),
  KEY `documentrolepermissions_createdby_foreign` (`createdBy`),
  CONSTRAINT `documentrolepermissions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentrolepermissions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  CONSTRAINT `documentrolepermissions_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentrolepermissions: ~12 rows (approximately)
INSERT INTO `documentrolepermissions` (`id`, `documentId`, `roleId`, `startDate`, `endDate`, `isTimeBound`, `isAllowDownload`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('1b611877-1e9a-4a88-8ed2-7cd4e041f122', '8421054e-8053-4117-b594-dbe8475eec48', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:58:07', '2026-01-20 12:58:07', NULL),
	('21c4ecb3-2969-4406-9197-9089803a6f3f', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', '2026-04-27 00:00:00', '2026-04-30 23:59:59', 1, 0, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:15:35', '2026-04-30 11:15:35', NULL),
	('2f8c1ecb-3fd7-4f0d-bebc-44fa2b176888', 'b3de4c93-91a1-4728-95ba-5590031c2ca1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 13:00:21', '2026-01-20 13:00:21', NULL),
	('326c2e2d-eec2-4409-9a17-995914dd4233', 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:49', '2026-04-08 11:16:49', NULL),
	('79226edc-baf7-4f08-b0ac-0a50b8fbad3e', '18689c70-7f0c-4e1d-9035-39018fa036d8', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:39', '2026-04-08 11:16:39', NULL),
	('957cff17-2e89-4554-8cb6-4c1ef5b4b27e', '9abd17d8-e8f8-43e1-8bc8-665172f2db01', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:41', '2026-04-08 11:16:41', NULL),
	('b345f82e-71d5-4693-9806-e509b11b5cc7', 'fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:44', '2026-04-08 11:16:44', NULL),
	('c0cca873-a381-4f23-b511-f9d320bd52ab', '89a0436a-f211-42c6-91d6-73a0de44189e', '707626ee-6bb3-4a75-8508-9f0500611e28', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:41:31', '2026-04-30 04:41:31', NULL),
	('c7c2b6fa-a86e-4ea5-8017-61bf2f1c68dd', '50854eef-8641-4426-a744-8c6711d4193b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:37', '2026-04-08 11:16:37', NULL),
	('e6eed0e8-ac56-42d7-9d25-80c5ef09fd4b', '9a83809a-beea-479a-90a6-d1816ae68e23', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:35:47', '2026-01-20 12:35:47', NULL),
	('e7f544e8-98c3-413f-9f86-a8d4e817e0eb', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:08:10', '2026-04-08 11:08:10', NULL),
	('ea95e092-8746-4e68-b3a7-3be0f6b91b45', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', '2026-04-27 00:00:00', '2026-04-29 23:59:59', 1, 0, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 06:05:50', '2026-05-04 06:05:50', NULL);

-- Dumping structure for table dms_ai.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoryId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'local',
  `isPermanentDelete` tinyint(1) DEFAULT '0',
  `isIndexed` tinyint(1) DEFAULT '0',
  `clientId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statusId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documentWorkflowId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `retentionPeriod` int DEFAULT NULL,
  `retentionAction` int DEFAULT NULL,
  `signById` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signDate` datetime DEFAULT NULL,
  `isExpired` tinyint(1) NOT NULL DEFAULT '0',
  `expiredDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_categoryid_foreign` (`categoryId`),
  KEY `documents_createdby_foreign` (`createdBy`),
  KEY `documents_clientid_foreign` (`clientId`),
  KEY `documents_statusid_foreign` (`statusId`),
  KEY `documents_documentworkflowid_foreign` (`documentWorkflowId`),
  KEY `documents_signbyid_foreign` (`signById`),
  CONSTRAINT `documents_categoryid_foreign` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`),
  CONSTRAINT `documents_clientid_foreign` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`),
  CONSTRAINT `documents_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documents_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentworkflow` (`id`),
  CONSTRAINT `documents_signbyid_foreign` FOREIGN KEY (`signById`) REFERENCES `users` (`id`),
  CONSTRAINT `documents_statusid_foreign` FOREIGN KEY (`statusId`) REFERENCES `documentstatus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documents: ~34 rows (approximately)
INSERT INTO `documents` (`id`, `categoryId`, `name`, `description`, `url`, `createdDate`, `createdBy`, `modifiedDate`, `modifiedBy`, `isDeleted`, `deletedBy`, `deleted_at`, `location`, `isPermanentDelete`, `isIndexed`, `clientId`, `statusId`, `documentWorkflowId`, `retentionPeriod`, `retentionAction`, `signById`, `signDate`, `isExpired`, `expiredDate`) VALUES
	('03528d7e-23d5-402d-985a-fbff279e281e', '699936fe-f8d2-4e68-b000-fdd2c17083a1', 'sample_employee.xlsx', NULL, 'documents/f6e3dbe3-9b0c-46e1-996e-6f59e47823d6.xlsx', '2026-04-20 06:14:35', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-29 06:52:26', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, 1, 2, NULL, NULL, 0, NULL),
	('0823e58a-d496-48fd-a01c-ace165443da7', 'dc62dc82-1600-43c4-a7e0-ad450e003d93', 'WPS 365.pdf', NULL, 'documents/da25228e-f717-4acc-ac06-125b0307d418.pdf', '2026-04-08 11:10:26', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:10:26', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, 'e4256832-9bbf-45a3-86d5-880b909cbb40', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('18689c70-7f0c-4e1d-9035-39018fa036d8', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', '10- M.zeeshan (SQA) CLRMIS.pdf', NULL, 'documents/e9910549-cd55-478d-9699-5e706985ee9d.pdf', '2026-04-08 11:16:38', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:16:38', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('1c0fdb1d-3577-462b-afc2-e4ef7ebbb679', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'IrfanAli_CV.docx', NULL, 'documents/96f9d13a-db42-4486-946f-b04c97c1adc4.docx', '2026-04-13 08:39:33', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:33', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('32a2f224-443c-454f-a3f6-46f26b819ce8', '2fccc230-c6fd-4aea-9b8a-d2ab6460fc4c', 'notes.docx', 'testing purpose', 'documents/01703119-b666-47f0-aca5-c933fbf80326.pdf', '2026-04-30 10:40:27', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-04-30 10:40:27', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 0, NULL, NULL, 'local', 0, 1, 'e4256832-9bbf-45a3-86d5-880b909cbb40', '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('3a0d5b28-af9b-40a8-bc5a-a4a594163a0b', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Muhammd_zeshan_Cv.pdf', NULL, 'documents/bf3aecf9-5612-4aa8-a802-8f1cbeeeb657.pdf', '2026-04-13 08:39:25', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:25', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('3cc3ea3a-e8a2-4a77-a5eb-16de9d5f6d58', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'MUHAMMAD Tahir(8-April-2026).pdf', NULL, 'documents/ab589123-71ea-4174-8d12-a82ba711a705.pdf', '2026-04-13 08:39:35', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:35', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('50854eef-8641-4426-a744-8c6711d4193b', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', '5- Aqib Javid (Full Stack Developer).pdf', NULL, 'documents/56fd1a0b-3877-4524-b891-4e9a0b587609.pdf', '2026-04-08 11:16:37', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:16:37', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('5185699f-9bec-48c4-bd53-725dd9883437', '2fccc230-c6fd-4aea-9b8a-d2ab6460fc4c', 'machine-learning-roadmap-v2.pdf', NULL, 'documents/03f6882f-45ec-4301-8701-678ae8788c5a.pdf', '2026-05-04 08:22:48', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-05-04 08:22:48', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 0, NULL, NULL, 'local', 0, 1, '8a1d7165-8106-47e8-9a72-0946f8ca9a30', '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('5b0991a1-bd84-425f-8b98-2022402f7e33', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'ABU_BAKAR_CV_Dn.pdf', NULL, 'documents/6d9607b6-08e3-41f0-8715-012899d57ff3.pdf', '2026-04-13 08:39:17', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:17', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('5d25cf1c-c637-45f3-be36-687b68638bcd', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Ayesha_JamshedSQAE.pdf', NULL, 'documents/03b3f780-e816-4772-991f-e02a2784b2e1.pdf', '2026-04-13 08:39:27', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:27', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('6d9607d1-cb69-4dc1-a9a3-69f01a6f0d3f', '2fccc230-c6fd-4aea-9b8a-d2ab6460fc4c', 'employee-db.pdf', 'testing purpose', 'documents/fcfccd8e-527f-4911-9c82-ec367fcbf180.pdf', '2026-04-30 04:24:57', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-04-30 04:24:57', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 0, NULL, NULL, 'local', 0, 1, 'e4256832-9bbf-45a3-86d5-880b909cbb40', '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('7f38e78c-79fa-4d4b-859d-a18946f18768', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Aqib_Javaid_CV.pdf', NULL, 'documents/a7d99871-eeb9-447a-b8a3-a3a3eb54a2f3.pdf', '2026-04-13 08:39:21', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:21', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('8421054e-8053-4117-b594-dbe8475eec48', '46dd7355-eef9-4b66-b674-59ada48ae4b1', '00081007899490_09082025055640.pdf', NULL, 'documents/eb6a023b-027b-4472-8f50-2052265231c3.pdf', '2026-01-20 12:58:07', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-01-20 12:58:07', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, 5, NULL, NULL, NULL, 0, NULL),
	('85ad34f3-c30b-43b1-bc0c-578b3bcd5e44', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Atif Javed updated cv.pdf', NULL, 'documents/bd1bbbd2-253a-4b73-980a-4ffd3798f389.pdf', '2026-04-13 08:39:29', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:29', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('89a0436a-f211-42c6-91d6-73a0de44189e', '5eff5eb6-f72e-4bb9-ad68-6126cfd06027', 'notes', NULL, 'documents/071fe587-c5c4-41d1-a4b4-9e167b93c847.docx', '2026-04-27 07:05:13', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-27 07:05:13', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, '1162a1ef-f41e-4509-85e3-70d17f56c0d6', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('8ce488a8-433a-44ea-96ee-381cf9d298f1', '5eff5eb6-f72e-4bb9-ad68-6126cfd06027', 'HIRING OF CONTRACTOR / FIRM FOR PROVISION OF SKILLED OUTSOURCED STAFF DRIVERS FOR VARIOUS HAZECO FIELD FORMATIONS HR-03-2025', NULL, 'documents/68f91c76-d54b-43b0-aebd-0f1a7d05f65a.pdf', '2026-04-08 11:07:56', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:08:37', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, 'e4256832-9bbf-45a3-86d5-880b909cbb40', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('92894d35-014b-4e76-a147-127e8edc8efb', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Ahmad_Asif_Saleem_Resume.pdf', NULL, 'documents/3a7904ec-a2a0-40f9-8190-23f67f204d4f.pdf', '2026-04-13 08:39:23', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:23', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('95633ac1-dc51-42fc-afc3-ffc68367fa43', '699936fe-f8d2-4e68-b000-fdd2c17083a1', 'machine-learning-roadmap-v2.pdf', 'For testing purpose', 'documents/7c5f7cfc-bbae-4333-8496-5721eb3c0486.pdf', '2026-05-04 08:21:43', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-05-04 08:21:43', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 0, NULL, NULL, 'local', 0, 1, '8a1d7165-8106-47e8-9a72-0946f8ca9a30', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('97213385-7ef2-4a64-a290-181d3157da2c', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Hamza-Saleem.pdf', NULL, 'documents/ca1c1ece-8576-437a-a92e-f3f133c63969.pdf', '2026-04-13 08:39:32', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:32', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('97a662b2-5a16-418b-8ae1-2e7057bcf829', '699936fe-f8d2-4e68-b000-fdd2c17083a1', 'PMS changes revised.pdf', NULL, 'documents/9b7000d3-e0e7-4d26-a6d9-6e102afb3562.pdf', '2026-04-23 11:09:33', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-29 06:43:54', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-29 06:43:54', 'local', 0, 1, NULL, '1162a1ef-f41e-4509-85e3-70d17f56c0d6', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('9a83809a-beea-479a-90a6-d1816ae68e23', '46dd7355-eef9-4b66-b674-59ada48ae4b1', 'BYRC UPDATES.pdf', NULL, 'documents/8749b52f-6b75-47c8-b741-16d07817bbfd.pdf', '2026-01-20 12:36:39', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-01-20 12:36:39', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, 5, 0, NULL, NULL, 0, NULL),
	('9abd17d8-e8f8-43e1-8bc8-665172f2db01', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', 'Ahmad-Asif-Saleem-Solution Architect-.pdf', NULL, 'documents/40060ccc-a7ef-4555-8f40-bea8f5994819.pdf', '2026-04-08 11:16:40', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:16:40', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('a0ba8ac1-da25-4578-a3d8-58ac7fb86dd4', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Waqas Cv Pdf.pdf', NULL, 'documents/f5eb1d1a-202f-4a60-8341-268b1268ccff.pdf', '2026-04-13 08:39:34', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:34', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('a11dbaed-44d0-4111-af91-9a852f6e3e5f', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', 'Resume Software Engineer Haroon (5).pdf', NULL, 'documents/babd4943-ab2d-4a27-92c9-46ba15f23f98.pdf', '2026-04-08 11:16:49', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:16:49', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 0, NULL, '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('a2ccbe92-08ea-4ef6-80ce-24d057beb2d0', '2fccc230-c6fd-4aea-9b8a-d2ab6460fc4c', 'ICT_Topic01-ICT_Fundamentals.pdf', NULL, 'documents/38a19855-a541-4102-b5f4-8751fee8cd98.pdf', '2026-04-29 07:49:57', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-04-29 07:49:57', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 0, NULL, NULL, 'local', 0, 1, 'e4256832-9bbf-45a3-86d5-880b909cbb40', '1162a1ef-f41e-4509-85e3-70d17f56c0d6', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('b318cded-3b9b-4298-81f9-532621a426cb', '46dd7355-eef9-4b66-b674-59ada48ae4b1', 'INV_2026_00011.pdf', NULL, 'documents/8cce8972-92f7-4c0a-862b-b0b3d44c8c66.pdf', '2026-04-08 11:31:43', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:31:43', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('b3de4c93-91a1-4728-95ba-5590031c2ca1', '46dd7355-eef9-4b66-b674-59ada48ae4b1', 'ID Front.jpg', NULL, 'documents/fa599659-570c-4118-9bed-5e2924119eed.jpg', '2026-01-20 13:00:21', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-01-20 13:00:21', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('d65bd38e-b74f-46d8-9705-1f1782c3fd10', '699936fe-f8d2-4e68-b000-fdd2c17083a1', 'PMS changes.pdf', NULL, 'documents/71a401ed-0bf6-4679-8ad2-038fbead1755.pdf', '2026-04-23 11:04:35', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-04-23 11:04:35', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 0, NULL, NULL, 'local', 0, 1, NULL, '1162a1ef-f41e-4509-85e3-70d17f56c0d6', NULL, 9, NULL, NULL, NULL, 0, NULL),
	('d6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', '699936fe-f8d2-4e68-b000-fdd2c17083a1', 'just for TEST.pdf', NULL, 'documents/569f2279-2823-4eb9-8ac4-68e179105d97.pdf', '2026-04-14 08:02:41', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-14 08:02:41', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('e8d27f72-443b-42a1-8d3e-5185ede59cc7', '699936fe-f8d2-4e68-b000-fdd2c17083a1', 'notes.docx', 'For testing purpose', 'documents/4c37e074-208d-4b60-9e11-e3dbb7aa2f10.docx', '2026-05-04 07:51:18', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-05-04 07:51:18', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 0, NULL, NULL, 'local', 0, 1, '8a1d7165-8106-47e8-9a72-0946f8ca9a30', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('fb85eda5-dd77-4a23-997f-58dc5a1ad472', 'a635acc0-5105-4ffc-83ee-e5ab5232ff2d', 'Zafran Shafiq.pdf', NULL, 'documents/d198cb73-2d3f-482a-bfc9-33db71381a65.pdf', '2026-04-13 08:39:37', 'f85fa233-db01-462b-befa-5c4eea1505b7', '2026-04-13 08:39:37', 'f85fa233-db01-462b-befa-5c4eea1505b7', 0, NULL, NULL, 'local', 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', 'DOC-20250612-WA0064..pdf', NULL, 'documents/c613ce20-3516-49a9-8003-7d04850b37f8.pdf', '2026-04-08 11:16:43', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:16:43', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, 'local', 0, 1, NULL, '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL),
	('ff66d604-877c-4f3c-90cc-3b94957c19d9', 'fe1cdbba-9936-433b-be75-ae3200c5aa9c', 'Muhammad kalim.pdf', NULL, 'documents/e0442d59-d5fb-445d-980c-164145229383.pdf', '2026-04-08 11:34:18', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-08 11:36:04', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, NULL, NULL, NULL, 0, 1, NULL, '911200e5-4e0d-490e-bb2b-0b837e489987', NULL, NULL, NULL, NULL, NULL, 0, NULL);

-- Dumping structure for table dms_ai.documentshareablelink
CREATE TABLE IF NOT EXISTS `documentshareablelink` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `linkExpiryTime` datetime DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAllowDownload` tinyint(1) NOT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentshareablelink_documentid_foreign` (`documentId`),
  KEY `documentshareablelink_createdby_foreign` (`createdBy`),
  CONSTRAINT `documentshareablelink_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentshareablelink_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentshareablelink: ~3 rows (approximately)
INSERT INTO `documentshareablelink` (`id`, `documentId`, `linkExpiryTime`, `password`, `linkCode`, `isAllowDownload`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('57a290f2-2e92-4d89-a9de-a335774e88cb', '9a83809a-beea-479a-90a6-d1816ae68e23', '2026-04-30 10:46:00', 'U0RGRFNG', 'YWMxODIyZmMtYjM5ZC00NjJiLTg2MTMtNjU1MDhhYjc0MWNm', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 10:47:02', '2026-04-08 10:47:02', NULL),
	('5d8af038-bc97-4d93-96be-0e8e2c3a6830', '89a0436a-f211-42c6-91d6-73a0de44189e', NULL, NULL, 'ZWExMzBhNmYtZjcwNS00OTY4LThhN2QtZTU5YTBkZGUyYjll', 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-28 05:10:04', '2026-04-28 05:10:39', '2026-04-28 05:10:39'),
	('a135b9e8-6416-460a-8969-1c71348a2d2b', 'd6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', NULL, 'MTIz', 'YTMyOTU0ODktNTE4ZS00YWZlLWEyNDctZDgyNDcxMGNiODQ5', 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-14 10:20:54', '2026-04-14 10:20:54', NULL);

-- Dumping structure for table dms_ai.documentsignatures
CREATE TABLE IF NOT EXISTS `documentsignatures` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signatureUrl` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `documentsignatures_documentid_foreign` (`documentId`),
  KEY `documentsignatures_createdby_foreign` (`createdBy`),
  CONSTRAINT `documentsignatures_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentsignatures_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentsignatures: ~0 rows (approximately)

-- Dumping structure for table dms_ai.documentstatus
CREATE TABLE IF NOT EXISTS `documentstatus` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colorCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentstatus_createdby_foreign` (`createdBy`),
  CONSTRAINT `documentstatus_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentstatus: ~5 rows (approximately)
INSERT INTO `documentstatus` (`id`, `name`, `description`, `colorCode`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('1162a1ef-f41e-4509-85e3-70d17f56c0d6', 'Approved', 'The Document is Approved', '#00ff33', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:11:59', '2026-05-04 04:16:12', NULL),
	('14e4715f-751f-427e-a59f-bb572ff9e28f', 'shortlist', 'doc is shortlisted', '#b38080', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 1, '2026-04-23 11:41:10', '2026-04-23 11:41:28', '2026-04-23 11:41:28'),
	('46cc4e16-8e02-4ae2-979d-675311f4e3da', 'Shortlist', 'This doc is shortlisted', '#f55b0b', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 12:33:44', '2026-05-02 12:33:44', NULL),
	('4ae58f6d-86a5-4db0-8d09-882a03a13fab', 'Rejected', 'Rejected', '#f42b2b', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:15:36', '2026-04-29 05:20:33', NULL),
	('911200e5-4e0d-490e-bb2b-0b837e489987', 'Shortlisted', 'Shortlisted', '#5fa3e0', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:14:39', '2026-04-29 05:20:22', NULL);

-- Dumping structure for table dms_ai.documenttokens
CREATE TABLE IF NOT EXISTS `documenttokens` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documenttokens: ~1 rows (approximately)
INSERT INTO `documenttokens` (`id`, `createdDate`, `documentId`, `token`) VALUES
	('3725024b-8648-4e64-9505-eb8bcc89e722', '2026-04-28 05:10:25', '89a0436a-f211-42c6-91d6-73a0de44189e', '03370a9c-c7b2-4f81-87e9-b6d6e4ecc9b9');

-- Dumping structure for table dms_ai.documentuserpermissions
CREATE TABLE IF NOT EXISTS `documentuserpermissions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `isTimeBound` tinyint(1) NOT NULL,
  `isAllowDownload` tinyint(1) NOT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentuserpermissions_documentid_foreign` (`documentId`),
  KEY `documentuserpermissions_userid_foreign` (`userId`),
  KEY `documentuserpermissions_createdby_foreign` (`createdBy`),
  CONSTRAINT `documentuserpermissions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentuserpermissions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  CONSTRAINT `documentuserpermissions_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentuserpermissions: ~38 rows (approximately)
INSERT INTO `documentuserpermissions` (`id`, `documentId`, `userId`, `startDate`, `endDate`, `isTimeBound`, `isAllowDownload`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('03ef561b-2a02-48b1-887e-766f44caeade', '6d9607d1-cb69-4dc1-a9a3-69f01a6f0d3f', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:24:57', '2026-04-30 04:24:57', NULL),
	('180fd5e8-0f32-4a44-9bb0-65686848fac0', 'fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:44', '2026-04-08 11:16:44', NULL),
	('1c572ef9-4bb3-460e-b44f-4f80ce610e8d', '3a0d5b28-af9b-40a8-bc5a-a4a594163a0b', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:25', '2026-04-13 08:39:25', NULL),
	('24fa81a3-cc33-4f6c-8fd6-36066b7043a5', 'ff66d604-877c-4f3c-90cc-3b94957c19d9', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:34:19', '2026-04-08 11:34:19', NULL),
	('251f7528-5c27-466a-b120-1c33da97c197', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-23 11:09:33', '2026-04-23 11:09:33', NULL),
	('2db77e3d-5f41-4a85-999e-ecfb6d122f39', '32a2f224-443c-454f-a3f6-46f26b819ce8', '1744effe-9859-4a80-9159-23d4aad48098', '2026-04-27 00:00:00', '2026-04-28 23:59:59', 1, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 06:05:05', '2026-05-04 06:05:05', NULL),
	('3207058c-b4c4-449d-abc3-87b1a8959282', '0823e58a-d496-48fd-a01c-ace165443da7', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:10:27', '2026-04-08 11:10:27', NULL),
	('350c2198-ca98-41e0-bf8f-efadb8c64dad', '97a662b2-5a16-418b-8ae1-2e7057bcf829', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-23 11:09:33', '2026-04-23 11:09:33', NULL),
	('38f77fe4-47fc-4f9c-b9bc-4ba51f45134d', '18689c70-7f0c-4e1d-9035-39018fa036d8', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:39', '2026-04-08 11:16:39', NULL),
	('40b975bd-19f8-4547-9ea9-32335807fb3a', 'd6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', '1744effe-9859-4a80-9159-23d4aad48098', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-14 08:02:41', '2026-04-14 08:02:41', NULL),
	('4d0aee6e-df3d-4ad4-baf8-453ad775311f', '1c0fdb1d-3577-462b-afc2-e4ef7ebbb679', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:33', '2026-04-13 08:39:33', NULL),
	('5914517e-c8f5-4588-a5e8-420efc2b6abe', '8ce488a8-433a-44ea-96ee-381cf9d298f1', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:08:10', '2026-04-08 11:08:10', NULL),
	('5c31a420-34f1-44ee-b91b-dd0976e45a7d', 'a0ba8ac1-da25-4578-a3d8-58ac7fb86dd4', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:34', '2026-04-13 08:39:34', NULL),
	('6424edac-fc10-4fa5-a6d9-c663f24a4d4c', '97213385-7ef2-4a64-a290-181d3157da2c', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:32', '2026-04-13 08:39:32', NULL),
	('6bc6f760-4400-47a6-9f7d-3b5b05fb20ca', 'fb85eda5-dd77-4a23-997f-58dc5a1ad472', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:38', '2026-04-13 08:39:38', NULL),
	('7128feab-b25d-4498-a76f-cb04a735520e', '5185699f-9bec-48c4-bd53-725dd9883437', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 08:22:49', '2026-05-04 08:22:49', NULL),
	('71e305b1-48ab-40e9-bbf5-5369b9ffb1c8', '92894d35-014b-4e76-a147-127e8edc8efb', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:23', '2026-04-13 08:39:23', NULL),
	('726a1105-4bc2-4fd3-ab21-df8ece2f446a', '7f38e78c-79fa-4d4b-859d-a18946f18768', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:22', '2026-04-13 08:39:22', NULL),
	('76b09e47-b0db-48e7-a7a9-a183109f9c30', '5d25cf1c-c637-45f3-be36-687b68638bcd', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:27', '2026-04-13 08:39:27', NULL),
	('791a9c9c-6ba9-4ea4-9d72-29d396ad3f26', '89a0436a-f211-42c6-91d6-73a0de44189e', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-27 07:05:13', '2026-04-27 07:05:13', NULL),
	('85bf09c8-24a1-4e42-a524-8251f8387a83', '9a83809a-beea-479a-90a6-d1816ae68e23', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:35:47', '2026-01-20 12:35:47', NULL),
	('8c45d026-af93-4a81-a67a-a4a642e37091', 'd6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-14 08:02:41', '2026-04-14 08:02:41', NULL),
	('952d9736-a821-4f82-837c-75d8ea386c35', 'b318cded-3b9b-4298-81f9-532621a426cb', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:31:43', '2026-04-08 11:31:43', NULL),
	('9bfa0681-b625-43f5-a525-8e320a8db123', '03528d7e-23d5-402d-985a-fbff279e281e', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-05-02 00:00:00', '2026-05-02 23:59:59', 1, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 11:07:02', '2026-05-02 11:07:02', NULL),
	('a5423c9b-e5a5-4d13-8105-f5c6ef74e5c1', '5b0991a1-bd84-425f-8b98-2022402f7e33', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:19', '2026-04-13 08:39:19', NULL),
	('a70cc6f9-d72d-41d8-bb76-7d27f046c994', '32a2f224-443c-454f-a3f6-46f26b819ce8', '6021958e-5cbb-4443-9242-8893aa19c3e0', '2026-04-27 00:00:00', '2026-04-30 23:59:59', 1, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 11:13:32', '2026-04-30 11:13:32', NULL),
	('a9340561-700e-4d6b-b52c-1dafbe9f0964', 'a2ccbe92-08ea-4ef6-80ce-24d057beb2d0', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-29 07:49:57', '2026-04-29 07:49:57', NULL),
	('ae016a2f-077b-43c9-99b9-84c8bc9cb9cf', '3cc3ea3a-e8a2-4a77-a5eb-16de9d5f6d58', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:36', '2026-04-13 08:39:36', NULL),
	('b9027bb6-abd1-4442-a07e-660d42bc5f73', '03528d7e-23d5-402d-985a-fbff279e281e', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-20 06:14:35', '2026-04-20 06:14:35', NULL),
	('b9dca99f-a393-4c62-a2dc-e070893993d6', '9abd17d8-e8f8-43e1-8bc8-665172f2db01', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:41', '2026-04-08 11:16:41', NULL),
	('bdc20f72-2c86-475e-98aa-c67aa75f8290', '89a0436a-f211-42c6-91d6-73a0de44189e', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-27 07:05:13', '2026-04-27 07:05:13', NULL),
	('c74b4d61-3938-4d2d-94f8-88d49e308fe4', '8421054e-8053-4117-b594-dbe8475eec48', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:58:07', '2026-01-20 12:58:07', NULL),
	('c9b12400-e23d-4fcd-a173-7a0508188202', 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:49', '2026-04-08 11:16:49', NULL),
	('cbd30481-9813-4489-ba5d-a6b95b2e1a43', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:24:55', '2026-04-30 04:24:55', NULL),
	('d355b197-b16c-416c-8ab1-98888c6f74f7', '50854eef-8641-4426-a744-8c6711d4193b', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:16:37', '2026-04-08 11:16:37', NULL),
	('edd2b885-06ff-423c-bef7-713258f8203d', '85ad34f3-c30b-43b1-bc0c-578b3bcd5e44', 'f85fa233-db01-462b-befa-5c4eea1505b7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f85fa233-db01-462b-befa-5c4eea1505b7', '', 0, '2026-04-13 08:39:30', '2026-04-13 08:39:30', NULL),
	('ee7d91cb-e9f0-4ca4-afc2-9da5ec4a065b', 'b3de4c93-91a1-4728-95ba-5590031c2ca1', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 13:00:21', '2026-01-20 13:00:21', NULL),
	('eecb34d1-212d-4fca-a982-a115bcf36778', 'e8d27f72-443b-42a1-8d3e-5185ede59cc7', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 07:51:18', '2026-05-04 07:51:18', NULL);

-- Dumping structure for table dms_ai.documentversions
CREATE TABLE IF NOT EXISTS `documentversions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'local',
  `signById` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentversions_documentid_foreign` (`documentId`),
  KEY `documentversions_createdby_foreign` (`createdBy`),
  KEY `documentversions_signbyid_foreign` (`signById`),
  CONSTRAINT `documentversions_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentversions_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  CONSTRAINT `documentversions_signbyid_foreign` FOREIGN KEY (`signById`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentversions: ~3 rows (approximately)
INSERT INTO `documentversions` (`id`, `documentId`, `url`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`, `location`, `signById`, `signDate`) VALUES
	('3063f51a-8588-4ab6-8dd2-66f498dd076d', '95633ac1-dc51-42fc-afc3-ffc68367fa43', 'documents/cf5c03ff-b607-4e11-9676-93333e10b7bb.pdf', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 07:51:45', '2026-05-04 07:51:45', NULL, 'local', NULL, NULL),
	('40412f19-9289-4a94-8855-6be31fd85734', '9a83809a-beea-479a-90a6-d1816ae68e23', 'documents/a99ea699-cc3a-48af-9d2a-85334cdc61f1.pdf', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:35:47', '2026-01-20 12:35:47', NULL, 'local', NULL, NULL),
	('90101a7b-2e86-4726-9d6a-88feb69ea0be', '32a2f224-443c-454f-a3f6-46f26b819ce8', 'documents/a7f2c665-7f66-4ddb-81eb-c4677c05059b.docx', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-30 04:24:55', '2026-04-30 04:24:55', NULL, 'local', NULL, NULL);

-- Dumping structure for table dms_ai.documentworkflow
CREATE TABLE IF NOT EXISTS `documentworkflow` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `workflowId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currentStepId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Initiated','InProgress','Completed','Cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Initiated',
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documentworkflow_createdby_foreign` (`createdBy`),
  KEY `documentworkflow_documentid_foreign` (`documentId`),
  KEY `documentworkflow_workflowid_foreign` (`workflowId`),
  KEY `documentworkflow_currentstepid_foreign` (`currentStepId`),
  CONSTRAINT `documentworkflow_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `documentworkflow_currentstepid_foreign` FOREIGN KEY (`currentStepId`) REFERENCES `workflowsteps` (`id`),
  CONSTRAINT `documentworkflow_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  CONSTRAINT `documentworkflow_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.documentworkflow: ~0 rows (approximately)

-- Dumping structure for table dms_ai.emaillogattachments
CREATE TABLE IF NOT EXISTS `emaillogattachments` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `emailLogId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `emaillogattachments_emaillogid_foreign` (`emailLogId`),
  CONSTRAINT `emaillogattachments_emaillogid_foreign` FOREIGN KEY (`emailLogId`) REFERENCES `emaillogs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.emaillogattachments: ~0 rows (approximately)

-- Dumping structure for table dms_ai.emaillogs
CREATE TABLE IF NOT EXISTS `emaillogs` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `senderEmail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `recipientEmail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('sent','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sent',
  `errorMessage` text COLLATE utf8mb4_unicode_ci,
  `sentAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.emaillogs: ~0 rows (approximately)

-- Dumping structure for table dms_ai.emailsmtpsettings
CREATE TABLE IF NOT EXISTS `emailsmtpsettings` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `port` int NOT NULL,
  `isDefault` tinyint(1) NOT NULL,
  `fromName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `encryption` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `fromEmail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.emailsmtpsettings: ~0 rows (approximately)

-- Dumping structure for table dms_ai.filerequestdocuments
CREATE TABLE IF NOT EXISTS `filerequestdocuments` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileRequestId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileRequestDocumentStatus` tinyint NOT NULL DEFAULT '0',
  `approvedRejectedDate` datetime DEFAULT NULL,
  `approvalOrRejectedById` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filerequestdocuments_filerequestid_foreign` (`fileRequestId`),
  KEY `filerequestdocuments_approvalorrejectedbyid_foreign` (`approvalOrRejectedById`),
  CONSTRAINT `filerequestdocuments_approvalorrejectedbyid_foreign` FOREIGN KEY (`approvalOrRejectedById`) REFERENCES `users` (`id`),
  CONSTRAINT `filerequestdocuments_filerequestid_foreign` FOREIGN KEY (`fileRequestId`) REFERENCES `filerequests` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.filerequestdocuments: ~4 rows (approximately)
INSERT INTO `filerequestdocuments` (`id`, `name`, `url`, `fileRequestId`, `fileRequestDocumentStatus`, `approvedRejectedDate`, `approvalOrRejectedById`, `reason`, `createdDate`) VALUES
	('6bfd2018-14e9-4e0c-a906-d55278b488d9', 'INV_2026_00011.pdf', 'documents/8cce8972-92f7-4c0a-862b-b0b3d44c8c66.pdf', 'b221b3c2-9f50-4a0e-9833-6d57c5ef21f4', 1, '2026-04-08 11:31:43', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-08 10:54:47'),
	('93da5d96-3dd0-4771-8da6-b1ee76fcddb0', 'Muhammad kalim.pdf', 'documents/e0442d59-d5fb-445d-980c-164145229383.pdf', '0a49d882-f3ff-48f1-b8a8-265351ad5d02', 1, '2026-04-08 11:34:19', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-08 11:33:21'),
	('af54902d-cfd5-4ea1-8ba0-a426cae9bd2d', 'ICT_Topic01-ICT_Fundamentals.pdf', 'documents/e87ce9af-7934-4c57-890c-737f2405d1c1.pdf', '05c805dc-b2f1-41b1-8753-66331c958461', 0, NULL, NULL, NULL, '2026-05-02 11:35:37'),
	('f1137c93-58a7-4296-a7d6-75668efbe062', 'ML.pdf', 'documents/0afef14f-6ada-4ce4-90fb-7974f07efa59.pdf', '90ca00f8-2f6b-4dd4-ae49-3a15e6a9093e', 0, NULL, NULL, NULL, '2026-05-03 14:01:12');

-- Dumping structure for table dms_ai.filerequests
CREATE TABLE IF NOT EXISTS `filerequests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxDocument` int DEFAULT NULL,
  `sizeInMb` int DEFAULT NULL,
  `allowExtension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileRequestStatus` tinyint NOT NULL DEFAULT '0',
  `linkExpiryTime` datetime DEFAULT NULL,
  `isLinkExpired` tinyint(1) NOT NULL DEFAULT '0',
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `filerequests_createdby_foreign` (`createdBy`),
  CONSTRAINT `filerequests_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.filerequests: ~10 rows (approximately)
INSERT INTO `filerequests` (`id`, `subject`, `email`, `password`, `maxDocument`, `sizeInMb`, `allowExtension`, `fileRequestStatus`, `linkExpiryTime`, `isLinkExpired`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('00188095-ca11-4a34-85b9-ce14004856ed', 'Deep learning', 'david@gm', 'aGVsbG8=', 2, 10, 'Office,Pdf', 0, '2026-05-02 10:15:10', 0, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 1, '2026-05-02 10:13:10', '2026-05-02 11:36:19', '2026-05-02 11:36:19'),
	('05c805dc-b2f1-41b1-8753-66331c958461', 'Machine Learning', 'abc123@gmail.com', 'aGVsbG8=', 2, 1, 'Pdf', 1, '2026-05-03 14:05:00', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-02 11:25:12', '2026-05-03 14:02:23', NULL),
	('0a49d882-f3ff-48f1-b8a8-265351ad5d02', 'DGSE- SPORTS TEACHERS', 'bwatiq4@gmail.com', 'aGVsbG8=', 1, 5, 'Office,Pdf,Image', 1, NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-08 11:31:19', '2026-05-02 10:50:29', NULL),
	('1a3437e1-58a9-4540-a857-2ac35b34731c', 'Document Needed', 'bwatiq4@gmail.com', NULL, 10, 5, 'Pdf', 0, NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 11:00:05', '2026-04-08 11:00:05', NULL),
	('72e15903-09e9-49d9-91d0-ff679c9526c9', 'test document Request', 'bwatiq4@gmail.com', 'dGVzdEAxMjM=', 1, 5, 'Pdf', 0, NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:29:48', '2026-01-20 12:29:48', NULL),
	('8bc0550d-2799-4214-ad8c-0aecd1c7b537', 'document11', 'alina00@gmail.com', NULL, 1, 10, 'Pdf', 0, NULL, 0, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-27 06:05:04', '2026-04-27 06:05:04', NULL),
	('90ca00f8-2f6b-4dd4-ae49-3a15e6a9093e', 'Deep Learning', 'abc123@gmail.com', 'aGVsbG8=', 1, 10, 'Pdf', 1, '2026-05-03 19:05:00', 0, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-03 13:59:55', '2026-05-03 14:01:12', NULL),
	('9b94890e-d2d7-492e-b7d2-1649af2d4d9d', 'sdsdsdsd', 'dddddddd@co', NULL, 1, 5, 'Office', 0, NULL, 0, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-04 07:11:50', '2026-05-04 07:11:50', NULL),
	('b221b3c2-9f50-4a0e-9833-6d57c5ef21f4', 'cv request', 'bwatiq4@gmail.com', NULL, 1, 10, 'Pdf', 1, NULL, 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-08 10:16:03', '2026-04-08 10:54:47', NULL),
	('ff6b1802-0868-4dac-b480-389beba9445d', 'JV Company Document XYZ', 'david@gmail.com', 'aGVsbG8=', 2, 100, 'Office,Image,Text,Video', 0, '2026-04-27 18:07:15', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-14 09:35:04', '2026-04-30 11:41:44', NULL);

-- Dumping structure for table dms_ai.halfyearlyreminders
CREATE TABLE IF NOT EXISTS `halfyearlyreminders` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminderId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day` int NOT NULL,
  `month` int NOT NULL,
  `quarter` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `halfyearlyreminders_reminderid_foreign` (`reminderId`),
  CONSTRAINT `halfyearlyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.halfyearlyreminders: ~0 rows (approximately)

-- Dumping structure for table dms_ai.languages
CREATE TABLE IF NOT EXISTS `languages` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imageUrl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isRTL` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `languages_createdby_foreign` (`createdBy`),
  CONSTRAINT `languages_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.languages: ~8 rows (approximately)
INSERT INTO `languages` (`id`, `code`, `name`, `imageUrl`, `createdBy`, `modifiedBy`, `order`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`, `isRTL`) VALUES
	('04906ab8-15b0-11ee-83f2-d85ed3312c1f', 'ru', 'Russian', 'images/flags/russia.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 5, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
	('10ac83d1-15b0-11ee-83f2-d85ed3312c1f', 'ja', 'Japanese', 'images/flags/japan.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 6, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
	('1d9a6233-15b0-11ee-83f2-d85ed3312c1f', 'fr', 'French', 'images/flags/france.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 7, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
	('9ed7278c-c7e7-4c91-9a83-83833603eb47', 'ko', 'Korean ', 'images/flags/south-korea.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 8, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
	('df8a9fe2-15af-11ee-83f2-d85ed3312c1f', 'en', 'English', 'images/flags/united-states.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 1, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
	('ef46fe64-15af-11ee-83f2-d85ed3312c1f', 'cn', 'Chinese', 'images/flags/china.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 2, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
	('f8041d27-15af-11ee-83f2-d85ed3312c1f', 'es', 'Spanish', 'images/flags/france.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 3, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, 0),
	('fe78a067-15af-11ee-83f2-d85ed3312c1f', 'ar', 'Arabic', 'images/flags/saudi-arabia.svg', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 4, '', 0, '0000-00-00 00:00:00', '2026-01-20 09:56:30', NULL, 1);

-- Dumping structure for table dms_ai.loginaudits
CREATE TABLE IF NOT EXISTS `loginaudits` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loginTime` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remoteIP` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.loginaudits: ~173 rows (approximately)
INSERT INTO `loginaudits` (`id`, `userName`, `loginTime`, `remoteIP`, `status`, `provider`, `latitude`, `longitude`) VALUES
	('01a75706-7f55-4860-b755-4368291bf20d', 'employee@gmail.com', '2026-04-27 05:40:23', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('021d133f-4d34-4a76-af28-5440575aa4d2', 'info@solochoicez.com', '2026-05-20 05:56:58', '127.0.0.1', 'Success', NULL, NULL, NULL),
	('02b4a4a9-6fc1-4b02-a5ce-55539e68dc88', 'employee@gmail.com', '2026-05-03 13:32:53', '39.49.238.166', 'Success', NULL, NULL, NULL),
	('03e3accf-2469-45d5-8e5d-737543f11617', 'employee@gmail.com', '2026-05-05 04:02:18', '154.192.25.153', 'Success', NULL, NULL, NULL),
	('050eaead-accd-422b-a5c5-df1e8320ab27', 'employee@gmail.com', '2026-04-30 05:19:39', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('068ef048-45d5-49c2-b4c3-c5a72515a2bf', 'info@solochoicez.com', '2026-04-28 09:25:30', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('06d6c190-aeaa-400b-9daf-74a36efb5783', 'info@solochoicez.com', '2026-04-08 10:24:59', '154.192.37.9', 'Error', NULL, NULL, NULL),
	('06e3db24-9f87-4028-9f40-14f7f771d0fd', 'employee@gmail.com', '2026-04-23 11:20:06', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('079b07e1-a720-480a-862b-77196bcb0416', 'info@solochoicez.com', '2026-04-27 05:18:17', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('09c35ef6-2246-49be-aa30-280f12995fdf', 'QA@example.com', '2026-04-16 12:51:45', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('0a8b9cdd-7369-4974-b10a-645bcc1fd51a', 'info@solochoicez.com', '2026-04-23 12:55:50', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('0ad887f7-cea0-4d57-9f8c-6ab3db2ba5d2', 'info@solochoicez.com', '2026-04-29 11:01:59', '2407:d000:17:f121:d8fa:1d55:f79d:9d1b', 'Success', NULL, NULL, NULL),
	('0c4eb1e1-6f78-45c2-b39e-6506073eb4c5', 'info@solochoicez.com', '2026-01-20 12:32:01', '2407:d000:b:1aa0:bca2:bfbc:d8ac:8fdf', 'Success', NULL, NULL, NULL),
	('0c60a771-8140-45d4-b824-3ecb548dfd65', 'info@solochoicez.com', '2026-04-16 10:31:58', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('0cfbd840-d15d-4e57-bc5d-4a261d7acc14', 'employee@gmail.com', '2026-04-27 05:25:04', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('0eda2b3f-5ee4-4973-b277-21bdfbbac77b', 'Employee@gmail.com', '2026-04-27 05:39:48', '154.192.22.180', 'Success', NULL, NULL, NULL),
	('0eeedc22-d542-43ca-b05f-30acfbd2217d', 'employee@gmail.com', '2026-04-27 06:31:08', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('0f43f853-8a71-4afb-9e8a-3beb3cfda7e6', 'info@solochoicez.com', '2026-04-23 10:34:32', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('118f5c3c-91e3-4bd4-850f-6a96609d35ba', 'employee@gmail.com', '2026-04-30 09:53:30', '154.192.21.16', 'Success', NULL, NULL, NULL),
	('149e0509-7e34-4518-b7aa-42c3be2f976a', 'info@solochoicez.com', '2026-04-30 09:52:32', '2407:d000:17:f121:9198:d705:31b6:c5d7', 'Success', NULL, NULL, NULL),
	('16174e78-211b-444b-a119-37275da147c7', 'umer.farooq@solochoicez.com', '2026-04-14 08:03:49', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('18cbe01c-bb60-49cb-a671-745e76188535', 'info@solochoicez.com', '2026-01-20 10:59:44', '2407:d000:b:1aa0:bca2:bfbc:d8ac:8fdf', 'Success', NULL, NULL, NULL),
	('18dce09c-eca2-4775-97e7-58090add74a0', 'employee@gmail.com', '2026-04-30 06:23:23', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('1a18efac-9643-4876-9164-24d26a254847', 'mployee@gmail.com', '2026-04-27 05:40:06', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('1acd5cbc-a01e-46ce-be92-b47bec75765e', 'umeroh5533@gmail.com', '2026-04-14 06:33:49', '154.192.37.9', 'Error', NULL, NULL, NULL),
	('1b6604ee-13f0-4be7-8dc3-0c694afebff9', 'employee@gmail.com', '2026-04-23 10:33:02', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('1cb72e77-d2b4-4906-91f7-67bf6ff16b8a', 'employee@gmail.com', '2026-05-04 11:31:42', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('1d76e3f2-2845-46a9-9bd7-164cf6f6b5d8', 'employee@gmail.com', '2026-04-27 09:15:24', '154.192.22.180', 'Success', NULL, NULL, NULL),
	('1e70fcf9-3b53-4c02-9ca4-21edebcfc2d9', 'info@solochociez.com', '2026-01-20 09:57:19', '2407:d000:b:1aa0:bca2:bfbc:d8ac:8fdf', 'Error', NULL, NULL, NULL),
	('20f677ac-bc99-4447-a209-3a36687b109f', 'info@solochoicez.com', '2026-04-27 11:14:51', '154.192.10.117', 'Success', NULL, NULL, NULL),
	('213e8e12-67a0-47fe-ae59-a51c6090e1be', 'employee@gmail.com', '2026-04-23 10:44:21', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('25481ec3-342c-4103-8f28-523ba6e130e9', 'employee@gmail.com', '2026-04-30 05:19:24', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('26117e43-8e72-411d-9ea4-5db05295155e', 'farah.zafar@solochoicez.com', '2026-04-13 07:48:43', '2401:ba80:a11a:e629:e0fa:1bff:fe05:5767', 'Success', NULL, NULL, NULL),
	('27d87dc5-6179-41de-bb16-a103cf763601', 'info@solochoicez.com', '2026-04-23 11:07:35', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('2a0c1f11-7375-4a61-ba20-34f42dbeefee', 'info@solochoicez.com', '2026-04-30 05:32:01', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('2a21d344-b00a-4a14-9450-c83f56642423', 'employee@gmail.com', '2026-04-27 05:05:26', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('2ad3c4be-2576-4313-9b45-35db70897b45', 'info@solochoicez.com', '2026-04-08 13:25:34', '2407:d000:17:f121:a017:62bf:b528:f2b4', 'Success', NULL, NULL, NULL),
	('2b2b3280-18df-46ee-a662-26f8df23a48f', 'shahzadhusyn48796@gmail.com', '2026-04-09 07:27:16', '2407:d000:17:f121:98d7:5456:cd3:c19b', 'Success', NULL, NULL, NULL),
	('2b3692b3-e9bb-4cf3-a6f2-eb1fa574a4e5', 'employee@gmail.com', '2026-05-05 04:01:32', '154.192.25.153', 'Success', NULL, NULL, NULL),
	('2d771450-d9a4-4d74-bc0f-b24971394d03', 'info@solochoicez.com', '2026-04-30 05:33:11', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('2e7b6d7b-ebbd-4121-b2d2-10e94176e64d', 'info@solochoicez.com', '2026-04-28 06:59:14', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('2f5e64a9-4ef1-4ea9-beab-9e08fd7c5a7a', 'employee@gmail.com', '2026-05-04 04:07:00', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('30f19e63-e20b-4b28-a066-369ee064168f', 'info@solochoicez.com', '2026-04-27 04:59:40', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('31b9e6fe-a3de-480e-874d-859542bbe941', 'info@solochoicez.com', '2026-04-13 10:39:05', '2407:d000:17:f121:bd5b:3d99:8f0e:9a1d', 'Success', NULL, NULL, NULL),
	('3283f8d7-efde-4dc0-b7b9-9e377fa126cc', 'info@solochoicez.com', '2026-04-08 10:24:59', '154.192.37.9', 'Error', NULL, NULL, NULL),
	('33e35302-718f-4d6e-aaf8-2912a40c57fd', 'info@solochoicez.com', '2026-04-09 07:23:40', '2407:d000:17:f121:98d7:5456:cd3:c19b', 'Success', NULL, NULL, NULL),
	('35452957-27e4-4ade-aed2-9c8dbb9f5ca7', 'shahzadhusyn48796@gmail.com', '2026-04-09 07:42:08', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('3599dc35-d2bd-40fa-ad06-c9155fbc77a6', 'employee@gmail.com', '2026-04-29 07:14:48', '182.184.167.243', 'Success', NULL, NULL, NULL),
	('3b2072a5-7b20-48c9-b588-07d2a9a4b882', 'employee@gmail.com', '2026-04-23 10:46:21', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('3c698e17-b5e3-4a68-925e-e6ee703e8390', 'employee@gmail.com', '2026-04-27 09:15:14', '154.192.22.180', 'Success', NULL, NULL, NULL),
	('3cc50151-9fdc-4731-ba34-1fd2697fc924', 'info@solochoicez.com', '2026-04-27 04:52:50', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('3dc469e0-f912-43e8-bb27-95fc48b37327', 'employee@gmail.com', '2026-04-23 10:53:17', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('3fcaae83-183a-4b83-81ac-9313baca0fbb', 'employee@gmail.com', '2026-04-23 10:51:23', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('4384c8c7-5c7a-494d-a356-a468a2494988', 'info@solochoicez.com', '2026-04-23 12:41:48', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('478a140a-0c56-42d8-9468-9b400cff3402', 'info@solochoicez.com', '2026-04-28 12:11:39', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('48fcaed5-0b1a-4dce-8c20-79b04073048d', 'info@solochoicez.com', '2026-04-30 05:31:54', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('49076762-f353-4c87-8fa3-a8d803db1c9f', 'info@solochoicez.com', '2026-01-21 05:48:34', '2407:d000:b:1aa0:7599:95c3:73a:50e5', 'Success', NULL, NULL, NULL),
	('49a68bb2-99ad-44e7-a63f-b9ca182a6ff0', 'employee@gmail.com', '2026-04-23 11:06:21', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('49b208f2-ccf0-43f2-a63d-647df107c018', 'info@solochoicez.com', '2026-04-28 06:59:55', '154.192.22.215', 'Success', NULL, NULL, NULL),
	('4c10bc0c-b2f9-4274-8535-1891de6f4909', 'employee@gmail.com', '2026-05-05 06:45:06', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('509634dd-be9c-4f66-a50d-a3bd6a5a4e24', 'info@solochoicez.com', '2026-01-21 05:48:11', '2407:d000:b:1aa0:7599:95c3:73a:50e5', 'Error', NULL, NULL, NULL),
	('51608989-e751-407b-ae30-cffc28849ef9', 'info@solochoicez.com', '2026-04-27 05:18:26', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('53d970b2-3dfc-4890-9af2-11a060d125f6', 'employee@gmail.com', '2026-04-27 07:20:07', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('55afd3ee-5032-4655-a7ad-ad696c902050', 'fatima.abbas@solochoicez.com', '2026-04-13 08:26:39', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('563c38bc-666a-4946-bbe2-555ab889c646', 'employee@gmail.com', '2026-04-23 12:37:19', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('59b7d753-bf20-4244-a1d7-1df9cd6a1ad4', 'info@solochoicez.com', '2026-04-28 10:25:36', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('5a54cc69-a66f-4f48-a611-bfb53636d61f', 'info@solochoicez.com', '2026-05-20 09:52:42', '127.0.0.1', 'Success', NULL, NULL, NULL),
	('5a62d40f-e4d1-4810-b894-cd324a347d10', 'employee@gmail.com', '2026-04-23 12:46:42', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('5a9f50d2-8653-4aa6-9a7e-cbe28f27c635', 'info@solochoicez.com', '2026-01-20 10:47:44', '2407:d000:b:1aa0:4156:b196:8a57:8e5', 'Error', NULL, NULL, NULL),
	('5b1431de-7006-40c0-906c-baab42b8ba71', 'info@solochoicez.com', '2026-05-02 10:58:56', '182.184.167.81', 'Success', NULL, NULL, NULL),
	('5d33b100-cd28-4251-a960-0bd6f1b5952b', 'info@solocho', '2026-04-27 05:33:06', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('5e7618a9-2e7f-4ebd-8b1e-c09fa04fa2b0', 'info@solochoicez.com', '2026-05-05 06:24:53', '2407:d000:17:f121:44f3:d146:c087:f183', 'Success', NULL, NULL, NULL),
	('5eaa43e8-4523-4cca-82f4-9f10c039ddfa', 'vako@mailinator.com', '2026-04-08 13:39:00', '45.115.86.126', 'Success', NULL, NULL, NULL),
	('5f50e633-a44e-4c7e-a334-e447176399b7', 'info@solochoicez.com', '2026-04-30 05:17:11', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('5f7fd2b0-b550-435b-b2af-7504e4d33214', 'info@solochoicez.com', '2026-04-30 10:08:49', '154.192.21.16', 'Success', NULL, NULL, NULL),
	('6362c474-fa2a-46e4-b9d3-844bc53058fa', 'info@solochoicez.com', '2026-04-16 11:22:08', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('63c13096-e15f-4aea-a528-1a1a6b730e9c', 'info@solochoicez.com', '2026-04-28 08:25:26', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('64420576-c20f-4400-8e6e-3c9212a933a6', 'info@solochoicez.com', '2026-04-27 06:34:38', '154.192.22.180', 'Success', NULL, NULL, NULL),
	('6493b97c-e368-4611-9ebe-6f29f6dc6d92', 'Hamza@gmail.com', '2026-04-26 15:45:19', '39.58.187.17', 'Error', NULL, NULL, NULL),
	('65e91760-5ed7-4761-b4f9-b1d1873bbeee', 'info@solochoicez.com', '2026-04-29 05:07:20', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('6819a8ac-bf5d-4b3d-882d-c35665d7499e', 'employee@gmail.com', '2026-05-02 13:37:05', '182.184.167.81', 'Success', NULL, NULL, NULL),
	('692e996b-6500-4831-b768-5967870f9690', 'info@solochoicez.com', '2026-04-08 10:25:03', '154.192.37.9', 'Error', NULL, NULL, NULL),
	('6c67b23a-e6ca-4b11-bc24-3aa0cd60d8a6', 'info@solochoicezz.com', '2026-05-02 10:58:41', '182.184.167.81', 'Error', NULL, NULL, NULL),
	('6d7101d2-98b8-45f8-8441-51860b9b12b4', 'employee@gmail.com', '2026-04-26 15:45:47', '39.58.187.17', 'Error', NULL, NULL, NULL),
	('70df6b2d-c3a2-4f75-ba13-8b92d2123a9b', 'info@solochoicez.com', '2026-04-17 10:51:39', '2407:d000:17:f121:50c1:17d6:abe5:740b', 'Success', NULL, NULL, NULL),
	('72e07007-c39e-4ba6-ade4-6799a25036dc', 'employee@gmail.com', '2026-05-02 16:38:07', '39.49.227.5', 'Success', NULL, NULL, NULL),
	('765a9e99-dfdc-4abc-9604-dc08bf343122', 'farah.zafar@solochoicez.com', '2026-04-09 07:40:18', '2401:ba80:a10f:dcf0:c42f:77ff:fe0b:218d', 'Success', NULL, NULL, NULL),
	('7906d96a-ded9-46b6-900d-2ce4423917f7', 'info@solochoicez.com', '2026-04-20 06:12:01', '154.192.22.201', 'Success', NULL, NULL, NULL),
	('7a2f980b-5472-49c9-98c0-733da429665d', 'employee@gmail.com', '2026-04-23 10:58:27', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('7ac26453-f9e0-47bd-925c-d3a05abd3fa2', 'info@solochoicez.com', '2026-04-08 13:28:24', '2407:d000:17:f121:5c7f:4e3b:8ad1:733e', 'Success', NULL, NULL, NULL),
	('7b180093-edbf-4cb2-a508-39d11f814ebf', 'employee@gmail.com', '2026-04-27 04:45:49', '154.192.22.180', 'Success', NULL, NULL, NULL),
	('7ba50477-28b4-4724-bd88-c468e359544e', 'info@solochoicez.com', '2026-04-27 10:09:51', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('7bf0b878-9275-49ff-abfd-2c04dabde0e0', 'zafarfarah425@gmail.com', '2026-04-09 07:38:58', '2401:ba80:a10f:dcf0:c42f:77ff:fe0b:218d', 'Error', NULL, NULL, NULL),
	('7c338066-ba06-4bd8-87c0-6e9e870bc8c0', 'employee@gmail.com', '2026-04-30 04:05:49', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('7d099fcb-eb48-4c3e-a14c-a8d0c07063dc', 'employee@gmail.com', '2026-04-23 11:18:48', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('7d4209af-17d5-46db-b595-8c35651d260b', 'info@solochoicez.com', '2026-01-20 13:10:56', '2407:d000:b:1aa0:9daa:50b5:1146:92ef', 'Success', NULL, NULL, NULL),
	('7f21ca23-7b96-4612-9cd4-95a5d884bde9', 'employee@gmail.com', '2026-04-23 12:32:00', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('820c97c0-85d5-439d-a90e-0f82f7a02314', 'info@solochoicez.com', '2026-01-20 13:06:50', '45.115.86.126', 'Success', NULL, NULL, NULL),
	('83a9efaf-c05d-49cb-9509-6d1e35a0131b', 'employee@gmail.com', '2026-05-19 09:49:29', '127.0.0.1', 'Success', NULL, NULL, NULL),
	('83f465be-34c1-4b2b-b309-fc379f969d2b', 'info@solochoicez.com', '2026-04-14 09:32:21', '2407:d000:17:f121:ec0f:a0da:98ba:d35c', 'Success', NULL, NULL, NULL),
	('84df145f-7151-480a-a786-26822c419317', 'employee@gmail.com', '2026-04-30 06:23:29', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('86eb1cee-5a3f-4862-b4fa-b388fe971bd0', 'info@solochoicez.com', '2026-04-17 12:38:26', '2407:d000:17:f121:50c1:17d6:abe5:740b', 'Success', NULL, NULL, NULL),
	('88286d1c-5386-47b8-b217-6791f9926c2b', 'info@solochoicez.com', '2026-04-27 04:43:13', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('8906fb47-7b00-4b01-bacd-60d12fa94c30', 'info@solochoicez.com', '2026-05-02 13:32:54', '182.184.167.81', 'Success', NULL, NULL, NULL),
	('8b041339-6501-4c0b-98ba-169e2529cd79', 'employee@gmail.com', '2026-04-30 06:50:12', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('8b999282-3b9d-4462-bc4f-16084ea3532b', 'info@solochoicez.com', '2026-05-02 16:34:37', '39.49.227.5', 'Success', NULL, NULL, NULL),
	('8d52ec93-a3b6-4dc8-8848-4cebdd3842a4', 'info@solochoicez.com', '2026-04-23 10:53:09', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('903f0c04-2415-4313-a2e7-12fef8d42980', 'employee@gmail.com', '2026-04-23 10:58:41', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('9367bd48-bdaa-410d-8d41-b749b5158f2c', 'hanza@gmail.com', '2026-04-26 15:45:34', '39.58.187.17', 'Error', NULL, NULL, NULL),
	('94483e1c-bda2-4bda-a6fe-a87fd3923163', 'info@solochoicez.com', '2026-04-23 09:52:53', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('95e8936d-071c-4fd0-bbd9-ae4daef540e3', 'info@solochoicez.com', '2026-05-19 10:31:21', '127.0.0.1', 'Success', NULL, NULL, NULL),
	('96cffa2b-bd34-4bdc-89f9-1dd571157d41', 'info@solochoicez.com', '2026-04-30 05:30:57', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('979da82c-e731-420f-a295-a19fdb7e6704', 'employee@gmail.com', '2026-04-27 05:24:37', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('9911dfb6-929e-4ba5-8ec7-f5a75b6e116d', 'employee@gmail.com', '2026-04-30 05:34:09', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('9b3ed7ad-7a92-433c-84ea-adec9cecca98', 'info@solochoicez.com', '2026-04-23 09:36:10', '2407:d000:17:f121:9c10:9545:51d5:6587', 'Success', NULL, NULL, NULL),
	('9da7c638-3dcf-4cf0-8971-657542760f8f', 'info@solochoicez.com', '2026-04-21 06:02:02', '2407:d000:17:f121:10c7:1f00:3112:1e7b', 'Success', NULL, NULL, NULL),
	('9ebf71ed-f6c9-4bd7-85b8-155d4fa94ed7', 'employee@gmail.com', '2026-05-04 04:35:08', '154.192.25.153', 'Success', NULL, NULL, NULL),
	('9effe161-49f9-45b7-9676-66bb18656732', 'info@solochociez.com', '2026-01-20 09:57:14', '2407:d000:b:1aa0:bca2:bfbc:d8ac:8fdf', 'Error', NULL, NULL, NULL),
	('a8abde96-60b7-4196-a150-a80e129bf92b', 'info@solochociez.com', '2026-01-20 09:57:23', '2407:d000:b:1aa0:bca2:bfbc:d8ac:8fdf', 'Error', NULL, NULL, NULL),
	('a8c07708-a96d-4bfb-ba3f-f527d285a7ee', 'info@solochoicez.com', '2026-05-20 17:49:05', '127.0.0.1', 'Success', NULL, NULL, NULL),
	('a9f79f4e-1875-424f-9e74-b60ba9bc2e3b', 'info@solochoicez.com', '2026-04-14 06:35:05', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('ac484c13-eed2-46b7-9c08-19157a319952', 'info@solochoicez.com', '2026-04-17 08:01:39', '2407:d000:17:f121:c918:d64e:6e95:443b', 'Success', NULL, NULL, NULL),
	('ace1a0ca-8810-43ea-81a4-3edbd06df3ea', 'abdulmateen03527@gmail.com', '2026-04-09 09:15:36', '2407:d000:17:f121:98d7:5456:cd3:c19b', 'Success', NULL, NULL, NULL),
	('ad110821-7df1-4e53-bb10-6b1189410771', 'employee@gmail.com', '2026-04-23 12:44:11', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('ad7e0dd8-999c-40ef-9a0f-9faf94e096e3', 'umer.farooq@solochoicez.com', '2026-04-14 06:31:37', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('b156fbec-706d-4e31-a14f-6997f3f64b74', 'info@solochoicez.com', '2026-01-20 11:34:20', '2407:d000:b:1aa0:4156:b196:8a57:8e5', 'Success', NULL, NULL, NULL),
	('b28d510b-6e84-481d-9f77-5ea253985cae', 'info@solochoicez.com', '2026-04-23 06:08:22', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('b46dbf24-3bef-4866-b467-7c01db70e250', 'employee@gmail.com', '2026-04-27 09:16:11', '154.192.22.180', 'Success', NULL, NULL, NULL),
	('ba6fb5dc-6f5a-4a2b-b28b-2a5c9a8eb38e', 'employee@gmail.com', '2026-04-23 10:39:27', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('bbd09307-a32d-4940-81ad-27fe2962ab1f', 'info@solochoicez.com', '2026-04-27 09:03:27', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('bc6fb691-1698-44d4-802f-c2af54770c79', 'info@solochoicez.com', '2026-04-23 11:15:45', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('bc97cb93-af2c-4b92-a6a8-2b2e7453689a', 'info@solochoicez.com', '2026-04-23 09:33:36', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('bd939e36-07fa-410c-8d81-d94dd4065bbf', 'info@solochoicez.com', '2026-01-21 12:34:00', '2407:d000:b:1aa0:997e:582a:fa86:1d32', 'Success', NULL, NULL, NULL),
	('bf38a8a4-a576-4124-a97a-519008bc443b', 'employee@gmail.com', '2026-04-23 11:12:01', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('c098c2cb-1f0a-4953-b80b-652a78d02730', 'employee@gmail.com', '2026-04-23 10:44:08', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('c124c251-05b6-49f5-8984-402f3ed0ab4a', 'employee@gmail.com', '2026-04-30 04:05:39', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('c2faa520-a75e-4030-a3e9-fe18b744d799', 'employee@gmail.com', '2026-04-30 04:05:35', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('c6ebbf1e-f0c6-4a2b-917c-0a034d4154e2', 'employee@gmail.com', '2026-05-02 16:25:06', '39.49.227.5', 'Success', NULL, NULL, NULL),
	('cab921c9-e265-4845-a047-30a49bb0c07e', 'shahzadhusyn48796@gmail.com', '2026-04-09 07:29:24', '2407:d000:17:f121:98d7:5456:cd3:c19b', 'Success', NULL, NULL, NULL),
	('cb3fe4ad-fcc6-475b-b933-379b69d408d2', 'info@solocho', '2026-04-27 05:25:32', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('cc72947e-7c67-44d9-a865-8774a1fbfa45', 'umer.farooq@solochoicez.com', '2026-04-14 10:08:46', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('cdeaaa5a-6892-4eec-903b-bc2e270190eb', 'info@solochoicez.com', '2026-04-22 10:01:44', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('ceef92da-1b88-481a-9f41-14958429d0b9', 'employee@gmail.com', '2026-05-02 09:56:42', '182.184.167.81', 'Success', NULL, NULL, NULL),
	('cfc2fe69-23bb-4914-8a2a-a670e1a70eeb', 'employee@gmail.com', '2026-05-06 04:27:08', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('d20798ac-4d05-4d28-acae-b448770d854d', 'info@solochoicez.com', '2026-04-28 04:52:51', '154.192.22.215', 'Success', NULL, NULL, NULL),
	('d3eb2d6a-4ba6-4481-acf4-e4c19ac28768', 'info@solochoicez.com', '2026-04-08 10:09:57', '2407:d000:17:f121:a017:62bf:b528:f2b4', 'Success', NULL, NULL, NULL),
	('d4f20c54-09eb-4d7d-b645-ed69f1034c07', 'employee@gmail.com', '2026-04-27 09:15:36', '154.192.22.180', 'Success', NULL, NULL, NULL),
	('d696e705-3307-4abd-80b0-33ead04d866f', 'employee@gmail.com', '2026-05-02 12:54:55', '182.184.167.81', 'Success', NULL, NULL, NULL),
	('d9c6d6b1-e80f-4f86-a0ed-833a156ce5e0', 'info@solochoicez.com', '2026-01-20 11:21:39', '2407:d000:b:1aa0:4156:b196:8a57:8e5', 'Success', NULL, NULL, NULL),
	('dd387a3f-ba74-4f3a-962c-b33b2d1425be', 'info@solochoicez.com', '2026-05-21 06:00:05', '127.0.0.1', 'Success', NULL, NULL, NULL),
	('dd60d6d5-4344-49fb-8070-0c7e291f447c', 'employee@gmail.com', '2026-04-23 12:19:02', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('df9cff04-e4bb-4cfc-ac11-06a7b16391a2', 'employee@gmail.com', '2026-04-30 06:49:01', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('dffa4ad4-deb1-460f-8014-6912a51baec4', 'info@solochoicez.com', '2026-04-14 05:56:46', '2407:d000:17:f121:18be:9803:c05c:6b32', 'Success', NULL, NULL, NULL),
	('e11437fd-8939-422a-96c8-1c86be222781', 'info@solochoicez.com', '2026-04-29 09:16:56', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('e1310a7f-71ee-4018-9295-5d4a70b37d9b', 'info@solochoicez.com', '2026-04-23 10:38:52', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('e1df6d87-f16e-45e7-92e7-571c23d305e8', 'info@solochoicez.com', '2026-04-24 12:49:11', '2407:d000:17:f121:f8a4:57b3:cba7:f768', 'Success', NULL, NULL, NULL),
	('e25eb7c2-63db-4b22-951d-29cc273a1868', 'info@solochoicez.com', '2026-04-14 06:56:49', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('e299787d-cf77-483d-a041-f3cd5275af7c', 'info@solochoicez.com', '2026-01-20 09:57:30', '2407:d000:b:1aa0:bca2:bfbc:d8ac:8fdf', 'Success', NULL, NULL, NULL),
	('e49ad34d-388b-4d98-92ed-6fe992879934', 'info@solochoicez.com', '2026-04-27 05:54:00', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('e6f1b0a1-1095-4e91-8ca9-dd2820ea5ed9', 'info@solochoicez.com', '2026-04-23 11:15:45', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('e8296e1e-7684-414b-a71d-dd404d31a794', 'info@solochoicez.com', '2026-04-29 09:27:04', '154.192.4.121', 'Success', NULL, NULL, NULL),
	('e9668bff-123f-4e86-8d34-dadf259f4543', 'info@solochoicez.com', '2026-04-23 11:16:16', '154.192.20.143', 'Success', NULL, NULL, NULL),
	('eeb9a5da-22e7-4629-8662-c9920a855384', 'info@solochoicez.com', '2026-04-08 10:41:40', '2407:d000:17:f121:a017:62bf:b528:f2b4', 'Success', NULL, NULL, NULL),
	('f4acbbfc-b7ab-4914-97d3-d9b329860f19', 'employee@gmail.com', '2026-04-30 06:03:20', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('f4dc37c4-2c9b-48b7-89f5-998e61ec87e5', 'info@solochoicez.com', '2026-04-30 05:17:20', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('f6e6fe6d-b176-437d-be78-1d21cb7f082b', 'info@solochoicez.com', '2026-04-17 09:37:43', '2407:d000:17:f121:50c1:17d6:abe5:740b', 'Success', NULL, NULL, NULL),
	('f8339c76-9905-4a1a-a4b3-c91cf636a50e', 'employee@gmail.com', '2026-04-26 15:35:27', '39.58.187.17', 'Success', NULL, NULL, NULL),
	('f852af40-d1e6-4c1f-99c9-e1f463248bb0', 'info@solochoicez.com', '2026-04-23 08:46:44', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('fa95557f-880e-4b59-9d29-8b25a6cf4126', 'employee@gmail.com', '2026-04-23 10:51:51', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('fe8798be-8020-4f3b-a137-bea2df1a5f8d', 'employee@gmail.com', '2026-05-04 09:43:39', '154.192.28.35', 'Success', NULL, NULL, NULL),
	('feddefcf-5acf-4228-bf0a-0b4dc351890f', 'bnbbnyee@gmail.com', '2026-04-27 05:40:14', '154.192.28.35', 'Error', NULL, NULL, NULL),
	('ff636983-ccea-4cc9-8a88-c6da98cfb6f5', 'info@solochoicez.com', '2026-04-17 06:37:22', '154.192.37.9', 'Success', NULL, NULL, NULL),
	('ffb44706-a892-4368-82c8-f0330e1c20eb', 'employee@gmail.com', '2026-05-02 14:13:24', '182.184.167.81', 'Success', NULL, NULL, NULL);

-- Dumping structure for table dms_ai.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.migrations: ~57 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2022_12_07_080139_create_users_table', 1),
	(2, '2022_12_07_101203_create_roles_table', 1),
	(3, '2022_12_08_055649_create_user_roles_table', 1),
	(4, '2022_12_08_064517_create_categories_table', 1),
	(5, '2023_01_06_103543_create_pages_table', 1),
	(6, '2023_01_06_103807_create_actions_table', 1),
	(7, '2023_01_07_084251_create_role_claims_table', 1),
	(8, '2023_01_07_102537_create_user_claims_table', 1),
	(9, '2023_01_23_062456_create_email_s_m_t_p_settings_table', 1),
	(10, '2023_01_23_082532_create_documents_table', 1),
	(11, '2023_01_25_091840_create_document_meta_datas_table', 1),
	(12, '2023_01_26_105856_create_document_versions_table', 1),
	(13, '2023_01_26_112250_create_document_role_permissions_table', 1),
	(14, '2023_01_26_112318_create_document_user_permissions_table', 1),
	(15, '2023_01_28_075359_create_document_comments_table', 1),
	(16, '2023_01_31_063051_create_document_audit_trails_table', 1),
	(17, '2023_02_07_112502_create_login_audits_table', 1),
	(18, '2023_02_08_080324_create_reminders_table', 1),
	(19, '2023_02_13_063925_create_reminder_users_table', 1),
	(20, '2023_02_13_064215_create_half_yearly_reminders_table', 1),
	(21, '2023_02_13_064719_create_quarterly_reminders_table', 1),
	(22, '2023_02_13_064914_create_daily_reminders_table', 1),
	(23, '2023_02_18_071307_create_reminder_notifications_table', 1),
	(24, '2023_02_18_073159_create_user_notifications_table', 1),
	(25, '2023_02_18_092637_create_send_emails_table', 1),
	(26, '2023_02_18_101836_create_reminder_schedulers_table', 1),
	(27, '2023_03_04_073617_create_document_tokens_table', 1),
	(28, '2023_07_18_175356_add_encryption_to_email_s_m_t_p_settings_table', 1),
	(29, '2023_07_19_084757_create_languages_table', 1),
	(30, '2023_07_19_162944_create_company_profile_table', 1),
	(31, '2023_12_16_103345_add_location_to_documents_table', 1),
	(32, '2023_12_16_103702_add_location_to_document_versions_table', 1),
	(33, '2023_12_27_110008_add_location_to_companyprofile_table', 1),
	(34, '2024_03_28_044727_add__is_permanent_delete_to__document_table', 1),
	(35, '2024_04_05_121019_add__is_r_t_l_to__language_table', 1),
	(36, '2024_05_08_113442_add_reset_password_code_users_table', 1),
	(37, '2024_07_30_060655_create_document_shareable_link', 1),
	(38, '2024_10_19_095904_add_is_indexed_to_documents_table', 1),
	(39, '2024_10_22_115740_create_page_helper_table', 1),
	(40, '2025_02_28_071020_create_file_requests_table', 1),
	(41, '2025_02_28_071225_create_file_request_documents_table', 1),
	(42, '2025_02_28_095855_create_allow_file_extensions_table', 1),
	(43, '2025_03_11_115518_create_clients_table', 1),
	(44, '2025_03_25_084930_add_client_column_to_document_table', 1),
	(45, '2025_03_25_090623_add_from_email_column_to_emailsmtp_table', 1),
	(46, '2025_04_22_081450_create_ai_prompt_template_table', 1),
	(47, '2025_04_22_131011_create_openai_documents_table', 1),
	(48, '2025_04_28_061655_create_document_status_table', 1),
	(49, '2025_04_28_062430_create__add_document_status_column_to_document_table', 1),
	(50, '2025_05_13_092603_add_small_logo_image_to_company_profile_table', 1),
	(51, '2025_05_15_125857_create_workflow_tables', 1),
	(52, '2025_06_14_090123_add_license_to_company_profile_table', 1),
	(53, '2025_06_25_110856_version_5_1', 1),
	(54, '2025_09_19_268904_version_5_2', 1),
	(55, '2026_05_20_000006_add_interviewer_and_rejection_to_proposal_candidates', 2),
	(56, '2026_05_20_000007_add_interviewer_user_id_to_proposal_candidates', 3),
	(57, '2026_05_20_000008_backfill_proposal_created_dates', 4);

-- Dumping structure for table dms_ai.openaidocuments
CREATE TABLE IF NOT EXISTS `openaidocuments` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prompt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` text COLLATE utf8mb4_unicode_ci,
  `maximumLength` int DEFAULT NULL,
  `creativity` decimal(18,2) DEFAULT NULL,
  `toneOfVoice` text COLLATE utf8mb4_unicode_ci,
  `response` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.openaidocuments: ~0 rows (approximately)

-- Dumping structure for table dms_ai.pagehelper
CREATE TABLE IF NOT EXISTS `pagehelper` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.pagehelper: ~50 rows (approximately)
INSERT INTO `pagehelper` (`id`, `code`, `name`, `description`) VALUES
	('0a43906f-72ab-4206-bdb6-40e5656518f4', 'EMAIL_LOGS', 'Email Logs', '<p><strong>Email Logs</strong> in a <strong>Document management system</strong> help monitor and track all email communications sent through the system. This feature ensures transparency, enables debugging in case of errors, and provides a history of email activity for auditing purposes.</p><hr><h3><strong>Key Features of Email Logs</strong></h3><ol><li><p><strong>Basic Email Details</strong></p><ul><li><p><strong>Email ID</strong>: A unique identifier for each email sent.</p></li><li><p><strong>Timestamp</strong>: Date and time the email was sent.</p></li><li><p><strong>Sender Email Address</strong>: The email address from which the email was sent (e.g., <a href="mailto:support@yourbusiness.com">support@</a><a href="yourbusiness.com" target="_blank">yourbusiness.com</a>).</p></li><li><p><strong>Recipient Email Address</strong>: The email address of the recipient.</p></li></ul></li><li><p><strong>Email Content Details</strong></p><ul><li><p><strong>Subject</strong>: The subject line of the email.</p></li><li><p><strong>Body</strong>: A preview or complete content of the email.</p></li><li><p><strong>Attachments</strong>: Details of any files attached to the email (e.g., invoices, purchase orders).</p></li></ul></li><li><p><strong>Delivery Status</strong></p><ul><li><p><strong>Status</strong>: The status of the email (e.g., Sent, Failed, Queued, Delivered, Opened, Bounced).</p></li><li><p><strong>Error Details</strong>: If the email failed, the error message or code explaining why (e.g., invalid recipient address, server timeout).</p></li></ul></li></ol><hr><h3><strong>How to Implement Email Logs in a Document management System</strong></h3><ol><li><p><strong>Email Sending Service Integration</strong></p><ul><li><p>Integrate with an SMTP server, third-party email service (e.g., SendGrid, Mailgun), or a built-in email module.</p></li></ul></li><li><p><strong>Database for Logging</strong></p><ul><li><p>Store email logs in a dedicated database table with all relevant fields (email ID, recipient, status, etc.).</p></li></ul></li><li><p><strong>UI for Logs</strong></p><ul><li><p>Design a user-friendly interface to view, filter, and export email logs.</p></li></ul></li><li><p><strong>Error Handling</strong></p><ul><li><p>Implement robust error-catching mechanisms to record and display reasons for failures.</p></li></ul></li><li><p><strong>Automated Notifications</strong></p><ul><li><p>Set up automatic alerts for critical email delivery issues.</p></li></ul></li></ol><hr><p></p>'),
	('0cc83192-f05b-4c97-ab20-f7f3b5ba16d0', 'REMINDERS', 'Reminders', '<p>The <strong>"Reminders"</strong> page is the central hub for managing reminders within CMR DMS, where users can create, view, and manage reminders or notifications related to documents or other activities. Reminders can be set to repeat at regular intervals and can be associated with a specific document for efficient tracking of tasks and activities.</p><h3>Main components:</h3><ol><li><strong>"Add Reminder" Button</strong>:<ul><li>Allows users to create a new reminder.</li><li>Upon clicking, it opens a form where details such as subject, message, frequency, associated document, and reminder date can be entered.</li></ul></li><li><strong>Reminders Table</strong>:<ul><li>Displays all created reminders in a tabular format.</li><li>Each entry includes:<ul><li>Start date</li><li>End date</li><li>Reminder subject</li><li>Associated message</li><li>Recurrence frequency</li><li>Associated document (if applicable)</li></ul></li></ul></li></ol><h3>"Add Reminder" Form:</h3><p>When users click on the <strong>"Add Reminder"</strong> button, a form opens with the following fields:</p><ul><li><strong>Subject</strong>: The title or topic of the reminder (e.g., "Document Review").</li><li><strong>Message</strong>: Additional details about the reminder (e.g., "Review the document by X date").</li><li><strong>Repeat Reminder</strong>: Sets the recurrence frequency, with options such as:<ul><li>Daily</li><li>Weekly</li><li>Monthly</li><li>Semi-annually</li></ul></li><li><strong>Send Email</strong>: An option to send an email notification when the reminder is activated.</li><li><strong>Select Users</strong>: Allows selecting users to whom the reminder will be sent. It can be customized for specific teams or individuals.</li><li><strong>Reminder Date</strong>: The date and time when the reminder will be activated and sent.</li></ul><h3>How to add a new reminder:</h3><ol><li>Navigate to the <strong>"Reminders"</strong> page.</li><li>Click the <strong>"Add Reminder"</strong> button.</li><li>Fill in the form fields with the necessary information.</li><li>After entering all the details, click <strong>"Save"</strong> or <strong>"Add"</strong> to save the reminder in the system.</li></ol><h3>"Add Reminder" Functionality in the "Manage Reminders" section:</h3><p>This is the dedicated place for creating and managing notifications related to events or tasks. The <strong>"Add Reminder"</strong> functionality offers full customization, and reminders can be sent to selected users.</p><ul><li><strong>Subject</strong>: Enter a descriptive title for the reminder.</li><li><strong>Message</strong>: Add a clear and concise message to detail the purpose of the reminder.</li><li><strong>Repeat Reminder</strong>: Set whether the reminder will be repeated periodically (daily, weekly, etc.).</li><li><strong>Send Email</strong>: If this option is checked, the reminder will also be sent as an email.</li><li><strong>Select Users</strong>: Select users from the system\'s list to whom the reminder will be sent.</li><li><strong>Reminder Date</strong>: Set the date and time for the reminder to be triggered.</li></ul>'),
	('0d3afaea-1984-41f9-a826-fa5b0a9ccad3', 'BULK_DOCUMENT_UPLOADS', 'Document Bulk Upload', '<h3><strong>Bulk Document Uploads</strong></h3><p>Easily upload multiple documents to your system with the following steps:</p><p><strong>1.Category</strong></p><ul><li><strong>Select Category</strong>: Choose a category where your documents will be stored. This helps organize your uploads.</li></ul><p><strong>2.Document Status</strong></p><ul><li>Define the status of each document (e.g., Draft, Final, Archived). This ensures clarity and organization.</li></ul><p><strong>3.Storage</strong></p><ul><li>Select the storage location for your documents:<ul><li><strong>Local</strong>: Save documents to the local storage system.</li></ul></li></ul><p><strong>4.Assign By Roles</strong></p><ul><li><strong>5.Roles</strong>: Assign specific roles to the documents. For example: Manager, Editor, or Viewer.</li><li>This determines which roles have access to the uploaded documents.</li></ul><p><strong>6.Assign By Users</strong></p><ul><li><strong>7.Users</strong>: Assign individual users who can access these documents.</li><li>Select from a list of users in your system.</li></ul><p><strong>8.Document Upload</strong></p><ul><li>Select multiple files to upload from your device.</li><li>Ensure the file extensions are in the allowed list.</li><li>Optionally, rename files before uploading to keep them organized.</li></ul><p><strong>9.Finalize Upload</strong></p><ul><li>After filling out all the required fields, upload the documents.</li><li>The system will automatically assign the selected roles and users to each uploaded file.</li></ul>'),
	('0fae65e2-091d-469b-8a2a-9bb363ba8290', 'DOCUMENTS_AUDIT_TRAIL', 'Document audit history', '<p><strong>General Description:</strong></p><p>The "Document Audit History" page provides a detailed view of all actions performed on documents within the DMS. It allows administrators and users with appropriate permissions to monitor and review document-related activities, ensuring transparency and information security.</p><p><strong>Main Components:</strong></p><p><strong>Search Boxes:</strong></p><ul><li><strong>By Document Name:</strong> Allows users to search for a specific document by entering its name or other details.</li><li><strong>By Meta Tag:</strong> Users can enter meta tags to filter and search for specific document-related activities.</li><li><strong>By User:</strong> Enables filtering activities based on the user who performed the operation.</li></ul><p><strong>List of Audited Documents:</strong></p><p>Displays all actions taken on documents in a tabular format.</p><p>Each entry includes details of the action, such as the date, document name, Category, operation performed, who performed the operation, to which user, and to which role the operation was directed.</p><p>Users can click on an entry to view additional details or access the associated document.</p><p><strong>List Sorting:</strong></p><p>Users can sort the list by any of the available columns, such as "Date," "Name," "Category Name," "Operation," "Performed by," "Directed to User," and "Directed to Role."</p><p>This feature makes it easier to organize and analyze information based on specific criteria.</p><p><strong>How to Search the Audit History:</strong></p><ul><li>Enter your search criteria in the corresponding search box (document name, meta tag, or user).</li><li>The search results will be displayed in the audited documents list.</li></ul><p><strong>How to Sort the List:</strong></p><ul><li>Click on the column title by which you want to sort the list (e.g., "Date" or "Name").</li><li>The list will automatically reorder based on the selected criterion.</li></ul>'),
	('25ccccd4-bd60-4f8b-8bc1-c49eca98fb49', 'EMAIL_SMTP_SETTINGS', 'SMTP Email Settings', '<p>The <strong>"Email SMTP Settings"</strong> page within CMR DMS allows administrators to configure and manage the SMTP settings for sending emails. This ensures that emails sent from the system are correctly and efficiently delivered to recipients.</p><p><strong>Key Components:</strong></p><ul><li><p><strong>SMTP Settings Table:</strong> Displays all configured SMTP settings in a tabular format.</p><p>Each entry in the table includes details such as the username, host, port, and whether that configuration is set as the default.</p></li><li><p><strong>"Add Settings" Button:</strong> Allows administrators to add a new SMTP configuration.</p><p>Clicking the button opens a form where details like username, host, port, and the option to set it as the default configuration can be entered.</p></li></ul><p><strong>"Add Settings" Form:</strong></p><p>This form opens when administrators click the "Add Settings" button and includes the following fields:</p><ul><li><strong>Username:</strong> The username required for authentication on the SMTP server.</li><li><strong>Host:</strong> The SMTP server address.</li><li><strong>Port:</strong> The port on which the SMTP server listens.</li><li><strong>Is Default:</strong> A checkbox that allows setting this configuration as the default for sending emails.</li></ul><p><strong>How to Add a New SMTP Configuration:</strong></p><ol><li>Click the "Add Settings" button.</li><li>The "Add Settings" form will open, where you can enter the SMTP configuration details.</li><li>Fill in the necessary fields and select the desired options.</li><li>After completing the details, click "Save" or "Add" to add the configuration to the system.</li></ol>'),
	('2b728c10-c0b3-451e-8d08-2be1e3f6d5b3', 'USERS', 'Users', '<p><strong>The "Users" page is the central hub for managing all registered users in CMR DMS. Here, administrators can add, edit, or delete users, as well as manage permissions and reset passwords. Each user has associated details such as first name, last name, mobile phone number, and email address.</strong></p><p><strong>Main Components:</strong></p><ul><li><p><strong>"Add User" Button:</strong> Allows administrators to create a new user in the system.</p><p>Opens a form where details such as first name, last name, mobile phone number, email address, password, and password confirmation can be entered.</p></li><li><p><strong>List of Existing Users:</strong> Displays all registered users in the system in a tabular format.</p><p>Each entry includes the userâ€™s email address, first name, last name, and mobile phone number.</p><p>Next to each user, there is an action menu represented by three vertical dots.</p></li><li><p><strong>Action Menu for Each User:</strong> This menu opens by clicking on the three vertical dots next to each user.</p><p>Includes the options:</p><ul><li><strong>Edit:</strong> Allows modification of the userâ€™s details.</li><li><strong>Delete:</strong> Removes the user from the system. This action may require confirmation to prevent accidental deletions.</li><li><strong>Permissions:</strong> Opens a window or form where administrators can set or modify the userâ€™s permissions.</li><li><strong>Reset Password:</strong> Allows administrators to initiate a password reset process for the selected user.</li></ul></li></ul><p><strong>How to Add a New User:</strong></p><ol><li>Click on the "Add User" button.</li><li>A form will open where you can enter the userâ€™s details: first name, last name, mobile phone number, email address, password, and password confirmation.</li><li>After completing the details, click "Save" or "Add" to add the user to the system.</li></ol>'),
	('2dd28c72-3ed4-4f75-b23b-63cadcaa3982', 'ALL_DOCUMENTS', 'All Documents', '<p>The <strong>"All Documents"</strong> page provides a complete overview of all documents uploaded in the DMS. It is the ideal place to search, view, manage, and distribute all available documents in the system.</p><p><strong>Main Components:</strong></p><ul><li><strong>"Add Document" Button:</strong> Allows any user with appropriate permissions to upload a new document into the system.<ul><li>Opens a form or a pop-up window where files can be selected and uploaded.</li></ul></li><li><strong>Search Box (by name):</strong> Allows users to search for a specific document by entering its name or other details.</li><li><strong>Search Box (by meta tags):</strong> Users can enter Meta tags to filter and search for specific documents.</li><li><strong>Category Dropdown:</strong> A dropdown menu that allows users to filter documents by Category.</li><li><strong>Storage Dropdown: </strong>The application lets users store documents in various storage options, such as AWS S3 and local storage. Users can easily search for documents by selecting the desired storage option from a dropdown menu.</li><li><strong>Search Box (by creation date):</strong> Allows users to search for documents based on their creation date.</li><li><strong>List of All Uploaded Files:</strong> Displays all documents available in the system.<ul><li>Each entry includes document details such as name, creation date, Category, status and storage.</li></ul></li><li><strong>Document Actions Menu:</strong> Alongside each document in the list, users will find an actions menu allowing them to perform various operations on the document:<ul><li><strong>Edit:</strong> Modify the document details, such as its name or description.</li><li><strong>Share:</strong> Share the document with other users or roles within the system.</li><li><strong>Get Shareable Link:</strong> Users can generate a shareable link to allow anonymous users to access documents. They can also protect the link with a password and set an expiration period, ensuring the link remains active only for the selected duration. Additionally, the link includes an option for recipients to download the shared document.</li><li><strong>View:</strong> Open the document for viewing.</li><li><strong>Upload a New Version:</strong> Add a new version of the document.</li><li><strong>Version History:</strong> Users can view all previous versions of a document, with the ability to restore any earlier version as needed. Each version can also be downloaded for offline access or review.</li><li><strong>Comment:</strong> Add or view comments on the document.</li><li><strong>Add Reminder:</strong> Set a reminder for the document.</li><li><strong>Send as Email:</strong> Send the document as an attachment via email.</li><li><strong>Delete:</strong> Remove the document from the system.</li></ul></li></ul><p><strong>Document Sharing:</strong></p><p>Users can select one, multiple, or all documents from the list and use the sharing option to distribute the selected documents to other users. This feature facilitates the mass distribution of documents to specific users or groups.</p>'),
	('350137e8-91d3-4e53-a621-1fae3fb680eb', 'FILE_REQUEST_UPLOADED_DOCUMENTS', 'File Request Documents', '<h2>File Request Uploaded Documents</h2><p>The <strong>File Request Uploaded Documents</strong> feature allows you to manage the documents submitted through your file request link. You can review, approve, or reject uploaded files and provide feedback or reasons for rejection.</p><h2>Key Features:</h2><p><strong>1.View Uploaded Documents</strong>:</p><ul><li>Access all documents submitted via the file request link.</li><li>See details such as:<ul><li>File Name</li><li>Upload Date</li><li>Document Status</li><li>Reason</li></ul></li></ul><p><strong>2.Approve Documents</strong>:</p><ul><li>Mark documents as <strong>Approved</strong> if they meet your requirements.</li><li>Approved documents will be saved and marked as finalized.</li></ul><p><strong>3.Reject Documents</strong>:</p><ul><li>Reject documents that do not meet the criteria or need corrections.</li><li>When rejecting a document:<ul><li>Add a <strong>Comment</strong> to explain the reason for rejection.</li><li>This ensures users understand what needs to be corrected or resubmitted.</li></ul></li></ul><p><strong>4.Document Preview</strong>:</p><ul><li>View uploaded documents directly before approving or rejecting them.</li><li>Supports previewing common file types such as PDF, DOCX, JPG, and PNG.</li></ul><p><strong>5.Status Tracking</strong>:</p><ul><li>Each document will have a status indicator:<ul><li><strong>Pending</strong>: Awaiting review.</li><li><strong>Approved</strong>: Accepted and finalized.</li><li><strong>Rejected</strong>: Requires resubmission with a reason provided.</li></ul></li></ul><h2>How It Works:</h2><h3>1. Viewing Uploaded Documents:</h3><ul><li>Go to the <strong>File Request Uploaded Documents</strong> page.</li><li>Select the relevant file request from the list.</li><li>All submitted documents for that request will be displayed.</li></ul><h3>2. Approving Documents:</h3><ul><li>Click on the document you want to approve.</li><li>Review the document using the preview feature.</li><li>If the document meets your requirements, click <strong>Approve</strong>.</li><li>The status will change to <strong>Approved</strong>.</li></ul><h3>3. Rejecting Documents:</h3><ul><li>Click on the document you want to reject.</li><li>Use the preview feature to review the document.</li><li>If the document does not meet the requirements:<ul><li>Click <strong>Reject</strong>.</li><li>Enter a <strong>Reason for Rejection</strong> in the comment box (e.g., Incorrect file format or Incomplete information).</li><li>Save the rejection and notify the user to resubmit.</li></ul></li></ul><h3>4. Adding Comments for Rejected Documents:</h3><ul><li>When rejecting a document, always provide a clear and actionable comment.</li><li>Examples of comments:<ul><li>Please upload a file in PDF format.</li><li>The document is missing required signatures.</li><li>File size exceeds the maximum limit; please compress and reupload.</li></ul></li></ul><h2>Benefits:</h2><ul><li><strong>Efficient Review</strong>: Quickly review and take action on uploaded documents.</li><li><strong>Clear Communication</strong>: Provide feedback for rejected documents, ensuring users know what to fix.</li><li><strong>Organized Workflow</strong>: Keep track of document statuses with easy-to-use status indicators.</li></ul><p>This feature ensures a smooth and transparent document review process for both you and the users.</p>'),
	('38f34f2a-2107-447a-b254-ae9fc8abd819', 'CRON_JOB_LOGS', 'Cron Job Logs', '<h2>ðŸ“‹ <strong>Cron Job Logs â€“ User Guide</strong></h2><p>The <strong>Cron Job Logs</strong> page provides a detailed overview of all automated background tasks scheduled and executed by the system. These tasks help maintain, notify, and manage document workflows, reminders, and data retention policies without manual effort. This guide explains each job and its purpose to help users understand the systemâ€™s automation process.</p><h3>ðŸ”„ <strong>List of Scheduled Cron Jobs</strong></h3><h4>ðŸ“… <strong>Custom Date Reminder</strong></h4><p>Sends reminders based on user-defined custom dates set for documents or events. Ideal for special dates that donâ€™t follow standard reminder frequencies.</p><h4>ðŸ—“ï¸ <strong>Daily Notification Handler</strong></h4><p>Processes and sends out daily notifications to users, keeping them informed about document activities, pending actions, or scheduled events.</p><h4>ðŸ§¹ <strong>Delete Archive Document By Retention Date</strong></h4><p>Automatically deletes archived documents that have exceeded their configured retention period to comply with data retention policies.</p><h4>ðŸ§¾ <strong>Delete Email, Audit and Cron Job Logs</strong></h4><p>Cleans up old logs including email history, audit trails, and cron job executions after a defined period to ensure system performance and storage optimization.</p><h4>ðŸ—ƒï¸ <strong>Delete or Archive or Expire Document By Retention Date</strong></h4><p>Manages documents based on their retention configurationâ€”automatically <strong>deleting</strong>, <strong>archiving</strong>, or <strong>expiring</strong> them as per rules defined in the retention settings.</p><h4>ðŸ“† <strong>Half Yearly Reminder</strong></h4><p>Sends notifications every six months to remind users of document reviews, renewals, or other periodic tasks.</p><h4>ðŸ“… <strong>Monthly Reminder</strong></h4><p>Sends monthly email reminders to assigned users or groups to take action on documents that require periodic attention.</p><h4>ðŸ—“ï¸ <strong>Quarterly Reminder</strong></h4><p>Triggers every three months to notify users of scheduled document-related tasks or to prompt reviews.</p><h4>ðŸ›Žï¸ <strong>Notification Scheduler</strong></h4><p>Central handler that coordinates all scheduled notifications (daily, weekly, etc.) to ensure they are sent at the right time with the right content.</p><h4>ðŸ“¤ <strong>Send Email</strong></h4><p>Responsible for sending emails queued by other jobs (like reminders or notifications). Ensures reliable and trackable delivery of communication from the system.</p><h4>ðŸ“† <strong>Weekly Reminder</strong></h4><p>Sends weekly emails about document actions, expiring records, or general reminders to keep users updated.</p><h4>ðŸ—“ï¸ <strong>Yearly Reminder</strong></h4><p>Annual notifications for documents that require yearly reviews, renewals, or actionsâ€”commonly used for compliance or regulatory tasks.</p><h3>âœ… <strong>Usage Tips</strong></h3><ul><li><strong>Monitor Execution</strong>: Check if each cron job is executing successfully or failing. Failures may require admin attention.</li><li><strong>Filter Logs</strong>: Use available filters to find logs by job name, status, or date.</li><li><strong>Audit Trail</strong>: This page acts as an audit trail for system automationâ€”valuable for compliance reviews and troubleshooting.</li><li><strong>Retention Settings</strong>: Ensure retention rules are properly configured, as they directly influence deletion and archival jobs.</li></ul>'),
	('3e0fe36d-cde5-4bd9-b65d-cfaeadcffce3', 'COMPANY_PROFILE', 'Company Profile', '<p>Hereâ€™s a detailed description of the functionality for managing the company profile, focusing on the company name, logo, and banner logo on the login screen.</p><h3>Â </h3><h4>Overview</h4><p>The Company Profile feature allows users to customize the branding of the application by entering the company name and uploading logos. This customization will reflect on the login screen, enhancing the professional appearance and brand identity of the application.</p><h4>Features</h4><ol><li><h4><strong>Company Name</strong></h4><ul><li><strong>Input Field:</strong><ul><li>Users can enter the name of the company in a text input field.</li><li><strong>Validation:</strong><ul><li>The field will have validation to ensure the name is not empty and meets any specified length requirements (e.g., minimum 2 characters, maximum 50 characters).</li><li><strong>Browser Title Setting:</strong></li><li>Upon saving the company name, the application will dynamically set the browser title to match the company name, improving brand visibility in browser tabs.</li></ul></li></ul></li></ul></li><li><h4><strong>logo Upload</strong></h4><ul><li><strong>Upload Button:</strong><ul><li>Users can upload a company logo that will be displayed in the header of the login page.</li><li><strong>File Requirements:</strong><ul><li>Supported file formats: PNG, JPG, JPEG (with size limits, e.g., up to 2 MB).</li><li>Recommended dimensions for optimal display (e.g., width: 200px, height: 100px).</li></ul></li></ul></li><li><strong>Preview:</strong><ul><li>After uploading, a preview of the logo will be displayed to confirm the upload.</li></ul></li></ul></li><li><h4><strong>Banner logo Upload</strong></h4><ul><li><strong>Upload Button:</strong><ul><li>Users can upload a banner logo that will appear prominently on the login screen.</li><li><strong>File Requirements:</strong><ul><li>Supported file formats: PNG, JPG, JPEG (with size limits, e.g., up to 3 MB).</li><li>Recommended dimensions for optimal display (e.g., width: 1200px, height: 300px).</li></ul></li></ul></li><li><strong>Preview:</strong><ul><li>A preview of the banner logo will be displayed after the upload for confirmation.</li></ul></li></ul></li><li><h4><strong>User Interaction Flow</strong></h4><ul><li><h4><strong>Navigating to the Company Profile:</strong></h4><ul><li>Users can access the company profile settings from the applicationâ€™s settings menu or administration panel.</li></ul></li><li><strong>Editing Company Profile:</strong><ul><li>Users enter the company name, upload the logo, and the banner logo.</li><li>A "Save Changes" button will be available to apply the modifications.</li></ul></li><li><strong>Saving Changes:</strong><ul><li>Upon clicking "Save Changes," the uploaded logos and company name will be saved and reflected on the login screen.</li><li>Confirmation messages will be displayed to indicate successful updates.</li></ul></li></ul></li><li><strong>Display on Login Screen</strong><ul><li><strong>Header Display:</strong><ul><li>The company logo will be displayed in the header at the top of the login page, maintaining a consistent branding experience.</li></ul></li><li><strong>Banner Display:</strong><ul><li>The banner logo will be displayed prominently below the header, enhancing the visual appeal of the login interface.</li></ul></li></ul></li></ol><h3>Summary</h3><p>The Company Profile functionality allows for a customizable branding experience, enabling users to set their company name and logos that will be visible on the login screen. This feature enhances user engagement and presents a professional image right from the login phase of the application.</p>'),
	('45c53b1a-a865-4c22-b56a-9f5e6cf83528', 'CLIENTS', 'Clients', '<p>The <strong>Clients</strong> section helps you manage and view all your clients in one place. Hereâ€™s what you can do:</p><p><strong>1.Clients List</strong></p><ul><li>A list of all your clients is displayed with the following details:</li></ul><p><strong>Action</strong>: Options to edit or delete client information.</p><p><strong>Company/Person Name</strong>: The name of the company or individual client.</p><p><strong>Contact Person</strong>: The primary contact person for the client.</p><p><strong>Email</strong>: The email address of the client for communication.</p><p><strong>Mobile Number</strong>: The mobile number of the client for easy contact.</p><p><strong>2.Add Client</strong></p><ul><li>Click the <strong>Add Client</strong> button to create a new client.</li><li>Fill in details like the company or person name, contact person, email, and mobile number.</li><li>Save the new client, and it will be added to the clients list.</li></ul>'),
	('4792e9a6-10f0-4a5a-9294-1eb4d663d72f', 'ARCHIVED_DOCUMENTS', 'Archived Documents', 'The Archived Documents feature allows users to securely store and organize documents that are no longer actively used but need to be retained for future reference or compliance purposes. Archiving helps declutter the active workspace by moving older documents to a dedicated archive, while still keeping them easily accessible when needed.'),
	('49612137-bc17-4b60-b905-3c48734500bd', 'AI_DOCUMENT_GENERATOR', 'AI Document Generator', '<h2>ðŸ§  Using the AI Document Generator</h2><h3>Step-by-Step Instructions</h3><h4>ðŸ–Šï¸ 1. <strong>Enter a Prompt</strong></h4><p>Navigate to the section where document creation is available. You will see a prompt input field labeled <strong>"Generate with AI"</strong> or similar.</p><blockquote><p>Example Prompt:<br>â€œWrite a GDPR privacy policy for a small e-commerce company.â€</p></blockquote><h4>â–¶ï¸ 2. <strong>Click â€˜Generateâ€™</strong></h4><p>Click the <strong>"Generate"</strong> or <strong>"Submit"</strong> button next to the prompt box. This sends your request to the backend, which calls OpenAI.</p><h4>ðŸ”„ 3. <strong>Real-Time Streaming</strong></h4><p>Youâ€™ll begin to see content populate inside the rich text editor <strong>(CKEditor)</strong> live â€” no need to refresh or wait for a full response. The AI streams back sentences as it composes.</p><blockquote><p>ðŸ’¡ This process typically starts in 1â€“2 seconds and streams text smoothly in real-time.</p></blockquote><h4>âœï¸ 4. <strong>Edit the Content</strong></h4><p>Once the document is generated, you can:</p><ul><li>Edit directly inside the CKEditor</li><li>Apply formatting (headings, lists, links, etc.)</li><li>Save the document into the system or export as needed</li></ul><h2>ðŸ§° Advanced Features</h2><ul><li>âœ… <strong>Real-Time Streaming</strong>: Watch content appear as itâ€™s generated.</li><li>ðŸ”’ <strong>Secure Access</strong>: Only authenticated users can access the API using Bearer tokens.</li><li>ðŸ’¾ <strong>Auto Save</strong>: Generated content is automatically stored along with the original prompt.</li><li>ðŸ“ <strong>Markdown to HTML</strong>: The system parses markdown and renders it as rich text in the editor.</li></ul><h2>â— Common Issues &amp; Troubleshooting</h2><figure class="table"><table><thead><tr><th>Issue</th><th>Cause</th><th>Solution</th></tr></thead><tbody><tr><td>âš ï¸ Nothing is generated</td><td>Blank prompt or network error</td><td>Make sure you entered a valid prompt and are connected to the internet</td></tr><tr><td>ðŸ”’ 419 Error</td><td>Missing CSRF token or unauthorized call</td><td>Ensure you\'re logged in and the request includes a valid Bearer token</td></tr><tr><td>âŒ API Failed</td><td>OpenAI error or rate limit</td><td>Try again in a few minutes or check logs for API key issues</td></tr></tbody></table></figure><h2>ðŸ“ˆ Best Practices</h2><ul><li>Use clear and specific prompts to get better results.</li><li>Include document type or target audience in your prompt.<ul><li>âœ… â€œCreate an employee NDA agreement for a startup in plain language.â€</li></ul></li><li>Edit the AI-generated content before final submission for accuracy.</li></ul><h2>ðŸ›¡ï¸ Security Notes</h2><ul><li>Your prompt and result are stored securely in the system.</li><li>OpenAI credentials are never exposed to the client.</li><li>Only authenticated users can trigger the AI generation feature.</li></ul><h2>ðŸ“ž Need Help?</h2><p>If you encounter issues:</p><ul><li>Contact Support via the Help Center</li><li>Check your browser console (F12) for error messages</li><li>Ensure your token is active and valid</li></ul><p>Would you like this delivered as a downloadable <strong>PDF</strong> or <strong>Markdown</strong> file for sharing? I can generate one for you right away.</p>'),
	('509dfdb8-8e5c-4370-8427-f6a9c2c78007', 'ROLE_USER', 'Role users', '<p><strong>The "User with Role" page is dedicated to assigning specific roles to users within the DMS. It allows administrators to associate users with particular roles using an intuitive "drag and drop" system. Users can be moved from the general user list to the "Users with Role" list, thereby assigning them the selected role.</strong></p><h3><strong>Main Components:</strong></h3><ul><li><strong>Title "User with Role":</strong> Indicates the purpose and functionality of the page.</li><li><strong>Department:</strong> Displays the currently selected department, in this case, "Approvals."<ul><li>There may be an option to change the department if needed.</li></ul></li><li><strong>Select Role:</strong> A dropdown menu or selection box where administrators can choose the role they wish to assign to users.<ul><li>Once a role is selected, users can be moved into the "Users with Role" list to assign them that role.</li></ul></li><li><strong>Note:</strong> A short instruction explaining how to use the page, indicating that users can be moved from the "All Users" list to the "Users with Role" list to assign them a role.</li><li><strong>"All Users" and "Users with Role" Lists:</strong><ul><li><strong>"All Users":</strong> Displays a complete list of all registered users in the CMR DMS.</li><li><strong>"Users with Role":</strong> Displays the users who have been assigned the selected role.</li><li>Users can be moved between these lists using the "drag and drop" functionality.</li></ul></li></ul><h3><strong>How to Assign a Role to a User:</strong></h3><ol><li>Select the desired role from the "Select Role" box.</li><li>Locate the desired user in the "All Users" list.</li><li>Using the mouse or a touch device, drag the user from the "All Users" list and drop them into the "Users with Role" list.</li><li>The selected user will now be associated with the chosen role and will appear in the "Users with Role" list.</li></ol>'),
	('5475c0fb-5a9e-44e1-b628-6757d6865d2a', 'MANAGE_ALLOW_FILE_EXTENSION', 'Manage File Extensions', '<p><strong>Manage Allowed File Extensions</strong></p><p>This functionality allows users to control which file types are permitted for upload in the application. Users can easily configure allowed file extensions by selecting the desired file types and specifying their extensions in a provided configuration interface. Here\'s how it works:</p><ol><li><strong>Select File Types</strong>: Users can choose from a predefined list of file types (e.g., images, documents, videos) or manually add custom types.</li><li><strong>Add Extensions</strong>: For each file type, users can specify the associated file extensions (e.g., .jpg, .pdf, .mp4).</li><li><strong>Apply Changes</strong>: Once configured, the application will enforce these rules, ensuring only the specified file types can be uploaded.</li><li><strong>Easy Management</strong>: Users can modify, add, or remove allowed extensions anytime, making the system flexible and easy to update.</li></ol><p>This functionality simplifies file type management and ensures compliance with application requirements or security policies.</p>'),
	('5c66b992-8ec0-4d61-ab1e-1f5d40186403', 'DEEP_SEARCH', 'Deep Search', '<p>The <strong>Deep Search</strong> feature in the document management system enables users to perform powerful searches within the content of various file formats such as PDFs, Word documents, text files, and Excel spreadsheets.</p><p>Key functionalities include:</p><p>- <strong>Content-Based Search</strong>: The system scans the actual content within supported file formats (PDF, Word, Text, Excel), allowing users to search for keywords, phrases, or data inside the documents, not just file names or metadata.<br>&nbsp;<br>- <strong>Multi-Format Support</strong>: Deep search works seamlessly across different file formats, ensuring users can locate relevant information regardless of the document type.<br>&nbsp;<br>- <strong>Top 10 Search Results</strong>: The search returns the most relevant top 10 results based on the query, helping users quickly access the most pertinent documents or information.<br>&nbsp;<br>- <strong>Fast and Efficient</strong>: Optimized for speed, the deep search functionality delivers results promptly, even when searching across large document libraries.</p><p>This feature enhances productivity by allowing users to find specific content within documents, saving time and improving access to critical information.</p><p><strong>Note:</strong></p><p>You will receive up to 10 results for each search. The search is not case-sensitive, so searching for "Report" and "report" will return the same results. Common words like "and,""the," and "is" are ignored to improve search efficiency. The search also matches variations of words, so searching for "run" will include results for "running" and "runs." Supported file types include Word documents, PDFs, Notepad files, and Excel spreadsheets.</p>'),
	('5d15d912-674b-47af-ade8-35013e4c95c4', 'DOCUMENT_COMMENTS', 'Comments', '<ul><li><strong>Allows users to add comments to the document.</strong></li><li>Other users can view and respond to comments, facilitating discussion and collaboration on the document.</li></ul>'),
	('5d7ba1b1-a380-4e4d-8cb0-56159a6ee0d3', 'ASSIGNED_DOCUMENTS', 'Assigned documents', '<p>The <strong>"Assigned Documents"</strong> page is the central hub for managing documents allocated to a specific user. Here, users can view all the documents assigned to them, search for specific documents, and perform various actions on each document.</p><h3>Main Components:</h3><ul><li><strong>"Add Document" Button</strong>: Allows users to upload a new document to the system.<ul><li>Opens a form or pop-up window where files can be selected and uploaded.</li></ul></li><li><strong>My Reminders</strong>: Displays a list of all the reminders set by the user.<ul><li>Users can view, edit, or delete reminders.</li></ul></li><li><strong>Search Box (by name or document)</strong>: Allows users to search for a specific document by entering its name or other document details.</li><li><strong>Search Box (by meta tags)</strong>: Users can enter meta tags to filter and search for specific documents.</li><li><strong>Category Selection Dropdown</strong>: A dropdown menu that allows users to filter documents based on their Category.</li><li><strong>Status Selection Dropdown</strong>: A dropdown menu that allows users to filter documents based on their status.</li><li><strong>List of files allocated to the user</strong>: Displays the documents assigned to the user in allocation order.<ul><li>Each entry includes columns for "Action," "Name," "Status," "Category Name," "Creation Date," "Expiration Date," and "Created By."</li></ul></li><li>Next to each document, there is a menu with options such as "edit," "share," "view," "upload a version," "version history," "comment," and "add reminder."</li></ul><h3>How to Add a New Document:</h3><ol><li>Click the <strong>"Add Document"</strong> button.</li><li>A form or pop-up window will open.</li><li>Select and upload the desired file, then fill in the necessary details.</li><li>Click <strong>"Save"</strong> or <strong>"Add"</strong> to upload the document to the system.</li></ol><h3>How to Search for a Document:</h3><ol><li>Enter the document\'s name or details in the appropriate search box.</li><li>The search results will be displayed in the document list.</li></ol><h3>How to Perform Actions on a Document:</h3><p><strong>Document Action Menu Overview</strong>:<br>The action menu offers users various options for managing and interacting with the assigned documents. Each action is designed to provide specific functionalities, allowing users to work efficiently with their documents.</p><h4>Available Options:</h4><ul><li><strong>Edit</strong>: Allows users to modify the document\'s details, such as its name, description, or meta tags.<ul><li>After making changes, users can save the updates.</li></ul></li><li><strong>Share</strong>: Provides the option to share the document with other users or roles in the system.<ul><li>Users can set specific permissions, such as view or edit, for those with whom the document is shared.</li></ul></li><li><strong>View</strong>: Opens the document in a new window or an embedded viewer, allowing users to view the document\'s content without downloading it.</li><li><strong>Upload a Version</strong>: Allows users to upload an updated version of the document.<ul><li>The original document remains in the system, and the new version is added as an update.</li></ul></li><li><strong>Version History</strong>: Displays all previous versions of the document.<ul><li>Users can view, or download any of the previous versions if the administrator allows the user to download document permission.</li></ul></li><li><strong>Comment</strong>: Allows users to add comments to the document.<ul><li>Other users can view and respond to comments, facilitating discussion and collaboration on the document.</li></ul></li><li><strong>Add Reminder</strong>: Sets a reminder for an event or action related to the document.<ul><li>Users can receive notifications or emails when the reminder date approaches.</li></ul></li></ul>'),
	('5d858491-f9db-4aef-959f-5af9d7f3b7bd', 'MANAGE_ROLE', 'Manage Role', '<ul><li>Allows administrators or users with appropriate permissions to create a new role in the system.</li><li>Opens a form or a pop-up window where permissions and role details can be defined.</li><li>Enter the role name and select the appropriate permissions from the available list.</li><li>Click <strong>"Save"</strong> or <strong>"Add"</strong> to add the role to the system with the specified permissions.</li></ul><p>Â </p><p><br>Â </p>'),
	('6333e858-a474-479d-92e1-bcd0f3f3def7', 'WATERMARK_DOCUMENT', 'Add Watermark', '<h2><strong>Document Watermark</strong></h2><p>The Document Watermark feature allows users to protect and brand their documents by automatically applying text-based watermarks to PDF files. This ensures content security, prevents unauthorized use, and maintains a clear document history with versioning and audit tracking.</p><h2><strong>How It Works</strong></h2><h3><strong>1. Adding a Watermark</strong></h3><p>Users can open any document and click on the <strong>"Add Watermark"</strong> option.</p><p>A popup window appears, allowing the user to:</p><ul><li>Enter the desired watermark text (e.g., <i>â€œConfidentialâ€</i>, <i>â€œDraftâ€</i>, <i>â€œApproved by John Doeâ€</i>, etc.).</li></ul><h3><strong>2. Automatic PDF Processing</strong></h3><p>Once the user confirms:</p><ul><li>The system automatically applies the watermark to the PDF file.</li><li>The watermark appears diagonally or in the chosen position across all pages.</li><li>A <strong>new version</strong> of the document is generated with the applied watermark.</li></ul><h3><strong>3. Audit &amp; Version Control</strong></h3><p>Every watermark action is logged in the system:</p><ul><li>Who added the watermark</li><li>The watermark text used</li><li>Date and time of the action</li><li>Version created after watermarking</li></ul><p>This ensures full traceability and compliance for document workflows.</p><h2><strong>Key Features</strong></h2><h3><strong>Easy and Intuitive</strong></h3><p>The popup interface makes it simple for users to enter watermark text and preview watermark options.</p><h3><strong>Automatic Placement</strong></h3><p>The system positions the watermark professionally across the PDF without requiring manual alignment.</p><h3><strong>Versioning Support</strong></h3><p>Each watermarked PDF is stored as a new version of the document, preserving the original and maintaining a history of all updates.</p><h3><strong>Audit Trail</strong></h3><p>Detailed logs capture all watermark activities for transparency and compliance.</p><h3><strong>Branding &amp; Security</strong></h3><p>Watermarks help prevent unauthorized distribution and clearly identify a documentâ€™s status or ownership.</p><h2><strong>Benefits</strong></h2><h3><strong>Improved Document Security</strong></h3><p>Watermarks discourage misuse, copying, and sharing of sensitive documents.</p><h3><strong>Professional Output</strong></h3><p>Automatically formatted watermarks make documents look clean, consistent, and ready for internal or external use.</p><h3><strong>Clear Document History</strong></h3><p>Versioning and audit logs ensure teams always know <strong>what was changed</strong>, <strong>when</strong>, and <strong>by whom</strong>.</p>'),
	('647244ec-b5b2-4fbf-9c93-6133cb252a40', 'MANAGE_CLIENT', 'Manage Client', '<p>The <strong>Manage Client</strong> feature makes it easy to add new clients or edit existing client details. Hereâ€™s how you can use it:</p><h4><strong>Add New Client</strong></h4><p>1.Click the <strong>Add Client</strong> button.</p><p>2.A form will appear where you can enter the following details:</p><p><strong>Company/Person Name</strong>: Enter the name of the company or individual client.</p><p><strong>Contact Person</strong>: Provide the name of the main contact person.</p><p><strong>Email</strong>: Enter the clientâ€™s email address.</p><p><strong>Mobile Number</strong>: Add the clientâ€™s mobile number for quick contact.</p><p>3.Once all the details are filled in, click the <strong>Save</strong> button to add the new client to the list.</p><p>4.The newly added client will now appear in the <strong>Clients List</strong>.</p><h4><strong>Edit Existing Client</strong></h4><p>1.In the <strong>Clients List</strong>, locate the client whose details you want to edit.</p><p>2.Click the <strong>Edit</strong> button in the <strong>Action</strong> column.</p><p>3.A form will open, pre-filled with the clientâ€™s existing details.</p><p>4.Update any necessary fields, such as:</p><p>Correcting the email address or phone number.</p><p>Changing the contact person or company name.</p><p>5.After making the changes, click the <strong>Save</strong> button to update the clientâ€™s information.</p><p>6.The changes will reflect immediately in the <strong>Clients List</strong>.</p>'),
	('647f1663-df23-45b0-872e-f6da5b609abb', 'LANGUAGES', 'Languages', '<p>The <strong>Multiple Language Support</strong> feature in the document management system enables users to interact with the platform and manage documents in various languages, providing flexibility for global teams or multilingual users.</p><p>Key functionalities include:</p><p>- <strong>Multi-Language Interface</strong>: The systemâ€™s interface can be viewed and navigated in multiple languages, ensuring ease of use for users across different regions.<br>&nbsp;<br>- <strong>Add New Languages</strong> Administrators have the ability to easily add support for additional languages, expanding the system\'s accessibility to more users worldwide.<br>&nbsp;<br>- <strong>Update Existing Languages</strong>: Existing language options can be updated to reflect changes in translations, regional language standards, or preferences, ensuring that the system stays relevant and user-friendly in all supported languages.<br>&nbsp;<br>- <strong>Delete Unused Languages</strong>: Administrators can remove language options that are no longer needed, streamlining the user interface and preventing unnecessary clutter.</p><p>This feature ensures the document management system can cater to a diverse, global audience while providing the flexibility to manage language options as needed.</p>'),
	('66e6f68d-d051-4cc1-9b26-e3fcac4d6e6b', 'WORKFLOW_LOGS', 'Workflow Logs', '<ul><li><h3>Workflow List Page Overview</h3></li><li>The <strong>Workflow List Page</strong> provides a complete overview of all workflows, displaying their statuses and details to help users manage and monitor workflows effectively. It combines visual graphs and detailed information to ensure clarity and usability.</li><li><h4><strong>Key Features</strong></h4></li><li><strong>Comprehensive Workflow Display</strong>:<ul><li>All workflows are listed on this page, categorized by their statuses:<ul><li><strong>Completed</strong>: Workflows that have been fully executed.</li><li><strong>Initiated</strong>: Newly started workflows awaiting progress.</li><li><strong>In Progress</strong>: Ongoing workflows with steps and transitions in process.</li><li><strong>Cancelled</strong>: Workflows that were terminated before completion.</li></ul></li></ul></li><li><strong>Workflow Details in Graphical View</strong>:<ul><li>Workflows are visually represented using graphs, showcasing:<ul><li>The structure of steps and transitions.</li><li><strong>Completed Transitions</strong>: Clearly highlighted.</li><li><strong>Pending Transitions</strong>: Distinctly marked.</li></ul></li><li>This graphical format allows users to quickly understand the workflowâ€™s progress and flow.</li></ul></li><li><strong>Workflow Information Table</strong>:<ul><li>Each workflow is accompanied by a table containing detailed information:<ul><li><strong>Workflow Name</strong>: Unique name of the workflow.</li><li><strong>Workflow Status</strong>: Current status of the workflow (Completed, Initiated, In Progress, Cancelled).</li><li><strong>Initiated By</strong>: The user who initiated the workflow.</li><li><strong>Document Name</strong>: The associated document, if applicable.</li><li><strong>Workflow Step</strong>: The current step(s) in the workflow.</li><li><strong>Workflow Step Status</strong>: Status of each step (Completed, Pending).</li><li><strong>Performed By</strong>: The user or team responsible for a specific step.</li><li><strong>Transition Status</strong>: Indicates the progress of transitions (Completed or Pending).</li></ul></li></ul></li><li><strong>Interactive Details</strong>:<ul><li>Users can click on workflow steps or transitions in the graph or table to access:<ul><li>Detailed descriptions.</li><li>Status history.</li><li>Timestamps and related actions.</li></ul></li></ul></li><li><h3>Benefits</h3></li><li>The <strong>Workflow List Page</strong> provides a holistic view of all workflows, their statuses, and detailed progress information. This ensures users can:</li><li>Track and manage all workflows efficiently.</li><li>Monitor progress visually and in detail.</li><li>Quickly identify completed, pending, or cancelled workflows.</li><li>This page is an essential tool for streamlining workflow operations and ensuring process transparency.</li></ul>'),
	('762a5894-0c49-48d8-9e0c-e5062a4c3322', 'SEND_EMAIL', 'Send mail', '<ul><li><strong>How to Send a Document as an Email Attachment:</strong></li><li><strong>Select the email field</strong>: Navigate to the section where you can compose an email and select the field for entering the recipient\'s email address.</li><li><strong>Enter the email address</strong>: Type the recipient\'s email address in the provided field.</li><li><strong>Subject field</strong>: Enter a relevant subject for your email.</li><li><strong>Email content</strong>: Write the body of your email, providing any necessary context or information.</li><li><strong>Attach the document</strong>: Find the option to "Attach" or "Upload" a document, then select the file you wish to send.</li><li><strong>Send the email</strong>: After attaching the document and ensuring the recipient, subject, and content are correct, click the "Send" button to deliver the email with the attached document.</li></ul>'),
	('8c1e5b05-0d7e-45cc-973d-423b2e10c5fd', 'SHARE_DOCUMENT', 'Share Document', '<h4>Overview</h4><p>The <strong>Share Document</strong> feature allows users to assign access permissions to specific documents for individual users or user roles, with the ability to manage these permissions effectively. Users can also remove existing permissions, enhancing collaboration and control over document access.</p><h4>Features</h4><ol><li><strong>Assign By Users and Assign By Roles</strong><ul><li><strong>Buttons:</strong><ul><li>Two separate buttons are available at the Top of the share document section:<ul><li><strong>Assign By Users:</strong> Opens a dialog for selecting individual users to share the document with.</li><li><strong>Assign By Roles:</strong> Opens a dialog for selecting user roles to share the document with.</li></ul></li></ul></li><li><strong>User/Roles List:</strong><ul><li>Below the buttons, a list displays users or roles who currently have document permissions, including details such as:</li><li>Delete Button( Allow to delete existing permission to user or role)<ul><li>User/Role Name</li><li>Type (User/Role)</li><li>Allow Download(if applicable)</li><li>Email(if applicable)</li><li>Start Date (if applicable)</li><li>End Date (if applicable)</li><li>Â </li><li><strong>Delete Button:</strong> A delete button next to each user/role in the list, allowing for easy removal of permissions.</li></ul></li></ul></li></ul></li><li><strong>Dialog for Selection</strong><ul><li><strong>Dialog Features:</strong><ul><li>Upon clicking either <strong>Assign By Users</strong> or <strong>Assign By Roles</strong>, a dialog opens with the following features:<ul><li><strong>User/Role Selection:</strong><ul><li>A multi-select dropdown list allows users to select multiple users or roles for sharing the document.</li></ul></li><li><strong>Additional Options:</strong><ul><li><strong>Share Duration:</strong> Users can specify a time period for which the document will be accessible (e.g., start date and end date). </li><li><strong>Allow Download:</strong> A checkbox option that allows users to enable or disable downloading of the document.</li><li><strong>Allow Email Notification:</strong>A checkbox option that, when checked, sends an email notification to the selected users/roles.<ul><li>If this option is selected, SMTP configuration must be set up in the application. If SMTP is not configured, an error message will display informing the user of the missing configuration.</li></ul></li></ul></li></ul></li></ul></li></ul></li><li><strong>Saving Shared Document Permissions</strong><ul><li><strong>Save Button:</strong><ul><li>A <strong>Save</strong> button within the dialog allows users to save the selected permissions.</li></ul></li><li><strong>Reflection of Changes:</strong><ul><li>Upon saving, the data is updated, and the list at the bottom of the main interface reflects the newly shared document permissions, showing:<ul><li>User/Role Name</li><li>Type (User/Role)</li><li>Allow Download(if applicable)</li><li>Email(if applicable)</li><li>Start Date (if applicable)</li><li>End Date (if applicable)</li><li>Whether download and email notification options are enabled</li></ul></li></ul></li></ul></li><li><strong>Removing Shared Permissions</strong><ul><li><strong>Delete Button Functionality:</strong><ul><li>Users can click the <strong>Delete</strong> button next to any user or role in the existing shared permissions list.</li><li><strong>Confirmation Dialog:</strong> A confirmation prompt appears to ensure that users intend to remove the selected permission. Users must confirm the action to proceed.</li></ul></li><li><strong>Updating the List:</strong><ul><li>Once confirmed, the shared permission for the selected user or role is removed from the list, and the list updates immediately to reflect this change.</li></ul></li></ul></li><li><strong>User Interaction Flow</strong><ul><li><strong>Navigating to Share Document:</strong><ul><li>Users access the <strong>Share Document</strong> section within the application.</li></ul></li><li><strong>Assigning Permissions:</strong><ul><li>Users click on <strong>Assign By Users</strong> or <strong>Assign By Roles</strong> to open the respective dialog.</li><li>They select the appropriate users or roles, configure additional options, and click <strong>Save</strong>.</li></ul></li><li><strong>Removing Permissions:</strong><ul><li>Users can remove permissions by clicking the <strong>Delete</strong> button next to an entry in the shared permissions list and confirming the action.</li></ul></li><li><strong>Reviewing Shared Permissions:</strong><ul><li>The updated list displays the current permissions, allowing users to verify and manage document sharing effectively.</li></ul></li></ul></li></ol><h3>Summary</h3><p>The <strong>Share Document</strong> functionality provides a structured interface for assigning and managing document permissions to individual users or roles, with added flexibility to remove existing permissions. This feature enhances document collaboration and control while ensuring users can efficiently manage access. The inclusion of SMTP configuration checks for email notifications adds robustness to the communication aspect of the document-sharing process.</p>'),
	('8db6ebc0-cf17-4be8-92e1-3d475222c042', 'ARCHIVE_DOCUMENT_RETENTION_PERIOD', 'Archive Document Retention Period', '<p><strong>What is it?</strong><br>Archive Retention Period allows you to automatically move documents to the <strong>delete</strong> after a selected number of days.</p><p><strong>Retention Options:</strong><br>You can choose to automatically delete documents after:</p><p>30 days</p><p>60 days</p><p>90 days</p><p>180 days</p><p>365 days</p><p><strong>How it works:</strong><br>Once this setting is enabled:</p><p>The system will monitor the age of each document.</p><p>When a document reaches the selected retention period (e.g., 30 days), it will be <strong>automatically deleted</strong>.</p><p><i>Enabling this feature helps keep your workspace organized by removing old documents automatically.</i></p>'),
	('8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'DOCUMENT_SIGNATURE', 'DOCUMENT_SIGNATURE', '<p><strong>Document Signature Functionality</strong></p><p>The <strong>Document Signature</strong> feature allows users to digitally sign documents with ease. This functionality is designed to make the process simple, secure, and efficient, eliminating the need for printing and manual signatures.</p><h3>How It Works:</h3><ol><li><strong>Initiating the Signature Process:</strong><ul><li>Users can click on the <strong>"Document Signature"</strong> button for any document.</li><li>A <strong>popup window</strong> opens, providing options to add a signature.</li></ul></li><li><strong>Applying the Signature:</strong><ul><li>Users can <strong>draw</strong> their signature using a touchscreen or mouse.</li><li>Alternatively, they can <strong>type</strong> their name and choose from various font styles to create a professional-looking signature.</li><li>The signature can be placed anywhere on the document by dragging it to the desired location.</li></ul></li><li><strong>Additional Functionalities:</strong><ul><li><strong>PDF Signature Integration:</strong> Users can directly sign PDFs without converting file formats.</li><li>The <strong>Company Profile</strong> section allows users to include their company details, such as &nbsp;in the PDF signature.</li></ul></li></ol><h3>Key Features:</h3><ul><li><strong>Interactive and User-Friendly:</strong> The popup makes it easy to apply signatures in just a few clicks.</li><li><strong>Professional Branding:</strong> Integrate company details with your signature for added authenticity.</li><li><strong>Secure Signing:</strong> Digital signatures are encrypted to ensure document integrity.</li><li><strong>Flexibility:</strong> Customize the signature and include additional annotations like dates or initials.</li></ul><h3>Benefits:</h3><ul><li><strong>Streamlined Workflow:</strong> Quickly sign and finalize documents without printing or scanning.</li><li><strong>Enhanced Professionalism:</strong> Signatures with company branding make documents look polished and credible.</li><li><strong>Secure and Reliable:</strong> All signed documents are protected with advanced encryption to ensure they remain tamper-proof.</li></ul><p>With the <strong>Document Signature</strong> feature, signing documents becomes fast, professional, and secure, offering users the flexibility and tools they need to manage their documents seamlessly.</p>'),
	('955ec3bf-5ec3-40be-b998-542a28e93369', 'CURRENT_WORKFLOWS', ' Current Workflows', '<ul><li><h3>Current Workflow Page Overview</h3></li><li>The <strong>Current Workflow Page</strong> provides users with a personalized view of workflows they have rights to manage or view. This page displays only the workflows associated with the user, ensuring they can easily track and manage their tasks.</li><li><h4><strong>Key Features</strong></h4></li><li><strong>User-Specific Workflow Display</strong>:<ul><li>This page shows <strong>only the workflows</strong> that the user has permission to access and manage.</li><li>The workflows are categorized based on their statuses:<ul><li><strong>Completed</strong>: Workflows that the user has finished or completed steps for.</li><li><strong>Initiated</strong>: Workflows the user has started but are awaiting further progress.</li><li><strong>In Progress</strong>: Workflows where the user is actively involved in ongoing steps.</li><li><strong>Cancelled</strong>: Workflows the user has been part of that were cancelled before completion.</li></ul></li></ul></li><li><strong>Workflow Details in Graphical View</strong>:<ul><li>The workflows are represented graphically to show:<ul><li>The flow of steps and transitions.</li><li><strong>Completed Transitions</strong>: Clearly marked for easy recognition.</li><li><strong>Pending Transitions</strong>: Distinctly highlighted to indicate remaining tasks.</li></ul></li></ul></li><li><strong>Workflow Information Table</strong>:<ul><li>For each workflow, users can view detailed information, including:<ul><li><strong>Workflow Name</strong>: Unique name of the workflow.</li><li><strong>Workflow Status</strong>: Current status (Completed, Initiated, In Progress, Cancelled).</li><li><strong>Initiated By</strong>: The user who initiated the workflow.</li><li><strong>Document Name</strong>: Associated document, if applicable.</li><li><strong>Workflow Step</strong>: The current step(s) the user is involved in.</li><li><strong>Workflow Step Status</strong>: Status of each step (Completed, Pending).</li><li><strong>Performed By</strong>: User(s) responsible for the steps.</li><li><strong>Transition Status</strong>: Whether transitions are completed or pending.</li></ul></li></ul></li><li><strong>Interactive Details</strong>:<ul><li>Users can click on any step or transition to access:<ul><li>Detailed information about that step/transition.</li><li>History and status of the action.</li><li>Relevant timestamps and actions taken.</li></ul></li></ul></li><li><h3>Benefits</h3></li><li>The <strong>Current Workflow Page</strong> is designed for users to have a focused, user-specific view of workflows they have rights to manage. This ensures:</li><li><strong>Personalized Workflow Management</strong>: Only workflows the user is authorized to access are shown.</li><li><strong>Efficient Tracking</strong>: Users can easily track progress of workflows theyâ€™re involved in.</li><li><strong>Clear Visibility</strong>: Understanding of the workflow status, transitions, and who is performing each step.</li><li>This page provides a secure and streamlined experience for users to manage their assigned workflows effectively.</li></ul>'),
	('99955bd2-fed3-4951-bce7-d0717118e065', 'WORKFLOWS', 'All Workflows', '<ul><li><h3>Workflow List Page Overview</h3></li><li>The <strong>Workflow List Page</strong> provides a complete overview of all workflows, displaying their statuses and details to help users manage and monitor workflows effectively. It combines visual graphs and detailed information to ensure clarity and usability.</li><li><h4><strong>Key Features</strong></h4></li><li><strong>Comprehensive Workflow Display</strong>:<ul><li>All workflows are listed on this page, categorized by their statuses:<ul><li><strong>Completed</strong>: Workflows that have been fully executed.</li><li><strong>Initiated</strong>: Newly started workflows awaiting progress.</li><li><strong>In Progress</strong>: Ongoing workflows with steps and transitions in process.</li><li><strong>Cancelled</strong>: Workflows that were terminated before completion.</li></ul></li></ul></li><li><strong>Workflow Details in Graphical View</strong>:<ul><li>Workflows are visually represented using graphs, showcasing:<ul><li>The structure of steps and transitions.</li><li><strong>Completed Transitions</strong>: Clearly highlighted.</li><li><strong>Pending Transitions</strong>: Distinctly marked.</li></ul></li><li>This graphical format allows users to quickly understand the workflowâ€™s progress and flow.</li></ul></li><li><strong>Workflow Information Table</strong>:<ul><li>Each workflow is accompanied by a table containing detailed information:<ul><li><strong>Workflow Name</strong>: Unique name of the workflow.</li><li><strong>Workflow Status</strong>: Current status of the workflow (Completed, Initiated, In Progress, Cancelled).</li><li><strong>Initiated By</strong>: The user who initiated the workflow.</li><li><strong>Document Name</strong>: The associated document, if applicable.</li><li><strong>Workflow Step</strong>: The current step(s) in the workflow.</li><li><strong>Workflow Step Status</strong>: Status of each step (Completed, Pending).</li><li><strong>Performed By</strong>: The user or team responsible for a specific step.</li><li><strong>Transition Status</strong>: Indicates the progress of transitions (Completed or Pending).</li></ul></li></ul></li><li><strong>Interactive Details</strong>:<ul><li>Users can click on workflow steps or transitions in the graph or table to access:<ul><li>Detailed descriptions.</li><li>Status history.</li><li>Timestamps and related actions.</li></ul></li></ul></li><li><h3>Benefits</h3></li><li>The <strong>Workflow List Page</strong> provides a holistic view of all workflows, their statuses, and detailed progress information. This ensures users can:</li><li>Track and manage all workflows efficiently.</li><li>Monitor progress visually and in detail.</li><li>Quickly identify completed, pending, or cancelled workflows.</li><li>This page is an essential tool for streamlining workflow operations and ensuring process transparency.</li></ul>'),
	('a1c28412-9590-4cdb-b7a0-1687e890ad5d', 'ADD_REMINDER', 'Add reminder', '<p><strong>The "Add Reminder" functionality in the "Manage Reminders" section allows users to create reminders or notifications related to specific events or tasks. These reminders can be customized according to the user \'s needs and can be sent to specific other users.</strong></p><p><strong>Components and Features:</strong></p><ul><li><strong>Subject:</strong> This field allows the user to enter a title or theme for the reminder. This will be the main subject of the notification.</li><li><strong>Message:</strong> Here, users can add additional details or information related to the reminder. This can be a descriptive message or specific instructions.</li><li><strong>Repeat Reminder:</strong> This option allows setting the frequency with which the reminder will be repeated, such as daily, weekly, or monthly.</li><li><strong>Send Email:</strong> If this option is enabled, the reminder will also be sent as an email to the selected users.</li><li><strong>Select Users:</strong> This field allows the selection of users to whom the reminder will be sent. Users can be selected individually or in groups.</li><li><strong>Reminder Date:</strong> This is the time at which the reminder will be activated and sent to the selected users.</li></ul><p><strong>How to Add a New Reminder:</strong></p><ul><li>; to the "Manage Reminders" section.</li><li>Click the "Add Reminder" button.</li><li>Fill in all required fields with the desired information.</li><li>After entering all the details, click "Save" or "Confirm" to add the reminder to the system.</li></ul>'),
	('a3664127-34f1-494c-84c5-fc3f307a9d11', 'USER_PAGE_PERMISSION_TO', 'User Page Permission To', '<ul><li>Enable the ability to assign specific permissions to users that are not tied to their assigned roles. This gives admins the flexibility to grant access to particular features for individual users.</li><li>Click <strong>"Save"</strong> or <strong>"Add"</strong> to assign the user to the system with the specified permissions.</li></ul>'),
	('ab28cf5c-0d89-4a52-a87b-359106897cba', 'MANAGE_EMAIL_SMTP_SETTING', 'Manage Email SMTP Setting', '<p>The <strong>"Email SMTP Settings"</strong> page within CMR DMS allows administrators to configure and manage the SMTP settings for sending emails. This ensures that emails sent from the system are correctly and efficiently delivered to recipients.</p><p><strong>Key Components:</strong></p><ul><li><p><strong>SMTP Settings Table:</strong> Displays all configured SMTP settings in a tabular format.</p><p>Each entry in the table includes details such as the username, host, port, and whether that configuration is set as the default.</p></li><li><p><strong>"Add Settings" Button:</strong> Allows administrators to add a new SMTP configuration.</p><p>Clicking the button opens a form where details like username, host, port, and the option to set it as the default configuration can be entered.</p></li></ul><p><strong>"Add Settings" Form:</strong></p><p>This form opens when administrators click the "Add Settings" button and includes the following fields:</p><ul><li><strong>Username:</strong> The username required for authentication on the SMTP server.</li><li><strong>Host:</strong> The SMTP server address.</li><li><strong>Port:</strong> The port on which the SMTP server listens.</li><li><strong>Is Default:</strong> A checkbox that allows setting this configuration as the default for sending emails.</li></ul><p><strong>How to Add a New SMTP Configuration:</strong></p><ol><li>Click the "Add Settings" button.</li><li>The "Add Settings" form will open, where you can enter the SMTP configuration details.</li><li>Fill in the necessary fields and select the desired options.</li><li>After completing the details, click "Save" or "Add" to add the configuration to the system.</li></ol>'),
	('b1c70caf-ce26-4dff-8f8a-aed4c8eab097', 'PAGE_HELPERS', 'Page Helpers', '<p>Users can manage the pages within the application using a user-friendly interface that displays a list of available pages. Each entry in the list includes options to <strong>Edit</strong> or <strong>View</strong> the corresponding page\'s details.</p><h4>Features</h4><ol><li><h4><strong>List of Pages</strong></h4><ul><li>Users can see a comprehensive list of all pages in the application, each with the following details:<ul><li><strong>Unique Code:</strong> A non-editable code for each page.</li><li><strong>Editable Name:</strong> An editable field that allows users to change the page name.</li><li><strong>Page Info Content:</strong> A section that displays the functionality description of each page.</li><li>Â </li></ul></li></ul></li><li><h4><strong>Edit Feature</strong></h4><ul><li><strong>Edit Button:</strong><ul><li>When a user clicks the <strong>Edit</strong> button next to a page, they are directed to an editable form.</li><li>Users can modify the page name and update the page info content to reflect any changes or improvements.</li><li><strong>Validation:</strong><ul><li>The form includes validation checks to ensure that the new name is unique and meets any defined requirements (e.g., length, special characters).</li></ul></li><li><strong>Save Changes:</strong><ul><li>Users can save the changes, which are then reflected in the list of pages and will persist across sessions.</li><li>Â </li></ul></li></ul></li></ul></li><li><h4><strong>View Feature</strong></h4><ul><li><strong>View Button:</strong><ul><li>Clicking the <strong>View</strong> button opens a dialog box displaying a preview of the page info content.</li><li>This preview includes Â current page name, and detailed functionality description.</li><li><strong>Modal Dialog:</strong><ul><li>The dialog box is modal, meaning users cannot interact with the rest of the application until they close the dialog.</li><li>Users can close the dialog by clicking an "X" button or a "Close" button.</li></ul></li></ul></li></ul></li><li>Â <ul><li><h4><strong>Navigating to the Page List:</strong></h4><ul><li>Users can easily navigate to the page list through the main navigation menu.</li></ul></li><li><strong>Editing a Page:</strong><ul><li>Users select the <strong>Edit</strong> button next to the desired page, modify the name and content, and click <strong>Save</strong> to apply the changes.</li></ul></li><li><strong>Viewing a Page:</strong><ul><li>Users can click the <strong>View</strong> button to open the dialog box, review the details, and close the dialog when finished.</li></ul></li></ul></li></ol><h3>Summary</h3><p>This functionality empowers users to effectively manage page names and content within the application, ensuring that information is accurate and up-to-date. The combination of edit and view features enhances the user experience by allowing for quick modifications and easy access to page details.</p>'),
	('b3dc6a76-6bd3-46ec-956c-eccef2df3eec', 'EXPIRED_DOCUMENTS', 'Expired Documents', '<p><strong>Expired Documents</strong> in a <strong>Document Management System</strong> automatically track and highlight files that have passed their defined expiration time. This helps maintain compliance, improves organization, and supports timely document lifecycle management.</p><h3>Key Features:</h3><ul><li><strong>Automated Tracking:</strong> The system automatically identifies and marks documents as expired based on predefined criteria.</li><li><strong>Notifications:</strong> Users receive alerts for expired documents, ensuring timely review and action.</li><li><strong>Reporting:</strong> Generate reports on expired documents for compliance and auditing purposes.</li></ul><h3>Benefits:</h3><ul><li><strong>Improved Compliance:</strong> Stay compliant with regulations by managing document lifecycles effectively.</li><li><strong>Enhanced Organization:</strong> Keep your document repository tidy by regularly reviewing and archiving expired files.</li><li><strong>Increased Efficiency:</strong> Reduce the risk of using outdated documents in critical processes.</li></ul>'),
	('b99e45c1-9d9f-4b0e-80f0-906c7c830394', 'STORAGE_SETTINGS', 'Storage Settings', '<p><strong>Document Storage Settings</strong>:<br>Users can configure various storage options, including AWS S3 with specific fields required for each storage type. Additionally, there is a default option available for storing files on a local server. This local server setting cannot be deleted, ensuring a reliable and consistent storage option for users.</p><ol><li><strong>Enable Encryption</strong>: When selected, this option ensures that files are stored in encrypted form within the chosen storage.</li><li><strong>Set as Default</strong>: If this option is set to "true," the storage becomes the default selection in the dropdown on the document add page.</li></ol><p>Upon saving the storage settings, the system attempts to upload a dummy file to verify the configuration. If the upload is successful, the settings are saved; otherwise, an error message prompts the user to adjust the field values.</p><ul><li><h4><strong>Add a new Storage Setting to the system.</strong></h4></li><li><strong>It includes the following fields:</strong></li><li><strong>Storage Type: </strong>AWS</li><li><strong>Access Key:</strong></li><li><strong>Secret Key:</strong></li><li><strong>Bucket Name:</strong></li><li><strong>Enable Encryption: </strong>When selected, this option ensures that files are stored in encrypted form within the chosen storage.</li><li><strong>Is Default:</strong> &nbsp;If this option is set to "true," the storage becomes the default selection in the dropdown on the document add page.</li><li>&nbsp;</li><li><h4><strong>Edit Storage Setting to the system.</strong></h4></li><li>Users can edit existing storage settings from the storage settings list, which includes an edit button on the left side of each row. When the edit button is clicked, the row opens in edit mode, allowing users to modify the following fields: name, "Is Default," and "Enable Encryption." This provides users with the flexibility to update their storage configurations as needed.</li></ul><h4>CREATE AWS S3 ACCOUNT:</h4><p><a href="https://aws.amazon.com/free/?gclid=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE&amp;trk=b8b87cd7-09b8-4229-a529-91943319b8f5&amp;sc_channel=ps&amp;ef_id=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE:G:s&amp;s_kwcid=AL!4422!3!536324516040!e!!g!!aws%20s3%20account!11539706604!115473954714&amp;all-free-tier.sort-by=item.additionalFields.SortRank&amp;all-free-tier.sort-order=asc&amp;awsf.Free%20Tier%20Types=*all&amp;awsf.Free%20Tier%20Categories=*all">https://aws.amazon.com/free/?gclid=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE&amp;trk=b8b87cd7-09b8-4229-a529-91943319b8f5&amp;sc_channel=ps&amp;ef_id=CjwKCAjwx4O4BhAnEiwA42SbVPBXf7hpN07vHx4ObiZX3xFHpgCLP9mHQ4P1CaykaQkJKT53F2EQFhoCWRkQAvD_BwE:G:s&amp;s_kwcid=AL!4422!3!536324516040!e!!g!!aws%20s3%20account!11539706604!115473954714&amp;all-free-tier.sort-by=item.additionalFields.SortRank&amp;all-free-tier.sort-order=asc&amp;awsf.Free%20Tier%20Types=*all&amp;awsf.Free%20Tier%20Categories=*all</a></p>'),
	('d0e88580-71d2-4d74-b1ac-b9f34aec6818', 'DOCUMENT_CATEGORIES', 'Document Categories', '<p><strong>The "Document Categories" page serves as a centralized hub for managing and organizing Categories, which essentially represent the departments that work with the files. It offers a hierarchical structure, allowing the creation of main Categories and subCategories.</strong></p><h4><strong>Main Components:</strong></h4><p><strong>"Add New Document Category" Button:</strong></p><ul><li>Allows administrators or users with appropriate permissions to create a new Category or department.</li><li>Opens a form or a pop-up window where details like the Category name and description can be entered.</li></ul><p><strong>List of Existing Categories:</strong></p><ul><li>Displays all the Categories or departments created within the system.</li><li>Each entry includes the Category name and associated action options.</li></ul><p><strong>Action Menu for Each Category:</strong></p><ul><li>Next to each Category, users will find action options that allow them to manage the Category:<ul><li><strong>Edit:</strong> Enables modification of the Category\'s details, such as the name or description.</li><li><strong>Delete:</strong> Removes the Category from the system. This action may require confirmation to prevent accidental deletions.</li></ul></li></ul><p><strong>Double Arrow Button ">>":</strong></p><ul><li>Located next to each main Category.</li><li>When clicked, it reveals the subCategories associated with the main Category.</li><li>Allows users to view and manage subCategories in a hierarchical manner.</li></ul><h4><strong>How to Add a New Category:</strong></h4><ol><li>Click on the "Add New Document Category" button.</li><li>A form or pop-up window will open.</li><li>Enter the Category name and description.</li><li>Click "Save" or "Add" to add the Category to the system.</li></ol><h4><strong>How to View SubCategories:</strong></h4><ol><li>Locate the main Category in the list.</li><li>Click on the double arrow button ">>" next to the Category name.</li><li>The associated subCategories will be displayed beneath the main Category.</li></ol>'),
	('d1ee0a7e-7962-46f5-a784-8be66fb58b51', 'AI_DOCUMENTS', 'AI Document Lists', '<h3>Overview</h3><p>This section allows you to view documents generated using OpenAI\'s AI. For each document, you can explore the original prompt that was used to generate the content, along with the full AI-generated output. This helps you understand how prompts shape responses and lets you track your creative or work process.</p><h3>ðŸ” How to Use</h3><h4>1. <strong>Accessing the Document List</strong></h4><ul><li>Navigate to the <strong>Generated Documents</strong> section from the main menu.</li><li>Youâ€™ll see a list of all documents generated by AI, including titles and creation dates.</li></ul><h4>2. <strong>Viewing a Document</strong></h4><ul><li>Click on any document in the list to open it.</li><li>Youâ€™ll see:<ul><li><strong>Prompt</strong> â€“ The exact input (question or instruction) used to generate the document.</li><li><strong>Output</strong> â€“ The AI-generated text based on the prompt.</li></ul></li></ul><h4>3. <strong>Understanding the Prompt-Output Pair</strong></h4><ul><li>Use this feature to:<ul><li>Learn how different prompts lead to different styles or content.</li><li>Refine your own prompt-writing skills.</li><li>Review previous outputs for reuse or inspiration.</li></ul></li></ul>'),
	('d2abfc80-7dfb-49b6-bccf-44d75844f098', 'MANAGE_FILE_REQUEST', 'Manage File Request', '<h2>File Request Functionality</h2><p>The <strong>File Request</strong> feature simplifies document collection by allowing you to generate unique links, share them with users, and review uploaded documents. Here\'s how it works:</p><h2>Key Features:</h2><p><strong>1.Generate Link</strong>:</p><ul><li>Create a unique link for a file request.</li><li>Share this link with users to allow them to upload the required documents.</li></ul><p><strong>2.Upload Documents</strong>:</p><p>Users can upload documents directly via the link you provide.</p><p>You can set the following parameters when creating a request:</p><p><strong>Maximum File Size Upload</strong>: Specify the largest file size allowed per upload.</p><p><strong>Maximum Document Upload</strong>: Limit the number of documents a user can upload.</p><ul><li><strong>Allowed File Extensions</strong>: Restrict uploads to specific file types (e.g., PDF, DOCX, JPG).</li></ul><p><strong>3.Review and Manage Requests</strong>:</p><ul><li>View all submissions on the <strong>File Request List</strong> page.</li><li>Approve or reject uploaded documents as necessary.</li></ul><p><strong>4.Request Data List</strong>:<br>Each file request includes the following details:</p><ul><li><strong>Subject</strong>: The purpose or title of the request.</li><li><strong>Email</strong>: The email address associated with the request.</li><li><strong>Maximum File Size Upload</strong>: The size limit for uploaded files.</li><li><strong>Maximum Document Upload</strong>: The number of documents users can upload.</li><li><strong>Allowed File Extensions</strong>: The types of files users can upload.</li><li><strong>Status</strong>: The current status of the request (e.g., Pending, Approved, Rejected).</li><li><strong>Created By</strong>: The user who created the request.</li><li><strong>Created Date</strong>: The date the request was created.</li><li><strong>Link Expiration</strong>: The date the link will no longer be valid.</li></ul><p><strong>5.Manage Requests</strong>:<br>For each file request, you can:</p><ul><li><strong>Edit</strong>: Update the details of the request, such as file size, document limits, or expiration date.</li><li><strong>Delete</strong>: Remove the request entirely.</li><li><strong>Copy Link</strong>: Copy the link to share it with others.</li></ul><h2>How It Works:</h2><h3>1. Creating a File Request:</h3><ul><li>Navigate to the <strong>File Request</strong> page and click Create New Request. </li><li>Enter details like the subject, allowed file extensions, and upload limits.</li><li>Generate the link and share it with the intended user.</li></ul><h3>2. Uploading Documents:</h3><ul><li>The user clicks the link and uploads their documents according to the criteria you set.</li></ul><h3>3. Reviewing Submissions:</h3><ul><li>Go to the <strong>File Request List</strong> page to view submitted documents.</li><li>Approve or reject submissions as required.</li></ul><h3>4. Managing Links:</h3><ul><li>Use the <strong>Edit</strong> or <strong>Delete</strong> options to modify or remove requests.</li><li>Copy the link anytime for reuse or sharing.</li></ul>'),
	('d6e392a9-b180-4c68-8566-6f289150a226', 'ADD_DOCUMENT', 'Manage document', '<ul><li><strong>Allows users to upload and add a new document to the system.</strong></li><li>It includes the following fields:</li><li><strong>Upload Document:</strong> An option to upload the document file.</li><li><strong>Category:</strong> The Category under which the document is classified.</li><li><strong>Name:</strong> The name of the document.</li><li><strong>Status:</strong> The status of the document (e.g., confidential or public).</li><li><strong>Description:</strong> A detailed description or additional notes related to the document.</li><li><strong>Meta Tags:</strong> Tags or keywords associated with the document for easier searching.</li></ul>'),
	('d8506639-f4ec-42d8-9939-bae893abef57', 'ROLES', 'Roles', '<p><strong>The "User Roles" page is essential for managing and defining permissions within the CMR DMS. Roles represent predefined sets of permissions that can be assigned to users, ensuring that each user has access only to the functionalities and documents appropriate to their position and responsibilities within the organization.</strong></p><h3><strong>Main Components:</strong></h3><p><strong>"Add Roles" Button:</strong></p><ul><li>Allows administrators or users with appropriate permissions to create a new role in the system.</li><li>Opens a form or pop-up window where the roleâ€™s permissions and details can be defined.</li></ul><p><strong>List of Existing Roles:</strong></p><ul><li>Displays all roles created within the system in a tabular format.</li><li>Each entry includes the role name and associated action options.</li></ul><p><strong>Action Menu for Each Role:</strong></p><ul><li>Includes options for "Edit" and "Delete."<ul><li><strong>Edit:</strong> Allows modification of the role\'s details and permissions.</li><li><strong>Delete:</strong> Removes the role from the system. This action may require confirmation to prevent accidental deletions.</li></ul></li></ul><p><strong>Role Creation Page:</strong></p><ul><li>Here, administrators can define specific permissions for each role.</li><li>Permissions can include rights such as viewing, editing, deleting, or sharing documents, managing users, defining Categories, and more.</li><li>Once permissions are set, they can be saved to create a new role or update an existing one.</li></ul><h3><strong>How to Add a New Role:</strong></h3><ol><li>Click on the "Add Roles" button.</li><li>A form or pop-up window will open.</li><li>Enter the role name and select the appropriate permissions from the available list.</li><li>Click "Save" or "Add" to add the role to the system with the specified permissions.</li></ol>'),
	('d96ee5aa-4253-4a28-ba61-94b15b6cbfae', 'VERSION_HISTORY', 'Document versions', '<p><strong>Uploading a New Version of the Document:</strong></p><p>Allows users to upload an updated or modified version of an existing document.</p><p>It includes the following fields:</p><ul><li><strong>Upload a New Version:</strong> A dedicated section for uploading a new version of the document.</li><li><strong>Restore previous version document to current version : </strong>When a user restores a previous version as the current document, the existing current document is automatically added to the document history. The restored document then becomes the active current document, ensuring effective version control and easy tracking of changes</li><li><strong>Upload Document:</strong> An option to upload the document file. Users can select the file they want to upload, and the text "No file chosen" will appear until a file is selected.</li><li><strong>View Document</strong>:<br>This feature provides users with the ability to preview previous versions of a document. Users can easily access and review any earlier version, allowing for better assessment and comparison before deciding to restore or make further edits.</li></ul><p><strong>How to Upload a New Version of the Document:</strong></p><ol><li>Navigate to the "All Documents" page.</li><li>Select the document for which you want to upload a new version.</li><li>Click on the "Upload a New Version" option or a similar button.</li><li>A dedicated form will open where you can select and upload the appropriate file.</li><li>After uploading the file, click "Save" or "Add" to update the document in the system with the new version.</li></ol>'),
	('dd0c9840-b7c6-4a51-b78a-e674918ff7e5', 'NOTIFICATIONS', 'Notifications', '<ul><li><strong>Document Shared Notification</strong>:<ul><li>Sends real-time notifications to users when a document is shared with them.</li><li>Notifications are sent via email and in-app, with details about the shared document, including name, category, and shared user.</li><li>For documents shared with external users, the recipient is notified with a secure link to access the document.</li></ul></li><li><strong>Reminder Notifications</strong>:<ul><li>Sends reminders to users for upcoming deadlines or actions related to documents (e.g., review deadlines or document expiration).</li><li>Users can configure reminder frequency and set specific reminders for important documents.</li><li>Reminders are delivered via both email and in-app notifications.</li></ul></li></ul><p>&nbsp;</p>'),
	('dd217b6b-b332-44ef-bc09-2fb68d9b0d79', 'DOCUMENT_STATUS', 'Document Status', '<h3>Document Status</h3><p>Document status is a feature that allows you to manage the lifecycle of your documents. You can set different statuses for your documents, such as:</p><ul><li>Draft</li><li>Final</li><li>Archived</li></ul><p>This helps you keep track of the current state of each document and ensures that only the right people have access to them.</p>'),
	('ec6b2368-b8fd-4101-addf-5dec7c1d1c63', 'SHAREABLE_LINK', 'Shareable Link', '<ul><li><strong>Shareable Link</strong>:<br>This feature allows users to share documents with anonymous users through a customizable link. Users have the flexibility to configure various options when creating a shareable link, including:<ul><li><strong>Start and Expiry Dates</strong>: Specify the validity period for the link, defining when it becomes active and when it expires.</li><li><strong>Password Protection</strong>: Optionally set a password to restrict access to the shared document.</li><li><strong>Download Permission</strong>: Choose whether recipients are allowed to download the document.</li></ul></li></ul><p>All options are optional, allowing users to customize the shareable link according to their preferences and requirements.</p>'),
	('eccba93d-48bb-48f6-9784-14968d8843c8', 'MANAGE_USER', 'Manage User', '<p>The User Information page is designed to collect and manage your personal details. This page is essential for setting up your user profile and ensuring you have a seamless experience using our application. Below is a brief overview of the fields you willl encounter:</p><h4><strong>Fields on the User Information Page</strong></h4><ol><li><strong>First Name</strong>:<ul><li><strong>What it is</strong>: Your given name.</li><li><strong>Importance</strong>: Helps us address you properly within the application.</li></ul></li><li><strong>Last Name</strong>:<ul><li><strong>What it is</strong>: Your family name or surname.</li><li><strong>Importance</strong>: Completes your identity and is often required for official documents.</li></ul></li><li><strong>Mobile Number</strong>:<ul><li><strong>What it is</strong>: Your phone number.</li><li><strong>Importance</strong>: Used for account recovery, notifications, and two-factor authentication. Itâ€™s optional but recommended for security purposes.</li></ul></li><li><strong>Email Address</strong>:<ul><li><strong>What it is</strong>: Your electronic mail address.</li><li><strong>Importance</strong>: Serves as your primary communication channel with us. Itâ€™s required for account verification, notifications, and password recovery.</li></ul></li><li><strong>Password</strong>:<ul><li><strong>What it is</strong>: A secret word or phrase you create to secure your account.</li><li><strong>Importance</strong>: Protects your account from unauthorized access. It must be at least 6 characters long.</li></ul></li><li><strong>Confirm Password</strong>:<ul><li><strong>What it is</strong>: A second entry of your chosen password.</li><li><strong>Importance</strong>: Ensures youâ€™ve entered your password correctly.</li></ul></li><li><strong>Role</strong>:<ul><li><strong>What it is</strong>: Your assigned position or function within the application (e.g., Admin, User, Editor).</li><li><strong>Importance</strong>: Determines your access level and permissions within the application. This field is required to define your responsibilities and capabilities.</li></ul></li></ol><h4><strong>How to Use the Page</strong></h4><ul><li><strong>Filling Out the Form</strong>:<ul><li>Enter your information in the required fields.</li><li>Ensure that your password and confirm password entries match to avoid any errors.</li></ul></li><li><strong>Submitting Your Information</strong>:<ul><li>Once you have filled in all required fields, click the \\\'submit\' button.</li><li>If any required fields are left blank or contain errors, you willl see helpful messages prompting you to correct them.</li></ul></li><li><strong>Visual Feedback</strong>:<ul><li>Fields that require your attention will be highlighted, and error messages will guide you in making the necessary corrections.</li></ul></li></ul>'),
	('ee4f69f1-1ed7-4447-87d4-c43a0b0f92e0', 'UPLOAD_NEW_VERSION', 'Upload version file', '<p><strong>How to Upload a New Version of a Document:</strong></p><ol><li>Navigate to the "All Documents" page.</li><li>Select the document for which you want to upload a new version.</li><li>Click on the option "Upload a New Version" or a similar button.</li><li>A dedicated form will open, allowing you to select and upload the appropriate file.</li><li>After uploading the file, click "Save" or "Add" to update the document in the system with the new version.</li></ol>'),
	('f5cecacd-f0e6-45b3-8de2-348d8ec29556', 'LOGIN_AUDIT_LOGS', 'Audit logs', '<p><strong>The "Login Audit Logs" page serves as a centralized record for all authentication activities within CMR DMS. Here, administrators can monitor and review all login attempts, successful or failed, made by users. This provides a clear perspective on system security and user activities.</strong></p><p><strong>Main Components:</strong></p><ul><li><p><strong>Authentication Logs Table:</strong> Displays all login entries in a tabular format.</p><p>Each entry includes details such as the username, login date and time, the IP address from which the login was made, and the result (success/failure).</p></li></ul><p><strong>How to View Log Entries:</strong></p><ol><li>Navigate to the "Login Audit Logs" page.</li><li>Browse through the table to view all login entries.</li><li>Use the search or filter function, if available, to find specific entries.</li></ol>'),
	('f6a1faa6-7245-4f9f-ad17-5478677bedfb', 'DOCUMENTS_BY_CATEGORY', 'Documents by Category', '<p>The <strong>Homepage</strong> provides an overview of the documents within the system, showcasing statistics related to the number of documents organized by Category. It is the ideal place to quickly obtain a clear view of the volume and distribution of documents in the DMS.</p><h3>Main Components:</h3><ol><li><strong>Document Statistics</strong>:<ul><li>Displays a numerical summary of all the documents in the system, organized by Category.</li><li>Each Category is accompanied by a number indicating how many documents are in that Category.</li></ul></li><li><strong>"Document Categories" List</strong>:<ul><li>Shows the different document Categories available in the system, such as:<ul><li>"Professional-Scientific_and_Education"</li><li>"HR Policies 2021"</li><li>"Professional1"</li><li>"Initial Complaint"</li><li>"HR Policies 2020"</li><li>"Studies_and_Strategies"</li><li>"Administrative_and_Financial"</li><li>"Approvals"</li><li>"Jurisdiction Commission"</li></ul></li><li>Next to each Category, the number of documents is displayed, providing a clear view of the document distribution across Categories.</li></ul></li></ol><h3>How to interpret the statistics:</h3><ol><li>Navigate to the <strong>Statistics</strong> section on the <strong>Homepage</strong>.</li><li>View the total number of documents for each Category.<ul><li>These numbers give you an idea of the volume of documents in each Category and help identify which Categories have the most or fewest documents.</li></ul></li></ol>'),
	('fa5c186a-ed5d-40b0-858e-34cf03a1866f', 'PROMPT_TEMPLATE', 'AI Prompt Template', '<h2>ðŸ’¡ How Prompt Templates Work</h2><p>Prompt templates make it easy to create AI-generated content quickly and consistently.</p><h3>ðŸ§© What is a Prompt Template?</h3><p>A prompt template is a ready-to-use sentence with placeholders (like **description**) that you can fill in with your own content. The AI then uses your completed prompt to generate a response.</p><h3>âœ¨ How to Use:</h3><ol><li><p><strong>Choose a Template</strong><br>Select from a list of available prompt templates, such as:</p><blockquote><p>Answer this email content: **description**.</p></blockquote></li><li><p><strong>Fill in the Blank</strong><br>After selecting a template, the system will ask you to enter a value for each placeholder (e.g., description).<br>Example:</p><blockquote><p><i>Iâ€™m unable to attend the meeting due to a personal emergency.</i></p></blockquote></li><li><p><strong>Generate the Final Prompt</strong><br>The system will automatically replace the placeholder with your input:</p><blockquote><p>Answer this email content: Iâ€™m unable to attend the meeting due to a personal emergency.</p></blockquote></li><li><strong>Get Your Result</strong><br>The AI will process the completed prompt and generate the content for you.</li></ol>'),
	('fac2acd8-1cc9-4722-a7e8-b2c297a37b7f', 'MANAGE_WORKFLOW', 'Manage Workflow', '<ul><li><h3><strong>Manage Workflow Overview</strong></h3></li><li>The <strong>Manage Workflow</strong> feature allows users to efficiently create, edit, and customize workflows as needed. This functionality is designed to ensure flexibility and control over workflow management. Here\'s how it works:</li><li><h4><strong>Creating a Workflow</strong></h4></li><li>If no workflows have been created, users can start by building a new workflow:</li><li><strong>Define Workflow Details</strong>: Provide a unique name and description for the workflow.</li><li><strong>Add Workflow Steps</strong>: Create the necessary steps that outline the workflow process.</li><li><strong>Set Workflow Transitions</strong>: Define the transitions between steps, specifying conditions or rules for movement.</li><li>Once the workflow is created, users can manage and update it as required.</li><li><h4><strong>Editing an Existing Workflow</strong></h4></li><li>For workflows that have already been created, users have the ability to make updates:</li><li><strong>Edit Workflow Name</strong>: Change the name of the workflow to reflect new requirements or corrections.</li><li><strong>Edit Workflow Step Name</strong>: Modify the names of individual steps within the workflow to ensure clarity or adjust for changes.</li><li><strong>Edit Workflow Transition Name</strong>: Update the names or rules for transitions between workflow steps as needed.</li><li><h3>Flexibility in Management</h3></li><li>The <strong>Manage Workflow</strong> feature is versatile, allowing users to either:</li><li><strong>Create a new workflow</strong> if none exist, or</li><li><strong>Edit an existing workflow</strong> to adapt to evolving needs.</li></ul>');

-- Dumping structure for table dms_ai.pages
CREATE TABLE IF NOT EXISTS `pages` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int NOT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.pages: ~24 rows (approximately)
INSERT INTO `pages` (`id`, `name`, `order`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('05edb281-cddb-4281-9ab3-fb90d1833c82', 'Archived Documents', 4, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('090ea443-01c7-4638-a194-ad3416a5ea7a', 'Role', 7, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('0c8b0806-f33f-48b3-a326-dcc9cc1a65c7', 'Deep Search', 4, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('2396f81c-f8b5-49ac-88d1-94ed57333f49', 'Document Audit Trail', 5, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('2e3c07a4-fcac-4303-ae47-0d0f796403c9', 'Email', 8, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('324bdc51-d71f-4f80-9f28-a30e8aae4009', 'User', 6, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('34328287-3a37-4c70-ac61-b291c3ef5ade', 'CLIENT', 10, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('42e44f15-8e33-423a-ad7f-17edc23d6dd3', 'Dashboard', 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('55e8aeb6-8a97-40f7-acf2-9a028f615ddb', 'FILE_REQUEST', 8, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('5a2a2bba-6208-4210-9f71-eb5c215c7d98', 'ALL_WORKFLOWS', 7, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('5a5f7cf8-21a6-434a-9330-db91b17d867c', 'Document Category', 4, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('637f010e-3397-41a9-903a-21d54db5e49a', 'AI_DOCUMENTS', 3, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('655f0bcd-676d-49fc-ba30-24c39c853e16', 'MY_WORKFLOWS', 9, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('8384e302-eaf1-4a0b-b293-a921b1e9e36a', 'BULK_DOCUMENT_UPLOADS', 4, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('869a8d5e-0430-41f4-94f0-3690895a8942', 'WORKFLOW_SETTINGS', 7, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('8740dd7a-7bca-442f-b50f-6cdf0fcaf7bd', 'DOCUMENT_STATUS', 10, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('8fbb83d6-9fde-4970-ac80-8e235cab1ff2', 'Settings', 9, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('97ff6eb0-39b3-4ddd-acf1-43205d5a9bb3', 'Reminder', 9, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('b2c3d4e5-6f7g-8h9i-0j1k-2l3m4n5o6p7q', 'WORKFLOW_LOGS', 7, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('c78e8ff2-71d7-49e4-bbee-a71ef9d581e9', 'Expired Documents', 6, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
	('cfa38ae7-b5ba-4881-9199-d2914d7fd58e', 'Page Helper', 14, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'All Documents', 2, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('f042bbee-d15f-40fb-b79a-8368f2c2e287', 'Logs', 10, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'Assigned Documents', 3, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL);

-- Dumping structure for table dms_ai.proposalcandidates
CREATE TABLE IF NOT EXISTS `proposalcandidates` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `candidateName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `candidateCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `experienceYears` smallint unsigned DEFAULT NULL,
  `workMode` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cvOriginalName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cvPath` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cv_received',
  `interviewLevel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interviewDate` datetime DEFAULT NULL,
  `interviewer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interviewerUserId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `analysisNotes` text COLLATE utf8mb4_unicode_ci,
  `rejectionReason` text COLLATE utf8mb4_unicode_ci,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proposalCandidates_postId_index` (`postId`),
  KEY `proposalCandidates_createdBy_index` (`createdBy`),
  KEY `proposalcandidates_intervieweruserid_foreign` (`interviewerUserId`),
  CONSTRAINT `proposalCandidates_createdBy_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `proposalcandidates_intervieweruserid_foreign` FOREIGN KEY (`interviewerUserId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `proposalCandidates_postId_foreign` FOREIGN KEY (`postId`) REFERENCES `proposalposts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.proposalcandidates: ~0 rows (approximately)

-- Dumping structure for table dms_ai.proposalfilerequests
CREATE TABLE IF NOT EXISTS `proposalfilerequests` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `folderId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileRequestId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `maxDocument` int unsigned NOT NULL DEFAULT '1',
  `sizeInMb` int unsigned NOT NULL DEFAULT '5',
  `allowExtension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hasPassword` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkExpiryTime` datetime DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proposalfilerequests_folderid_foreign` (`folderId`),
  KEY `proposalfilerequests_createdby_foreign` (`createdBy`),
  KEY `proposalfilerequests_filerequestid_foreign` (`fileRequestId`),
  CONSTRAINT `proposalfilerequests_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `proposalfilerequests_filerequestid_foreign` FOREIGN KEY (`fileRequestId`) REFERENCES `filerequests` (`id`) ON DELETE SET NULL,
  CONSTRAINT `proposalfilerequests_folderid_foreign` FOREIGN KEY (`folderId`) REFERENCES `proposalfolders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.proposalfilerequests: ~2 rows (approximately)
INSERT INTO `proposalfilerequests` (`id`, `folderId`, `fileRequestId`, `title`, `email`, `description`, `maxDocument`, `sizeInMb`, `allowExtension`, `hasPassword`, `password`, `linkExpiryTime`, `status`, `createdBy`, `createdDate`) VALUES
	('6dbb5a13-0acf-4539-aeab-1426078e1c7f', 'c84ebeeb-f6d2-4874-bb9e-58a8d8527e3d', '90ca00f8-2f6b-4dd4-ae49-3a15e6a9093e', 'Deep Learning', 'abc123@gmail.com', 'For testing purpose', 1, 10, '1', 1, 'hello', '2026-05-03 19:05:00', 'pending', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-05-03 13:59:55'),
	('9e4b34c6-8012-416d-aee9-ccdff9aa0ae1', '574ea4eb-13c6-4ddf-af03-2771f480999c', '05c805dc-b2f1-41b1-8753-66331c958461', 'Machine Learning', 'abc123@gmail.com', 'For testing purpose', 2, 1, '1', 1, 'hello', '2026-05-02 16:40:00', 'pending', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-02 11:25:13');

-- Dumping structure for table dms_ai.proposalfiles
CREATE TABLE IF NOT EXISTS `proposalfiles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `folderId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `originalName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proposalfiles_folderid_foreign` (`folderId`),
  KEY `proposalfiles_createdby_foreign` (`createdBy`),
  CONSTRAINT `proposalfiles_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `proposalfiles_folderid_foreign` FOREIGN KEY (`folderId`) REFERENCES `proposalfolders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.proposalfiles: ~4 rows (approximately)
INSERT INTO `proposalfiles` (`id`, `folderId`, `title`, `originalName`, `url`, `createdBy`, `createdDate`) VALUES
	('7643ae91-712d-46fd-bdfa-1c2a967b4039', '574ea4eb-13c6-4ddf-af03-2771f480999c', 'ICTbasics', 'ICTbasics.pdf', 'proposals/4c36b2b9-0887-47ac-9f5e-db019c44f46a.pdf', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-02 11:15:57'),
	('a2c56bf4-d541-4449-ada4-36397c416eb4', 'c84ebeeb-f6d2-4874-bb9e-58a8d8527e3d', 'ICTbasics', 'ICTbasics.pdf', 'proposals/fe4eb880-441e-4c8a-a2ff-d12a48297cb8.pdf', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-05-03 13:41:18'),
	('c760b0d5-cea0-4fde-8838-94523ca83427', '574ea4eb-13c6-4ddf-af03-2771f480999c', 'DeepLearning', 'DeepLearning.pdf', 'proposals/c51f85cb-ee5d-4bb5-8d80-f6984c32be83.pdf', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-02 11:15:14'),
	('d320f774-39a1-4735-b9a0-9a16ac860303', 'c84ebeeb-f6d2-4874-bb9e-58a8d8527e3d', 'DeepLearning', 'DeepLearning.pdf', 'proposals/520f4e96-30e9-468d-abb6-2ad8e4250a90.pdf', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-05-03 13:41:02');

-- Dumping structure for table dms_ai.proposalfolders
CREATE TABLE IF NOT EXISTS `proposalfolders` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parentFolderId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proposalfolders_createdby_foreign` (`createdBy`),
  KEY `proposalfolders_parentfolderid_foreign` (`parentFolderId`),
  CONSTRAINT `proposalfolders_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `proposalfolders_parentfolderid_foreign` FOREIGN KEY (`parentFolderId`) REFERENCES `proposalfolders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.proposalfolders: ~5 rows (approximately)
INSERT INTO `proposalfolders` (`id`, `name`, `parentFolderId`, `createdBy`, `createdDate`, `modifiedDate`) VALUES
	('574ea4eb-13c6-4ddf-af03-2771f480999c', '1', '6cf9e1e0-34c6-42a3-8231-5e56efbcc49b', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-30 10:10:43', '2026-04-30 10:10:43'),
	('6cf9e1e0-34c6-42a3-8231-5e56efbcc49b', 'proposals', NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-04-30 10:10:39', '2026-04-30 10:10:39'),
	('c0ff0a67-8b9c-4464-b430-f0d56b598947', 'Test', '574ea4eb-13c6-4ddf-af03-2771f480999c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-02 11:14:08', '2026-05-02 11:14:08'),
	('c84ebeeb-f6d2-4874-bb9e-58a8d8527e3d', 'QA test', 'd93107f6-e556-444d-8399-1f1775fbd0b6', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-04-30 10:03:58', '2026-04-30 10:03:58'),
	('d93107f6-e556-444d-8399-1f1775fbd0b6', 'proposals', NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '2026-04-30 10:03:38', '2026-04-30 10:03:38');

-- Dumping structure for table dms_ai.proposalposts
CREATE TABLE IF NOT EXISTS `proposalposts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `experienceYears` smallint unsigned DEFAULT NULL,
  `workMode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'physical',
  `address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  `interviewKit` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'basic',
  `basicQuestions` text COLLATE utf8mb4_unicode_ci,
  `intermediateQuestions` text COLLATE utf8mb4_unicode_ci,
  `expertQuestions` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `proposalPosts_createdBy_foreign` (`createdBy`),
  CONSTRAINT `proposalPosts_createdBy_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.proposalposts: ~4 rows (approximately)
INSERT INTO `proposalposts` (`id`, `title`, `department`, `category`, `experienceYears`, `workMode`, `address`, `description`, `createdBy`, `createdDate`, `modifiedDate`, `interviewKit`, `basicQuestions`, `intermediateQuestions`, `expertQuestions`) VALUES
	('9c3d0dfc-f765-4762-b1b4-166a61867c7c', 'Vue.js Developer', 'Frontend', 'Frontend Development', 3, 'remote', NULL, 'Seeking a Vue.js Developer to build responsive UI components and integrate APIs with frontend applications.', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-21 06:13:30', '2026-05-21 06:13:30', 'basic', 'What is Vue.js and why is it used?\nExplain components in Vue.js.\nWhat is reactive data in Vue?\nHow do you call APIs in Vue.js?', 'Explain Vue lifecycle hooks.\nHow do you manage state in Vue?\nWhat is the difference between props and emits?\nDescribe a UI challenge you solved.', 'How do you optimize Vue application performance?\nExplain dynamic routing in Vue Router.\nHow do you structure large Vue projects?\nDescribe a complex frontend architecture you worked on.'),
	('a007466e-91d7-43e8-a4a2-c20c53519d7e', 'Team Lead Laravel', 'Engineering', 'Team Management', 5, 'remote', NULL, 'Looking for a Laravel Team Lead to manage developers, review code, and deliver scalable applications.', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-21 06:19:47', '2026-05-21 06:19:47', 'basic', 'Tell us about your leadership experience.\nHow do you manage deadlines?\nWhat tools do you use for project tracking?\nExplain your coding standards process.', 'How do you handle conflicts within a team?\nDescribe your code review process.\nHow do you assign tasks to developers?\nExplain a project you managed successfully.', 'How do you architect scalable Laravel systems?\nHow do you improve team productivity?\nExplain your deployment workflow.\nDescribe a difficult technical decision you made as a lead.'),
	('a1b5c97c-e1e8-4168-9e2c-90e611551845', 'Senior Laravel Developer', 'Engineering', 'Software Development', 3, 'remote', NULL, 'We are looking for a Laravel Developer responsible for developing APIs, managing databases, and maintaining web applications.', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-21 06:06:29', '2026-05-21 06:10:08', 'basic', 'Tell us about your Laravel experience.\nWhat is MVC architecture in Laravel?\nWhich databases have you worked with?\nExplain Laravel routing basics.', 'How do you optimize Laravel queries?\nExplain middleware in Laravel.\nHow do you handle authentication in Laravel?\nDescribe a Laravel project you completed recently.', 'How would you scale a Laravel application for high traffic?\nExplain repository pattern in Laravel.\nHow do you secure Laravel APIs?\nDescribe a complex issue you solved in production.'),
	('b28656e4-eaeb-4fef-ad31-4aa7ff14e3ae', 'QA Engineer', 'Quality Assurance', 'Software Testing', 2, 'remote', NULL, 'We need a QA Engineer to perform manual and automated testing for web applications.', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '2026-05-21 06:16:33', '2026-05-21 06:16:33', 'basic', 'What is software testing?\nDifference between bug and defect?\nWhat testing tools have you used?\nExplain functional testing.', 'How do you write test cases?\nExplain regression testing.\nDescribe a bug you identified and reported.\nHow do you prioritize testing tasks?', 'How do you build an automation testing strategy?\nExplain API testing process.\nHow do you ensure application quality before release?\nDescribe a critical production issue you handled.');

-- Dumping structure for table dms_ai.quarterlyreminders
CREATE TABLE IF NOT EXISTS `quarterlyreminders` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminderId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day` int NOT NULL,
  `month` int NOT NULL,
  `quarter` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quarterlyreminders_reminderid_foreign` (`reminderId`),
  CONSTRAINT `quarterlyreminders_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.quarterlyreminders: ~0 rows (approximately)

-- Dumping structure for table dms_ai.remindernotifications
CREATE TABLE IF NOT EXISTS `remindernotifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminderId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fetchDateTime` datetime NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `isEmailNotification` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `remindernotifications_reminderid_foreign` (`reminderId`),
  CONSTRAINT `remindernotifications_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.remindernotifications: ~0 rows (approximately)

-- Dumping structure for table dms_ai.reminders
CREATE TABLE IF NOT EXISTS `reminders` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frequency` int DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `dayOfWeek` int DEFAULT NULL,
  `isRepeated` tinyint(1) NOT NULL,
  `isEmailNotification` tinyint(1) NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminders_documentid_foreign` (`documentId`),
  KEY `reminders_createdby_foreign` (`createdBy`),
  CONSTRAINT `reminders_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `reminders_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.reminders: ~8 rows (approximately)
INSERT INTO `reminders` (`id`, `subject`, `message`, `frequency`, `startDate`, `endDate`, `dayOfWeek`, `isRepeated`, `isEmailNotification`, `documentId`, `createdBy`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('0d92c4e2-8910-442d-ab02-c98a76a36722', 'MEETING', 'Demo', 6, '2026-05-02 16:38:42', NULL, 6, 0, 1, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-05-02 16:37:24', '2026-05-02 16:37:24', NULL),
	('24d22983-9d23-4f3f-a308-e79181dab154', 'Team Meeting Reminder', 'Attend the meeting at 3PM', 0, '2026-05-04 15:03:19', '2026-05-10 15:24:42', NULL, 1, 1, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-04-23 12:00:15', '2026-05-03 15:04:01', NULL),
	('7d86d9a9-c5f0-4631-8f23-9e6c6180f1e0', '34ed3sd3ed', 'de3d3ed3ede3de3', 1, '2026-05-03 14:52:58', '2026-05-18 14:55:23', 0, 1, 0, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 1, '2026-05-03 14:55:27', '2026-05-03 15:02:30', '2026-05-03 15:02:30'),
	('9898357d-5e2b-46ed-bbe3-236b2325ad6e', '34ed3sd3ed', 'de3d3ed3ede3de3', 1, '2026-05-03 14:52:58', '2026-05-18 14:55:23', 0, 1, 0, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 1, '2026-05-03 14:55:32', '2026-05-03 15:02:39', '2026-05-03 15:02:39'),
	('cc20ef22-0883-4251-99b4-458f89243fa2', '34ed3sd3ed', 'de3d3ed3ede3de3', 1, '2026-05-03 14:52:58', '2026-05-20 14:55:23', 0, 1, 0, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 1, '2026-05-03 14:55:36', '2026-05-03 15:02:34', '2026-05-03 15:02:34'),
	('ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 'MEETING', 'FOR TESTING PURPOSE', 0, '2026-05-03 14:20:16', '2026-05-10 14:15:33', NULL, 1, 1, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-03 14:16:04', '2026-05-04 09:22:51', NULL),
	('d489c0d9-d72a-42d1-b830-c89c00c3338f', '34ed3sd3ed', 'de3d3ed3ede3de3', 1, '2026-05-03 14:52:58', '2026-05-20 14:55:23', 0, 1, 0, NULL, 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', '', 0, '2026-05-03 14:55:43', '2026-05-03 14:55:43', NULL),
	('ede177d5-bc22-4640-aca3-6e967561180c', 'Test Scrum meeting', 'This scrum meeting is for testing purpose', 6, '2026-04-27 07:34:24', NULL, 1, 0, 0, NULL, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-27 07:22:39', '2026-04-27 07:28:33', NULL);

-- Dumping structure for table dms_ai.reminderschedulers
CREATE TABLE IF NOT EXISTS `reminderschedulers` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` datetime NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `frequency` int DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isRead` tinyint(1) NOT NULL,
  `isEmailNotification` tinyint(1) NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reminderschedulers_documentid_foreign` (`documentId`),
  KEY `reminderschedulers_userid_foreign` (`userId`),
  CONSTRAINT `reminderschedulers_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  CONSTRAINT `reminderschedulers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.reminderschedulers: ~0 rows (approximately)

-- Dumping structure for table dms_ai.reminderusers
CREATE TABLE IF NOT EXISTS `reminderusers` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reminderId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reminderusers_reminderid_foreign` (`reminderId`),
  KEY `reminderusers_userid_foreign` (`userId`),
  CONSTRAINT `reminderusers_reminderid_foreign` FOREIGN KEY (`reminderId`) REFERENCES `reminders` (`id`),
  CONSTRAINT `reminderusers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.reminderusers: ~10 rows (approximately)
INSERT INTO `reminderusers` (`id`, `reminderId`, `userId`) VALUES
	('005d31f7-1f04-43aa-ba07-9bf9b02e6909', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df'),
	('19537061-c8d2-4021-ab5d-9fb57a979e5c', '9898357d-5e2b-46ed-bbe3-236b2325ad6e', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df'),
	('2091e800-7886-4834-bd7f-072951072524', '0d92c4e2-8910-442d-ab02-c98a76a36722', '6021958e-5cbb-4443-9242-8893aa19c3e0'),
	('24f041e3-9e94-43ae-be79-3615298a0e3f', '7d86d9a9-c5f0-4631-8f23-9e6c6180f1e0', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df'),
	('555a4809-fba6-4eb4-8e55-c21054c927e2', 'cc20ef22-0883-4251-99b4-458f89243fa2', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df'),
	('7ab13c21-a3c0-4ee5-8343-cef213f6c8dc', 'd489c0d9-d72a-42d1-b830-c89c00c3338f', '6021958e-5cbb-4443-9242-8893aa19c3e0'),
	('acd99626-a58f-4f8c-b7b3-3a92bab46986', 'ce9dc1fe-0928-4639-b91f-e8bfef62c9af', '6021958e-5cbb-4443-9242-8893aa19c3e0'),
	('bc4c1f67-8ab1-43e4-905c-c8ba40d6d9c8', 'ede177d5-bc22-4640-aca3-6e967561180c', 'b7797b54-5026-49cf-a34e-34d6c168e84c'),
	('ccdef849-b4fd-4164-bd96-e6e33b4af9e5', '24d22983-9d23-4f3f-a308-e79181dab154', '6021958e-5cbb-4443-9242-8893aa19c3e0'),
	('f63ab073-56ea-4ed7-8422-596e13d1946e', 'ede177d5-bc22-4640-aca3-6e967561180c', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df');

-- Dumping structure for table dms_ai.roleclaims
CREATE TABLE IF NOT EXISTS `roleclaims` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actionId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roleId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claimType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `claimValue` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roleclaims_actionid_foreign` (`actionId`),
  KEY `roleclaims_roleid_foreign` (`roleId`),
  CONSTRAINT `roleclaims_actionid_foreign` FOREIGN KEY (`actionId`) REFERENCES `actions` (`id`),
  CONSTRAINT `roleclaims_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.roleclaims: ~229 rows (approximately)
INSERT INTO `roleclaims` (`id`, `actionId`, `roleId`, `claimType`, `claimValue`) VALUES
	('003bf7d3-6110-4cd3-bd82-8f244e5eb3ca', '2f264576-2d7f-44a2-beeb-97c53847ad70', '707626ee-6bb3-4a75-8508-9f0500611e28', 'EMAIL_LOG_SET_RETENTION_PERIOD', NULL),
	('0085595e-b43b-401a-9743-6b6636e2a84a', '72ca5c91-b415-4997-a234-b4d71ba03253', '707626ee-6bb3-4a75-8508-9f0500611e28', 'SETTING_MANAGE_LANGUAGE', NULL),
	('012007a5-d3f4-4683-b40c-e8bc711bef8e', 'e506ec48-b99a-45b4-9ec9-6451bc67477b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'USER_ASSIGN_PERMISSION', NULL),
	('031a749c-fcf7-4d75-8b0f-8e3a5106b434', 'c2d3e4f5-6a7b-8c9d-0e1f-2a3b4c5d6e7f', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_DELETE_WORKFLOW', NULL),
	('03e34ad9-ae33-4c52-bd53-8ecefa856105', '4cce3cb4-5179-4fc7-b59c-7b15afc747f7', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'CLIENTS_MANAGE_CLIENTS', NULL),
	('05d12ab5-5551-4212-8a59-91286b068192', '322c388d-0ab4-4617-9bee-a8c79906e738', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_SET_RETENTION_PERIOD', ''),
	('06799dbe-c970-4a77-9eed-5a23d117f25c', 'c04a1094-f289-4de7-b788-9f21ee3fe32a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_SEND_EMAIL', NULL),
	('06b9bcbe-1ee3-4f48-84d5-d60897e1808e', '374d74aa-a580-4928-848d-f7553db39914', '707626ee-6bb3-4a75-8508-9f0500611e28', 'USER_DELETE_USER', NULL),
	('07fe22f9-0b4c-4e91-94b2-e0f404998bdd', 'ac6d6fbc-6348-4149-9c0c-154ab79d1166', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ASSIGNED_DOCUMENTS_SHARE_DOCUMENT', NULL),
	('08171651-7655-4241-a581-0c63cfb2f456', 'f5829228-ea73-4389-8aee-e2dc8ef6934a', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOC_ADD_SIGNATURE', NULL),
	('09433d62-e3b2-4030-ac34-836cccc36b5c', 'fa5b07a4-e8c4-40e2-b5cf-f1a562087783', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'VIEW_AI_GENERATED_DOCUMENTS', NULL),
	('0b9c9eb2-22c1-4390-a49a-9b0c78e39372', '0478e8b6-7d52-4c26-99e1-657a1c703e8b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_DELETE_FILE_REQUEST', NULL),
	('0e667f60-7c92-4d8e-a87b-e2c1570540fc', '324192f0-a319-4228-ba06-f1ce10189822', '707626ee-6bb3-4a75-8508-9f0500611e28', 'LOGIN_AUDIT_SET_RETENTION_PERIOD', NULL),
	('0f2f26ce-20ab-445e-be57-73e002e1a9df', '31ba8e74-8fa0-4c34-82ac-950e73a4c18e', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EXPIRED_DOCUMENTS_ACTIVATE_DOCUMENT', NULL),
	('101ab30a-8bcc-43dc-85ff-084b51f1b986', 'db8825b1-ee4e-49f6-9a08-b0210ed53fd4', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ROLE_CREATE_ROLE', NULL),
	('106f2976-04b9-4318-8748-565c77685d54', 'f508f793-5d4c-4e03-889c-2c62b6cf484f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_MY_WORKFLOWS', NULL),
	('11e4a9f2-f7d5-454d-9088-271e86fd2d4e', '229ad778-c7d3-4f5f-ab52-24b537c39514', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_DELETE_DOCUMENT', NULL),
	('1272ef49-7cd7-4326-bcea-f0a0b0f4f500', 'ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', '707626ee-6bb3-4a75-8508-9f0500611e28', 'LOGIN_AUDIT_VIEW_LOGIN_AUDIT_LOGS', NULL),
	('131e8af1-d407-45de-9b71-c0b12e17f72f', '086ce19f-5f1b-42ec-98ac-dea2d92901a3', '707626ee-6bb3-4a75-8508-9f0500611e28', 'EXPIRED_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
	('14462325-095e-4a3a-b282-b2bd2c0e7962', 'e017d419-8080-4b2d-ac89-4e966182a12f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'MANAGE_DOCUMENT_STATUS', NULL),
	('1514dc8b-0e55-4e65-815b-38080c21841d', '26e383c9-7f7f-4ed0-b78d-a2941f5b4fe7', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_ADD_REMINDER', NULL),
	('15355137-76a5-4cd8-97d2-b69c121014cf', '9a086704-b7c2-4dff-9088-dde29ad259ef', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DEEP_SEARCH_REMOVE_INDEXING', NULL),
	('17255753-5980-4ff1-8c25-764b1a7ef182', '18d07817-4b47-4c84-b21f-abe05da5e1ba', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
	('1796cc90-e5d4-45ad-a510-67f3b85a2272', '595a769d-f7ef-45f3-9f9e-60c58c5e1542', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_SEND_EMAIL', NULL),
	('18b1352e-1552-46e4-a359-e76e1c936cdd', '2ea6ba08-eb36-4e34-92d9-f1984c908b31', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_SHARE_DOCUMENT', NULL),
	('19ac6744-414a-47d6-a081-ed44ec2d8bd8', 'b36cf0a4-ad53-4938-aac5-fb7fbfc2cfcf', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_RESTORE_VERSION', NULL),
	('1a43a4d7-9942-4e20-b888-1d656ae3a9e8', '63355376-2650-4949-9580-fc8c888353f0', '707626ee-6bb3-4a75-8508-9f0500611e28', 'SETTINGS_MANAGE_OPEN_AI_API_KEY', NULL),
	('1a9d9378-057e-43a4-a164-332c2a2add74', '44ecbcaf-6d4a-4fc2-911c-e96be65bffb2', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_MANAGE_COMMENT', NULL),
	('1c074970-b56e-4089-a528-e7610a45695c', 'bc515aea-ef66-4d8d-9cdb-47477cb74145', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'MANAGE_AI_PROMPT_TEMPLATES', NULL),
	('1d031cab-8a85-4965-b3a2-ba1b97e9f85c', '374d74aa-a580-4928-848d-f7553db39914', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_DELETE_USER', NULL),
	('1d25e335-e458-4eb9-b16b-39fec12cf79b', '37db8a21-e552-466d-bcf4-f90f5e4e1008', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_VIEW_DETAIL', NULL),
	('1d5d87a6-4163-4915-8b4f-0d51cd3b437a', '3da78b4d-d263-4b13-8e81-7aa164a3688c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_ADD_REMINDER', NULL),
	('1d5f1fda-b277-4e7d-ae3c-6ea1779a4cb1', '6f2717fc-edef-4537-916d-2d527251a5c1', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'REMINDER_VIEW_REMINDERS', NULL),
	('1eb312da-21d3-44af-992c-660a3b6bc446', '92596605-e49a-4ab6-8a39-60116eba8abe', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_DELETE_DOCUMENT', NULL),
	('24bd14f5-63e5-418a-a2be-6e86aae5ec86', '0f70cc17-26a9-43b1-922e-01fefb248d3c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_WORKFLOW_SETTINGS', NULL),
	('25241f34-ba15-4397-84d1-f7f3cb7049bb', '260d1089-46c7-4f53-83e6-f80b9b3fb823', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
	('26bb614e-9495-40eb-a6f7-3710db468b0c', '4cce3cb4-5179-4fc7-b59c-7b15afc747f7', '707626ee-6bb3-4a75-8508-9f0500611e28', 'CLIENTS_MANAGE_CLIENTS', NULL),
	('29b3fcf4-d9be-4aed-9ea2-e56349de142c', '6719a065-8a4a-4350-8582-bfc41ce283fb', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_DOWNLOAD_DOCUMENT', NULL),
	('2a22cbd8-f5ab-4ad0-b212-33dfcdb1ec3c', '41f65d07-9023-4cfb-9c7c-0e3247a012e0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EMAIL_MANAGE_SMTP_SETTINGS', NULL),
	('2affbde7-beea-4871-98cf-795489e1fccd', 'fa91ffd9-61ee-4bb1-bf86-6a593cdc7be9', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_CREATE_DOCUMENT', NULL),
	('2c8939c8-ef43-4a16-8524-74ae64fb8284', 'a5b485ac-8c7b-4a4f-a62d-6f839d77e91f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_VIEW_VERSION_HISTORY', NULL),
	('2d04d150-b33a-463a-ba35-8058724e4f96', 'fa91ffd9-61ee-4bb1-bf86-6a593cdc7be9', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_CREATE_DOCUMENT', NULL),
	('2d34fa40-4d51-4a25-8808-f28e49946294', 'e3fcd910-3f9b-4035-9bbb-312c5b599d52', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'GENERATE_AI_DOCUMENTS', NULL),
	('2e27b009-7c47-4962-8920-a41b54be98b8', 'cb988c3a-7487-4366-9521-c0c5adf9b5a6', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'BULK_DOCUMENT_UPLOAD', NULL),
	('2f47632a-45cf-4659-8da0-76f973ac44cf', 'a57b1ad5-8fbc-429b-b776-fbb468e5c6a4', '707626ee-6bb3-4a75-8508-9f0500611e28', 'SETTING_MANAGE_PROFILE', NULL),
	('2ff65f82-4c52-4004-b241-457c15acd217', '5f24c3d8-94d8-4e57-adb3-bef3e000e7d0', '707626ee-6bb3-4a75-8508-9f0500611e28', 'EXPIRED_DOCUMENTS_VIEW_DOCUMENT', NULL),
	('30262d6c-dcbf-465e-bb06-2807db1e0ad5', 'e9ff854b-23f7-46c2-9029-efba3d8587b5', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_MANAGE_SHARABLE_LINK', NULL),
	('313b53d8-98e0-4851-9f80-29e96957bf48', 'e3fcd910-3f9b-4035-9bbb-312c5b599d52', '707626ee-6bb3-4a75-8508-9f0500611e28', 'GENERATE_AI_DOCUMENTS', NULL),
	('31e42bba-6973-4696-948a-b35694a14f2b', '63ed1277-1db5-4cf7-8404-3e3426cb4bc5', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_VIEW_DOCUMENTS', NULL),
	('337223e8-68fc-4df0-acec-1681dde68332', 'a5b485ac-8c7b-4a4f-a62d-6f839d77e91f', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_VIEW_VERSION_HISTORY', NULL),
	('34312716-5bce-45a9-b842-802465db70fc', '165505b2-ad31-42c7-aafe-f66f291cb5a9', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_MANAGE_COMMENT', NULL),
	('347d9be0-49ec-4436-a700-38a6580142c7', '1e5fc904-5f70-4b07-8914-242703da5702', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGS_VIEW_EMAIL_LOGS', ''),
	('34c88d61-0091-4492-bace-72852beb9741', '7ba630ca-a9d3-42ee-99c8-766e2231fec1', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'DASHBOARD_VIEW_DASHBOARD', NULL),
	('36706f80-6be0-4c5d-8b0f-7d1f00c009f1', '92596605-e49a-4ab6-8a39-60116eba8abe', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_DELETE_DOCUMENT', NULL),
	('37b1a199-8dc6-482a-a11d-521773f3b59e', 'cb988c3a-7487-4366-9521-c0c5adf9b5a6', '707626ee-6bb3-4a75-8508-9f0500611e28', 'BULK_DOCUMENT_UPLOAD', NULL),
	('38150b34-bcca-4348-9a9f-dd98bcb1b750', '595a769d-f7ef-45f3-9f9e-60c58c5e1542', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_SEND_EMAIL', NULL),
	('391906f7-67f3-4f83-9493-792f1db5e167', '7562978b-155a-4fb1-bc3f-6153f62ed565', '707626ee-6bb3-4a75-8508-9f0500611e28', 'FILE_REQUEST_VIEW_FILE_REQUEST', NULL),
	('3979fbc2-e54c-41b4-b9d7-87ef963ef688', '2f264576-2d7f-44a2-beeb-97c53847ad70', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EMAIL_LOG_SET_RETENTION_PERIOD', ''),
	('39948cc2-e67c-4949-89ce-c4026062618b', '96865813-77f0-40cf-968d-8b9c023d810e', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_ADD_WORKFLOW', NULL),
	('39cc12b7-f432-460e-a655-d612bea28bb0', '44ecbcaf-6d4a-4fc2-911c-e96be65bffb2', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_MANAGE_COMMENT', NULL),
	('39e40495-295a-46f2-b585-df81fbb3cdae', '7562978b-155a-4fb1-bc3f-6153f62ed565', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_VIEW_FILE_REQUEST', NULL),
	('3cf73cb0-b163-4584-ac25-1c80c3734469', '324192f0-a319-4228-ba06-f1ce10189822', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGIN_AUDIT_SET_RETENTION_PERIOD', ''),
	('3d6b7fbe-f3a0-4ed6-8147-050d7cf0dcec', 'd57ff519-1448-4336-8d76-98d43a9ada2c', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_ALL_CANCEL_WORKFLOW', NULL),
	('3eb46076-eabe-4b4f-ab8c-d97e94acbf4f', '72ce114a-d299-4d7d-aeee-598167a4fabc', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOC_GENERATE_SUMMARY', ''),
	('3f25ea31-0288-4f7b-ae4b-6505e243a15b', 'c288b5d3-419d-4dc0-9e5a-083194016d2c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_EDIT_ROLE', NULL),
	('3f925c44-1873-424c-a764-bf399fe5eae5', '18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ROLE_DELETE_ROLE', NULL),
	('3fd6e98d-4d28-4e8e-87e7-246b5ca8ebcf', '1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DOCUMENT_AUDIT_TRAIL_VIEW_DOCUMENT_AUDIT_TRAIL', NULL),
	('40c21dec-e3ea-4e14-88fa-c0b512431837', 'c2d3e4f5-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_DELETE_WORKFLOW', NULL),
	('430fc3c7-99c9-4883-a84a-8cb9e37c85c1', '31ba8e74-8fa0-4c34-82ac-950e73a4c18e', '707626ee-6bb3-4a75-8508-9f0500611e28', 'EXPIRED_DOCUMENTS_ACTIVATE_DOCUMENT', NULL),
	('4314e241-8746-456d-8072-365181d26282', 'c18e4105-e9d7-4c5d-b396-a2854bcb8e21', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_VIEW_VERSION_HISTORY', NULL),
	('47203d2f-a4ab-4584-ae16-660b8ef39483', 'a57b1ad5-8fbc-429b-b776-fbb468e5c6a4', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTING_MANAGE_PROFILE', NULL),
	('4732c1c1-ef66-4df6-8d49-0803f861e5fd', '1e5fc904-5f70-4b07-8914-242703da5702', '707626ee-6bb3-4a75-8508-9f0500611e28', 'LOGS_VIEW_EMAIL_LOGS', NULL),
	('4a2df025-2a33-4a21-b684-3b901a96113a', 'd4d724fc-fd38-49c4-85bc-73937b219e20', '707626ee-6bb3-4a75-8508-9f0500611e28', 'USER_RESET_PASSWORD', NULL),
	('4aa2e80f-ed80-4f77-b815-28a182616359', 'b36cf0a4-ad53-4938-aac5-fb7fbfc2cfcf', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_RESTORE_VERSION', NULL),
	('4efea0e4-a762-4f98-8f2b-6cbc757beae3', 'bf3ec13f-1e81-40f3-ad7a-05523608e85c', '707626ee-6bb3-4a75-8508-9f0500611e28', 'SETTINGS_MANAGE_GEMINI_API_KEY', NULL),
	('50125e00-8fa3-4930-bdef-0c25c4e9c20d', '8e3fbe21-0225-44e2-a537-bb50ddffb95c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_MANAGE_ALLOW_FILE_EXTENSIONS', NULL),
	('513b12f7-fe15-4864-aeeb-b546ec7f86b7', '26e383c9-7f7f-4ed0-b78d-a2941f5b4fe7', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_ADD_REMINDER', NULL),
	('52ad0436-27bd-4387-9da6-118ea0467e6a', '229150ef-9007-4c62-9276-13dd18294370', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_RESTORE_VERSION', NULL),
	('53ada20e-d861-464e-ab01-fdd40efc7c13', '4f0e8a83-8a01-415e-88f5-c204369290de', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DEEP_SEARCH_DEEP_SEARCH', NULL),
	('53c60147-b09f-4a74-9a1d-785dd3424e68', '6f2717fc-edef-4537-916d-2d527251a5c1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_VIEW_REMINDERS', NULL),
	('55cd098b-a050-4824-8318-5fa79576b1bb', '2e71e9d6-2302-44d8-b0f6-747b98d89125', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'FILE_REQUEST_UPDATE_FILE_REQUEST', NULL),
	('563d7345-2266-487c-91fa-964586a028ce', '0f70cc17-26a9-43b1-922e-01fefb248d3c', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_VIEW_WORKFLOW_SETTINGS', NULL),
	('57994ef8-35d1-41ee-8f57-4e136729794a', '2ea6ba08-eb36-4e34-92d9-f1984c908b31', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_SHARE_DOCUMENT', NULL),
	('57bd0276-18ec-4ff5-aec4-5ff83b10aa1e', '96865813-77f0-40cf-968d-8b9c023d810e', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_ADD_WORKFLOW', NULL),
	('57eff421-a0f2-4a45-890d-ee0b6d9cc017', '0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'USER_EDIT_USER', NULL),
	('58417c5c-d97b-4ce3-9753-cf637714d566', '538c081b-2e14-4f0d-bc34-5f26ad2f77cf', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGS_DELETE_EMAIL_LOG', ''),
	('586d4cbe-df73-4a3e-9271-2bbc78f8e5b1', 'e017d419-8080-4b2d-ac89-4e966182a12f', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'MANAGE_DOCUMENT_STATUS', NULL),
	('589db9c8-f668-4bdd-b9e4-f961b6c7ac5c', '63ed1277-1db5-4cf7-8404-3e3426cb4bc5', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_VIEW_DOCUMENTS', NULL),
	('59046720-f7de-4c97-898a-8af9d508f14a', '3ccaf408-8864-4815-a3e0-50632d90bcb6', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'REMINDER_EDIT_REMINDER', NULL),
	('59a099a2-f809-4164-a481-0d777b8d6f93', '57216dcd-1a1c-4f94-a33d-83a5af2d7a46', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ROLE_VIEW_ROLES', NULL),
	('5a6b9d86-1490-447b-b015-c8b47f91f330', '8d7e1668-ab2d-4aa5-b8d1-0358906d6995', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_VIEW_DETAIL', NULL),
	('5cd65967-adb4-4f80-ad77-088e097f3b66', '07ad64e9-9a43-40d0-a205-2adb81e238b1', '707626ee-6bb3-4a75-8508-9f0500611e28', 'SETTINGS_STORAGE_SETTINGS', NULL),
	('5ea8cc34-6887-4fd5-a3a7-43e5f943bd54', '37db8a21-e552-466d-bcf4-f90f5e4e1008', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_VIEW_DETAIL', NULL),
	('5fa28e48-8e62-4479-8bae-a355ba2b55ea', 'ff4b3b73-c29f-462a-afa4-94a40e6b2c4a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGIN_AUDIT_VIEW_LOGIN_AUDIT_LOGS', NULL),
	('61482c70-3abd-4402-83ba-114777420fd1', '6bc0458e-22f5-4975-b387-4d6a4fb35201', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'REMINDER_CREATE_REMINDER', NULL),
	('61d864e7-b597-4ddc-8396-c127140137c2', 'a8dd972d-e758-4571-8d39-c6fec74b361b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_EDIT_DOCUMENT', NULL),
	('62e39d13-8a7f-4a34-96c8-d69174f77027', 'c6e2e9f8-1ee4-4c1d-abd1-721ff604c8b8', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_ADD_REMINDER', NULL),
	('639d9892-77b6-4df1-949c-27bb9981ee2f', 'cb988c3a-7487-4366-9521-c0c5adf9b5a6', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'BULK_DOCUMENT_UPLOAD', NULL),
	('663f60d8-0870-43b1-8d8d-7d902ac2686b', 'fbe77c07-3058-4dbe-9d56-8c75dc879460', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_ASSIGN_USER_ROLE', NULL),
	('671cf49e-1aa9-4e65-84a9-6474e8429655', 'c6e2e9f8-1ee4-4c1d-abd1-721ff604c8b8', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_ADD_REMINDER', NULL),
	('673edb4c-f1cd-4987-81ee-91ab3db6f730', '707c447d-5e0b-454a-abdf-550d8923eabc', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_START_WORKFLOW', NULL),
	('675c0304-41bf-4cab-9fe4-114dfca570f3', 'c288b5d3-419d-4dc0-9e5a-083194016d2c', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ROLE_EDIT_ROLE', NULL),
	('69905a88-2504-4314-be40-5d94c458d594', '8d7e1668-ab2d-4aa5-b8d1-0358906d6995', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_VIEW_DETAIL', NULL),
	('69a1b05b-5713-420b-b3ad-76e7c46240af', 'b1c5f8d2-3e4f-4b0a-9c6d-7e8f9a0b1c2d', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_UPDATE_WORKFLOW', NULL),
	('69a784f5-749e-42fc-924d-3c118e15ee08', 'b4d722d6-755c-4be4-8f0d-2283c9394e18', '707626ee-6bb3-4a75-8508-9f0500611e28', 'FILE_REQUEST_APPROVE_FILE_REQUEST', NULL),
	('6c8e9ad9-b136-4310-a337-944668ab93f8', '6f2717fc-edef-4537-916d-2d527251a5c1', '707626ee-6bb3-4a75-8508-9f0500611e28', 'REMINDER_VIEW_REMINDERS', NULL),
	('6d9be43f-950a-4185-8967-0f37d89560d1', '239035d5-cd44-475f-bbc5-9ef51768d389', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ALL_DOCUMENTS_CREATE_DOCUMENT', NULL),
	('6de556d0-f988-4d1a-b1cf-1d08557b9696', '31cb6438-7d4a-4385-8a34-b4e8f6096a48', '707626ee-6bb3-4a75-8508-9f0500611e28', 'USER_VIEW_USERS', NULL),
	('6e179205-b7d7-4cb9-9496-c5da933b3bc4', 'b0f2a1c4-3d8e-4b5c-9f6d-7a0e5f3b8c1d', '707626ee-6bb3-4a75-8508-9f0500611e28', 'DELETE_AI_GENERATED_DOCUMENTS', NULL),
	('732267bf-894d-4517-bd3b-f82b672a89a1', '707c447d-5e0b-454a-abdf-550d8923eabc', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_START_WORKFLOW', NULL),
	('7380aa43-2261-42c2-967b-d37e50daaa7a', 'd9067d75-e3b9-4d2d-8f82-567ad5f2b9ca', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_VIEW_DOCUMENTS', NULL),
	('73fc24d2-1def-45bc-8f5f-483c767ac6b2', '61de0ba3-f41f-4ca8-9af6-ec8dc456c16b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'FILE_REQUEST_CREATE_FILE_REQUEST', NULL),
	('74af9f3c-adbe-4cef-969e-9b3f6c610051', '7562978b-155a-4fb1-bc3f-6153f62ed565', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'FILE_REQUEST_VIEW_FILE_REQUEST', NULL),
	('75596b60-33ce-46f3-bcae-f05ced8e7305', '4cce3cb4-5179-4fc7-b59c-7b15afc747f7', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'CLIENTS_MANAGE_CLIENTS', NULL),
	('7566f924-f73d-4be1-9a7b-bfaead990c9c', '2e71e9d6-2302-44d8-b0f6-747b98d89125', '707626ee-6bb3-4a75-8508-9f0500611e28', 'FILE_REQUEST_UPDATE_FILE_REQUEST', NULL),
	('75e3dd10-bf0b-471c-b532-5f605eadf9e9', '239035d5-cd44-475f-bbc5-9ef51768d389', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_CREATE_DOCUMENT', NULL),
	('78a526f1-a506-4b94-8287-4104ed836088', 'dba2e7bf-6bac-4620-a9e6-d4eaa2c8480f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'PAGE_HELPER_MANAGE_PAGE_HELPER', NULL),
	('79bbc319-3115-4278-844a-c2d209af1e0d', '9a086704-b7c2-4dff-9088-dde29ad259ef', '707626ee-6bb3-4a75-8508-9f0500611e28', 'DEEP_SEARCH_REMOVE_INDEXING', NULL),
	('7a12397d-3ac6-434d-bcef-8c1403a497a6', '3ccaf408-8864-4815-a3e0-50632d90bcb6', '707626ee-6bb3-4a75-8508-9f0500611e28', 'REMINDER_EDIT_REMINDER', NULL),
	('7ae1cb27-72c3-4b61-b41c-abffd1b5e318', '6bc0458e-22f5-4975-b387-4d6a4fb35201', '707626ee-6bb3-4a75-8508-9f0500611e28', 'REMINDER_CREATE_REMINDER', NULL),
	('7b12b3ba-c11d-48fc-977c-ff33c29e3b5e', 'bc515aea-ef66-4d8d-9cdb-47477cb74145', '707626ee-6bb3-4a75-8508-9f0500611e28', 'MANAGE_AI_PROMPT_TEMPLATES', NULL),
	('7b134356-6092-4d96-b960-69a09d78abc0', 'c04a1094-f289-4de7-b788-9f21ee3fe32a', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_SEND_EMAIL', NULL),
	('7c7f6c20-c167-4393-a3bb-aaf3dc1e056d', '6bc0458e-22f5-4975-b387-4d6a4fb35201', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_CREATE_REMINDER', NULL),
	('7d668b03-937e-4e47-878a-e4a4bd203b2e', 'aa712002-aa9a-4656-9835-34278487a848', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGN_ADD_SIGNATURE', NULL),
	('8035681f-b676-45fe-9ce5-00bd2993ff3c', '7ba630ca-a9d3-42ee-99c8-766e2231fec1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DASHBOARD_VIEW_DASHBOARD', NULL),
	('85336509-aa30-4fd1-bf1b-110e91923e94', '229150ef-9007-4c62-9276-13dd18294370', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_RESTORE_VERSION', NULL),
	('85c65457-c988-4891-9bbc-938782aca671', '322c388d-0ab4-4617-9bee-a8c79906e738', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ARCHIVE_DOCUMENT_SET_RETENTION_PERIOD', NULL),
	('8bd72e94-047f-4c19-88b3-89700c546d30', '61de0ba3-f41f-4ca8-9af6-ec8dc456c16b', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'FILE_REQUEST_CREATE_FILE_REQUEST', NULL),
	('8c88816b-b14e-4ee5-95d8-a44bc0baccc6', '8e3fbe21-0225-44e2-a537-bb50ddffb95c', '707626ee-6bb3-4a75-8508-9f0500611e28', 'SETTINGS_MANAGE_ALLOW_FILE_EXTENSIONS', NULL),
	('8ebab0f7-e476-425b-95c0-dfb11e4d2a0d', '8b63ccd0-616a-4b97-8af6-aa49066a0a9e', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOC_GENERATE_SUMMARY', ''),
	('8eca94e8-b5cd-438f-a389-4a9798519048', 'db8825b1-ee4e-49f6-9a08-b0210ed53fd4', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_CREATE_ROLE', NULL),
	('93775729-b9b5-4426-bf14-ccf6de43604d', '9ac0f6f5-0731-49d9-a7b9-6fbd92291241', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'CRON_JOB_LOG_SET_RETENTION_PERIOD', ''),
	('940b5b6a-7af7-4ef7-8f52-4b2b62e7eb61', '260d1089-46c7-4f53-83e6-f80b9b3fb823', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
	('9468157b-0ffe-4032-b8d0-cac9ce3da991', '57216dcd-1a1c-4f94-a33d-83a5af2d7a46', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_VIEW_ROLES', NULL),
	('94d4e22c-1127-4071-b559-b8a1738f5e5a', '18d07817-4b47-4c84-b21f-abe05da5e1ba', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
	('94e07e1f-c357-4bf7-bbdd-703636e2255a', '1d768490-d67d-40b6-b610-22b17cc7ce2d', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'DEEP_SEARCH_ADD_INDEXING', NULL),
	('94f5548d-7d00-4204-b6bb-45c6506c8233', '86ce1382-a2b1-48ed-ae81-c9908d00cf3b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_CREATE_USER', NULL),
	('95ebdc3b-0b28-43ad-b5d3-c6987fa20011', 'd9067d75-e3b9-4d2d-8f82-567ad5f2b9ca', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ARCHIVE_DOCUMENT_VIEW_DOCUMENTS', NULL),
	('97f46531-5928-4e7e-9141-f9e3128b486d', 'ac6d6fbc-6348-4149-9c0c-154ab79d1166', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_SHARE_DOCUMENT', NULL),
	('99242b64-1600-4d1f-bc01-2e33a2169b7a', '79ce78a8-0716-4850-a40b-cdc36f3579e4', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_VIEW_WORKFLOW_LOGS', NULL),
	('99a280fd-e214-45df-a436-befc7e01069d', '5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', '707626ee-6bb3-4a75-8508-9f0500611e28', 'REMINDER_DELETE_REMINDER', NULL),
	('9a51f65a-8f67-4408-9112-519250d6ad5a', '57f0b2ef-eeba-44a6-bd88-458003f013ef', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_UPLOAD_NEW_VERSION', NULL),
	('9bb2adcc-3c8e-4555-a0f7-8ac1c769c0e8', 'a737284a-e43b-481d-9fdd-07e1680ffe11', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_EDIT_DOCUMENT', NULL),
	('9d1537d1-dc37-4434-92bc-27b76ad04246', 'a8dd972d-e758-4571-8d39-c6fec74b361b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_EDIT_DOCUMENT', NULL),
	('9dbed0d1-02cb-4f53-b6e2-728358091f93', '165505b2-ad31-42c7-aafe-f66f291cb5a9', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_MANAGE_COMMENT', NULL),
	('a1905d84-6357-48dd-bcf8-1839e3736d1c', '79ce78a8-0716-4850-a40b-cdc36f3579e4', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_WORKFLOW_LOGS', NULL),
	('a3c45829-d1fe-42a4-9805-bc99fe93be69', 'fbe77c07-3058-4dbe-9d56-8c75dc879460', '707626ee-6bb3-4a75-8508-9f0500611e28', 'USER_ASSIGN_USER_ROLE', NULL),
	('a3cff737-7bfc-40ad-94a3-0ee572154005', '72ca5c91-b415-4997-a234-b4d71ba03253', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTING_MANAGE_LANGUAGE', NULL),
	('a53f8717-2500-4afa-b708-b012d829f26e', 'd9067d75-e3b9-4d2d-8f82-567ad5f2b9ca', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ARCHIVE_DOCUMENT_VIEW_DOCUMENTS', NULL),
	('a5a08f90-2871-4cc5-9079-993325a7af77', '72ce114a-d299-4d7d-aeee-598167a4fabc', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOC_GENERATE_SUMMARY', NULL),
	('a6aec532-48b7-4f40-81ab-64ca3bec697c', '5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_DELETE_REMINDER', NULL),
	('a7b13a19-6323-4e98-b3be-c5d33780ce16', 'e9ff854b-23f7-46c2-9029-efba3d8587b5', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_MANAGE_SHARABLE_LINK', NULL),
	('a856b02b-2f4b-4451-afba-591985744e8f', '1d768490-d67d-40b6-b610-22b17cc7ce2d', '707626ee-6bb3-4a75-8508-9f0500611e28', 'DEEP_SEARCH_ADD_INDEXING', NULL),
	('aba4ca2f-3821-4c27-8d1a-dd47a6ccb540', 'd57ff519-1448-4336-8d76-98d43a9ada2c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_ALL_CANCEL_WORKFLOW', NULL),
	('ad098140-781c-4238-a75d-ca2c1f807f4e', '86ce1382-a2b1-48ed-ae81-c9908d00cf3b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'USER_CREATE_USER', NULL),
	('ad408ccf-6c65-455a-ba09-f06e8bfced87', '4f0e8a83-8a01-415e-88f5-c204369290de', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'DEEP_SEARCH_DEEP_SEARCH', NULL),
	('add2dd23-a2e5-4daa-97cf-59372b3499cf', '3da78b4d-d263-4b13-8e81-7aa164a3688c', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_ADD_REMINDER', NULL),
	('ae0b1ea9-35d6-460a-9a93-6dc71f76e1df', '0478e8b6-7d52-4c26-99e1-657a1c703e8b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'FILE_REQUEST_DELETE_FILE_REQUEST', NULL),
	('ae5cc9f6-926b-4f36-9b17-46cb6de07331', 'aa712002-aa9a-4656-9835-34278487a848', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGN_ADD_SIGNATURE', ''),
	('b1d3388c-3479-4e9e-b6f9-5b9752832dda', 'a8dd972d-e758-4571-8d39-c6fec74b361b', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ALL_DOCUMENTS_EDIT_DOCUMENT', NULL),
	('b20a5380-0606-43ae-853b-d56e0e7e1102', 'a74e0f79-bc3c-4582-a2ea-008d568e6a8b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'LOGS_VIEW_CRON_JOBS_LOGS', NULL),
	('b2c652c2-164c-40cd-923e-fb9b84506420', 'a74e0f79-bc3c-4582-a2ea-008d568e6a8b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'LOGS_VIEW_CRON_JOBS_LOGS', ''),
	('b35ff7f1-976b-410e-b6e9-f34a91753f02', '391c1739-1045-4dd4-9705-4a960479f0a0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_UPLOAD_NEW_VERSION', NULL),
	('b42bcd3d-c3bd-4522-80fa-ddf3df0243b2', '7ba630ca-a9d3-42ee-99c8-766e2231fec1', '707626ee-6bb3-4a75-8508-9f0500611e28', 'DASHBOARD_VIEW_DASHBOARD', NULL),
	('b45c243d-89f2-4594-a1df-a31a2f9f6ae7', '41f65d07-9023-4cfb-9c7c-0e3247a012e0', '707626ee-6bb3-4a75-8508-9f0500611e28', 'EMAIL_MANAGE_SMTP_SETTINGS', NULL),
	('b4eb3e41-8076-41aa-a9a0-9823977c9297', 'ef979f76-027c-4b20-9330-5c81a3dc5869', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOC_WATERMARK', ''),
	('b5af9509-82ec-4250-927f-41bf71efc187', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_START_WORKFLOW', NULL),
	('b624396c-42ed-4b6b-b565-0558e93769a5', '18a5a8f6-7cb6-4178-857d-b6a981ea3d4f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ROLE_DELETE_ROLE', NULL),
	('b740f7f7-ed5e-44ac-af7c-5f161cb9837f', 'bf3ec13f-1e81-40f3-ad7a-05523608e85c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_MANAGE_GEMINI_API_KEY', ''),
	('b7ec15a1-4451-4332-92fd-7d1112e8df58', '78d881d1-1da5-42d9-a97b-a6ad71e27ebc', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOC_WATERMARK', NULL),
	('b98fc385-4681-4d93-a1c5-103c808fccab', '9a086704-b7c2-4dff-9088-dde29ad259ef', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'DEEP_SEARCH_REMOVE_INDEXING', NULL),
	('b9ed0cf3-a133-4f22-89bb-24ffe0fab31b', '6719a065-8a4a-4350-8582-bfc41ce283fb', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_DOWNLOAD_DOCUMENT', NULL),
	('bb539daa-419e-4fcf-b5a0-ae9dde4e3ed8', 'b0f2a1c4-3d8e-4b5c-9f6d-7a0e5f3b8c1d', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DELETE_AI_GENERATED_DOCUMENTS', NULL),
	('bc88adf8-9281-4f02-b76c-7804a1c757d8', 'cd46a3a4-ede5-4941-a49b-3df7eaa46428', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY', NULL),
	('c012447c-aad0-4728-8c2c-198c7b0e0352', 'f4d8a768-151d-4ec9-a8e3-41216afe0ec0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_DELETE_DOCUMENTS', NULL),
	('c0ee9ee1-5f85-4495-9b06-1f7ca57afb8d', '9ac0f6f5-0731-49d9-a7b9-6fbd92291241', '707626ee-6bb3-4a75-8508-9f0500611e28', 'CRON_JOB_LOG_SET_RETENTION_PERIOD', NULL),
	('c3ace46b-6c59-4091-8279-ec66f8784cfa', '1c7d3e31-08ad-43cf-9cf7-4ffafdda9029', '707626ee-6bb3-4a75-8508-9f0500611e28', 'DOCUMENT_AUDIT_TRAIL_VIEW_DOCUMENT_AUDIT_TRAIL', NULL),
	('c469fd87-d908-4073-b3af-4b897b31fd29', 'f508f793-5d4c-4e03-889c-2c62b6cf484f', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_VIEW_MY_WORKFLOWS', NULL),
	('c47c3f16-fbac-42ae-ad24-6767fae462b9', '61de0ba3-f41f-4ca8-9af6-ec8dc456c16b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_CREATE_FILE_REQUEST', NULL),
	('c5c5a7c3-645e-4a15-b706-e8cd5923fd53', '8b63ccd0-616a-4b97-8af6-aa49066a0a9e', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOC_GENERATE_SUMMARY', NULL),
	('c6d0b372-bae4-4c1a-b3f5-e145b1a53840', 'fa5b07a4-e8c4-40e2-b5cf-f1a562087783', '707626ee-6bb3-4a75-8508-9f0500611e28', 'VIEW_AI_GENERATED_DOCUMENTS', NULL),
	('c794ebba-1531-482f-8b81-c87798f7855a', '4f0e8a83-8a01-415e-88f5-c204369290de', '707626ee-6bb3-4a75-8508-9f0500611e28', 'DEEP_SEARCH_DEEP_SEARCH', NULL),
	('c7ef029e-144c-4f4d-88c8-b287d162fe74', 'dba2e7bf-6bac-4620-a9e6-d4eaa2c8480f', '707626ee-6bb3-4a75-8508-9f0500611e28', 'PAGE_HELPER_MANAGE_PAGE_HELPER', NULL),
	('c8aa16d3-dc91-44d5-8933-84783814da1e', 'f165f5a2-fe26-490a-91bc-08a736096fed', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_VIEW_ALL_WORKFLOWS', NULL),
	('c9242bfd-025f-4e19-ac01-09b17cd1ee3a', 'ac6d6fbc-6348-4149-9c0c-154ab79d1166', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_SHARE_DOCUMENT', NULL),
	('ca0d3046-ba08-4b01-ae0d-78af5ee9df4b', '0478e8b6-7d52-4c26-99e1-657a1c703e8b', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'FILE_REQUEST_DELETE_FILE_REQUEST', NULL),
	('ca3f1a41-4adf-4d43-982f-195073302fa8', '63355376-2650-4949-9580-fc8c888353f0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_MANAGE_OPEN_AI_API_KEY', NULL),
	('cb76e5e1-1bd5-43fb-8098-6db7aaeca0de', '538c081b-2e14-4f0d-bc34-5f26ad2f77cf', '707626ee-6bb3-4a75-8508-9f0500611e28', 'LOGS_DELETE_EMAIL_LOG', NULL),
	('cc694a1f-d72d-4523-b8e0-595f44333bec', '6b0fe007-1b92-4568-a4b7-6d105eb5c48c', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_ALL_PERFORM_TRANSITION', NULL),
	('cd1ad1af-1dbe-4fd3-9b31-ebe5719e521a', '239035d5-cd44-475f-bbc5-9ef51768d389', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_CREATE_DOCUMENT', NULL),
	('ce4a777d-d9f1-4ced-9505-bdaa9a9fd813', '5f7c13fd-3c5d-4e69-9e21-a263924d273b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_CHANGE_PDF_SETTINGS', ''),
	('d1cae036-fe4f-4479-8d03-7aba0f1f3d86', '3ccaf408-8864-4815-a3e0-50632d90bcb6', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'REMINDER_EDIT_REMINDER', NULL),
	('d4e9dfa8-6564-42ff-b8f9-cd48cfc33ead', 'e506ec48-b99a-45b4-9ec9-6451bc67477b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_ASSIGN_PERMISSION', NULL),
	('d5c84749-dd31-4815-833c-abcd3ca20646', '086ce19f-5f1b-42ec-98ac-dea2d92901a3', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EXPIRED_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
	('d67f4f42-3a7e-4fdc-bef0-dc4292f59652', '086ce19f-5f1b-42ec-98ac-dea2d92901a3', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'EXPIRED_DOCUMENTS_ARCHIVE_DOCUMENT', NULL),
	('d87778c9-81ec-490c-b12e-7df71714b2c8', 'f9ec1096-b798-4623-bbf8-4f5d4fe775e9', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_MANAGE_SHARABLE_LINK', NULL),
	('d915adcc-e5cd-45e3-a78a-5ab9a9176236', '5f24c3d8-94d8-4e57-adb3-bef3e000e7d0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'EXPIRED_DOCUMENTS_VIEW_DOCUMENT', NULL),
	('da74ab5e-c585-4186-b62c-aa147a446b94', 'ef979f76-027c-4b20-9330-5c81a3dc5869', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ASSIGNED_DOC_WATERMARK', NULL),
	('dba277e5-a70e-4049-bcbc-49e386ab685f', 'd4d724fc-fd38-49c4-85bc-73937b219e20', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_RESET_PASSWORD', NULL),
	('dc844230-498c-4ff6-86ff-f3e1a88bd1e2', 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_START_WORKFLOW', NULL),
	('dfb958a4-b15a-4b43-8b64-0c18d0be3d74', '0a2e19fc-d9f2-446c-8ca3-e6b8b73b5f9b', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_EDIT_USER', NULL),
	('dff36ced-7390-4a47-aa86-c7964ae29699', '5f7c13fd-3c5d-4e69-9e21-a263924d273b', '707626ee-6bb3-4a75-8508-9f0500611e28', 'SETTINGS_CHANGE_PDF_SETTINGS', NULL),
	('e2cde46e-381b-47a3-a52f-f76d34829170', 'b1c5f8d2-3e4f-4b0a-9c6d-7e8f9a0b1c2d', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_UPDATE_WORKFLOW', NULL),
	('e33d5df7-be33-4e97-b3a8-420504f628eb', 'c18e4105-e9d7-4c5d-b396-a2854bcb8e21', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_VIEW_VERSION_HISTORY', NULL),
	('e3c667fc-4866-4458-a2aa-936418b650d0', '07ad64e9-9a43-40d0-a205-2adb81e238b1', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'SETTINGS_STORAGE_SETTINGS', NULL),
	('e67a4d28-e0b4-477d-be88-7fece937262f', 'f165f5a2-fe26-490a-91bc-08a736096fed', '707626ee-6bb3-4a75-8508-9f0500611e28', 'WORKFLOW_VIEW_ALL_WORKFLOWS', NULL),
	('e8401bbb-0203-4b95-9ab5-126e78cb344b', '31cb6438-7d4a-4385-8a34-b4e8f6096a48', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'USER_VIEW_USERS', NULL),
	('e9ce5a9d-cb19-47e3-bd3b-8a4b7bf9c64b', '2e71e9d6-2302-44d8-b0f6-747b98d89125', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_UPDATE_FILE_REQUEST', NULL),
	('e9df289f-906e-441f-b2e0-0ef48ccb30e3', '78d881d1-1da5-42d9-a97b-a6ad71e27ebc', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOC_WATERMARK', ''),
	('ead96c66-ea5d-42bf-9eca-7f42a6b3e3d0', 'ef979f76-027c-4b20-9330-5c81a3dc5869', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOC_WATERMARK', NULL),
	('ebfd484c-487b-41f5-8e34-e20867220331', '57f0b2ef-eeba-44a6-bd88-458003f013ef', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOCUMENTS_UPLOAD_NEW_VERSION', NULL),
	('edc5f5c0-3976-49d1-835f-3e6cb7cc2bac', 'e017d419-8080-4b2d-ac89-4e966182a12f', '707626ee-6bb3-4a75-8508-9f0500611e28', 'MANAGE_DOCUMENT_STATUS', NULL),
	('ee487546-c334-4669-ab54-94c202291e30', 'fa91ffd9-61ee-4bb1-bf86-6a593cdc7be9', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ASSIGNED_DOCUMENTS_CREATE_DOCUMENT', NULL),
	('ef73da2a-621b-4eb8-9ab9-782bdcb8419a', 'b4d722d6-755c-4be4-8f0d-2283c9394e18', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_APPROVE_FILE_REQUEST', NULL),
	('ef7f2c45-3990-46ec-bc63-778b24da5b9f', '229ad778-c7d3-4f5f-ab52-24b537c39514', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_DELETE_DOCUMENT', NULL),
	('f249542f-f3eb-4f0b-924c-3578f1a732da', '5ea48d56-2ed3-4239-bb90-dd4d70a1b0b2', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'REMINDER_DELETE_REMINDER', NULL),
	('f2973315-fd48-47b7-8ab9-d20e6bb8ee02', '1ae728c8-58df-4e9f-b284-132dc3c8ff89', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'FILE_REQUEST_REJECT_FILE_REQUEST', NULL),
	('f2abd15e-4b5f-4c34-96da-0bce936be85e', '1d768490-d67d-40b6-b610-22b17cc7ce2d', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'DEEP_SEARCH_ADD_INDEXING', NULL),
	('f361d3b3-ec4e-4f16-b1a7-f3ce8f808ca8', '4071ed2e-56fb-4c5a-887d-8a175cac8d71', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ARCHIVE_DOCUMENT_RESTORE_DOCUMENT', NULL),
	('f433e54c-2520-46d0-99f5-21566c405172', 'f5829228-ea73-4389-8aee-e2dc8ef6934a', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ALL_DOC_ADD_SIGNATURE', ''),
	('f53ac86d-7472-4cde-8b70-712a6a527e86', '391c1739-1045-4dd4-9705-4a960479f0a0', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ASSIGNED_DOCUMENTS_UPLOAD_NEW_VERSION', NULL),
	('f54a8547-d66b-4394-9e8c-0c352c2e6bc0', 'f9ec1096-b798-4623-bbf8-4f5d4fe775e9', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ALL_DOCUMENTS_MANAGE_SHARABLE_LINK', NULL),
	('f592fa0d-daf3-4134-84ba-e2af25cee0a8', '391c1739-1045-4dd4-9705-4a960479f0a0', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ASSIGNED_DOCUMENTS_UPLOAD_NEW_VERSION', NULL),
	('f6f1c174-211f-4ed8-a502-c37f85ca3014', 'f4d8a768-151d-4ec9-a8e3-41216afe0ec0', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ARCHIVE_DOCUMENT_DELETE_DOCUMENTS', NULL),
	('f7bec836-1670-4b89-bf32-86dfeedd5e45', 'cd46a3a4-ede5-4941-a49b-3df7eaa46428', '707626ee-6bb3-4a75-8508-9f0500611e28', 'DOCUMENT_CATEGORY_MANAGE_DOCUMENT_CATEGORY', NULL),
	('f7e55c82-2679-4cbb-abef-2be73da55adc', '1ae728c8-58df-4e9f-b284-132dc3c8ff89', '707626ee-6bb3-4a75-8508-9f0500611e28', 'FILE_REQUEST_REJECT_FILE_REQUEST', NULL),
	('fb7efc1f-ed7f-41d2-b050-44529cd378d0', '6b0fe007-1b92-4568-a4b7-6d105eb5c48c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'WORKFLOW_ALL_PERFORM_TRANSITION', NULL),
	('fbd44f99-df56-410c-b16f-a135a99e0f59', 'a737284a-e43b-481d-9fdd-07e1680ffe11', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ASSIGNED_DOCUMENTS_EDIT_DOCUMENT', NULL),
	('fdc99670-69f9-413f-96bf-1fd7763828c7', '4071ed2e-56fb-4c5a-887d-8a175cac8d71', '707626ee-6bb3-4a75-8508-9f0500611e28', 'ARCHIVE_DOCUMENT_RESTORE_DOCUMENT', NULL);

-- Dumping structure for table dms_ai.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.roles: ~3 rows (approximately)
INSERT INTO `roles` (`id`, `isDeleted`, `name`, `createdBy`, `modifiedBy`, `deletedBy`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('707626ee-6bb3-4a75-8508-9f0500611e28', 0, 'Test Role', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-04-16 12:48:37', '2026-04-16 12:48:37', NULL),
	('f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 0, 'Super Admin', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL),
	('ff635a8f-4bb3-4d70-a3ed-c7749030696c', 0, 'Employee', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, '2026-01-20 09:56:30', '2026-01-20 09:56:30', NULL);

-- Dumping structure for table dms_ai.seed_history
CREATE TABLE IF NOT EXISTS `seed_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `seeder_class` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seed_history_seeder_class_unique` (`seeder_class`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.seed_history: ~15 rows (approximately)
INSERT INTO `seed_history` (`id`, `seeder_class`, `created_at`, `updated_at`) VALUES
	(1, 'Database\\Seeders\\RoleSeeder', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(2, 'Database\\Seeders\\PermissionSeeder', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(3, 'Database\\Seeders\\LanguageSeeder', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(4, 'Database\\Seeders\\PermissionSeederV2', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(5, 'Database\\Seeders\\PermissionSeederV21', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(6, 'Database\\Seeders\\PermissionSeederV22', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(7, 'Database\\Seeders\\PermissionSeederV23', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(8, 'Database\\Seeders\\PermissionSeederV24', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(9, 'Database\\Seeders\\PermissionSeederV30', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(10, 'Database\\Seeders\\PermissionSeederV31', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(11, 'Database\\Seeders\\PermissionSeederV40', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(12, 'Database\\Seeders\\PermissionSeederV50', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(13, 'Database\\Seeders\\PermissionSeederV51', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(14, 'Database\\Seeders\\PermissionSeederV52', '2026-01-20 09:56:30', '2026-01-20 09:56:30'),
	(15, 'Database\\Seeders\\PermissionSeederV53', '2026-01-20 09:56:30', '2026-01-20 09:56:30');

-- Dumping structure for table dms_ai.sendemails
CREATE TABLE IF NOT EXISTS `sendemails` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fromEmail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isSend` tinyint(1) NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modifiedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sendemails_documentid_foreign` (`documentId`),
  KEY `sendemails_createdby_foreign` (`createdBy`),
  CONSTRAINT `sendemails_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `sendemails_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.sendemails: ~0 rows (approximately)

-- Dumping structure for table dms_ai.userclaims
CREATE TABLE IF NOT EXISTS `userclaims` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actionId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claimType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `claimValue` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userclaims_actionid_foreign` (`actionId`),
  KEY `userclaims_userid_foreign` (`userId`),
  CONSTRAINT `userclaims_actionid_foreign` FOREIGN KEY (`actionId`) REFERENCES `actions` (`id`),
  CONSTRAINT `userclaims_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.userclaims: ~0 rows (approximately)

-- Dumping structure for table dms_ai.usernotifications
CREATE TABLE IF NOT EXISTS `usernotifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isRead` tinyint(1) NOT NULL,
  `documentId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `notificationType` int NOT NULL DEFAULT '0',
  `documentWorkflowId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fileRequestId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usernotifications_userid_foreign` (`userId`),
  KEY `usernotifications_documentid_foreign` (`documentId`),
  KEY `usernotifications_documentworkflowid_foreign` (`documentWorkflowId`),
  KEY `usernotifications_filerequestid_foreign` (`fileRequestId`),
  CONSTRAINT `usernotifications_documentid_foreign` FOREIGN KEY (`documentId`) REFERENCES `documents` (`id`),
  CONSTRAINT `usernotifications_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentworkflow` (`id`),
  CONSTRAINT `usernotifications_filerequestid_foreign` FOREIGN KEY (`fileRequestId`) REFERENCES `filerequests` (`id`),
  CONSTRAINT `usernotifications_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.usernotifications: ~50 rows (approximately)
INSERT INTO `usernotifications` (`id`, `userId`, `message`, `isRead`, `documentId`, `createdDate`, `modifiedDate`, `notificationType`, `documentWorkflowId`, `fileRequestId`) VALUES
	('19631293-17eb-4eeb-94e7-8ad5bdb32979', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 1, '97a662b2-5a16-418b-8ae1-2e7057bcf829', '2026-04-23 11:09:33', '2026-04-23 11:43:22', 0, NULL, NULL),
	('217ea708-e777-46ec-b0b2-06eb981efa3b', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 0, '03528d7e-23d5-402d-985a-fbff279e281e', '2026-04-20 06:14:35', '2026-04-20 06:14:35', 0, NULL, NULL),
	('243bdd78-a55c-4770-aacb-de46ea17e242', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-30 04:40:07', '2026-04-30 04:40:07', 0, NULL, NULL),
	('252ea7eb-ace6-4bbf-9f50-fd3d2f4fc4af', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, 'b3de4c93-91a1-4728-95ba-5590031c2ca1', '2026-01-20 13:00:21', '2026-04-14 07:18:48', 0, NULL, NULL),
	('28cd2bee-f592-420f-90a0-dfc8e8ca89f2', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 1, 'd65bd38e-b74f-46d8-9705-1f1782c3fd10', '2026-04-23 11:04:36', '2026-04-23 11:43:22', 0, NULL, NULL),
	('2fb7076b-4fb1-4dd2-9729-1618aa3e38fb', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, 0, '9abd17d8-e8f8-43e1-8bc8-665172f2db01', '2026-04-08 11:16:41', '2026-04-08 11:16:41', 0, NULL, NULL),
	('3088f812-712e-4081-a979-9ef8c8f54d24', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, NULL, '2026-04-08 11:33:21', '2026-04-14 07:18:55', 2, NULL, '0a49d882-f3ff-48f1-b8a8-265351ad5d02'),
	('31b0194b-25f3-4585-9702-6637e7450ca6', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 1, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:17:10', 0, NULL, NULL),
	('38199867-da0f-4ae0-bd80-e22185952733', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 06:05:50', 0, NULL, NULL),
	('3826853d-166d-4f72-9118-ab4eff90f8ed', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, NULL, '2026-04-08 10:54:47', '2026-04-16 11:21:35', 2, NULL, 'b221b3c2-9f50-4a0e-9833-6d57c5ef21f4'),
	('38d53a80-07af-47be-8ec3-cd24c98bb847', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 06:05:05', 0, NULL, NULL),
	('39f9530c-9193-436e-af3c-69eadd88c310', '7cbcb8f8-0ee5-4b82-95da-462a9d5cedcd', NULL, 0, '03528d7e-23d5-402d-985a-fbff279e281e', '2026-04-20 06:14:35', '2026-04-20 06:14:35', 0, NULL, NULL),
	('43b2e40c-b4fc-4910-a688-9003a8188ed0', '17a2f9be-13d1-4767-8c13-2bb9536e28ad', NULL, 0, '03528d7e-23d5-402d-985a-fbff279e281e', '2026-04-20 06:14:35', '2026-04-20 06:14:35', 0, NULL, NULL),
	('571c7ef6-3c2b-4ed2-aa0c-efc927090295', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, 0, '18689c70-7f0c-4e1d-9035-39018fa036d8', '2026-04-08 11:16:39', '2026-04-08 11:16:39', 0, NULL, NULL),
	('58787a8a-47b2-47c9-8a73-b06b03eb6630', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 1, NULL, '2026-05-03 14:01:12', '2026-05-04 04:20:23', 2, NULL, '90ca00f8-2f6b-4dd4-ae49-3a15e6a9093e'),
	('58da9548-aba3-48c0-aaab-6ab763cbdbb4', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 1, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 09:23:14', 0, NULL, NULL),
	('59b9f10a-dbf4-484e-a014-73337c5e273a', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, 0, '8ce488a8-433a-44ea-96ee-381cf9d298f1', '2026-04-08 11:08:10', '2026-04-08 11:08:10', 0, NULL, NULL),
	('5fb1bbca-9d6e-4a4e-94a6-30ed82cb6d5b', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 06:05:50', 0, NULL, NULL),
	('6397b6e8-fd37-4c84-a483-c6f658e3e044', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, 0, 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', '2026-04-08 11:16:49', '2026-04-08 11:16:49', 0, NULL, NULL),
	('63e19a10-2738-4e0e-beed-54284d49e439', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:13:32', 0, NULL, NULL),
	('671d853c-28a2-4ea8-a543-4a9ff73a39f0', '8bbaee29-7515-44f7-ba7f-a8ba302ecba3', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 06:05:50', 0, NULL, NULL),
	('72cb356d-a496-40e7-a5c8-7b2e78ece4c7', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, '9abd17d8-e8f8-43e1-8bc8-665172f2db01', '2026-04-08 11:16:41', '2026-04-16 11:21:35', 0, NULL, NULL),
	('7394c9a4-afc1-4424-820d-9af8eea3e5f7', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 1, '03528d7e-23d5-402d-985a-fbff279e281e', '2026-05-02 00:00:00', '2026-05-02 12:55:10', 0, NULL, NULL),
	('777f4cc1-2889-4bbe-b6a8-fe7c99729fd3', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:15:35', 0, NULL, NULL),
	('7d203af1-dac3-4d96-9b17-b2509d4ea18d', '7cbcb8f8-0ee5-4b82-95da-462a9d5cedcd', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:15:35', 0, NULL, NULL),
	('8295688d-70f2-4e64-8e5e-ab40ce50ae6f', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 0, NULL, '2026-05-02 11:35:38', '2026-05-02 11:35:38', 2, NULL, '05c805dc-b2f1-41b1-8753-66331c958461'),
	('8398ffcf-c386-4e84-b757-f58feded496c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, '50854eef-8641-4426-a744-8c6711d4193b', '2026-04-08 11:16:37', '2026-04-16 11:21:35', 0, NULL, NULL),
	('851b00ac-9ca0-448d-ae21-400870cb9630', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, 0, 'fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', '2026-04-08 11:16:44', '2026-04-08 11:16:44', 0, NULL, NULL),
	('873bfe67-51b2-4325-a3ca-53f695b02a4d', '8bbaee29-7515-44f7-ba7f-a8ba302ecba3', NULL, 0, '03528d7e-23d5-402d-985a-fbff279e281e', '2026-04-20 06:14:35', '2026-04-20 06:14:35', 0, NULL, NULL),
	('9005c892-c9f4-4cf8-8c38-2a000ccedb0b', '8bbaee29-7515-44f7-ba7f-a8ba302ecba3', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:15:35', 0, NULL, NULL),
	('982a64d3-9d12-4b88-b149-b997ca936c63', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-05-04 06:09:56', '2026-05-04 06:09:56', 0, NULL, NULL),
	('9e3a1608-b065-4b67-b9fb-3046db5471b6', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 0, 'd6b74c0b-f0a9-40ee-be49-cf9ecef7c36a', '2026-04-14 08:02:41', '2026-04-14 08:02:41', 0, NULL, NULL),
	('a6d07bd3-eea0-47f4-94ac-6d5de272dff6', '17a2f9be-13d1-4767-8c13-2bb9536e28ad', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 06:05:50', 0, NULL, NULL),
	('ad1609e1-a1fa-49bf-9df0-daa63a6f9cec', '4907694e-1724-4674-a3c3-c8b96406e4fe', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 06:05:50', 0, NULL, NULL),
	('b3c6da83-ec2b-4634-8f8f-5df2a2e53ae7', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, 'a11dbaed-44d0-4111-af91-9a852f6e3e5f', '2026-04-08 11:16:49', '2026-04-16 11:21:35', 0, NULL, NULL),
	('bcb3ed8c-5386-49b7-8131-f6a78774556a', 'f85fa233-db01-462b-befa-5c4eea1505b7', NULL, 0, '50854eef-8641-4426-a744-8c6711d4193b', '2026-04-08 11:16:37', '2026-04-08 11:16:37', 0, NULL, NULL),
	('bdad5ac3-eb25-4751-b68e-eb26b7a03e13', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, '9a83809a-beea-479a-90a6-d1816ae68e23', '2026-01-20 12:35:47', '2026-01-20 12:45:32', 0, NULL, NULL),
	('bfbbc1b1-e998-4301-b4d2-a0f5aad5ad25', '7cbcb8f8-0ee5-4b82-95da-462a9d5cedcd', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-05-04 06:05:50', 0, NULL, NULL),
	('c136e225-9399-4de7-8d0d-d00f3c3d23f1', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, 'fcc5b37b-cbf1-49bc-b1ce-3224f449ef07', '2026-04-08 11:16:44', '2026-04-16 11:21:35', 0, NULL, NULL),
	('c3bc240e-4ad6-48eb-96a0-84380aa21630', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, '8ce488a8-433a-44ea-96ee-381cf9d298f1', '2026-04-08 11:08:10', '2026-04-16 11:21:35', 0, NULL, NULL),
	('ca7eca6a-b326-4f2d-b37d-8d81643e5762', '4907694e-1724-4674-a3c3-c8b96406e4fe', NULL, 0, '03528d7e-23d5-402d-985a-fbff279e281e', '2026-04-20 06:14:35', '2026-04-20 06:14:35', 0, NULL, NULL),
	('ccacfb12-3bd9-4c16-9cb1-1def90cf5849', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 0, '89a0436a-f211-42c6-91d6-73a0de44189e', '2026-04-27 00:00:00', '2026-04-27 09:33:37', 0, NULL, NULL),
	('cd140c9f-b631-4cb2-91a2-4f75d9e38c1d', '4907694e-1724-4674-a3c3-c8b96406e4fe', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:15:35', 0, NULL, NULL),
	('ce5d9be3-29f7-4f2d-aead-44200ba91655', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', NULL, 1, '89a0436a-f211-42c6-91d6-73a0de44189e', '2026-04-27 07:05:13', '2026-04-27 07:06:12', 0, NULL, NULL),
	('d27b669f-4f96-4f74-bc69-fd3c628315d3', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 0, '89a0436a-f211-42c6-91d6-73a0de44189e', '2026-04-30 04:41:31', '2026-04-30 04:41:31', 0, NULL, NULL),
	('d60395b1-9cf6-4792-8f13-212336befe29', '17a2f9be-13d1-4767-8c13-2bb9536e28ad', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:15:35', 0, NULL, NULL),
	('df4dd509-1e73-4637-82b9-88ea4b1ec043', '6021958e-5cbb-4443-9242-8893aa19c3e0', NULL, 0, '32a2f224-443c-454f-a3f6-46f26b819ce8', '2026-04-27 00:00:00', '2026-04-30 11:15:35', 0, NULL, NULL),
	('e7ea21c1-08f9-4b1c-b1c8-3c90ccde1957', '1744effe-9859-4a80-9159-23d4aad48098', NULL, 0, '89a0436a-f211-42c6-91d6-73a0de44189e', '2026-04-30 04:41:31', '2026-04-30 04:41:31', 0, NULL, NULL),
	('efd3542e-4f77-4a6c-9523-b23e5ea7bc64', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, '8421054e-8053-4117-b594-dbe8475eec48', '2026-01-20 12:58:07', '2026-04-16 11:21:35', 0, NULL, NULL),
	('fd6483fc-8c0c-4a65-95e4-f8f64d8424f8', 'b7797b54-5026-49cf-a34e-34d6c168e84c', NULL, 1, '18689c70-7f0c-4e1d-9035-39018fa036d8', '2026-04-08 11:16:39', '2026-04-16 11:21:35', 0, NULL, NULL);

-- Dumping structure for table dms_ai.userroles
CREATE TABLE IF NOT EXISTS `userroles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roleId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userroles_userid_foreign` (`userId`),
  KEY `userroles_roleid_foreign` (`roleId`),
  CONSTRAINT `userroles_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`),
  CONSTRAINT `userroles_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.userroles: ~11 rows (approximately)
INSERT INTO `userroles` (`id`, `userId`, `roleId`) VALUES
	('1375f598-5e32-4f6b-bbce-9e58926a5afe', '6021958e-5cbb-4443-9242-8893aa19c3e0', '707626ee-6bb3-4a75-8508-9f0500611e28'),
	('3a36dd3f-e239-46b1-b654-7c084d14da92', '17a2f9be-13d1-4767-8c13-2bb9536e28ad', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c'),
	('4495c61d-147a-4cba-8731-190d7566e7b4', '7cbcb8f8-0ee5-4b82-95da-462a9d5cedcd', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c'),
	('479c0ec4-35ea-4abd-9b6b-fb085b67b234', 'f85fa233-db01-462b-befa-5c4eea1505b7', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4'),
	('51d853c9-3218-43a5-8258-8c45c28180f2', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4'),
	('599295bf-d8f0-48b2-9084-2b84d42e07e1', 'e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c'),
	('71156c8b-5fee-4a51-84e4-5f05f19b44a0', '1744effe-9859-4a80-9159-23d4aad48098', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c'),
	('ad48a0c0-0221-4a2d-bfec-4bef1d6a567a', '6021958e-5cbb-4443-9242-8893aa19c3e0', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c'),
	('bf904d80-7618-4ff4-8272-a72e1d76ec6a', '4907694e-1724-4674-a3c3-c8b96406e4fe', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c'),
	('d3942857-98b6-472a-a276-13176cb1fa29', '1744effe-9859-4a80-9159-23d4aad48098', '707626ee-6bb3-4a75-8508-9f0500611e28'),
	('e2c9cb5d-50e6-4482-beea-e955e5dfd1a0', '8bbaee29-7515-44f7-ba7f-a8ba302ecba3', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c');

-- Dumping structure for table dms_ai.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `userName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `normalizedUserName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `normalizedEmail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emailConfirmed` tinyint(1) NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `securityStamp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `concurrencyStamp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumberConfirmed` tinyint(1) NOT NULL,
  `twoFactorEnabled` tinyint(1) NOT NULL,
  `lockoutEnd` timestamp NULL DEFAULT NULL,
  `lockoutEnabled` tinyint(1) NOT NULL,
  `accessFailedCount` int NOT NULL,
  `resetPasswordCode` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isSystemUser` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.users: ~10 rows (approximately)
INSERT INTO `users` (`id`, `firstName`, `lastName`, `isDeleted`, `userName`, `normalizedUserName`, `email`, `normalizedEmail`, `emailConfirmed`, `password`, `securityStamp`, `concurrencyStamp`, `phoneNumber`, `phoneNumberConfirmed`, `twoFactorEnabled`, `lockoutEnd`, `lockoutEnabled`, `accessFailedCount`, `resetPasswordCode`, `isSystemUser`) VALUES
	('1744effe-9859-4a80-9159-23d4aad48098', 'Umer', 'Farooq', 0, 'umer.farooq@solochoicez.com', NULL, 'umer.farooq@solochoicez.com', NULL, 0, '$2y$10$Gmbwpkq6.Ek1FmvUmtQZfO/xohpMMu2Haez4Q/vIKK1nZxKUmMKwS', NULL, NULL, '031863673826', 0, 0, NULL, 0, 0, NULL, 0),
	('17a2f9be-13d1-4767-8c13-2bb9536e28ad', 'Abdul', 'Mateen', 0, 'abdulmateen03527@gmail.com', NULL, 'abdulmateen03527@gmail.com', NULL, 0, '$2y$10$2oEUpoATRsw0TREdF8sutOIvgHCiI82HL0yfSWPQzHEe9bMKPpHie', NULL, NULL, '03465353527', 0, 0, NULL, 0, 0, NULL, 0),
	('4907694e-1724-4674-a3c3-c8b96406e4fe', 'Farah', 'Zafar', 0, 'farah.zafar@solochoicez.com', NULL, 'farah.zafar@solochoicez.com', NULL, 0, '$2y$10$oA3djOE9/iKb8NF7Bn0TReXOHk9pLJDpp5HoswgI4bmH6tfvl/48y', NULL, NULL, '+92 333 8110004', 0, 0, NULL, 0, 0, NULL, 0),
	('6021958e-5cbb-4443-9242-8893aa19c3e0', 'QA', 'Test', 0, 'QA@example.com', NULL, 'QA@example.com', NULL, 0, '$2y$10$spYkIaKFspEIbSi4VhymL.5DzWQZusQd/YIz5CgAX7HJY.U61l35y', NULL, NULL, '030000000', 0, 0, NULL, 0, 0, NULL, 0),
	('7cbcb8f8-0ee5-4b82-95da-462a9d5cedcd', 'Reiciendis sunt quod', 'A vitae dolor fuga', 0, 'vako@mailinator.com', NULL, 'vako@mailinator.com', NULL, 0, '$2y$10$kOHd8nMD8LirF53l/BC8t.tPsBpwhlL6iPhIu4X2imYMB//gvHrW.', NULL, NULL, 'Excepteur officia es', 0, 0, NULL, 0, 0, NULL, 0),
	('84edde09-b4cd-4ff3-9f1a-afa6eb24c7cb', 'System', 'User', 0, NULL, NULL, 'system@user.com', NULL, 0, '$2y$10$6o/y0gZqyWF.wjPfSShODef7N9tVXbhY806RSh38eGp10X3LKIe1y', NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, 1),
	('8bbaee29-7515-44f7-ba7f-a8ba302ecba3', 'Shahzad', 'Hussain', 0, 'shahzadhusyn48796@gmail.com', NULL, 'shahzadhusyn48796@gmail.com', NULL, 0, '$2y$10$Fi7s3.Pb81CQHF0kJtHliuZNHiVxy6koP6w9MWzpfzaJ5E.O7Hlo2', NULL, NULL, '+92 340 9361479', 0, 0, NULL, 0, 0, NULL, 0),
	('b7797b54-5026-49cf-a34e-34d6c168e84c', 'Solochoicez', 'Admin', 0, 'info@solochoicez.com', NULL, 'info@solochoicez.com', NULL, 0, '$2y$10$NzjfnbWLwD2OTA2yoJMJiucW1IB73X4iEzpr6qTJe.F03kjJj4Gwa', NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, 0),
	('e3daf14f-2195-456f-9a88-dc1ed1c9e1df', 'employee', 'one', 0, 'employee@gmail.com', NULL, 'employee@gmail.com', NULL, 0, '$2y$10$0SiTLwwHQy5SRNKBbJtbkelry9JXGCert4q4tWs66btLFlIDfuU0S', NULL, NULL, '01234567890', 0, 0, NULL, 0, 0, NULL, 0),
	('f85fa233-db01-462b-befa-5c4eea1505b7', 'Fatima', 'Zia Abbas', 0, 'fatima.abbas@solochoicez.com', NULL, 'fatima.abbas@solochoicez.com', NULL, 0, '$2y$10$GkEmEqfPWQxWNYtl8oRyrublq4.IKdJuYUC6j35w05.hZOe.Zg7Ey', NULL, NULL, '+92 323 5113902', 0, 0, NULL, 0, 0, NULL, 0);

-- Dumping structure for table dms_ai.workflowlogs
CREATE TABLE IF NOT EXISTS `workflowlogs` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentWorkflowId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transitionId` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `type` enum('Transition','Initiated','Cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Transition',
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowlogs_documentworkflowid_foreign` (`documentWorkflowId`),
  KEY `workflowlogs_transitionid_foreign` (`transitionId`),
  KEY `workflowlogs_createdby_foreign` (`createdBy`),
  CONSTRAINT `workflowlogs_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `workflowlogs_documentworkflowid_foreign` FOREIGN KEY (`documentWorkflowId`) REFERENCES `documentworkflow` (`id`),
  CONSTRAINT `workflowlogs_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowtransitions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.workflowlogs: ~0 rows (approximately)

-- Dumping structure for table dms_ai.workflows
CREATE TABLE IF NOT EXISTS `workflows` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `createdBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isWorkflowSetup` tinyint(1) NOT NULL,
  `modifiedBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deletedBy` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isDeleted` tinyint(1) NOT NULL,
  `createdDate` datetime NOT NULL,
  `modifiedDate` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflows_createdby_foreign` (`createdBy`),
  KEY `workflows_modifiedby_foreign` (`modifiedBy`),
  CONSTRAINT `workflows_createdby_foreign` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`),
  CONSTRAINT `workflows_modifiedby_foreign` FOREIGN KEY (`modifiedBy`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.workflows: ~4 rows (approximately)
INSERT INTO `workflows` (`id`, `name`, `description`, `createdBy`, `isWorkflowSetup`, `modifiedBy`, `deletedBy`, `isDeleted`, `createdDate`, `modifiedDate`, `deleted_at`) VALUES
	('050c6524-cefa-4781-8468-e06d7f5946d0', 'cds', 'ewdwcc', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 0, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 1, '2026-04-23 06:22:13', '2026-04-27 07:14:26', '2026-04-27 07:14:26'),
	('643e90e6-572e-4ad0-9d97-550d76069ec7', 'mm', 'mm', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 1, '2026-04-23 10:02:22', '2026-04-27 07:14:19', '2026-04-27 07:14:19'),
	('8527bbc7-fca2-4df4-83ce-52876d73076a', 'First Workflow', 'First Workflow test', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-01-20 12:31:01', '2026-01-20 12:32:12', NULL),
	('fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'QA Testing Process', 'A document is a structured piece of written, printed, or digital information created to record, communicate, or store data.', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 1, 'b7797b54-5026-49cf-a34e-34d6c168e84c', '', 0, '2026-04-16 10:49:49', '2026-04-16 10:58:40', NULL);

-- Dumping structure for table dms_ai.workflowsteps
CREATE TABLE IF NOT EXISTS `workflowsteps` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `workflowId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowsteps_workflowid_foreign` (`workflowId`),
  CONSTRAINT `workflowsteps_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.workflowsteps: ~14 rows (approximately)
INSERT INTO `workflowsteps` (`id`, `workflowId`, `name`) VALUES
	('23190eb4-463c-475b-a42a-d4ac64770f8c', '050c6524-cefa-4781-8468-e06d7f5946d0', 'dxxx'),
	('2e3cbbc7-a788-4758-9fc3-3152df353a6b', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'Requirement Analysis'),
	('305d8446-415e-4fea-a166-50a6be503479', '643e90e6-572e-4ad0-9d97-550d76069ec7', 'kk'),
	('315d89c1-5985-4d06-aebc-f0711d414e7b', '8527bbc7-fca2-4df4-83ce-52876d73076a', 'Flow step 2'),
	('347efdc7-7d92-469f-a96b-ec5af859784b', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'Test Execution'),
	('4371960b-c5b4-45b9-b846-a9e2646bc4dd', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'Retesting'),
	('4c627dc8-3c83-4129-8612-e48c61c47bec', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'Defect Reporting'),
	('5670667a-f4db-41e3-8d68-521a86457424', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'Test Case Design'),
	('6baa93f2-b592-4d3d-b904-8db4ec41a107', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'Test Planning'),
	('6ecaad18-8af4-4724-8583-d32ed92468bc', '8527bbc7-fca2-4df4-83ce-52876d73076a', 'Flow step 1'),
	('7d4d0459-86eb-4931-b139-78d9b52b42ba', '8527bbc7-fca2-4df4-83ce-52876d73076a', 'Flow step 3'),
	('92f4ebc0-7388-4d7f-ac00-4c1ed532e388', '050c6524-cefa-4781-8468-e06d7f5946d0', 'sdewdx'),
	('a5316f11-4e18-4be0-be67-b8d908dc7ec3', '643e90e6-572e-4ad0-9d97-550d76069ec7', 'mm'),
	('a641c011-166a-4c1a-874a-3bef8852239c', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', 'Test Closure');

-- Dumping structure for table dms_ai.workflowtransitionroles
CREATE TABLE IF NOT EXISTS `workflowtransitionroles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roleId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transitionId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowtransitionroles_roleid_foreign` (`roleId`),
  KEY `workflowtransitionroles_transitionid_foreign` (`transitionId`),
  CONSTRAINT `workflowtransitionroles_roleid_foreign` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`),
  CONSTRAINT `workflowtransitionroles_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowtransitions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.workflowtransitionroles: ~9 rows (approximately)
INSERT INTO `workflowtransitionroles` (`id`, `roleId`, `transitionId`) VALUES
	('03c3cbf8-a64a-43e4-a813-92a3731f52bd', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'fc909fc6-658c-4591-a5d2-39d6fee55029'),
	('0be92865-b8e5-44e1-a138-8aeae70dd6b0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'fc909fc6-658c-4591-a5d2-39d6fee55029'),
	('25d9b9a2-9b4a-45b3-abb5-cb34c6549998', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', '1601f605-9ad1-4cc1-bf33-48a048626a21'),
	('3bf914c9-04fd-49f4-a84c-ce8d8310e8b7', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'f596f357-705f-496d-826e-916d0a491e09'),
	('3c37e333-220f-4ea1-b3bc-186dd13837a0', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'ff66fe9c-3357-48cf-8f1f-e34a7898da32'),
	('3d84dfa7-9f95-4942-a012-f33cdbf54b9f', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '05211236-4e24-4e74-b3d6-c05a14fb2128'),
	('78070768-a4da-4bfd-8aae-99020b760d7c', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', 'ff66fe9c-3357-48cf-8f1f-e34a7898da32'),
	('99538db6-bc06-4c0a-b154-9180a4e7c67c', 'ff635a8f-4bb3-4d70-a3ed-c7749030696c', '05211236-4e24-4e74-b3d6-c05a14fb2128'),
	('b2e1025c-67ba-482b-b1e7-76d2dbf63750', 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', '7bb4aa54-183b-4d70-82a4-ada68c420d81');

-- Dumping structure for table dms_ai.workflowtransitions
CREATE TABLE IF NOT EXISTS `workflowtransitions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `workflowId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fromStepId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `toStepId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orderNo` int NOT NULL,
  `isFirstTransaction` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `workflowtransitions_workflowid_foreign` (`workflowId`),
  KEY `workflowtransitions_fromstepid_foreign` (`fromStepId`),
  KEY `workflowtransitions_tostepid_foreign` (`toStepId`),
  CONSTRAINT `workflowtransitions_fromstepid_foreign` FOREIGN KEY (`fromStepId`) REFERENCES `workflowsteps` (`id`),
  CONSTRAINT `workflowtransitions_tostepid_foreign` FOREIGN KEY (`toStepId`) REFERENCES `workflowsteps` (`id`),
  CONSTRAINT `workflowtransitions_workflowid_foreign` FOREIGN KEY (`workflowId`) REFERENCES `workflows` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.workflowtransitions: ~6 rows (approximately)
INSERT INTO `workflowtransitions` (`id`, `workflowId`, `fromStepId`, `toStepId`, `name`, `color`, `orderNo`, `isFirstTransaction`) VALUES
	('05211236-4e24-4e74-b3d6-c05a14fb2128', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', '4371960b-c5b4-45b9-b846-a9e2646bc4dd', '4c627dc8-3c83-4129-8612-e48c61c47bec', 'QA 3', 'pending', 2, 0),
	('1601f605-9ad1-4cc1-bf33-48a048626a21', '8527bbc7-fca2-4df4-83ce-52876d73076a', '315d89c1-5985-4d06-aebc-f0711d414e7b', '7d4d0459-86eb-4931-b139-78d9b52b42ba', 'Workflow Transition 2', 'inprogress', 1, 0),
	('7bb4aa54-183b-4d70-82a4-ada68c420d81', '643e90e6-572e-4ad0-9d97-550d76069ec7', '305d8446-415e-4fea-a166-50a6be503479', 'a5316f11-4e18-4be0-be67-b8d908dc7ec3', 'mm', 'inprogress', 0, 1),
	('f596f357-705f-496d-826e-916d0a491e09', '8527bbc7-fca2-4df4-83ce-52876d73076a', '6ecaad18-8af4-4724-8583-d32ed92468bc', '315d89c1-5985-4d06-aebc-f0711d414e7b', 'Workflow Transition', 'inprogress', 0, 1),
	('fc909fc6-658c-4591-a5d2-39d6fee55029', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', '2e3cbbc7-a788-4758-9fc3-3152df353a6b', '347efdc7-7d92-469f-a96b-ec5af859784b', 'QA flow', 'approved', 0, 1),
	('ff66fe9c-3357-48cf-8f1f-e34a7898da32', 'fcbdde95-98f2-4735-b9f1-0e38e8631e50', '347efdc7-7d92-469f-a96b-ec5af859784b', '4371960b-c5b4-45b9-b846-a9e2646bc4dd', 'QA 2', 'rejected', 1, 0);

-- Dumping structure for table dms_ai.workflowtransitionusers
CREATE TABLE IF NOT EXISTS `workflowtransitionusers` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transitionId` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflowtransitionusers_userid_foreign` (`userId`),
  KEY `workflowtransitionusers_transitionid_foreign` (`transitionId`),
  CONSTRAINT `workflowtransitionusers_transitionid_foreign` FOREIGN KEY (`transitionId`) REFERENCES `workflowtransitions` (`id`),
  CONSTRAINT `workflowtransitionusers_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table dms_ai.workflowtransitionusers: ~9 rows (approximately)
INSERT INTO `workflowtransitionusers` (`id`, `userId`, `transitionId`) VALUES
	('16cd4566-ed7f-4a0d-835d-8a8454f35751', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '7bb4aa54-183b-4d70-82a4-ada68c420d81'),
	('28d73a02-edb3-4086-ad01-b4adcd183ce3', '1744effe-9859-4a80-9159-23d4aad48098', 'ff66fe9c-3357-48cf-8f1f-e34a7898da32'),
	('500c4308-251e-4d7a-892b-14e704c54c1e', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'f596f357-705f-496d-826e-916d0a491e09'),
	('97b8b95e-94e0-403d-a89c-d06b6a536322', '1744effe-9859-4a80-9159-23d4aad48098', '05211236-4e24-4e74-b3d6-c05a14fb2128'),
	('b25a4945-5907-4001-a39f-85427a27fb60', '1744effe-9859-4a80-9159-23d4aad48098', 'fc909fc6-658c-4591-a5d2-39d6fee55029'),
	('b77f4c47-e115-4fee-9cab-1ac9d27c08f2', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'fc909fc6-658c-4591-a5d2-39d6fee55029'),
	('c8a6b6e8-4f28-45ad-b9ff-33d3b4f9f358', 'b7797b54-5026-49cf-a34e-34d6c168e84c', 'ff66fe9c-3357-48cf-8f1f-e34a7898da32'),
	('d02519b9-6fb6-4ddd-bf6a-d92aa55d3c4e', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '1601f605-9ad1-4cc1-bf33-48a048626a21'),
	('e4d745c9-450f-40cd-9e9c-74f206e01f3a', 'b7797b54-5026-49cf-a34e-34d6c168e84c', '05211236-4e24-4e74-b3d6-c05a14fb2128');

-- Dumping structure for table dms_ai.wp_actionscheduler_actions
CREATE TABLE IF NOT EXISTS `wp_actionscheduler_actions` (
  `action_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `hook` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `scheduled_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  `priority` tinyint unsigned NOT NULL DEFAULT '10',
  `args` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schedule` longtext COLLATE utf8mb4_unicode_520_ci,
  `group_id` bigint unsigned NOT NULL DEFAULT '0',
  `attempts` int NOT NULL DEFAULT '0',
  `last_attempt_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` datetime DEFAULT '0000-00-00 00:00:00',
  `claim_id` bigint unsigned NOT NULL DEFAULT '0',
  `extended_args` varchar(8000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  KEY `hook_status_scheduled_date_gmt` (`hook`(163),`status`,`scheduled_date_gmt`),
  KEY `status_scheduled_date_gmt` (`status`,`scheduled_date_gmt`),
  KEY `scheduled_date_gmt` (`scheduled_date_gmt`),
  KEY `args` (`args`),
  KEY `group_id` (`group_id`),
  KEY `last_attempt_gmt` (`last_attempt_gmt`),
  KEY `claim_id_status_priority_scheduled_date_gmt` (`claim_id`,`status`,`priority`,`scheduled_date_gmt`),
  KEY `status_last_attempt_gmt` (`status`,`last_attempt_gmt`),
  KEY `status_claim_id` (`status`,`claim_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- Dumping data for table dms_ai.wp_actionscheduler_actions: ~4 rows (approximately)
INSERT INTO `wp_actionscheduler_actions` (`action_id`, `hook`, `status`, `scheduled_date_gmt`, `scheduled_date_local`, `priority`, `args`, `schedule`, `group_id`, `attempts`, `last_attempt_gmt`, `last_attempt_local`, `claim_id`, `extended_args`) VALUES
	(8, 'action_scheduler_run_recurring_actions_schedule_hook', 'complete', '2025-08-13 09:18:40', '2025-08-13 09:18:40', 20, '[]', 'O:32:"ActionScheduler_IntervalSchedule":5:{s:22:"\0*\0scheduled_timestamp";i:1755076720;s:18:"\0*\0first_timestamp";i:1754990318;s:13:"\0*\0recurrence";i:86400;s:49:"\0ActionScheduler_IntervalSchedule\0start_timestamp";i:1755076720;s:53:"\0ActionScheduler_IntervalSchedule\0interval_in_seconds";i:86400;}', 2, 1, '2025-12-04 06:49:38', '2025-12-04 06:49:38', 69, NULL),
	(9, 'hostinger-reach/jobs/cleanup_carts/start', 'complete', '2025-12-04 06:49:36', '2025-12-04 06:49:36', 10, '[]', 'O:32:"ActionScheduler_IntervalSchedule":5:{s:22:"\0*\0scheduled_timestamp";i:1764830976;s:18:"\0*\0first_timestamp";i:1764830976;s:13:"\0*\0recurrence";i:86400;s:49:"\0ActionScheduler_IntervalSchedule\0start_timestamp";i:1764830976;s:53:"\0ActionScheduler_IntervalSchedule\0interval_in_seconds";i:86400;}', 3, 1, '2025-12-04 06:49:38', '2025-12-04 06:49:38', 69, NULL),
	(10, 'hostinger-reach/jobs/cleanup_carts/start', 'pending', '2025-12-05 06:49:38', '2025-12-05 06:49:38', 10, '[]', 'O:32:"ActionScheduler_IntervalSchedule":5:{s:22:"\0*\0scheduled_timestamp";i:1764917378;s:18:"\0*\0first_timestamp";i:1764830976;s:13:"\0*\0recurrence";i:86400;s:49:"\0ActionScheduler_IntervalSchedule\0start_timestamp";i:1764917378;s:53:"\0ActionScheduler_IntervalSchedule\0interval_in_seconds";i:86400;}', 3, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, NULL),
	(11, 'action_scheduler_run_recurring_actions_schedule_hook', 'pending', '2025-12-05 06:49:38', '2025-12-05 06:49:38', 20, '[]', 'O:32:"ActionScheduler_IntervalSchedule":5:{s:22:"\0*\0scheduled_timestamp";i:1764917378;s:18:"\0*\0first_timestamp";i:1754990318;s:13:"\0*\0recurrence";i:86400;s:49:"\0ActionScheduler_IntervalSchedule\0start_timestamp";i:1764917378;s:53:"\0ActionScheduler_IntervalSchedule\0interval_in_seconds";i:86400;}', 2, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, NULL);

-- Dumping structure for table dms_ai.wp_actionscheduler_claims
CREATE TABLE IF NOT EXISTS `wp_actionscheduler_claims` (
  `claim_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date_created_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`claim_id`),
  KEY `date_created_gmt` (`date_created_gmt`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- Dumping data for table dms_ai.wp_actionscheduler_claims: ~0 rows (approximately)

-- Dumping structure for table dms_ai.wp_actionscheduler_groups
CREATE TABLE IF NOT EXISTS `wp_actionscheduler_groups` (
  `group_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `slug` (`slug`(191))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- Dumping data for table dms_ai.wp_actionscheduler_groups: ~3 rows (approximately)
INSERT INTO `wp_actionscheduler_groups` (`group_id`, `slug`) VALUES
	(1, 'action-scheduler-migration'),
	(2, 'ActionScheduler'),
	(3, 'hostinger-reach');

-- Dumping structure for table dms_ai.wp_actionscheduler_logs
CREATE TABLE IF NOT EXISTS `wp_actionscheduler_logs` (
  `log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `action_id` bigint unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `log_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`log_id`),
  KEY `action_id` (`action_id`),
  KEY `log_date_gmt` (`log_date_gmt`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- Dumping data for table dms_ai.wp_actionscheduler_logs: ~8 rows (approximately)
INSERT INTO `wp_actionscheduler_logs` (`log_id`, `action_id`, `message`, `log_date_gmt`, `log_date_local`) VALUES
	(5, 8, 'action created', '2025-08-12 09:18:40', '2025-08-12 09:18:40'),
	(8, 9, 'action created', '2025-12-04 06:49:37', '2025-12-04 06:49:37'),
	(9, 9, 'action started via Async Request', '2025-12-04 06:49:38', '2025-12-04 06:49:38'),
	(10, 9, 'action complete via Async Request', '2025-12-04 06:49:38', '2025-12-04 06:49:38'),
	(11, 10, 'action created', '2025-12-04 06:49:38', '2025-12-04 06:49:38'),
	(12, 8, 'action started via Async Request', '2025-12-04 06:49:38', '2025-12-04 06:49:38'),
	(13, 8, 'action complete via Async Request', '2025-12-04 06:49:38', '2025-12-04 06:49:38'),
	(14, 11, 'action created', '2025-12-04 06:49:38', '2025-12-04 06:49:38');

-- Dumping structure for table dms_ai.wp_commentmeta
CREATE TABLE IF NOT EXISTS `wp_commentmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- Dumping data for table dms_ai.wp_commentmeta: ~0 rows (approximately)

-- Dumping structure for table dms_ai.wp_e_events
CREATE TABLE IF NOT EXISTS `wp_e_events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `event_data` text COLLATE utf8mb4_unicode_520_ci,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- Dumping data for table dms_ai.wp_e_events: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
