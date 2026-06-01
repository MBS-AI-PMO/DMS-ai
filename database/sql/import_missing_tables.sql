-- From dms-ahi.sql naming (all lowercase). phpMyAdmin → Import.

CREATE TABLE IF NOT EXISTS `allowfileextensions` (
  `id` char(36) NOT NULL,
  `fileType` tinyint NOT NULL,
  `extensions` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `allowfileextensions` (`id`, `fileType`, `extensions`) VALUES
('64dac07d-9072-4661-b537-053a09d42d6e', 0, 'doc,docx,ppt,pptx,xls,xlsx,csv'),
('3257c50c-a128-4c98-8809-cc2564b7db2a', 1, 'pdf'),
('0c0be0a9-0a4e-4f05-8742-3a5d6d74acf0', 2, 'png,jpg,jpge,gif,bmp,tiff,tif,svg,webp,ico,heif,heic,avif,apng,jfif,pjpeg,pjp,svgz,wmf,emf,djv,djvu,eps,ps,ai,indd,idml,psd,tga,dds'),
('13a28d05-d6be-4e6b-87fe-b784642e2a95', 3, 'txt'),
('9eaf6b33-0cef-45a4-bf92-7c525e2ed536', 4, '3gp,aa,aac,aax,act,aiff,alac,amr,ape,au,awb,dss,dvf,flac,gsm,iklx,ivs,m4a,m4b,m4p,mmf,mp3,mpc,msv,nmf,ogg,oga,mogg,opus,org,ra,rm,raw,rf64,sln,tta,voc,vox,wav,wma,wv'),
('cb1612ef-8e3c-4823-af2b-469f4b0010b8', 5, 'webm,flv,vob,ogv,ogg,drc,avi,mts,m2ts,wmv,yuv,viv,mp4,m4p,3pg,f4v,f4a'),
('ab5db62f-1fc7-49ed-895f-6ac4be6db33a', 6, 'zip');

CREATE TABLE IF NOT EXISTS `loginaudits` (
  `id` char(36) NOT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `loginTime` varchar(255) NOT NULL,
  `remoteIP` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
