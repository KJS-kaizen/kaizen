-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.6-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for kaizen
CREATE DATABASE IF NOT EXISTS `kaizen` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `kaizen`;

-- Dumping structure for table kaizen.log_admin_login
CREATE TABLE IF NOT EXISTS `log_admin_login` (
  `log_id` bigint(20) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_bin NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `log_admin_login_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `tbl_admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_admin_login: ~0 rows (approximately)
DELETE FROM `log_admin_login`;
/*!40000 ALTER TABLE `log_admin_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_admin_login` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_contents_edit_admin
CREATE TABLE IF NOT EXISTS `log_contents_edit_admin` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `school_contents_id` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL,
  `contents_edit_action_id` tinyint(3) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `school_contents_id` (`school_contents_id`),
  KEY `admin_id` (`admin_id`),
  KEY `contents_edit_action_id` (`contents_edit_action_id`),
  KEY `FK_log_contents_edit_admin_mst_contents_category` (`contents_category_id`),
  CONSTRAINT `FK_log_contents_edit_admin_mst_contents_category` FOREIGN KEY (`contents_category_id`) REFERENCES `mst_contents_category` (`contents_category_id`),
  CONSTRAINT `log_contents_edit_admin_ibfk_1` FOREIGN KEY (`school_contents_id`) REFERENCES `tbl_school_contents_bk` (`school_contents_id`),
  CONSTRAINT `log_contents_edit_admin_ibfk_3` FOREIGN KEY (`contents_edit_action_id`) REFERENCES `mst_contents_edit_action` (`contents_edit_action_id`),
  CONSTRAINT `log_contents_edit_admin_ibfk_4` FOREIGN KEY (`admin_id`) REFERENCES `tbl_admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_contents_edit_admin: ~0 rows (approximately)
DELETE FROM `log_contents_edit_admin`;
/*!40000 ALTER TABLE `log_contents_edit_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_contents_edit_admin` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_contents_edit_teacher
CREATE TABLE IF NOT EXISTS `log_contents_edit_teacher` (
  `log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `school_contents_id` int(10) unsigned NOT NULL,
  `teacher_id` int(10) unsigned NOT NULL,
  `contents_edit_action_id` tinyint(3) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `school_contents_id` (`school_contents_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `contents_edit_action_id` (`contents_edit_action_id`),
  KEY `FK_log_contents_edit_teacher_mst_contents_category` (`contents_category_id`),
  CONSTRAINT `FK_log_contents_edit_teacher_mst_contents_category` FOREIGN KEY (`contents_category_id`) REFERENCES `mst_contents_category` (`contents_category_id`),
  CONSTRAINT `log_contents_edit_teacher_ibfk_1` FOREIGN KEY (`school_contents_id`) REFERENCES `tbl_school_contents_bk` (`school_contents_id`),
  CONSTRAINT `log_contents_edit_teacher_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `tbl_teacher` (`teacher_id`),
  CONSTRAINT `log_contents_edit_teacher_ibfk_3` FOREIGN KEY (`contents_edit_action_id`) REFERENCES `mst_contents_edit_action` (`contents_edit_action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_contents_edit_teacher: ~0 rows (approximately)
DELETE FROM `log_contents_edit_teacher`;
/*!40000 ALTER TABLE `log_contents_edit_teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_contents_edit_teacher` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_contents_history_student
CREATE TABLE IF NOT EXISTS `log_contents_history_student` (
  `history_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `school_contents_id` int(10) unsigned NOT NULL,
  `student_id` int(10) unsigned NOT NULL,
  `player_code` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `key_word` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `registered_datetime` datetime NOT NULL,
  `contents_download_datetime` datetime DEFAULT NULL,
  `history_upload_datetime` datetime DEFAULT NULL,
  `reached_frame` bigint(10) unsigned DEFAULT NULL,
  `proportion_flg` tinyint(3) unsigned DEFAULT 0,
  `proportion` tinyint(3) unsigned DEFAULT 0,
  `duration` bigint(10) unsigned DEFAULT NULL,
  `reacquire_data_flg` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `play_start_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  UNIQUE KEY `key_word` (`key_word`),
  KEY `school_contents_id` (`school_contents_id`),
  KEY `student_id` (`student_id`),
  KEY `FK_log_contents_history_student_mst_contents_category` (`contents_category_id`),
  CONSTRAINT `FK_log_contents_history_student_mst_contents_category` FOREIGN KEY (`contents_category_id`) REFERENCES `mst_contents_category` (`contents_category_id`),
  CONSTRAINT `log_contents_history_student_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `tbl_student` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_contents_history_student: ~6 rows (approximately)
DELETE FROM `log_contents_history_student`;
/*!40000 ALTER TABLE `log_contents_history_student` DISABLE KEYS */;
INSERT INTO `log_contents_history_student` (`history_id`, `contents_category_id`, `school_contents_id`, `student_id`, `player_code`, `key_word`, `registered_datetime`, `contents_download_datetime`, `history_upload_datetime`, `reached_frame`, `proportion_flg`, `proportion`, `duration`, `reacquire_data_flg`, `play_start_datetime`) VALUES
	(1, 1, 1, 1, '41f844357da552114227a7774a66f033e88b269a3a32c9af', NULL, '2019-12-03 12:08:18', '2019-12-03 12:08:18', '2019-12-03 12:09:08', 46370, 1, 80, 87560, 0, '2019-12-03 12:08:18'),
	(2, 1, 1, 1, 'cb5ac3d4ff047115cce28051c148c8c438f2b8b489221086', NULL, '2019-12-03 12:09:17', '2019-12-03 12:09:17', '2019-12-03 12:10:32', 69860, 1, 80, 87560, 0, '2019-12-03 12:09:17'),
	(3, 1, 21, 1, '9a87f3c1fe5b3bb13b084d8ffb5af8db48f21da84658f97b', NULL, '2019-12-03 14:18:17', '2019-12-03 14:18:17', '2019-12-03 14:18:25', 5370, 0, 0, 123270, 0, '2019-12-03 14:18:17'),
	(4, 1, 54, 1, '30eb4b0e89a0283fb0ec750d776ad7cb14ca11c034cfdb58', NULL, '2019-12-03 14:55:27', '2019-12-03 14:55:27', '2019-12-03 14:55:34', 0, 0, 0, 105830, 0, '2019-12-03 14:55:27'),
	(5, 1, 60, 1, '14dec4ae0205f8a4a23567eebcddb8e6606c625c0bcc98a0', NULL, '2019-12-03 14:55:44', '2019-12-03 14:55:44', '2019-12-03 14:55:50', 1270, 0, 10, 105830, 0, '2019-12-03 14:55:44'),
	(6, 1, 60, 1, 'fa83d708dd2d17aa15e5d55f4f71d61d2b196bb24855ca64', NULL, '2019-12-03 14:56:03', '2019-12-03 14:56:03', '2019-12-03 14:59:10', 7590, 0, 10, 105830, 0, '2019-12-03 14:56:03');
/*!40000 ALTER TABLE `log_contents_history_student` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_contents_history_student_event
CREATE TABLE IF NOT EXISTS `log_contents_history_student_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `history_id` bigint(20) unsigned NOT NULL,
  `progress_time` bigint(20) unsigned NOT NULL,
  `position` bigint(20) unsigned NOT NULL,
  `event_action_id` tinyint(3) unsigned NOT NULL,
  `speed_id` tinyint(3) unsigned NOT NULL,
  `volume_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `history_id` (`history_id`),
  KEY `event_action_id` (`event_action_id`),
  KEY `speed_id` (`speed_id`),
  KEY `volume_id` (`volume_id`),
  KEY `FK_log_contents_history_student_event_mst_contents_category` (`contents_category_id`),
  CONSTRAINT `FK_log_contents_history_student_event_mst_contents_category` FOREIGN KEY (`contents_category_id`) REFERENCES `mst_contents_category` (`contents_category_id`),
  CONSTRAINT `log_contents_history_student_event_ibfk_2` FOREIGN KEY (`event_action_id`) REFERENCES `mst_event_action` (`event_action_id`),
  CONSTRAINT `log_contents_history_student_event_ibfk_3` FOREIGN KEY (`speed_id`) REFERENCES `mst_speed` (`speed_id`),
  CONSTRAINT `log_contents_history_student_event_ibfk_4` FOREIGN KEY (`volume_id`) REFERENCES `mst_volume` (`volume_id`),
  CONSTRAINT `log_contents_history_student_event_ibfk_5` FOREIGN KEY (`history_id`) REFERENCES `log_contents_history_student` (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_contents_history_student_event: ~48 rows (approximately)
DELETE FROM `log_contents_history_student_event`;
/*!40000 ALTER TABLE `log_contents_history_student_event` DISABLE KEYS */;
INSERT INTO `log_contents_history_student_event` (`event_id`, `contents_category_id`, `history_id`, `progress_time`, `position`, `event_action_id`, `speed_id`, `volume_id`) VALUES
	(1, 1, 1, 40, 0, 0, 0, 100),
	(2, 1, 1, 951, 0, 2, 10, 100),
	(3, 1, 1, 963, 10, 2, 0, 100),
	(4, 1, 1, 1572, 10, 2, 10, 100),
	(5, 1, 1, 3056, 1490, 3, 10, 100),
	(6, 1, 1, 9341, 7780, 2, 0, 100),
	(7, 1, 1, 9401, 7780, 2, 10, 100),
	(8, 1, 1, 20502, 18880, 2, 0, 100),
	(9, 1, 1, 20559, 18880, 2, 10, 100),
	(10, 1, 1, 30470, 28790, 2, 0, 100),
	(11, 1, 1, 30541, 28790, 2, 10, 100),
	(12, 1, 1, 47366, 45610, 2, 0, 100),
	(13, 1, 1, 47883, 45610, 2, 10, 100),
	(14, 1, 1, 48638, 46370, 255, 0, 100),
	(15, 1, 2, 20, 0, 0, 0, 100),
	(16, 1, 2, 1612, 0, 2, 10, 100),
	(17, 1, 2, 1621, 0, 2, 0, 100),
	(18, 1, 2, 3514, 0, 2, 10, 100),
	(19, 1, 2, 4307, 800, 3, 10, 100),
	(20, 1, 2, 11296, 7790, 2, 0, 100),
	(21, 1, 2, 11379, 7790, 2, 10, 100),
	(22, 1, 2, 22469, 18880, 2, 0, 100),
	(23, 1, 2, 22653, 18880, 2, 10, 100),
	(24, 1, 2, 32632, 28860, 2, 0, 100),
	(25, 1, 2, 32733, 28860, 2, 10, 100),
	(26, 1, 2, 49576, 45700, 2, 0, 100),
	(27, 1, 2, 49640, 45700, 2, 10, 100),
	(28, 1, 2, 65896, 61950, 2, 0, 100),
	(29, 1, 2, 65961, 61950, 2, 10, 100),
	(30, 1, 2, 73867, 69860, 255, 0, 100),
	(31, 1, 3, 27, 0, 0, 0, 100),
	(32, 1, 3, 902, 0, 2, 10, 100),
	(33, 1, 3, 912, 10, 2, 0, 100),
	(34, 1, 3, 1006, 10, 2, 10, 100),
	(35, 1, 3, 6369, 5370, 255, 0, 100),
	(36, 1, 4, 32, 0, 0, 0, 100),
	(37, 1, 4, 925, 0, 2, 10, 100),
	(38, 1, 4, 934, 0, 255, 0, 100),
	(39, 1, 5, 16, 0, 0, 0, 100),
	(40, 1, 5, 871, 0, 2, 10, 100),
	(41, 1, 5, 879, 0, 2, 0, 100),
	(42, 1, 5, 938, 0, 2, 10, 100),
	(43, 1, 5, 2201, 1270, 255, 0, 100),
	(44, 1, 6, 20, 0, 0, 0, 100),
	(45, 1, 6, 874, 0, 2, 10, 100),
	(46, 1, 6, 887, 10, 2, 0, 100),
	(47, 1, 6, 960, 10, 2, 10, 100),
	(48, 1, 6, 8540, 7590, 255, 0, 100);
/*!40000 ALTER TABLE `log_contents_history_student_event` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_contents_history_student_event_reason
CREATE TABLE IF NOT EXISTS `log_contents_history_student_event_reason` (
  `reason_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `event_reason_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`reason_id`),
  KEY `log_contents_history_student_event_reason_ibfk1` (`event_id`),
  KEY `log_contents_history_student_event_reason_ibfk2` (`event_reason_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.log_contents_history_student_event_reason: ~60 rows (approximately)
DELETE FROM `log_contents_history_student_event_reason`;
/*!40000 ALTER TABLE `log_contents_history_student_event_reason` DISABLE KEYS */;
INSERT INTO `log_contents_history_student_event_reason` (`reason_id`, `event_id`, `event_reason_id`) VALUES
	(1, 1, 18),
	(2, 1, 19),
	(3, 1, 20),
	(4, 2, 5),
	(5, 3, 17),
	(6, 4, 5),
	(7, 5, 22),
	(8, 6, 17),
	(9, 7, 5),
	(10, 8, 17),
	(11, 9, 5),
	(12, 10, 17),
	(13, 11, 5),
	(14, 12, 17),
	(15, 13, 5),
	(16, 14, 3),
	(17, 15, 18),
	(18, 15, 19),
	(19, 15, 20),
	(20, 16, 5),
	(21, 17, 17),
	(22, 18, 5),
	(23, 19, 22),
	(24, 20, 17),
	(25, 21, 5),
	(26, 22, 17),
	(27, 23, 5),
	(28, 24, 17),
	(29, 25, 5),
	(30, 26, 17),
	(31, 27, 5),
	(32, 28, 17),
	(33, 29, 5),
	(34, 30, 3),
	(35, 31, 18),
	(36, 31, 19),
	(37, 31, 20),
	(38, 32, 5),
	(39, 33, 17),
	(40, 34, 5),
	(41, 35, 3),
	(42, 36, 18),
	(43, 36, 19),
	(44, 36, 20),
	(45, 37, 5),
	(46, 38, 17),
	(47, 39, 18),
	(48, 39, 19),
	(49, 39, 20),
	(50, 40, 5),
	(51, 41, 17),
	(52, 42, 5),
	(53, 43, 3),
	(54, 44, 18),
	(55, 44, 19),
	(56, 44, 20),
	(57, 45, 5),
	(58, 46, 17),
	(59, 47, 5),
	(60, 48, 3);
/*!40000 ALTER TABLE `log_contents_history_student_event_reason` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_organizer_login
CREATE TABLE IF NOT EXISTS `log_organizer_login` (
  `log_id` bigint(20) unsigned NOT NULL,
  `organizer_id` int(10) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_bin NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `organizer_id` (`organizer_id`),
  CONSTRAINT `log_organizer_login_ibfk_1` FOREIGN KEY (`organizer_id`) REFERENCES `tbl_organizer` (`organizer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_organizer_login: ~0 rows (approximately)
DELETE FROM `log_organizer_login`;
/*!40000 ALTER TABLE `log_organizer_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_organizer_login` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_student_login
CREATE TABLE IF NOT EXISTS `log_student_login` (
  `log_id` bigint(20) unsigned NOT NULL,
  `student_id` int(10) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_bin NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `log_student_login_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `tbl_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_student_login: ~0 rows (approximately)
DELETE FROM `log_student_login`;
/*!40000 ALTER TABLE `log_student_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_student_login` ENABLE KEYS */;

-- Dumping structure for table kaizen.log_teacher_login
CREATE TABLE IF NOT EXISTS `log_teacher_login` (
  `log_id` bigint(20) unsigned NOT NULL,
  `teacher_id` int(10) unsigned NOT NULL,
  `datetime` datetime NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_bin NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `log_teacher_login_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `tbl_teacher` (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.log_teacher_login: ~0 rows (approximately)
DELETE FROM `log_teacher_login`;
/*!40000 ALTER TABLE `log_teacher_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_teacher_login` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_boolean
CREATE TABLE IF NOT EXISTS `mst_boolean` (
  `boolean_id` tinyint(4) unsigned NOT NULL,
  `boolean` varchar(5) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_boolean: ~3 rows (approximately)
DELETE FROM `mst_boolean`;
/*!40000 ALTER TABLE `mst_boolean` DISABLE KEYS */;
INSERT INTO `mst_boolean` (`boolean_id`, `boolean`) VALUES
	(0, 'false'),
	(1, 'true'),
	(2, 'purge');
/*!40000 ALTER TABLE `mst_boolean` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_contents_category
CREATE TABLE IF NOT EXISTS `mst_contents_category` (
  `contents_category_id` tinyint(3) unsigned NOT NULL,
  `contents_category_name` varchar(15) CHARACTER SET utf8 NOT NULL,
  `display_name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`contents_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_contents_category: ~2 rows (approximately)
DELETE FROM `mst_contents_category`;
/*!40000 ALTER TABLE `mst_contents_category` DISABLE KEYS */;
INSERT INTO `mst_contents_category` (`contents_category_id`, `contents_category_name`, `display_name`) VALUES
	(0, 'common', '共通コンテンツ'),
	(1, 'school', '学校コンテンツ');
/*!40000 ALTER TABLE `mst_contents_category` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_contents_edit_action
CREATE TABLE IF NOT EXISTS `mst_contents_edit_action` (
  `contents_edit_action_id` tinyint(3) unsigned NOT NULL,
  `action` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`contents_edit_action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_contents_edit_action: ~3 rows (approximately)
DELETE FROM `mst_contents_edit_action`;
/*!40000 ALTER TABLE `mst_contents_edit_action` DISABLE KEYS */;
INSERT INTO `mst_contents_edit_action` (`contents_edit_action_id`, `action`) VALUES
	(1, 'registration'),
	(2, 'change'),
	(3, 'delete');
/*!40000 ALTER TABLE `mst_contents_edit_action` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_contents_extension
CREATE TABLE IF NOT EXISTS `mst_contents_extension` (
  `contents_extension_id` tinyint(3) unsigned NOT NULL,
  `extension` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`contents_extension_id`),
  UNIQUE KEY `extension` (`extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_contents_extension: ~8 rows (approximately)
DELETE FROM `mst_contents_extension`;
/*!40000 ALTER TABLE `mst_contents_extension` DISABLE KEYS */;
INSERT INTO `mst_contents_extension` (`contents_extension_id`, `extension`) VALUES
	(8, 'MP4'),
	(1, 'TBO'),
	(3, 'TBO-L'),
	(4, 'TBO-LN'),
	(5, 'TBO-M'),
	(6, 'TBO-MN'),
	(2, 'TBON'),
	(7, 'mp4');
/*!40000 ALTER TABLE `mst_contents_extension` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_event_action
CREATE TABLE IF NOT EXISTS `mst_event_action` (
  `event_action_id` tinyint(3) unsigned NOT NULL,
  `event` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`event_action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_event_action: ~7 rows (approximately)
DELETE FROM `mst_event_action`;
/*!40000 ALTER TABLE `mst_event_action` DISABLE KEYS */;
INSERT INTO `mst_event_action` (`event_action_id`, `event`) VALUES
	(0, 'non'),
	(1, 'position'),
	(2, 'speed'),
	(3, 'volume'),
	(4, 'last'),
	(5, 'abort'),
	(255, 'end');
/*!40000 ALTER TABLE `mst_event_action` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_event_reason
CREATE TABLE IF NOT EXISTS `mst_event_reason` (
  `event_reason_id` tinyint(3) unsigned NOT NULL,
  `reason` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`event_reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table kaizen.mst_event_reason: ~25 rows (approximately)
DELETE FROM `mst_event_reason`;
/*!40000 ALTER TABLE `mst_event_reason` DISABLE KEYS */;
INSERT INTO `mst_event_reason` (`event_reason_id`, `reason`) VALUES
	(1, 'INVISIBLE'),
	(2, 'WAIT_TOUCH_MEDIA'),
	(3, 'PAUSE'),
	(4, 'SEARCH'),
	(5, 'ALL_CLEAR'),
	(6, 'PLAY_BUTTON'),
	(7, 'PAUSE_BUTTON'),
	(8, 'TOP_BUTTON'),
	(9, 'PREVIOUS_BUTTON'),
	(10, 'NEXT_BUTTON'),
	(11, 'SEEK_BAR'),
	(12, 'AUTO_REPEAT'),
	(13, 'CHAPTER'),
	(14, 'SPEED_BAR'),
	(15, 'WAIT_TOUCH_FULL_SCREEN'),
	(16, 'BLOCK_HOLD'),
	(17, 'WAIT_MEDIA'),
	(18, 'LOAD_IMAGE'),
	(19, 'LOAD_PEN'),
	(20, 'LOAD_AUDIO'),
	(21, 'LOAD_VIDEO'),
	(22, 'VOLUME_BAR'),
	(23, 'SWITCHING_SPEED'),
	(24, 'BEFORE_SEEK'),
	(25, 'BACK_SEEK');
/*!40000 ALTER TABLE `mst_event_reason` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_query_type
CREATE TABLE IF NOT EXISTS `mst_query_type` (
  `query_type_id` tinyint(4) unsigned NOT NULL,
  `type` varchar(25) COLLATE utf8_bin NOT NULL,
  `type_jp` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`query_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_query_type: ~4 rows (approximately)
DELETE FROM `mst_query_type`;
/*!40000 ALTER TABLE `mst_query_type` DISABLE KEYS */;
INSERT INTO `mst_query_type` (`query_type_id`, `type`, `type_jp`) VALUES
	(0, 'single_choice', 'single_choice'),
	(1, 'multiple_choice', 'multiple_choice'),
	(2, 'word', 'word'),
	(3, 'length', 'length');
/*!40000 ALTER TABLE `mst_query_type` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_speed
CREATE TABLE IF NOT EXISTS `mst_speed` (
  `speed_id` tinyint(3) unsigned NOT NULL,
  `speed` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`speed_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_speed: ~35 rows (approximately)
DELETE FROM `mst_speed`;
/*!40000 ALTER TABLE `mst_speed` DISABLE KEYS */;
INSERT INTO `mst_speed` (`speed_id`, `speed`) VALUES
	(0, 'x0'),
	(1, 'x1'),
	(2, 'x2'),
	(4, 'x4'),
	(10, 'x1'),
	(11, 'x1.1'),
	(12, 'x1.2'),
	(13, 'x1.3'),
	(14, 'x1.4'),
	(15, 'x1.5'),
	(16, 'x1.6'),
	(17, 'x1.7'),
	(18, 'x1.8'),
	(19, 'x1.9'),
	(20, 'x2'),
	(21, 'x2.1'),
	(22, 'x2.2'),
	(23, 'x2.3'),
	(24, 'x2.4'),
	(25, 'x2.5'),
	(26, 'x2.6'),
	(27, 'x2.7'),
	(28, 'x2.8'),
	(29, 'x2.9'),
	(30, 'x3'),
	(31, 'x3.1'),
	(32, 'x3.2'),
	(33, 'x3.3'),
	(34, 'x3.4'),
	(35, 'x3.5'),
	(36, 'x3.6'),
	(37, 'x3.7'),
	(38, 'x3.8'),
	(39, 'x3.9'),
	(40, 'x4');
/*!40000 ALTER TABLE `mst_speed` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_user_level
CREATE TABLE IF NOT EXISTS `mst_user_level` (
  `user_level_id` tinyint(4) unsigned NOT NULL,
  `user_level_name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`user_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_user_level: ~3 rows (approximately)
DELETE FROM `mst_user_level`;
/*!40000 ALTER TABLE `mst_user_level` DISABLE KEYS */;
INSERT INTO `mst_user_level` (`user_level_id`, `user_level_name`) VALUES
	(0, 'admin'),
	(1, 'teacher'),
	(2, 'student');
/*!40000 ALTER TABLE `mst_user_level` ENABLE KEYS */;

-- Dumping structure for table kaizen.mst_volume
CREATE TABLE IF NOT EXISTS `mst_volume` (
  `volume_id` tinyint(3) unsigned NOT NULL,
  `volume` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`volume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.mst_volume: ~101 rows (approximately)
DELETE FROM `mst_volume`;
/*!40000 ALTER TABLE `mst_volume` DISABLE KEYS */;
INSERT INTO `mst_volume` (`volume_id`, `volume`) VALUES
	(0, '0%'),
	(1, '1%'),
	(2, '2%'),
	(3, '3%'),
	(4, '4%'),
	(5, '5%'),
	(6, '6%'),
	(7, '7%'),
	(8, '8%'),
	(9, '9%'),
	(10, '10%'),
	(11, '11%'),
	(12, '12%'),
	(13, '13%'),
	(14, '14%'),
	(15, '15%'),
	(16, '16%'),
	(17, '17%'),
	(18, '18%'),
	(19, '19%'),
	(20, '20%'),
	(21, '21%'),
	(22, '22%'),
	(23, '23%'),
	(24, '24%'),
	(25, '25%'),
	(26, '26%'),
	(27, '27%'),
	(28, '28%'),
	(29, '29%'),
	(30, '30%'),
	(31, '31%'),
	(32, '32%'),
	(33, '33%'),
	(34, '34%'),
	(35, '35%'),
	(36, '36%'),
	(37, '37%'),
	(38, '38%'),
	(39, '39%'),
	(40, '40%'),
	(41, '41%'),
	(42, '42%'),
	(43, '43%'),
	(44, '44%'),
	(45, '45%'),
	(46, '46%'),
	(47, '47%'),
	(48, '48%'),
	(49, '49%'),
	(50, '50%'),
	(51, '51%'),
	(52, '52%'),
	(53, '53%'),
	(54, '54%'),
	(55, '55%'),
	(56, '56%'),
	(57, '57%'),
	(58, '58%'),
	(59, '59%'),
	(60, '60%'),
	(61, '61%'),
	(62, '62%'),
	(63, '63%'),
	(64, '64%'),
	(65, '65%'),
	(66, '66%'),
	(67, '67%'),
	(68, '68%'),
	(69, '69%'),
	(70, '70%'),
	(71, '71%'),
	(72, '72%'),
	(73, '73%'),
	(74, '74%'),
	(75, '75%'),
	(76, '76%'),
	(77, '77%'),
	(78, '78%'),
	(79, '79%'),
	(80, '80%'),
	(81, '81%'),
	(82, '82%'),
	(83, '83%'),
	(84, '84%'),
	(85, '85%'),
	(86, '86%'),
	(87, '87%'),
	(88, '88%'),
	(89, '89%'),
	(90, '90%'),
	(91, '91%'),
	(92, '92%'),
	(93, '93%'),
	(94, '94%'),
	(95, '95%'),
	(96, '96%'),
	(97, '97%'),
	(98, '98%'),
	(99, '99%'),
	(100, '100%');
/*!40000 ALTER TABLE `mst_volume` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__bookmark
CREATE TABLE IF NOT EXISTS `pma__bookmark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- Dumping data for table kaizen.pma__bookmark: ~0 rows (approximately)
DELETE FROM `pma__bookmark`;
/*!40000 ALTER TABLE `pma__bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__bookmark` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__central_columns
CREATE TABLE IF NOT EXISTS `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin DEFAULT NULL,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`db_name`,`col_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- Dumping data for table kaizen.pma__central_columns: ~0 rows (approximately)
DELETE FROM `pma__central_columns`;
/*!40000 ALTER TABLE `pma__central_columns` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__central_columns` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__column_info
CREATE TABLE IF NOT EXISTS `pma__column_info` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- Dumping data for table kaizen.pma__column_info: ~0 rows (approximately)
DELETE FROM `pma__column_info`;
/*!40000 ALTER TABLE `pma__column_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__column_info` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__designer_settings
CREATE TABLE IF NOT EXISTS `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- Dumping data for table kaizen.pma__designer_settings: ~0 rows (approximately)
DELETE FROM `pma__designer_settings`;
/*!40000 ALTER TABLE `pma__designer_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__designer_settings` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__export_templates
CREATE TABLE IF NOT EXISTS `pma__export_templates` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- Dumping data for table kaizen.pma__export_templates: ~0 rows (approximately)
DELETE FROM `pma__export_templates`;
/*!40000 ALTER TABLE `pma__export_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__export_templates` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__favorite
CREATE TABLE IF NOT EXISTS `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- Dumping data for table kaizen.pma__favorite: ~0 rows (approximately)
DELETE FROM `pma__favorite`;
/*!40000 ALTER TABLE `pma__favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__favorite` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__history
CREATE TABLE IF NOT EXISTS `pma__history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`,`db`,`table`,`timevalue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- Dumping data for table kaizen.pma__history: ~0 rows (approximately)
DELETE FROM `pma__history`;
/*!40000 ALTER TABLE `pma__history` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__history` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__navigationhiding
CREATE TABLE IF NOT EXISTS `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- Dumping data for table kaizen.pma__navigationhiding: ~0 rows (approximately)
DELETE FROM `pma__navigationhiding`;
/*!40000 ALTER TABLE `pma__navigationhiding` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__navigationhiding` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__pdf_pages
CREATE TABLE IF NOT EXISTS `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`page_nr`),
  KEY `db_name` (`db_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- Dumping data for table kaizen.pma__pdf_pages: ~0 rows (approximately)
DELETE FROM `pma__pdf_pages`;
/*!40000 ALTER TABLE `pma__pdf_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__pdf_pages` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__recent
CREATE TABLE IF NOT EXISTS `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- Dumping data for table kaizen.pma__recent: ~0 rows (approximately)
DELETE FROM `pma__recent`;
/*!40000 ALTER TABLE `pma__recent` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__recent` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__relation
CREATE TABLE IF NOT EXISTS `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  KEY `foreign_field` (`foreign_db`,`foreign_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- Dumping data for table kaizen.pma__relation: ~0 rows (approximately)
DELETE FROM `pma__relation`;
/*!40000 ALTER TABLE `pma__relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__relation` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__savedsearches
CREATE TABLE IF NOT EXISTS `pma__savedsearches` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- Dumping data for table kaizen.pma__savedsearches: ~0 rows (approximately)
DELETE FROM `pma__savedsearches`;
/*!40000 ALTER TABLE `pma__savedsearches` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__savedsearches` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__table_coords
CREATE TABLE IF NOT EXISTS `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float unsigned NOT NULL DEFAULT 0,
  `y` float unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- Dumping data for table kaizen.pma__table_coords: ~0 rows (approximately)
DELETE FROM `pma__table_coords`;
/*!40000 ALTER TABLE `pma__table_coords` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__table_coords` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__table_info
CREATE TABLE IF NOT EXISTS `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`db_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- Dumping data for table kaizen.pma__table_info: ~0 rows (approximately)
DELETE FROM `pma__table_info`;
/*!40000 ALTER TABLE `pma__table_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__table_info` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__table_uiprefs
CREATE TABLE IF NOT EXISTS `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`username`,`db_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- Dumping data for table kaizen.pma__table_uiprefs: ~0 rows (approximately)
DELETE FROM `pma__table_uiprefs`;
/*!40000 ALTER TABLE `pma__table_uiprefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__table_uiprefs` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__tracking
CREATE TABLE IF NOT EXISTS `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin DEFAULT NULL,
  `data_sql` longtext COLLATE utf8_bin DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`db_name`,`table_name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- Dumping data for table kaizen.pma__tracking: ~0 rows (approximately)
DELETE FROM `pma__tracking`;
/*!40000 ALTER TABLE `pma__tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__tracking` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__userconfig
CREATE TABLE IF NOT EXISTS `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

-- Dumping data for table kaizen.pma__userconfig: ~0 rows (approximately)
DELETE FROM `pma__userconfig`;
/*!40000 ALTER TABLE `pma__userconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__userconfig` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__usergroups
CREATE TABLE IF NOT EXISTS `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N',
  PRIMARY KEY (`usergroup`,`tab`,`allowed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- Dumping data for table kaizen.pma__usergroups: ~0 rows (approximately)
DELETE FROM `pma__usergroups`;
/*!40000 ALTER TABLE `pma__usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__usergroups` ENABLE KEYS */;

-- Dumping structure for table kaizen.pma__users
CREATE TABLE IF NOT EXISTS `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`username`,`usergroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

-- Dumping data for table kaizen.pma__users: ~0 rows (approximately)
DELETE FROM `pma__users`;
/*!40000 ALTER TABLE `pma__users` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__users` ENABLE KEYS */;

-- Dumping structure for table kaizen.tblcms_admin
CREATE TABLE IF NOT EXISTS `tblcms_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `AdminUserName` varchar(255) NOT NULL,
  `AdminPassword` varchar(255) NOT NULL,
  `AdminEmailId` varchar(255) NOT NULL,
  `Is_Active` int(11) NOT NULL,
  `CreationDate` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table kaizen.tblcms_admin: ~0 rows (approximately)
DELETE FROM `tblcms_admin`;
/*!40000 ALTER TABLE `tblcms_admin` DISABLE KEYS */;
INSERT INTO `tblcms_admin` (`id`, `AdminUserName`, `AdminPassword`, `AdminEmailId`, `Is_Active`, `CreationDate`) VALUES
	(1, 'admin', '$2y$10$fX40BAGH7V3vD5g7y4XoLu6.XTJhTktF7yC0fTbH3jlK01I47fwV6', 'cms_admin@e-kjs.jp', 1, '2019-10-28 17:51:00');
/*!40000 ALTER TABLE `tblcms_admin` ENABLE KEYS */;

-- Dumping structure for table kaizen.tblcms_posts
CREATE TABLE IF NOT EXISTS `tblcms_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `PostTitle` longtext DEFAULT NULL,
  `PostDetails` longtext DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT current_timestamp(),
  `PostingDate` varchar(255) NOT NULL,
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `Is_Active` int(1) DEFAULT NULL,
  `PostUrl` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tblcms_posts: ~4 rows (approximately)
DELETE FROM `tblcms_posts`;
/*!40000 ALTER TABLE `tblcms_posts` DISABLE KEYS */;
INSERT INTO `tblcms_posts` (`id`, `PostTitle`, `PostDetails`, `CreationDate`, `PostingDate`, `UpdationDate`, `Is_Active`, `PostUrl`) VALUES
	(1, 'Kaizen Learning Platform - Under Construction', '<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Kaizen Learning Platform - Under Construction</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img src="data:image/jpeg;base64,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+Y+qUJSL4/SrH1llSmCGv3pPAWxIPMpUWez6rCiEZ7zqKioqUXFFibV/MfVfzn1X8Z9VIkUun6pJw1EhPiE1CSUWW3r61iDtKioqKGCOEzpTAWYPqv5j6r+c+q/nvqv5z6r+e+qwauRxlOVqC1RUUUQUI5lMu7AKDS9ARugWoHx2HBS4Bu6DPtUpXcJ/IaVvBsD6o5NiKjLa1RUVFRWoseHNhX859V/MfVfzH1X859V/OfVCgswiIGjbhFRUUT02NB4q/nPqv576r+e+qaMCYDTlQOHlvqpfrQhsdG1RUVFRUUXHLpp4FyDJyvKKu61gG1WlKOS75V/MfVCEaYMPqpYyWz3nUVFRUcIoMZZCH1R0yCM22FbYfA+qMWIgQ8kRTYlsDOVRUVFRUVFRUVFRUVFRUVFOjDecaccJzrGTFAA5E1j82AW8yv576r+c+q/nPqjspyEQNG1RUVFRQRAXDjdcxrbdafvQpMAlCY2uYUcgvCrqzu1ERDAIlRUVFRUU0yWNKPpUFITEPqv5j6r+c+q/nPqv5j6oQCjZh9VgqsOM1FRUU5mRm1P5j6r+Y+q/mPqv5j6r+Y+q/9oADAMBAAIAAwAAABD777777777777777777777777777777777777777777777777777777777777777777777777777777777777777z777777777777777777777777777777777777777777777b777777777777777777777777777776DH77777777777777777777777777777777777777777777Rv77777777777777777777777777777Vir777777777777777777H2PX7777777777777777777773xH7777777777777777766ufP777776oY3T77777777777777776Y2zzrX7777777777777777776ka2T77777777777777776Abx4H77776ua0zz7777777777777776kXtDzxrb77777777777777776zYMbz7777777777777776oAqBX77776s+khz77777777777777774vwsBbBr77777777777777777x9Ubz77777777777777775myoDcL7777xnVz777777777777777775dwkio7z77777777777777767R/fz777777777777777774352YAz76eBehz777777777777777777703yxpj7777777777777776M6c/z777777777777/wC+++++IT2jDM++g9L++++++++++++++++++++++9+aeun/APPPvvvvvvvvvvvpx1/vvvvvvvvvuPL7FtPvvvvviSmXPvvvXvPvvvvuPvvvvvvvvvvvvvvvvrHncX/P7edvvvvvvvvvvv8Abz77777jzjTE0/7Fezz77z776x77777777777777/wC++++++++++h8+++8155btAJKetX++++++42+++++++++6j+GJe8m6390/++++++++++++++++++++/wDvvvvvvvvoXvvvvu10IK3HH7HmHPvvvvuBfvvvvvvvvvqLXrvvnERtflfvvvvvvvvvvvvvvvvvvvvvv/vvvvvvoXvvvvvrHw3n/vv/AL6rX7777gX77777777774L3/wA+++D31uf+++++++++++++++++++++++/+++++he+++++++++iZ+++/wDrLvtEMxfvvvvvvvvvvvv3Pv8Az74RX/77777777777777777777777777/wC++he+++8888+++IPzMI9/++wLZF8z8++++++++++++++/8+TS++++++++++++++++++++++++++++/wDoXvvvviBj/wD774nAHDB77+91weEHqpz77777777777wMMZx5b6sMPb777777777777777777777776Z7777765AnT774mAJaL/778W+77779/wC++++++++++8xTrn6c+tzJ++++++++++++++++++++++++he/+++++6s9QyyyfcWt8/wDvuBOZvvvvvvvvvsMPvvvvvPEEf91vvKPfvvvvvvvvvvvvvvvvvvvvvvoXvvv/AL777/zzvTC8sIUzz/7gX6zX777777764QN77777zyCj2irzzwz7777777777777777777776F77777/AO++/wDPLadVv1VfPMMAcfuu/vvvvvvvvFX/AD77LLWByj01bP8A88+++++++++++++++++++++he++++++/++/888888PKV884Ebd+6s/8AvttfPvvDPPPlRVIHPKPcSfCNPPvvvvvvvvvvvvvvvvvvvoXvvvvvvvvv/v8AzzzzzwrFXzgCw937537/AF/AQK7x84CAy8Ff88o9mYe8I0+++++++++++++++++++he++++++++++9/888888HUc4Ese8/8AuO9jl4wJ1qNfPMV4YD3PPKPV/TPPCNvvvvvvvvvvvvvvvvvrnvvvvvvvvvvvvv8Azzzzyzzxwzzzzz/p7COg9NS56hbzw30Nzzzzyi/zzzzzx7777777777777777777777777777776hXzzzzzywTzzzzzwTrbwVPFxTzyxzzzzwrzzzzzw/wA88888z++++++++++++xRpX++++++++++++++pc888884gs888888888888888888gE08888888888888888b+++++7z++++mFkMlX+++++++++++++988888wYgA88888888888888888gk8s088888888888888842+++jgM+++pFzxRuG0++++++++++++c8888s0g0c8888888888888888ok8c0s0888888888888884e++4eXM+++P0qAs7Cc++++++++++++18884cMg88888888888888888888U8wQQ88888888888888s1++Pp58+++v2cGqac++++++++++++688880oAc8888888888888LNc08w8c4E4c88888888888888sc88p7c++++ue8RSc++++++++++++++W88Eowc88888888888888r+v88sU804c8888888888888888NsFIc++++++uiB8+++++++++++++++w8U4Q88888888888888881+/c88scgc88888888888888888n/A++++++++++++++4++++++++++++of8Yc8888880888888888T+9888888888888888888888884g+c++++++++++++++89++++++++++++G088888888I088888888l+yU888888888Q888888888884TV+++++++++++++++++89++++++++++/8A9PPPPPPPPPCNPPPPPPPKoX/PPPPPPPPPLEPPPPPPPPPOBK/vvvvvvvvvvvvvvvvvvvPfvvvvvvvv/vvPPPPPPPPPPCNPPPPPPL3OvPPPPPPPPPPLEPPPPPPPOBPPPvvvvvvvvvvvvvvvvvvvvPfvvvvvv/vuXvPPPPPPPPPPCNPPPPPOPpPPPPPPPPPPPPLEPPPPPOBPOPvvvvvvvvvvvvvvvvvvvvvvPfvvvv8A776NzzzzzzzzzzzzwjTzzzy7JvzzzzzzzzzzzzyxDzzzgTzytb7777777777777777777777z377/wC+++288888888888888I0888oGv88888888888888sQ84E888k++++++++++++++++++++++++89/+++408888888888888888c088f+7f88888888888888sUE8888F+++++++++++++++++++++++++t9+++gc88888888888888888I083w9c888888888888884UQ888vd++++++++++++++++++++++++/wDvPfvdfPPPPPPPPPPPPPPPPPPCNLH7vPPPPPPPPPPPPPOBPLEPPBvvvvvvvvvvvvvvvvvvvvvvvvv/AL77zxTzzzzzzzzzzzv/AE47z988+M495w068881y+50884E888sQ8U+++++++++++++++++++++++/+++++7888888888888ooU73WV4d8po30xG+4ygo+10L84E88888se+++++++++++++++++++++++/++++++m888888888888oocpUWHaj9p9J0CsW7Q1j+11/4E8888888F/+++++++++++++++++++++/wDvvvvvqFPPPPPPPPPPPPKJVLVHFr5fqffCJfPPMdw/hCoRPPPPPPPPPvv/AL777777777777777777/wC+++++++Ww88888888888qfx27UWPw8p96132e/Qwj+3RM8888888t1+++8+++++++++++++++45u+++++++++s9sR7088888888bL7LYd3N2q7uSkm7vOOPimYv0888888K+++++++++++++++++++8oL++++++++++++++f+88go4088svtc88c8ssM9+c8sMMcAgM8cc88888we+++++++6QtN9++++++5W1V+++++++++++++++28gk08I08YPAO6Dw3PX/wARLyo/xGu5w9+vPPPPOBfvvvvvvun4NLD/AL7777fKHnz77777777777776RyCTxxzxiwwnioKxV5MJ2oTUOUQ99KXdzTzzzzxT77777774iBEHz77777hy+H7777777777777777fyzTTzhSjxB8/2eQBuIC+M24ScyQ5NCRObzzzyP377777774nwkC33777AYdlz7777777777777775nSjxzwThzzzzzzzzzzzzzzzzyySCTzzzzzzzzzX777777775HR4qMD76crtlz77777777777777776dzxjzThzzzzzzzzzzzzzzzzzSxiTzzzzzzzzyjX7777777779LxkT775DL17777777777777777777TzzwzhzzzzzzzzzzzzzzzzzziBzzzzzzzzzzyjb77777777761Yz77766dz77777j7777777777777x/wA888888888888888888888sM88888888888rU++++++++++++++++++++++++++/8Avvvvvvvvvvv3OfPPPPPPPMPPPPPPPPPPPPNPPPPPPPPPPPPPONfvvvvvv3Pvvvvvvvvvvvvvvvvvvv8A777777777/77jzzzzzzzyxDzzzzzzzzzzzzzzzzzzzzzzzzyhb77777/AO+++++++++++++++++++++/+++++++/+++s088888888sQ8888888888888888888888888f++++/8Avvvvvvvvvvvvvvvvvvvvvvvv/vvvvv8A77775TzzzzzzzzyxDzzzzzzzzzzzzzzzzzzzzzzzwD777/77777777777777777777777777/wC++/8AvvvvvgfPPPPPPPPPLEPPPPPPPPPPPPPPPPPPPPPPPLfPv/vvvvvvvvvvvvvvvvvvvvvvvvvvvv8A7/77777767DzzzzzzzzzyxDzzzzzzzzzzzzzzzzzzzzzyz3/AO++++++++++++++++++++++++++++++++++++++++/8888888889tU8888888888888888888888W++++++++++++++++++++++++++++++/wDv/vvvvvvvvvBNtNOPME33uPEPPPPPPPPPPPPPPPPPPPPIDHfvvvvvvvvvvvvvvvvvvvvvvvvvvvv/AL77/wC+++++++++uMeuc+++4x8sQ888888888888888888gc8a+++++++++++++++++++++++++++/+++++/wDvvvvvvvvvvvvvvvuBfffLEPPPPPPPPPPPPPPPPIHPPPFf/vvvvvvvvvvvvvvvvvvvvvvvv/vvvvvvv/vvvvvvvvvvvvvuBfvoPPLEPPPPPPPPPPPPPPIHPPPPK1v/AL777777777777777777777/AO++++++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" data-filename="45878057-under-construction-background-vector-illustration.jpg" style="width: 25%;">&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br></p><p><br></p>', '2019-11-20 05:43:38', '2019/11/20', NULL, 1, 'Kaizen-Learning-Platform---Under-Construction'),
	(2, 'Kaizen E-learning System Launching Soon', '<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Kaizen E-learning System Launching Soon....</p><p><b>Benefits :&nbsp;</b></p><ul><li>Easy&nbsp; to learn</li><li>Learn 24/7</li></ul>', '2019-11-20 05:47:17', '2019/11/20', NULL, 1, 'Kaizen-E-learning-System-Launching-Soon'),
	(3, 'Kaizan AI powered E-learning platform Launching Date', '<p>Kaizan AI powered E-learning platform Launching Date : **/**/****</p><p>click here&nbsp; &nbsp; &nbsp;<a href="http://15.188.130.179/" target="_blank" style="background-color: rgb(255, 255, 255);">Kaizen2.0</a></p>', '2019-11-20 05:50:14', '2019/11/20', '2019-11-21 02:35:03', 1, 'Kaizan-AI-powered-E-learning-platform-Launching-Date'),
	(4, 'Christmas Wishes From Kaizen 2.0', '                              <p>Happy Christmas to all&nbsp;</p><p><b><br></b></p>                            ', '2019-11-21 02:36:27', '2019/11/21', '2019-11-21 02:36:56', 1, 'Christmas-Wishes-From-Kaizen-2.0');
/*!40000 ALTER TABLE `tblcms_posts` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_access_lecture
CREATE TABLE IF NOT EXISTS `tbl_access_lecture` (
  `lecture_type_id` tinyint(3) unsigned NOT NULL,
  `lecture_id` int(10) unsigned NOT NULL,
  `access_id` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_access_lecture: ~0 rows (approximately)
DELETE FROM `tbl_access_lecture`;
/*!40000 ALTER TABLE `tbl_access_lecture` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_access_lecture` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_access_user
CREATE TABLE IF NOT EXISTS `tbl_access_user` (
  `user_level_id` tinyint(3) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `access_id` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_access_user: ~0 rows (approximately)
DELETE FROM `tbl_access_user`;
/*!40000 ALTER TABLE `tbl_access_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_access_user` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_admin
CREATE TABLE IF NOT EXISTS `tbl_admin` (
  `admin_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL,
  `admin_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `access_code` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `access_datetime` datetime DEFAULT NULL,
  `enable` tinyint(3) unsigned NOT NULL,
  `display_order` int(10) unsigned DEFAULT NULL,
  `manage` tinyint(3) unsigned NOT NULL,
  `permission` varchar(1000) COLLATE utf8_bin NOT NULL,
  `bit_subject` varchar(1000) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `id` (`id`),
  KEY `school_id` (`school_id`),
  KEY `enable` (`enable`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_admin: ~2 rows (approximately)
DELETE FROM `tbl_admin`;
/*!40000 ALTER TABLE `tbl_admin` DISABLE KEYS */;
INSERT INTO `tbl_admin` (`admin_id`, `school_id`, `admin_name`, `id`, `password`, `access_code`, `access_datetime`, `enable`, `display_order`, `manage`, `permission`, `bit_subject`) VALUES
	(1, 1, 'kjsadmin1', 'J1e2+b8xHnw+z683N/+9oUb8ZhZQ5NsUSER69tvfrPc=', 'h+zr7FqBfbygm3l4rrdRzA==', NULL, NULL, 1, 1, 1, 'FFFF', '0'),
	(2, 1, 'システム管理者', 'bt9Fnfm8uRp1TBXTb8AzM0b8ZhZQ5NsUSER69tvfrPc=', 'M6OhFvmjR27MCLWq3GwIfA==', NULL, NULL, 1, 2, 1, 'FFFF', '0');
/*!40000 ALTER TABLE `tbl_admin` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_classroom
CREATE TABLE IF NOT EXISTS `tbl_classroom` (
  `classroom_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL,
  `classroom_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_classroom: ~0 rows (approximately)
DELETE FROM `tbl_classroom`;
/*!40000 ALTER TABLE `tbl_classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_classroom` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_classroom_subject_section
CREATE TABLE IF NOT EXISTS `tbl_classroom_subject_section` (
  `classroom_id` int(10) unsigned NOT NULL,
  `subject_section_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table kaizen.tbl_classroom_subject_section: ~0 rows (approximately)
DELETE FROM `tbl_classroom_subject_section`;
/*!40000 ALTER TABLE `tbl_classroom_subject_section` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_classroom_subject_section` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_access_restriction_bk
CREATE TABLE IF NOT EXISTS `tbl_common_access_restriction_bk` (
  `common_access_restriction_id` int(10) unsigned NOT NULL,
  `common_subject_section_id` int(10) unsigned NOT NULL,
  `school_id` int(10) unsigned NOT NULL,
  `grade_enable` tinyint(3) unsigned NOT NULL,
  `classroom_enable` tinyint(3) unsigned NOT NULL,
  `course_enable` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`common_access_restriction_id`),
  KEY `common_subject_section_id` (`common_subject_section_id`),
  KEY `grade_enable` (`grade_enable`),
  KEY `classroom_enable` (`classroom_enable`),
  KEY `course_enable` (`course_enable`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `tbl_common_access_restriction_bk_ibfk_2` FOREIGN KEY (`grade_enable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_common_access_restriction_bk_ibfk_3` FOREIGN KEY (`classroom_enable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_common_access_restriction_bk_ibfk_4` FOREIGN KEY (`course_enable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_common_access_restriction_bk_ibfk_5` FOREIGN KEY (`common_subject_section_id`) REFERENCES `tbl_common_subject_section_bk` (`common_subject_section_id`),
  CONSTRAINT `tbl_common_access_restriction_bk_ibfk_6` FOREIGN KEY (`school_id`) REFERENCES `tbl_school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_access_restriction_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_access_restriction_bk`;
/*!40000 ALTER TABLE `tbl_common_access_restriction_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_access_restriction_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_access_restriction_classroom_bk
CREATE TABLE IF NOT EXISTS `tbl_common_access_restriction_classroom_bk` (
  `common_access_restriction_id` int(10) unsigned NOT NULL,
  `classroom_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`common_access_restriction_id`,`classroom_id`),
  KEY `classroom_id` (`classroom_id`),
  CONSTRAINT `tbl_common_access_restriction_classroom_bk_ibfk_1` FOREIGN KEY (`common_access_restriction_id`) REFERENCES `tbl_common_access_restriction_bk` (`common_access_restriction_id`),
  CONSTRAINT `tbl_common_access_restriction_classroom_bk_ibfk_2` FOREIGN KEY (`classroom_id`) REFERENCES `tbl_classroom` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_access_restriction_classroom_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_access_restriction_classroom_bk`;
/*!40000 ALTER TABLE `tbl_common_access_restriction_classroom_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_access_restriction_classroom_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_access_restriction_course_bk
CREATE TABLE IF NOT EXISTS `tbl_common_access_restriction_course_bk` (
  `common_access_restriction_id` int(10) unsigned NOT NULL,
  `course_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`common_access_restriction_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `tbl_common_access_restriction_course_bk_ibfk_1` FOREIGN KEY (`common_access_restriction_id`) REFERENCES `tbl_common_access_restriction_bk` (`common_access_restriction_id`),
  CONSTRAINT `tbl_common_access_restriction_course_bk_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `tbl_course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_access_restriction_course_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_access_restriction_course_bk`;
/*!40000 ALTER TABLE `tbl_common_access_restriction_course_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_access_restriction_course_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_access_restriction_grade_bk
CREATE TABLE IF NOT EXISTS `tbl_common_access_restriction_grade_bk` (
  `common_access_restriction_id` int(10) unsigned NOT NULL,
  `grade_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`common_access_restriction_id`,`grade_id`),
  KEY `grade_id` (`grade_id`),
  CONSTRAINT `tbl_common_access_restriction_grade_bk_ibfk_1` FOREIGN KEY (`common_access_restriction_id`) REFERENCES `tbl_common_access_restriction_bk` (`common_access_restriction_id`),
  CONSTRAINT `tbl_common_access_restriction_grade_bk_ibfk_2` FOREIGN KEY (`grade_id`) REFERENCES `tbl_grade` (`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_access_restriction_grade_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_access_restriction_grade_bk`;
/*!40000 ALTER TABLE `tbl_common_access_restriction_grade_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_access_restriction_grade_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_access_restriction_school_bk
CREATE TABLE IF NOT EXISTS `tbl_common_access_restriction_school_bk` (
  `common_subject_section_id` int(10) unsigned NOT NULL,
  `school_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`common_subject_section_id`,`school_id`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `tbl_common_access_restriction_school_bk_ibfk_1` FOREIGN KEY (`common_subject_section_id`) REFERENCES `tbl_common_subject_section_bk` (`common_subject_section_id`),
  CONSTRAINT `tbl_common_access_restriction_school_bk_ibfk_2` FOREIGN KEY (`school_id`) REFERENCES `tbl_school` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_access_restriction_school_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_access_restriction_school_bk`;
/*!40000 ALTER TABLE `tbl_common_access_restriction_school_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_access_restriction_school_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_contents_attachment_bk
CREATE TABLE IF NOT EXISTS `tbl_common_contents_attachment_bk` (
  `common_contents_attachment_id` int(10) unsigned NOT NULL,
  `common_contents_id` int(10) unsigned NOT NULL,
  `file_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`common_contents_attachment_id`),
  KEY `common_contents_id` (`common_contents_id`),
  CONSTRAINT `tbl_common_contents_attachment_bk_ibfk_1` FOREIGN KEY (`common_contents_id`) REFERENCES `tbl_common_contents_bk` (`common_contents_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_common_contents_attachment_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_contents_attachment_bk`;
/*!40000 ALTER TABLE `tbl_common_contents_attachment_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_contents_attachment_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_contents_bk
CREATE TABLE IF NOT EXISTS `tbl_common_contents_bk` (
  `common_contents_id` int(10) unsigned NOT NULL,
  `common_subject_section_id` int(10) unsigned NOT NULL,
  `common_contents_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `comment` varchar(255) COLLATE utf8_bin NOT NULL,
  `file_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `contents_extension_id` tinyint(3) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`common_contents_id`),
  UNIQUE KEY `display_order` (`display_order`),
  KEY `common_subject_section_id` (`common_subject_section_id`),
  KEY `contents_extension_id` (`contents_extension_id`),
  KEY `enable` (`enable`),
  CONSTRAINT `tbl_common_contents_bk_ibfk_1` FOREIGN KEY (`common_subject_section_id`) REFERENCES `tbl_common_subject_section_bk` (`common_subject_section_id`),
  CONSTRAINT `tbl_common_contents_bk_ibfk_2` FOREIGN KEY (`contents_extension_id`) REFERENCES `mst_contents_extension` (`contents_extension_id`),
  CONSTRAINT `tbl_common_contents_bk_ibfk_3` FOREIGN KEY (`enable`) REFERENCES `mst_boolean` (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_contents_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_contents_bk`;
/*!40000 ALTER TABLE `tbl_common_contents_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_contents_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_subject_bk
CREATE TABLE IF NOT EXISTS `tbl_common_subject_bk` (
  `common_subject_id` int(10) unsigned NOT NULL,
  `common_subject_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`common_subject_id`),
  UNIQUE KEY `display_order` (`display_order`),
  KEY `enable` (`enable`),
  CONSTRAINT `tbl_common_subject_bk_ibfk_1` FOREIGN KEY (`enable`) REFERENCES `mst_boolean` (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_subject_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_subject_bk`;
/*!40000 ALTER TABLE `tbl_common_subject_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_subject_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_common_subject_section_bk
CREATE TABLE IF NOT EXISTS `tbl_common_subject_section_bk` (
  `common_subject_section_id` int(10) unsigned NOT NULL,
  `common_subject_id` int(10) unsigned NOT NULL,
  `common_subject_section_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`common_subject_section_id`),
  UNIQUE KEY `display_order` (`display_order`),
  KEY `common_subject_id` (`common_subject_id`),
  KEY `enable` (`enable`),
  CONSTRAINT `tbl_common_subject_section_bk_ibfk_1` FOREIGN KEY (`common_subject_id`) REFERENCES `tbl_common_subject_bk` (`common_subject_id`),
  CONSTRAINT `tbl_common_subject_section_bk_ibfk_2` FOREIGN KEY (`enable`) REFERENCES `mst_boolean` (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_common_subject_section_bk: ~0 rows (approximately)
DELETE FROM `tbl_common_subject_section_bk`;
/*!40000 ALTER TABLE `tbl_common_subject_section_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_common_subject_section_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_contents
CREATE TABLE IF NOT EXISTS `tbl_contents` (
  `contents_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL DEFAULT 0,
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `subject_section_id` int(10) unsigned NOT NULL,
  `contents_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `comment` varchar(255) COLLATE utf8_bin NOT NULL,
  `first_day` date DEFAULT NULL,
  `last_day` date DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `user_level_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `register_id` int(10) unsigned NOT NULL,
  `register_datetime` datetime DEFAULT NULL,
  `contents_extension_id` tinyint(3) unsigned NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned NOT NULL DEFAULT 1,
  `bit_classroom` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `proportion` int(10) unsigned NOT NULL DEFAULT 50,
  PRIMARY KEY (`contents_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_contents: ~67 rows (approximately)
DELETE FROM `tbl_contents`;
/*!40000 ALTER TABLE `tbl_contents` DISABLE KEYS */;
INSERT INTO `tbl_contents` (`contents_id`, `school_id`, `contents_category_id`, `subject_section_id`, `contents_name`, `comment`, `first_day`, `last_day`, `file_name`, `user_level_id`, `register_id`, `register_datetime`, `contents_extension_id`, `size`, `enable`, `display_order`, `bit_classroom`, `proportion`) VALUES
	(1, 1, 1, 0, 'contents1', 'contents1', '0000-01-01', '9999-12-31', '0721', 0, 2, '2019-12-03 06:07:18', 2, 2885946, 0, 1, '40000', 50),
	(2, 1, 1, 0, 'V-1.1.4', '', '0000-01-01', '9999-12-31', 'r030638', 0, 2, '2019-12-03 07:00:11', 4, 3790066, 1, 2, '100000', 50),
	(3, 1, 1, 0, 'V-1.1.3', '', '0000-01-01', '9999-12-31', 'r030638', 0, 2, '2019-12-03 07:00:49', 4, 3790066, 1, 3, '100000', 50),
	(4, 1, 1, 0, 'V-1.1.2', '', '0000-01-01', '9999-12-31', 'r030638', 0, 2, '2019-12-03 07:01:08', 4, 3790066, 1, 4, '100000', 50),
	(5, 1, 1, 0, 'V-1.1.1', '', '0000-01-01', '9999-12-31', 'r030638', 0, 2, '2019-12-03 07:01:38', 4, 3790066, 1, 5, '100000', 50),
	(6, 1, 1, 0, 'V-1.2.4', '', '0000-01-01', '9999-12-31', 'r030638', 0, 2, '2019-12-03 07:02:36', 4, 3790066, 1, 6, '800000', 50),
	(7, 1, 1, 0, 'V-1.2.3', '', '0000-01-01', '9999-12-31', 'r030639', 0, 2, '2019-12-03 07:03:05', 4, 2723888, 1, 7, '800000', 50),
	(8, 1, 1, 0, 'V-1.2.2', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:03:28', 4, 1784158, 1, 8, '800000', 50),
	(9, 1, 1, 0, 'V-1.2.1', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:03:44', 4, 1784158, 1, 9, '800000', 50),
	(10, 1, 1, 0, 'V-1.3.5', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:04:21', 4, 1784158, 1, 10, '1000000', 50),
	(11, 1, 1, 0, 'V-1.3.4', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:04:50', 4, 1784158, 1, 11, '1000000', 50),
	(12, 1, 1, 0, 'V-1.3.3', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:05:11', 4, 1784158, 1, 12, '1000000', 50),
	(13, 1, 1, 0, 'V-1.3.2', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:05:30', 4, 1784158, 1, 13, '1000000', 50),
	(14, 1, 1, 0, 'V-1.3.1', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:05:47', 4, 1784158, 1, 14, '1000000', 50),
	(15, 1, 1, 0, 'V-1.4.7', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:07:26', 4, 1784158, 1, 15, '2000000', 50),
	(16, 1, 1, 0, 'V-1.4.6', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:08:01', 4, 1784158, 1, 16, '2000000', 50),
	(17, 1, 1, 0, 'V-1.4.5', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:08:25', 4, 1784158, 1, 17, '2000000', 50),
	(18, 1, 1, 0, 'V-1.4.4', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:08:47', 4, 1784158, 1, 18, '2000000', 50),
	(19, 1, 1, 0, 'V-1.4.3', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:09:14', 4, 1784158, 1, 19, '2000000', 50),
	(20, 1, 1, 0, 'V-1.4.2', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:09:31', 4, 1784158, 1, 20, '2000000', 50),
	(21, 1, 1, 0, 'V-1.4.1', '', '0000-01-01', '9999-12-31', 'r100322', 0, 2, '2019-12-03 07:09:52', 4, 1784158, 1, 21, '2000000', 50),
	(22, 1, 1, 0, 'V-2.1.10', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:12:11', 2, 1566018, 1, 22, '8000000', 50),
	(23, 1, 1, 0, 'V-2.1.9', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:12:27', 2, 1566018, 1, 23, '8000000', 50),
	(24, 1, 1, 0, 'V-2.1.8', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:12:48', 2, 1566018, 1, 24, '8000000', 50),
	(25, 1, 1, 0, 'V-2.1.7', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:13:07', 2, 1566018, 1, 25, '8000000', 50),
	(26, 1, 1, 0, 'V-2.1.6', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:13:25', 2, 1566018, 1, 26, '8000000', 50),
	(27, 1, 1, 0, 'V-2.1.5', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:13:41', 2, 1566018, 1, 27, '8000000', 50),
	(28, 1, 1, 0, 'V-2.1.4', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:19:25', 2, 1566018, 1, 28, '8000000', 50),
	(29, 1, 1, 0, 'V-2.1.3', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:20:03', 2, 1566018, 1, 29, '8000000', 50),
	(30, 1, 1, 0, 'V-2.1.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:20:18', 2, 1566018, 1, 30, '8000000', 50),
	(31, 1, 1, 0, 'V-2.1.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:20:36', 2, 1566018, 1, 31, '8000000', 50),
	(32, 1, 1, 0, 'V-2.2.5', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:21:34', 2, 1566018, 1, 32, '10000000', 50),
	(33, 1, 1, 0, 'V-2.2.4', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:21:56', 2, 1566018, 1, 33, '10000000', 50),
	(34, 1, 1, 0, 'V-2.2.3', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:22:19', 2, 1566018, 1, 34, '10000000', 50),
	(35, 1, 1, 0, 'V-2.2.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:22:34', 2, 1566018, 1, 35, '10000000', 50),
	(36, 1, 1, 0, 'V-2.2.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:22:51', 2, 1566018, 1, 36, '10000000', 50),
	(37, 1, 1, 0, 'V-2.3.6', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:23:44', 2, 1566018, 1, 37, '20000000', 50),
	(38, 1, 1, 0, 'V-2.3.5', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:25:07', 2, 1566018, 1, 38, '20000000', 50),
	(39, 1, 1, 0, 'V-2.3.4', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:25:21', 2, 1566018, 1, 39, '20000000', 50),
	(40, 1, 1, 0, 'V-2.3.3', '', '0000-01-01', '9999-12-31', 'r070205', 0, 2, '2019-12-03 07:25:43', 2, 1623385, 1, 40, '20000000', 50),
	(41, 1, 1, 0, 'V-2.3.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:26:00', 2, 1566018, 1, 41, '20000000', 50),
	(42, 1, 1, 0, 'V-2.3.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:26:15', 2, 1566018, 1, 42, '20000000', 50),
	(43, 1, 1, 0, 'V-3.1.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:27:58', 2, 1566018, 1, 43, '0-1', 50),
	(44, 1, 1, 0, 'V-3.1.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:28:18', 2, 1566018, 1, 44, '0-1', 50),
	(45, 1, 1, 0, 'V-3.2.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:28:52', 2, 1566018, 1, 45, '0-2', 50),
	(46, 1, 1, 0, 'V-3.2.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:29:23', 2, 1566018, 1, 46, '0-2', 50),
	(47, 1, 1, 0, 'V-3.3.5', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:30:36', 2, 1566018, 1, 47, '0-4', 50),
	(48, 1, 1, 0, 'V-3.3.4', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:30:52', 2, 1566018, 1, 48, '0-4', 50),
	(49, 1, 1, 0, 'V-3.3.3', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:31:10', 2, 1566018, 1, 49, '0-4', 50),
	(50, 1, 1, 0, 'V-3.3.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:31:25', 2, 1566018, 1, 50, '0-4', 50),
	(51, 1, 1, 0, 'V-3.3.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:31:40', 2, 1566018, 1, 51, '0-4', 50),
	(52, 1, 1, 0, 'V-3.4.3', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:32:42', 2, 1566018, 1, 52, '0-8', 50),
	(53, 1, 1, 0, 'V-3.4.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:32:57', 2, 1566018, 1, 53, '0-8', 50),
	(54, 1, 1, 0, 'V-3.4.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:33:12', 2, 1566018, 1, 54, '0-8', 50),
	(55, 1, 1, 0, 'V-4.1.6', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:34:13', 2, 1566018, 1, 55, '0-20', 50),
	(56, 1, 1, 0, 'V-4.1.5', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:34:29', 2, 1566018, 1, 56, '0-20', 50),
	(57, 1, 1, 0, 'V-4.1.4', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:34:46', 2, 1566018, 1, 57, '0-20', 50),
	(58, 1, 1, 0, 'V-4.1.3', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:35:01', 2, 1566018, 1, 58, '0-20', 50),
	(59, 1, 1, 0, 'V-4.1.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:35:16', 2, 1566018, 1, 59, '0-20', 50),
	(60, 1, 1, 0, 'V-4.1.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:35:36', 2, 1566018, 1, 60, '0-20', 50),
	(61, 1, 1, 0, 'V-4.2.4', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:36:55', 2, 1566018, 1, 61, '0-40', 50),
	(62, 1, 1, 0, 'V-4.2.3', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:37:08', 2, 1566018, 1, 62, '0-40', 50),
	(63, 1, 1, 0, 'V-4.2.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:37:24', 2, 1566018, 1, 63, '0-40', 50),
	(64, 1, 1, 0, 'V-4.2.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:37:41', 2, 1566018, 1, 64, '0-40', 50),
	(65, 1, 1, 0, 'V-4.3.2', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:38:19', 2, 1566018, 1, 65, '0-80', 50),
	(66, 1, 1, 0, 'V-4.3.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:38:34', 2, 1566018, 1, 66, '0-80', 50),
	(67, 1, 1, 0, 'V-4.4.1', '', '0000-01-01', '9999-12-31', 'r070206', 0, 2, '2019-12-03 07:38:53', 2, 1566018, 1, 67, '0-100', 50),
	(68, 1, 1, 0, 'ui', '', '0000-01-01', '9999-12-31', 'r070205', 0, 2, '2019-12-12 16:45:18', 2, 1623385, 0, 68, '100000', 50);
/*!40000 ALTER TABLE `tbl_contents` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_contents_attachment
CREATE TABLE IF NOT EXISTS `tbl_contents_attachment` (
  `contents_attachment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contents_category_id` tinyint(3) unsigned NOT NULL,
  `contents_id` int(10) unsigned NOT NULL,
  `file_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`contents_attachment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_contents_attachment: ~0 rows (approximately)
DELETE FROM `tbl_contents_attachment`;
/*!40000 ALTER TABLE `tbl_contents_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_contents_attachment` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_course
CREATE TABLE IF NOT EXISTS `tbl_course` (
  `course_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(11) unsigned NOT NULL,
  `course_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_course: ~0 rows (approximately)
DELETE FROM `tbl_course`;
/*!40000 ALTER TABLE `tbl_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_course` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_course_subject_section
CREATE TABLE IF NOT EXISTS `tbl_course_subject_section` (
  `course_id` int(10) unsigned NOT NULL,
  `subject_section_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table kaizen.tbl_course_subject_section: ~0 rows (approximately)
DELETE FROM `tbl_course_subject_section`;
/*!40000 ALTER TABLE `tbl_course_subject_section` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_course_subject_section` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_function_group
CREATE TABLE IF NOT EXISTS `tbl_function_group` (
  `function_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL DEFAULT 1,
  `function_group_name` varchar(255) NOT NULL,
  `bit_classroom` varchar(1000) NOT NULL DEFAULT '0',
  `enable` tinyint(3) unsigned NOT NULL,
  UNIQUE KEY `function_group_id` (`function_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_function_group: ~0 rows (approximately)
DELETE FROM `tbl_function_group`;
/*!40000 ALTER TABLE `tbl_function_group` DISABLE KEYS */;
INSERT INTO `tbl_function_group` (`function_group_id`, `school_id`, `function_group_name`, `bit_classroom`, `enable`) VALUES
	(1, 1, 'yu', '100000', 0);
/*!40000 ALTER TABLE `tbl_function_group` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_function_list
CREATE TABLE IF NOT EXISTS `tbl_function_list` (
  `type` tinyint(3) unsigned NOT NULL COMMENT 'コンテンツ：0　アンケート：1　レポート：2　テスト：3',
  `primary_id` int(10) unsigned NOT NULL,
  `parent_function_group_id` int(10) unsigned NOT NULL,
  `display_order` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_function_list: ~131 rows (approximately)
DELETE FROM `tbl_function_list`;
/*!40000 ALTER TABLE `tbl_function_list` DISABLE KEYS */;
INSERT INTO `tbl_function_list` (`type`, `primary_id`, `parent_function_group_id`, `display_order`) VALUES
	(0, 1, 0, 1),
	(0, 2, 0, 2),
	(0, 3, 0, 3),
	(0, 4, 0, 4),
	(0, 5, 0, 5),
	(0, 6, 0, 6),
	(0, 7, 0, 7),
	(0, 8, 0, 8),
	(0, 9, 0, 9),
	(0, 10, 0, 10),
	(0, 11, 0, 11),
	(0, 12, 0, 12),
	(0, 13, 0, 13),
	(0, 14, 0, 14),
	(0, 15, 0, 15),
	(0, 16, 0, 16),
	(0, 17, 0, 17),
	(0, 18, 0, 18),
	(0, 19, 0, 19),
	(0, 20, 0, 20),
	(0, 21, 0, 21),
	(0, 22, 0, 22),
	(0, 23, 0, 23),
	(0, 24, 0, 24),
	(0, 25, 0, 25),
	(0, 26, 0, 26),
	(0, 27, 0, 27),
	(0, 28, 0, 28),
	(0, 29, 0, 29),
	(0, 30, 0, 30),
	(0, 31, 0, 31),
	(0, 32, 0, 32),
	(0, 33, 0, 33),
	(0, 34, 0, 34),
	(0, 35, 0, 35),
	(0, 36, 0, 36),
	(0, 37, 0, 37),
	(0, 38, 0, 38),
	(0, 39, 0, 39),
	(0, 40, 0, 40),
	(0, 41, 0, 41),
	(0, 42, 0, 42),
	(0, 43, 0, 43),
	(0, 44, 0, 44),
	(0, 45, 0, 45),
	(0, 46, 0, 46),
	(0, 47, 0, 47),
	(0, 48, 0, 48),
	(0, 49, 0, 49),
	(0, 50, 0, 50),
	(0, 51, 0, 51),
	(0, 52, 0, 52),
	(0, 53, 0, 53),
	(0, 54, 0, 54),
	(0, 55, 0, 55),
	(0, 56, 0, 56),
	(0, 57, 0, 57),
	(0, 58, 0, 58),
	(0, 59, 0, 59),
	(0, 60, 0, 60),
	(0, 61, 0, 61),
	(0, 62, 0, 62),
	(0, 63, 0, 63),
	(0, 64, 0, 64),
	(0, 65, 0, 65),
	(0, 66, 0, 66),
	(0, 67, 0, 67),
	(4, 1, 0, 68),
	(3, 1, 0, 69),
	(3, 2, 0, 70),
	(3, 3, 0, 71),
	(3, 4, 0, 72),
	(3, 5, 0, 73),
	(3, 6, 0, 74),
	(3, 7, 0, 75),
	(3, 8, 0, 76),
	(3, 9, 0, 77),
	(3, 10, 0, 78),
	(3, 11, 0, 79),
	(3, 12, 0, 80),
	(3, 13, 0, 81),
	(3, 14, 0, 82),
	(3, 15, 0, 83),
	(3, 16, 0, 84),
	(3, 17, 0, 85),
	(3, 18, 0, 86),
	(3, 19, 0, 87),
	(3, 20, 0, 88),
	(3, 21, 0, 89),
	(3, 22, 0, 90),
	(3, 23, 0, 91),
	(3, 24, 0, 92),
	(3, 25, 0, 93),
	(3, 26, 0, 94),
	(3, 27, 0, 95),
	(3, 28, 0, 96),
	(3, 29, 0, 97),
	(3, 30, 0, 98),
	(3, 31, 0, 99),
	(3, 32, 0, 100),
	(3, 33, 0, 101),
	(3, 34, 0, 102),
	(3, 35, 0, 103),
	(0, 68, 0, 104),
	(3, 36, 0, 105),
	(3, 37, 0, 106),
	(3, 38, 0, 107),
	(3, 39, 0, 108),
	(3, 40, 0, 109),
	(3, 41, 0, 110),
	(3, 42, 0, 111),
	(3, 43, 0, 112),
	(3, 44, 0, 113),
	(3, 45, 0, 114),
	(3, 46, 0, 115),
	(3, 47, 0, 116),
	(3, 48, 0, 117),
	(3, 49, 0, 118),
	(3, 50, 0, 119),
	(3, 51, 0, 120),
	(3, 52, 0, 121),
	(3, 53, 0, 122),
	(3, 54, 0, 123),
	(3, 55, 0, 124),
	(3, 56, 0, 125),
	(3, 57, 0, 126),
	(3, 58, 0, 127),
	(3, 59, 0, 128),
	(3, 60, 0, 129),
	(3, 61, 0, 130),
	(3, 62, 0, 131),
	(3, 63, 0, 132),
	(3, 64, 0, 133),
	(3, 65, 0, 134),
	(3, 66, 0, 135),
	(3, 67, 0, 136),
	(3, 68, 0, 137),
	(3, 69, 0, 138),
	(3, 70, 0, 139),
	(3, 71, 0, 140),
	(3, 72, 0, 141),
	(3, 73, 0, 142),
	(3, 74, 0, 143),
	(3, 75, 0, 144),
	(3, 76, 0, 145),
	(3, 77, 0, 146),
	(3, 78, 0, 147),
	(3, 79, 0, 148),
	(3, 80, 0, 149),
	(3, 81, 0, 150);
/*!40000 ALTER TABLE `tbl_function_list` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_grade
CREATE TABLE IF NOT EXISTS `tbl_grade` (
  `grade_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL,
  `grade_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_grade: ~0 rows (approximately)
DELETE FROM `tbl_grade`;
/*!40000 ALTER TABLE `tbl_grade` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_grade` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_grade_subject_section
CREATE TABLE IF NOT EXISTS `tbl_grade_subject_section` (
  `grade_id` int(10) unsigned NOT NULL,
  `subject_section_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table kaizen.tbl_grade_subject_section: ~0 rows (approximately)
DELETE FROM `tbl_grade_subject_section`;
/*!40000 ALTER TABLE `tbl_grade_subject_section` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_grade_subject_section` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_lecture_group
CREATE TABLE IF NOT EXISTS `tbl_lecture_group` (
  `group_id` int(10) unsigned NOT NULL,
  `lecture_type` tinyint(3) unsigned NOT NULL,
  `lecture_id` int(10) unsigned NOT NULL,
  `lecture_order` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_lecture_group: ~0 rows (approximately)
DELETE FROM `tbl_lecture_group`;
/*!40000 ALTER TABLE `tbl_lecture_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_lecture_group` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_message
CREATE TABLE IF NOT EXISTS `tbl_message` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `auther_user_level_id` tinyint(3) unsigned NOT NULL,
  `auther_user_id` int(10) unsigned NOT NULL,
  `register_datetime` datetime NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `message_level` tinyint(3) unsigned NOT NULL,
  `limit_date` date NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_message: ~0 rows (approximately)
DELETE FROM `tbl_message`;
/*!40000 ALTER TABLE `tbl_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_message` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_message_check
CREATE TABLE IF NOT EXISTS `tbl_message_check` (
  `message_id` int(10) unsigned NOT NULL,
  `user_level_id` tinyint(3) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `check_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_message_check: ~0 rows (approximately)
DELETE FROM `tbl_message_check`;
/*!40000 ALTER TABLE `tbl_message_check` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_message_check` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_message_detail
CREATE TABLE IF NOT EXISTS `tbl_message_detail` (
  `message_detail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned NOT NULL,
  `message` varchar(2000) NOT NULL,
  `send_user_level_id` tinyint(3) unsigned NOT NULL,
  `send_user_id` int(10) unsigned NOT NULL,
  `register_datetime` datetime NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`message_detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_message_detail: ~0 rows (approximately)
DELETE FROM `tbl_message_detail`;
/*!40000 ALTER TABLE `tbl_message_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_message_detail` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_message_target
CREATE TABLE IF NOT EXISTS `tbl_message_target` (
  `message_target_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_detail_id` int(10) unsigned NOT NULL,
  `grade_id` int(10) unsigned NOT NULL DEFAULT 0,
  `classroom_id` int(10) unsigned NOT NULL DEFAULT 0,
  `course_id` int(10) unsigned NOT NULL DEFAULT 0,
  `receive_user_level_id` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `receive_user_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`message_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_message_target: ~0 rows (approximately)
DELETE FROM `tbl_message_target`;
/*!40000 ALTER TABLE `tbl_message_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_message_target` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_organizer
CREATE TABLE IF NOT EXISTS `tbl_organizer` (
  `organizer_id` int(10) unsigned NOT NULL,
  `organizer_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `id` varchar(255) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `access_code` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `vertical index` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`organizer_id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `vertical index` (`vertical index`),
  KEY `enable` (`enable`),
  CONSTRAINT `tbl_organizer_ibfk_1` FOREIGN KEY (`enable`) REFERENCES `mst_boolean` (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_organizer: ~2 rows (approximately)
DELETE FROM `tbl_organizer`;
/*!40000 ALTER TABLE `tbl_organizer` DISABLE KEYS */;
INSERT INTO `tbl_organizer` (`organizer_id`, `organizer_name`, `id`, `password`, `access_code`, `enable`, `vertical index`) VALUES
	(1, 'master', '9/U69xLk7zJgnKzZfjszlA==', 'PEGpvfzkBQiOvrAn2B3cN0b8ZhZQ5NsUSER69tvfrPc=', '7selttyrs904kug69zvb', 1, 1),
	(2, '岡上　剛', 'qxHmRSsn/Lm7CBWwM3+NAg==', 'UmxErXRQ99ULYYg25eze6g==', 'xb54b130kvo1dzb4uxu7', 1, 2);
/*!40000 ALTER TABLE `tbl_organizer` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_question
CREATE TABLE IF NOT EXISTS `tbl_question` (
  `question_id` int(10) unsigned NOT NULL,
  `common_contents_id` int(10) unsigned DEFAULT NULL,
  `school_contents_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned NOT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `text` varchar(1000) COLLATE utf8_bin NOT NULL,
  `datetime` int(10) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_question: ~0 rows (approximately)
DELETE FROM `tbl_question`;
/*!40000 ALTER TABLE `tbl_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_question` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire
CREATE TABLE IF NOT EXISTS `tbl_questionnaire` (
  `questionnaire_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_bin NOT NULL,
  `description` varchar(255) COLLATE utf8_bin NOT NULL,
  `finished_message` varchar(255) COLLATE utf8_bin NOT NULL,
  `enable` tinyint(4) unsigned NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `start_day` date NOT NULL,
  `last_day` date NOT NULL,
  `user_level_id` tinyint(3) unsigned NOT NULL,
  `register_user_id` int(10) unsigned NOT NULL,
  `register_datetime` datetime NOT NULL,
  `type` tinyint(4) unsigned NOT NULL,
  `bit_classroom` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`questionnaire_id`),
  KEY `school_id` (`school_id`,`display_order`),
  KEY `enable` (`enable`),
  KEY `user_level_id` (`user_level_id`,`register_user_id`),
  CONSTRAINT `tbl_questionnaire_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `tbl_school` (`school_id`),
  CONSTRAINT `tbl_questionnaire_ibfk_2` FOREIGN KEY (`enable`) REFERENCES `mst_boolean` (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire`;
/*!40000 ALTER TABLE `tbl_questionnaire` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_answer
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int(10) unsigned NOT NULL,
  `student_id` int(10) unsigned NOT NULL,
  `answer_datetime` datetime NOT NULL,
  `enable` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `student_id` (`student_id`),
  KEY `questionnaire_id` (`questionnaire_id`),
  KEY `tbl_questionnaire_student_answer_ibfk_3` (`enable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_answer: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_answer`;
/*!40000 ALTER TABLE `tbl_questionnaire_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_answer` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_answer_query
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_answer_query` (
  `answer_query_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `answer_id` int(10) unsigned NOT NULL,
  `query_id` int(10) unsigned NOT NULL,
  `query_type` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`answer_query_id`),
  KEY `student_answer_id` (`answer_id`),
  KEY `query_type` (`query_type`),
  KEY `questionnaire_query_id` (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_answer_query: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_answer_query`;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_answer_query_length
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_answer_query_length` (
  `answer_query_id` int(10) unsigned NOT NULL,
  `length` mediumint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_questionnaire_answer_query_length: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_answer_query_length`;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_length` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_length` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_answer_query_multiple_choice
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_answer_query_multiple_choice` (
  `answer_query_id` int(10) unsigned NOT NULL,
  `choices_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_answer_query_multiple_choice: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_answer_query_multiple_choice`;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_multiple_choice` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_multiple_choice` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_answer_query_single_choice
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_answer_query_single_choice` (
  `answer_query_id` int(10) unsigned NOT NULL,
  `choice_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_answer_query_single_choice: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_answer_query_single_choice`;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_single_choice` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_single_choice` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_answer_query_text
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_answer_query_text` (
  `answer_query_id` int(10) unsigned NOT NULL,
  `text` varchar(2000) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_answer_query_text: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_answer_query_text`;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_text` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_answer_query_word
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_answer_query_word` (
  `answer_query_id` int(10) unsigned NOT NULL,
  `word` varchar(1400) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_answer_query_word: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_answer_query_word`;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_word` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_answer_query_word` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_query
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int(10) unsigned NOT NULL,
  `query` varchar(255) COLLATE utf8_bin NOT NULL,
  `query_type` tinyint(4) unsigned NOT NULL,
  `flg_query_must` tinyint(4) unsigned NOT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `enable` tinyint(4) unsigned NOT NULL,
  PRIMARY KEY (`query_id`),
  KEY `questionnaire_id` (`questionnaire_id`,`display_order`,`enable`),
  KEY `query_type` (`query_type`),
  KEY `enable` (`enable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_query: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_query`;
/*!40000 ALTER TABLE `tbl_questionnaire_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_query` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_query_choices
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_query_choices` (
  `choices_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `query_id` int(10) unsigned NOT NULL,
  `text` varchar(1000) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`choices_id`),
  KEY `query_id` (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_query_choices: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_query_choices`;
/*!40000 ALTER TABLE `tbl_questionnaire_query_choices` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_query_choices` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_query_length
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_query_length` (
  `length_id` int(10) NOT NULL AUTO_INCREMENT,
  `query_id` int(10) unsigned NOT NULL,
  `min_label` varchar(56) NOT NULL,
  `max_label` varchar(56) NOT NULL,
  `min_limit` int(10) NOT NULL,
  `max_limit` int(10) NOT NULL,
  `step` int(10) NOT NULL,
  PRIMARY KEY (`length_id`),
  KEY `tbl_questionnaire_query_length_ibfk_1` (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_questionnaire_query_length: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_query_length`;
/*!40000 ALTER TABLE `tbl_questionnaire_query_length` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_query_length` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_target_access_restriction
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_target_access_restriction` (
  `questionnaire_target_id` int(10) unsigned NOT NULL COMMENT 'ターゲットナンバー',
  `questionnaire_id` int(10) unsigned NOT NULL COMMENT 'テストナンバー',
  `grade_id` int(10) unsigned DEFAULT NULL COMMENT '対象の学年',
  `classroom_id` int(10) unsigned DEFAULT NULL COMMENT '対象のクラス',
  `course_id` int(10) unsigned DEFAULT NULL COMMENT '対象のコース',
  PRIMARY KEY (`questionnaire_target_id`),
  KEY `grade_id` (`grade_id`),
  KEY `classroom_id` (`classroom_id`),
  KEY `course_id` (`course_id`),
  KEY `cbt_id_UNIQUE` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='テストの対象ユーザー';

-- Dumping data for table kaizen.tbl_questionnaire_target_access_restriction: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_target_access_restriction`;
/*!40000 ALTER TABLE `tbl_questionnaire_target_access_restriction` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_target_access_restriction` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_target_range_common
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_target_range_common` (
  `questionnaire_common_target_range_id` int(10) unsigned NOT NULL,
  `questionnaire_id` int(10) unsigned NOT NULL,
  `contents_category_id` tinyint(4) unsigned NOT NULL,
  `common_subject_id` int(10) unsigned NOT NULL,
  `common_subject_section_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`questionnaire_common_target_range_id`),
  KEY `questionnaire_id` (`questionnaire_id`),
  KEY `contents_category_id` (`contents_category_id`),
  KEY `common_subject_id` (`common_subject_id`),
  KEY `common_subject_section_id` (`common_subject_section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_target_range_common: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_target_range_common`;
/*!40000 ALTER TABLE `tbl_questionnaire_target_range_common` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_target_range_common` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_questionnaire_target_range_school
CREATE TABLE IF NOT EXISTS `tbl_questionnaire_target_range_school` (
  `questionnaire_school_target_range_id` int(10) unsigned NOT NULL,
  `questionnaire_id` int(10) unsigned NOT NULL,
  `contents_category_id` tinyint(4) unsigned NOT NULL,
  `subject_genre_id` int(10) unsigned NOT NULL,
  `subject_section_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`questionnaire_school_target_range_id`),
  KEY `questionnaire_id` (`questionnaire_id`),
  KEY `contents_category_id` (`contents_category_id`),
  KEY `subject_id` (`subject_genre_id`),
  KEY `subject_section_id` (`subject_section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_questionnaire_target_range_school: ~0 rows (approximately)
DELETE FROM `tbl_questionnaire_target_range_school`;
/*!40000 ALTER TABLE `tbl_questionnaire_target_range_school` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_questionnaire_target_range_school` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz
CREATE TABLE IF NOT EXISTS `tbl_quiz` (
  `quiz_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'テストナンバー',
  `school_id` int(10) unsigned NOT NULL COMMENT 'テスト作成した学校',
  `title` varchar(255) NOT NULL COMMENT 'テストのタイトル',
  `description` varchar(255) NOT NULL COMMENT 'テストの説明',
  `qualifying_score` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '合格点',
  `finished_message` varchar(255) NOT NULL DEFAULT 'Thank you very much.' COMMENT '終了後のメッセージ',
  `enable` tinyint(4) unsigned NOT NULL DEFAULT 0 COMMENT '論理削除フラグ（有効：１）',
  `display_order` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '順番',
  `start_day` date NOT NULL COMMENT '公開開始日',
  `last_day` date NOT NULL COMMENT '公開期限日',
  `register_datetime` datetime NOT NULL COMMENT 'テスト登録日',
  `limit_time` int(10) unsigned NOT NULL DEFAULT 10 COMMENT '制限時間(分)0は無制限',
  `time_limit_flag` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '制限時間設定フラグ（不使用）',
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT 'テスト対象の講義(共有・学校)',
  `subject_section_id` int(10) unsigned DEFAULT NULL COMMENT 'テスト対象の講義ID',
  `repeat_challenge` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '受験できる回数の設定',
  `answer_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '回答後生徒答案結果表示設定：生徒に答えを見せるかどうか',
  `explain_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '回答後生徒答案結果表示設定：生徒に解説を見せるかどうか',
  `average_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '生徒に平均点を表示するか',
  `rank_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '生徒に順位を表示するか',
  `student_answer_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '生徒に自身が答えた選択を表示するか',
  `answer_rate_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '生徒に正解率を表示するか',
  `success_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '生徒に合否を表示するか',
  `relations_quiz_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '紐づけた講座配下のコンテンツ全て視聴後に受験できるのか否か',
  `deviation_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '生徒に偏差値を表示するか',
  `correct_flg` tinyint(4) unsigned NOT NULL DEFAULT 1 COMMENT '生徒に問題の正誤を表示するかどうか',
  `user_level_id` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'テスト作成者（0:管理者 １：教師）',
  `register_id` int(10) unsigned NOT NULL COMMENT 'テストを作成したユーザーID',
  `bit_classroom` varchar(1000) NOT NULL DEFAULT '0',
  PRIMARY KEY (`quiz_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz: ~77 rows (approximately)
DELETE FROM `tbl_quiz`;
/*!40000 ALTER TABLE `tbl_quiz` DISABLE KEYS */;
INSERT INTO `tbl_quiz` (`quiz_id`, `school_id`, `title`, `description`, `qualifying_score`, `finished_message`, `enable`, `display_order`, `start_day`, `last_day`, `register_datetime`, `limit_time`, `time_limit_flag`, `contents_category_id`, `subject_section_id`, `repeat_challenge`, `answer_flg`, `explain_flg`, `average_flg`, `rank_flg`, `student_answer_flg`, `answer_rate_flg`, `success_flg`, `relations_quiz_flg`, `deviation_flg`, `correct_flg`, `user_level_id`, `register_id`, `bit_classroom`) VALUES
	(1, 1, 'Productivity Test', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 2, '100000'),
	(2, 1, 'Productivity Test', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 02:41:25', 0, 1, 1, NULL, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '100000'),
	(3, 1, 'Q5', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:38:22', 0, 1, 1, NULL, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(4, 1, 'Q4', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:38:07', 0, 1, 1, NULL, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(5, 1, 'Q3', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:37:59', 0, 1, 1, NULL, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(6, 1, 'Q2', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:37:53', 0, 1, 1, NULL, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(7, 1, 'Q1', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:37:46', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(8, 1, 'Q5', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:37:33', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(9, 1, 'Q4', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-06 09:01:09', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(10, 1, 'Q3', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:36:55', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(11, 1, 'Q2', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:36:49', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(12, 1, 'Q1', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:36:42', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(13, 1, 'Q5', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:34:14', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-800'),
	(14, 1, 'Q4', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:34:07', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-800'),
	(15, 1, 'Q3', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:34:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-800'),
	(16, 1, '', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '0-800'),
	(17, 1, 'Q2', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:33:48', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-800'),
	(18, 1, 'Q1', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:33:41', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-800'),
	(19, 1, 'Q5', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:35:12', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-1000'),
	(20, 1, 'Q4', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:35:04', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-1000'),
	(21, 1, 'Q3', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:34:42', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-1000'),
	(22, 1, 'Q2', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:34:36', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-1000'),
	(23, 1, 'Q1', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-05 04:34:30', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-1000'),
	(24, 1, '', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '0-200'),
	(25, 1, '', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '0-200'),
	(26, 1, '', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '0-200'),
	(27, 1, '', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '100000'),
	(28, 1, 'Q7', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-06 07:05:51', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '100000'),
	(29, 1, 'Question bundle', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-06 07:49:25', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(30, 1, 'Productivity Quiz', '', 0, 'Thank you very much.', 1, 0, '0000-01-01', '9999-12-31', '2019-12-06 08:59:24', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(31, 1, 'Kaizen Quiz', '', 0, 'Thank you very much.', 1, 0, '0000-01-01', '9999-12-31', '2019-12-17 09:35:22', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(32, 1, '5S quiz', '', 0, 'Thank you very much.', 1, 0, '0000-01-01', '9999-12-31', '2019-12-06 09:20:38', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-800'),
	(33, 1, 'Others Quiz', '', 0, 'Thank you very much.', 1, 0, '0000-01-01', '9999-12-31', '2019-12-06 09:30:36', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-1000'),
	(34, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(35, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(36, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-13 07:19:24', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(37, 1, '', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '0-200'),
	(38, 1, '', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, '0-200'),
	(39, 1, 'mapping2', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-16 03:00:59', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(40, 1, 'mapping3', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '2019-12-16 05:35:42', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(41, 1, 'mapping4', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(42, 1, 'mapping5', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(43, 1, 'mapping6', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(44, 1, 'mapping7', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(46, 1, 'mapping8', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(47, 1, 'quiz_mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-200'),
	(48, 1, 'mapping9', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(49, 1, 'mapping10', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(50, 1, 'mapping 10', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(51, 1, 'mapping11', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(52, 1, 'mapping 12', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(53, 1, 'mapping13', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(54, 1, 'mapping14', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(55, 1, 'mapping 15', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(56, 1, 'mapping 15', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(57, 1, 'mapping 15', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(58, 1, 'mapping 16', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(59, 1, 'mappiinf', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(60, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(61, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(62, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(63, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(64, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(65, 1, 'm', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(66, 1, 'mapp', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(67, 1, 'k', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(68, 1, 'mp', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(69, 1, 'mapping', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 0, 1, 1, NULL, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(70, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(71, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(72, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(73, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(74, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(75, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(76, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(77, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(78, 1, 'map1', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(79, 1, 'ki', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(80, 1, 'map', '', 0, 'Thank you very much.', 0, 0, '0000-01-01', '9999-12-31', '0000-00-00 00:00:00', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400'),
	(81, 1, 'testing of mapping', '', 0, 'Thank you very much.', 1, 0, '0000-01-01', '9999-12-31', '2019-12-20 11:19:30', 10, 1, 1, NULL, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 2, '0-400');
/*!40000 ALTER TABLE `tbl_quiz` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_answer
CREATE TABLE IF NOT EXISTS `tbl_quiz_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'アンサーナンバー',
  `quiz_id` int(10) unsigned NOT NULL COMMENT 'クイズナンバー',
  `school_id` int(10) unsigned NOT NULL COMMENT 'スクールナンバー',
  `student_id` int(10) unsigned NOT NULL COMMENT '回答した生徒ナンバー',
  `register_datetime` datetime NOT NULL COMMENT '回答日時',
  `answer_time` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '（秒）',
  `total_score` int(10) unsigned NOT NULL DEFAULT 0,
  `correct_answer_rate` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '正解率',
  PRIMARY KEY (`answer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_answer: ~32 rows (approximately)
DELETE FROM `tbl_quiz_answer`;
/*!40000 ALTER TABLE `tbl_quiz_answer` DISABLE KEYS */;
INSERT INTO `tbl_quiz_answer` (`answer_id`, `quiz_id`, `school_id`, `student_id`, `register_datetime`, `answer_time`, `total_score`, `correct_answer_rate`) VALUES
	(1, 7, 1, 4, '2019-12-05 08:59:09', 0, 0, 0),
	(2, 7, 1, 4, '2019-12-05 08:59:44', 0, 10, 100),
	(3, 7, 1, 4, '2019-12-05 10:06:30', 0, 0, 0),
	(4, 7, 1, 4, '2019-12-05 10:07:09', 0, 0, 0),
	(5, 6, 1, 4, '2019-12-05 10:07:59', 0, 0, 0),
	(6, 23, 1, 4, '2019-12-05 10:39:23', 0, 10, 100),
	(7, 23, 1, 4, '2019-12-05 11:45:11', 0, 10, 100),
	(8, 7, 1, 1, '2019-12-05 11:59:56', 0, 10, 100),
	(9, 23, 1, 4, '2019-12-05 12:16:20', 0, 10, 100),
	(10, 23, 1, 4, '2019-12-05 12:16:48', 0, 0, 0),
	(11, 28, 1, 4, '2019-12-06 13:49:58', 0, 0, 0),
	(12, 29, 1, 4, '2019-12-06 13:51:04', 0, 10, 50),
	(13, 29, 1, 1, '0000-00-00 00:00:00', 0, 0, 0),
	(14, 7, 1, 1, '2019-12-06 14:16:50', 0, 10, 100),
	(15, 6, 1, 1, '2019-12-06 14:17:27', 0, 10, 100),
	(16, 5, 1, 1, '2019-12-06 14:17:44', 0, 10, 100),
	(17, 4, 1, 1, '2019-12-06 14:17:59', 0, 10, 100),
	(18, 3, 1, 1, '2019-12-06 14:18:19', 0, 10, 100),
	(19, 33, 1, 4, '2019-12-06 15:34:14', 0, 5, 25),
	(20, 30, 1, 4, '2019-12-09 13:08:35', 0, 15, 40),
	(21, 31, 1, 4, '2019-12-09 13:19:41', 0, 5, 20),
	(22, 31, 1, 4, '2019-12-09 13:39:18', 0, 10, 40),
	(23, 31, 1, 4, '2019-12-10 07:03:57', 0, 15, 60),
	(24, 32, 1, 4, '2019-12-10 07:08:02', 0, 15, 50),
	(25, 30, 1, 4, '2019-12-10 07:19:16', 0, 10, 40),
	(26, 33, 1, 4, '2019-12-10 07:20:29', 0, 10, 50),
	(27, 30, 1, 4, '2019-12-10 15:38:36', 0, 30, 100),
	(28, 31, 1, 4, '2019-12-11 14:00:26', 0, 20, 80),
	(29, 30, 1, 4, '2019-12-13 13:26:54', 0, 20, 60),
	(30, 30, 1, 4, '2019-12-17 07:28:10', 0, 20, 60),
	(31, 30, 1, 4, '2019-12-17 07:34:40', 0, 20, 60),
	(32, 30, 1, 4, '2019-12-17 09:00:03', 0, 20, 60),
	(33, 30, 1, 4, '2019-12-17 09:02:35', 0, 15, 60);
/*!40000 ALTER TABLE `tbl_quiz_answer` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_answer_detail_bk
CREATE TABLE IF NOT EXISTS `tbl_quiz_answer_detail_bk` (
  `detail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` int(10) unsigned NOT NULL COMMENT 'クイズID',
  `query_id` int(10) unsigned NOT NULL COMMENT '答えた問題のナンバー',
  `answer_id` int(10) unsigned NOT NULL COMMENT 'アンサーナンバー',
  `selection_id` int(10) unsigned NOT NULL,
  `flg_right` tinyint(4) unsigned NOT NULL COMMENT '問題の正誤フラグ',
  `flg_no_answer` tinyint(4) unsigned NOT NULL COMMENT '問題の無解答フラグ',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_answer_detail_bk: ~0 rows (approximately)
DELETE FROM `tbl_quiz_answer_detail_bk`;
/*!40000 ALTER TABLE `tbl_quiz_answer_detail_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_answer_detail_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_answer_query
CREATE TABLE IF NOT EXISTS `tbl_quiz_answer_query` (
  `answer_query_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `answer_id` int(10) unsigned NOT NULL COMMENT 'アンサーナンバー',
  `query_id` int(10) unsigned NOT NULL COMMENT '答えた問題のナンバー',
  `quiz_id` int(10) unsigned NOT NULL COMMENT 'クイズID',
  `flg_right` tinyint(4) unsigned NOT NULL COMMENT '問題の正誤フラグ',
  `flg_no_answer` tinyint(4) unsigned NOT NULL COMMENT '問題の無解答フラグ',
  PRIMARY KEY (`answer_query_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_answer_query: ~93 rows (approximately)
DELETE FROM `tbl_quiz_answer_query`;
/*!40000 ALTER TABLE `tbl_quiz_answer_query` DISABLE KEYS */;
INSERT INTO `tbl_quiz_answer_query` (`answer_query_id`, `answer_id`, `query_id`, `quiz_id`, `flg_right`, `flg_no_answer`) VALUES
	(1, 1, 8, 7, 0, 0),
	(2, 2, 8, 7, 1, 0),
	(3, 3, 8, 7, 0, 0),
	(4, 4, 8, 7, 0, 0),
	(5, 5, 7, 6, 0, 0),
	(6, 6, 23, 23, 1, 0),
	(7, 7, 23, 23, 1, 0),
	(8, 8, 8, 7, 1, 0),
	(9, 9, 23, 23, 1, 0),
	(10, 10, 23, 23, 0, 0),
	(11, 11, 24, 28, 0, 1),
	(12, 11, 25, 28, 0, 1),
	(13, 11, 26, 28, 0, 1),
	(14, 12, 27, 29, 0, 1),
	(15, 12, 28, 29, 1, 0),
	(16, 13, 27, 29, 0, 1),
	(17, 13, 28, 29, 0, 1),
	(18, 14, 8, 7, 1, 0),
	(19, 15, 7, 6, 1, 0),
	(20, 16, 6, 5, 1, 0),
	(21, 17, 5, 4, 1, 0),
	(22, 18, 4, 3, 1, 0),
	(23, 19, 45, 33, 0, 1),
	(24, 19, 46, 33, 0, 1),
	(25, 19, 47, 33, 1, 0),
	(26, 19, 48, 33, 0, 0),
	(27, 20, 29, 30, 1, 0),
	(28, 20, 30, 30, 0, 1),
	(29, 20, 31, 30, 0, 0),
	(30, 20, 32, 30, 0, 0),
	(31, 20, 33, 30, 1, 0),
	(32, 21, 34, 31, 1, 0),
	(33, 21, 35, 31, 0, 1),
	(34, 21, 36, 31, 0, 1),
	(35, 21, 37, 31, 0, 0),
	(36, 21, 38, 31, 0, 1),
	(37, 22, 34, 31, 0, 1),
	(38, 22, 35, 31, 1, 0),
	(39, 22, 36, 31, 1, 0),
	(40, 22, 37, 31, 0, 0),
	(41, 22, 38, 31, 0, 0),
	(42, 23, 34, 31, 1, 0),
	(43, 23, 35, 31, 0, 0),
	(44, 23, 36, 31, 1, 0),
	(45, 23, 37, 31, 1, 0),
	(46, 23, 38, 31, 0, 0),
	(47, 24, 39, 32, 0, 0),
	(48, 24, 40, 32, 0, 0),
	(49, 24, 41, 32, 0, 0),
	(50, 24, 42, 32, 1, 0),
	(51, 24, 43, 32, 1, 0),
	(52, 24, 44, 32, 1, 0),
	(53, 25, 29, 30, 0, 0),
	(54, 25, 30, 30, 1, 0),
	(55, 25, 31, 30, 1, 0),
	(56, 25, 32, 30, 0, 0),
	(57, 25, 33, 30, 0, 0),
	(58, 26, 45, 33, 0, 0),
	(59, 26, 46, 33, 0, 0),
	(60, 26, 47, 33, 1, 0),
	(61, 26, 48, 33, 1, 0),
	(62, 27, 29, 30, 1, 0),
	(63, 27, 30, 30, 1, 0),
	(64, 27, 31, 30, 1, 0),
	(65, 27, 32, 30, 1, 0),
	(66, 27, 33, 30, 1, 0),
	(67, 28, 34, 31, 0, 0),
	(68, 28, 35, 31, 1, 0),
	(69, 28, 36, 31, 1, 0),
	(70, 28, 37, 31, 1, 0),
	(71, 28, 38, 31, 1, 0),
	(72, 29, 29, 30, 0, 0),
	(73, 29, 30, 30, 0, 0),
	(74, 29, 31, 30, 1, 0),
	(75, 29, 32, 30, 1, 0),
	(76, 29, 33, 30, 1, 0),
	(77, 30, 29, 30, 1, 0),
	(78, 30, 30, 30, 1, 0),
	(79, 30, 31, 30, 0, 0),
	(80, 30, 32, 30, 0, 0),
	(81, 30, 33, 30, 1, 0),
	(82, 31, 29, 30, 0, 0),
	(83, 31, 30, 30, 0, 0),
	(84, 31, 31, 30, 1, 0),
	(85, 31, 32, 30, 1, 0),
	(86, 31, 33, 30, 1, 0),
	(87, 32, 29, 30, 0, 0),
	(88, 32, 30, 30, 0, 0),
	(89, 32, 31, 30, 1, 0),
	(90, 32, 32, 30, 1, 0),
	(91, 32, 33, 30, 1, 0),
	(92, 33, 29, 30, 1, 0),
	(93, 33, 30, 30, 1, 0),
	(94, 33, 31, 30, 1, 0),
	(95, 33, 32, 30, 0, 0),
	(96, 33, 33, 30, 0, 0);
/*!40000 ALTER TABLE `tbl_quiz_answer_query` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_answer_query_choice
CREATE TABLE IF NOT EXISTS `tbl_quiz_answer_query_choice` (
  `answer_query_id` int(10) unsigned NOT NULL COMMENT 'アンサークエリーナンバー',
  `selection_id` int(10) unsigned NOT NULL COMMENT '選択した選択肢ナンバー',
  PRIMARY KEY (`answer_query_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_answer_query_choice: ~79 rows (approximately)
DELETE FROM `tbl_quiz_answer_query_choice`;
/*!40000 ALTER TABLE `tbl_quiz_answer_query_choice` DISABLE KEYS */;
INSERT INTO `tbl_quiz_answer_query_choice` (`answer_query_id`, `selection_id`) VALUES
	(1, 31),
	(2, 33),
	(3, 31),
	(4, 32),
	(5, 28),
	(6, 90),
	(7, 90),
	(8, 33),
	(9, 90),
	(10, 91),
	(15, 110),
	(18, 33),
	(19, 29),
	(20, 25),
	(21, 21),
	(22, 14),
	(25, 201),
	(26, 206),
	(27, 118),
	(29, 125),
	(30, 132),
	(31, 136),
	(32, 139),
	(35, 154),
	(38, 143),
	(39, 148),
	(40, 155),
	(41, 160),
	(42, 139),
	(43, 144),
	(44, 148),
	(45, 153),
	(46, 159),
	(47, 164),
	(48, 168),
	(49, 173),
	(50, 178),
	(51, 184),
	(52, 187),
	(53, 115),
	(54, 119),
	(55, 126),
	(56, 129),
	(57, 135),
	(58, 192),
	(59, 196),
	(60, 201),
	(61, 209),
	(62, 118),
	(63, 119),
	(64, 126),
	(65, 130),
	(66, 136),
	(67, 142),
	(68, 143),
	(69, 148),
	(70, 153),
	(71, 158),
	(72, 116),
	(73, 120),
	(74, 126),
	(75, 130),
	(76, 136),
	(77, 118),
	(78, 119),
	(79, 127),
	(80, 132),
	(81, 136),
	(82, 115),
	(83, 120),
	(84, 126),
	(85, 130),
	(86, 136),
	(87, 117),
	(88, 120),
	(89, 126),
	(90, 130),
	(91, 136),
	(92, 118),
	(93, 119),
	(94, 126),
	(95, 131),
	(96, 137);
/*!40000 ALTER TABLE `tbl_quiz_answer_query_choice` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_contents_mapping
CREATE TABLE IF NOT EXISTS `tbl_quiz_contents_mapping` (
  `quiz_id` int(11) NOT NULL,
  `query_id` int(11) NOT NULL,
  `contents_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_contents_mapping: ~32 rows (approximately)
DELETE FROM `tbl_quiz_contents_mapping`;
/*!40000 ALTER TABLE `tbl_quiz_contents_mapping` DISABLE KEYS */;
INSERT INTO `tbl_quiz_contents_mapping` (`quiz_id`, `query_id`, `contents_id`) VALUES
	(30, 29, 2),
	(30, 29, 5),
	(30, 30, 8),
	(30, 30, 9),
	(30, 31, 7),
	(30, 31, 11),
	(30, 32, 19),
	(30, 33, 4),
	(31, 34, 30),
	(31, 34, 31),
	(31, 35, 39),
	(31, 35, 40),
	(31, 36, 34),
	(31, 36, 36),
	(31, 37, 30),
	(31, 38, 38),
	(32, 39, 43),
	(32, 39, 44),
	(32, 40, 48),
	(32, 40, 49),
	(32, 41, 45),
	(32, 41, 46),
	(32, 42, 53),
	(32, 43, 51),
	(32, 44, 52),
	(33, 45, 59),
	(33, 45, 60),
	(33, 46, 65),
	(33, 46, 66),
	(33, 47, 62),
	(33, 47, 64),
	(33, 48, 67);
/*!40000 ALTER TABLE `tbl_quiz_contents_mapping` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_query
CREATE TABLE IF NOT EXISTS `tbl_quiz_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'クエリーナンバー',
  `quiz_id` int(10) unsigned NOT NULL COMMENT 'テストナンバー',
  `query_text` varchar(255) NOT NULL COMMENT '問題文',
  `description` varchar(255) DEFAULT NULL COMMENT '解説',
  `score` tinyint(4) DEFAULT NULL,
  `image_file_name` varchar(255) DEFAULT NULL,
  `sound_file_name` varchar(255) DEFAULT NULL,
  `query_type` tinyint(4) unsigned NOT NULL COMMENT '問題の種類',
  `display_order` int(10) unsigned NOT NULL COMMENT '順番',
  `enable` tinyint(4) unsigned NOT NULL COMMENT '論理削除フラグ',
  PRIMARY KEY (`query_id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_query: ~157 rows (approximately)
DELETE FROM `tbl_quiz_query`;
/*!40000 ALTER TABLE `tbl_quiz_query` DISABLE KEYS */;
INSERT INTO `tbl_quiz_query` (`query_id`, `quiz_id`, `query_text`, `description`, `score`, `image_file_name`, `sound_file_name`, `query_type`, `display_order`, `enable`) VALUES
	(1, 1, 'hdd', '', 10, NULL, NULL, 0, 0, 1),
	(3, 2, 'What is the Capital of Bangladesh?', '', 10, NULL, NULL, 0, 0, 1),
	(4, 3, 'What is the capital of Bangladesh?', '', 10, NULL, NULL, 0, 0, 1),
	(5, 4, 'What is the capital of Japan?', '', 10, NULL, NULL, 0, 0, 1),
	(6, 5, 'What is the capital of India?', '', 10, NULL, NULL, 0, 0, 1),
	(7, 6, 'What is the capital of Pakistan?', '', 10, NULL, NULL, 0, 0, 1),
	(8, 7, 'What is the capital of Nepal?', '', 10, NULL, NULL, 0, 0, 1),
	(9, 8, 'What is the popular sports of Pakistan?', '', 10, NULL, NULL, 0, 0, 1),
	(10, 9, 'What is the popular sports of USA?', '', 10, NULL, NULL, 0, 0, 1),
	(11, 10, 'What is the popular sports of Japan?', '', 10, NULL, NULL, 0, 0, 1),
	(12, 11, 'What is the popular sports of India?', '', 10, NULL, NULL, 0, 0, 1),
	(13, 12, 'What is the popular sports of Russia?', '', 10, NULL, NULL, 0, 0, 1),
	(14, 13, 'What is the popular food of Bangladesh?', '', 10, NULL, NULL, 0, 0, 1),
	(15, 14, 'What is the popular food of Nepal?', '', 10, NULL, NULL, 0, 0, 1),
	(16, 15, 'What is the popular food of Japan?', '', 10, NULL, NULL, 0, 0, 1),
	(17, 17, 'What is the popular food of India?', '', 10, NULL, NULL, 0, 0, 1),
	(18, 18, 'What is the popular food of Mongolia?', '', 10, NULL, NULL, 0, 0, 1),
	(19, 19, 'What is the popular tourist spot of Japan?', '', 10, NULL, NULL, 0, 0, 1),
	(20, 20, 'What is the popular tourist spot of India?', '', 10, NULL, NULL, 0, 0, 1),
	(21, 21, 'What is the popular tourist spot of Bangladesh?', '', 10, NULL, NULL, 0, 0, 1),
	(22, 22, 'What is the popular tourist spot of Nepal?', '', 10, NULL, NULL, 0, 0, 1),
	(23, 23, 'What is the popular tourist spot of India?', '', 10, NULL, NULL, 0, 0, 1),
	(24, 28, 'h', '', 10, NULL, NULL, 0, 0, 1),
	(25, 28, 'g', '', 10, NULL, NULL, 0, 2, 1),
	(26, 28, 'n', '', 10, NULL, NULL, 0, 3, 1),
	(27, 29, 'What is the currency of Japan?', '', 10, NULL, NULL, 0, 0, 1),
	(28, 29, 'What is the currency of Bangladesh?', '', 10, NULL, NULL, 0, 2, 1),
	(29, 30, 'What is the official language of Japan?', '', 5, NULL, NULL, 0, 0, 1),
	(30, 30, 'What is the official language of Bangladesh?', '', 5, NULL, NULL, 0, 2, 1),
	(31, 30, 'What is the official language of Spain?', '', 5, NULL, NULL, 0, 3, 1),
	(32, 30, 'What is the official language of England?', '', 5, NULL, NULL, 0, 4, 1),
	(33, 30, 'What is the official language of Netherlands?', '', 10, NULL, NULL, 0, 5, 1),
	(34, 31, 'What is the national animal of Bangladesh? ', '', 5, NULL, NULL, 0, 0, 1),
	(35, 31, 'What is the national animal of Pakistan? ', '', 5, NULL, NULL, 0, 2, 1),
	(36, 31, 'What is the national animal of Nepal?', '', 5, NULL, NULL, 0, 3, 1),
	(37, 31, 'What is the national animal of USA?  ', '', 5, NULL, NULL, 0, 4, 1),
	(38, 31, 'What is the national animal of UK? ', '', 5, NULL, NULL, 0, 5, 1),
	(39, 32, 'What is the currency of India? ', '', 5, NULL, NULL, 0, 0, 1),
	(40, 32, 'What is the currency of pakistan? ', '', 5, NULL, NULL, 0, 2, 1),
	(41, 32, 'What is the currency of Vietnam?', '', 5, NULL, NULL, 0, 3, 1),
	(42, 32, 'What is the currency of USA? ', '', 5, NULL, NULL, 0, 4, 1),
	(43, 32, 'What is the currency of Kuwait? ', '', 5, NULL, NULL, 0, 5, 1),
	(44, 32, 'What is the currency of UK?', '', 5, NULL, NULL, 0, 6, 1),
	(45, 33, 'What is the national flower of India? ', '', 10, NULL, NULL, 0, 0, 1),
	(46, 33, 'What is the national flower of Pakistan?', '', 5, NULL, NULL, 0, 2, 1),
	(47, 33, 'What is the national flower of Japan? ', '', 5, NULL, NULL, 0, 3, 1),
	(48, 33, 'What is the national flower of Bangladesh?', '', 5, NULL, NULL, 0, 4, 1),
	(51, 36, 'what is mapping?1', '', 10, NULL, NULL, 0, 0, 1),
	(52, 39, 'What is mapping2?', '', 5, NULL, NULL, 0, 0, 1),
	(53, 40, 'fkjvs', '', 10, NULL, NULL, 0, 0, 1),
	(54, 41, '', NULL, NULL, NULL, NULL, 0, 0, 1),
	(55, 42, '', NULL, NULL, NULL, NULL, 0, 0, 1),
	(56, 43, '', NULL, NULL, NULL, NULL, 0, 0, 1),
	(57, 44, '', '', 10, NULL, NULL, 0, 0, 1),
	(58, 46, 'What is the capital of BD?', '', 10, NULL, NULL, 0, 0, 1),
	(59, 46, 'What is the capital of Japan?', '', 10, NULL, NULL, 0, 2, 1),
	(60, 47, 'tyy', '', 10, NULL, NULL, 0, 0, 1),
	(62, 47, '', '', 10, NULL, NULL, 0, 2, 1),
	(63, 47, '', '', 10, NULL, NULL, 0, 3, 1),
	(65, 48, 'uj', '', 10, NULL, NULL, 0, 0, 1),
	(66, 48, '', '', 10, NULL, NULL, 0, 2, 1),
	(69, 49, 'ui', '', 10, NULL, NULL, 0, 0, 1),
	(70, 50, 'o', '', 10, NULL, NULL, 0, 0, 1),
	(71, 50, 'p', '', 10, NULL, NULL, 0, 2, 1),
	(72, 51, 'r', '', 10, NULL, NULL, 0, 0, 1),
	(73, 51, 'f', '', 10, NULL, NULL, 0, 2, 1),
	(74, 52, 'Is mapping Done?', '', 10, NULL, NULL, 0, 0, 1),
	(75, 52, 'Is mapping Done?', '', 10, NULL, NULL, 0, 2, 1),
	(76, 52, 'Is mapping done?', '', 10, NULL, NULL, 0, 3, 1),
	(77, 52, 'IS mapping done?', '', 10, NULL, NULL, 0, 4, 1),
	(78, 52, 'g', '', 10, NULL, NULL, 0, 5, 1),
	(79, 52, 'g', '', 10, NULL, NULL, 0, 6, 1),
	(80, 52, '', NULL, NULL, NULL, NULL, 0, 7, 1),
	(81, 53, 'Is mapping done?', '', 10, NULL, NULL, 0, 0, 1),
	(82, 53, 'Is mapping done?', '', 10, NULL, NULL, 0, 2, 1),
	(83, 53, '', NULL, NULL, NULL, NULL, 0, 3, 1),
	(84, 54, 'is mapping done?', '', 10, NULL, NULL, 0, 0, 1),
	(85, 54, 'Is mapping done?', '', 10, NULL, NULL, 0, 2, 1),
	(86, 54, 'is mapping done?', '', 10, NULL, NULL, 0, 3, 1),
	(87, 54, 'is mapping done?', '', 10, NULL, NULL, 0, 4, 1),
	(88, 54, '', NULL, NULL, NULL, NULL, 0, 5, 1),
	(89, 55, 'Is mapping done?', '', 10, NULL, NULL, 0, 0, 1),
	(90, 55, '', '', 10, NULL, NULL, 0, 2, 1),
	(91, 56, 'I smapping done?', '', 10, NULL, NULL, 0, 0, 1),
	(92, 56, 'Is mapping done?', '', 10, NULL, NULL, 0, 2, 1),
	(93, 56, '', NULL, NULL, NULL, NULL, 0, 3, 1),
	(94, 57, 'Is mapping doe?', '', 10, NULL, NULL, 0, 0, 1),
	(95, 57, 'Is mapping done?', '', 10, NULL, NULL, 0, 2, 1),
	(96, 57, '', NULL, NULL, NULL, NULL, 0, 3, 1),
	(97, 58, 'Is mapping done?', '', 10, NULL, NULL, 0, 0, 1),
	(98, 58, 'Is mapping done?', '', 10, NULL, NULL, 0, 2, 1),
	(99, 58, '', NULL, NULL, NULL, NULL, 0, 3, 1),
	(100, 59, 'is mappping?', '', 10, NULL, NULL, 0, 0, 1),
	(101, 59, '', '', 10, NULL, NULL, 0, 2, 1),
	(102, 60, 'is mapping?', '', 10, NULL, NULL, 0, 0, 1),
	(103, 60, '', '', 10, NULL, NULL, 0, 2, 1),
	(104, 61, 'what is mapping?', '', 10, NULL, NULL, 0, 0, 1),
	(105, 61, 'Is mapping?', '', 10, NULL, NULL, 0, 2, 1),
	(106, 61, '', '', 10, NULL, NULL, 0, 3, 1),
	(107, 62, '', NULL, NULL, NULL, NULL, 0, 0, 1),
	(108, 63, 'r', '', 10, NULL, NULL, 0, 0, 1),
	(109, 63, '', '', 10, NULL, NULL, 0, 2, 1),
	(110, 64, 'y', '', 10, NULL, NULL, 0, 0, 1),
	(111, 64, '', NULL, NULL, NULL, NULL, 0, 2, 1),
	(112, 65, 'm', '', 10, NULL, NULL, 0, 0, 1),
	(113, 65, '', NULL, NULL, NULL, NULL, 0, 2, 1),
	(114, 66, 'y', '', 10, NULL, NULL, 0, 0, 1),
	(115, 66, '', NULL, NULL, NULL, NULL, 0, 2, 1),
	(117, 67, '', '', 10, NULL, NULL, 0, 2, 1),
	(118, 68, 'r', '', 10, NULL, NULL, 0, 0, 1),
	(119, 68, '', '', 10, NULL, NULL, 0, 2, 1),
	(120, 69, 'map', '', 10, NULL, NULL, 0, 0, 1),
	(121, 69, '', '', 10, NULL, NULL, 0, 2, 1),
	(122, 70, 'map', '', 10, NULL, NULL, 0, 0, 1),
	(123, 70, '', NULL, NULL, NULL, NULL, 0, 2, 1),
	(124, 71, 'map', '', 10, NULL, NULL, 0, 0, 1),
	(125, 71, 'pam', '', 10, NULL, NULL, 0, 2, 1),
	(126, 71, 'map', '', 10, NULL, NULL, 0, 3, 1),
	(127, 71, 'pam', '', 10, NULL, NULL, 0, 4, 1),
	(128, 71, 'map', '', 10, NULL, NULL, 0, 5, 1),
	(129, 71, '', '', 10, NULL, NULL, 0, 6, 1),
	(131, 72, 'pam', '', 10, NULL, NULL, 0, 2, 1),
	(132, 72, 'map', '', 10, NULL, NULL, 0, 3, 1),
	(133, 72, 'pam', '', 10, NULL, NULL, 0, 4, 1),
	(134, 72, 'map', '', 10, NULL, NULL, 0, 5, 1),
	(135, 72, 'pam', '', 10, NULL, NULL, 0, 6, 1),
	(136, 72, 'map', '', 10, NULL, NULL, 0, 7, 1),
	(137, 72, 'pam', '', 10, NULL, NULL, 0, 8, 1),
	(138, 72, 'map', '', 10, NULL, NULL, 0, 9, 1),
	(139, 72, 'pam', '', 10, NULL, NULL, 0, 10, 1),
	(141, 72, 'pam', '', 10, NULL, NULL, 0, 12, 1),
	(142, 72, '', '', 10, NULL, NULL, 0, 13, 1),
	(143, 73, 'map', '', 10, NULL, NULL, 0, 0, 1),
	(145, 73, '', '', 10, NULL, NULL, 0, 3, 1),
	(152, 74, '', NULL, NULL, NULL, NULL, 0, 0, 1),
	(153, 75, 'map', '', 10, NULL, NULL, 0, 0, 1),
	(155, 75, '', '', 10, NULL, NULL, 0, 3, 1),
	(158, 76, 'map', '', 10, NULL, NULL, 0, 3, 1),
	(159, 76, '', NULL, NULL, NULL, NULL, 0, 2, 1),
	(165, 77, 'map2', '', 10, NULL, NULL, 0, 3, 1),
	(166, 77, 'map3', '', 10, NULL, NULL, 0, 3, 1),
	(168, 78, 'map1', '', 10, NULL, NULL, 0, 0, 1),
	(169, 78, 'map2', '', 10, NULL, NULL, 0, 2, 1),
	(170, 78, 'map3', '', 10, NULL, NULL, 0, 3, 1),
	(171, 78, 'map4', '', 10, NULL, NULL, 0, 4, 1),
	(172, 78, 'map5', '', 10, NULL, NULL, 0, 5, 1),
	(173, 78, 'oo', '', 10, NULL, NULL, 0, 6, 1),
	(174, 79, 'map1', '', 10, NULL, NULL, 0, 0, 1),
	(175, 79, 'map2', '', 10, NULL, NULL, 0, 2, 1),
	(176, 79, '', '', 10, NULL, NULL, 0, 3, 1),
	(177, 80, 'jhfht', '', 10, NULL, NULL, 0, 0, 1),
	(178, 80, 'data2ndtime', '', 10, NULL, NULL, 0, 2, 1),
	(180, 80, 'ytt', '', 10, NULL, NULL, 0, 4, 1),
	(181, 80, 'ujg', '', 10, NULL, NULL, 0, 4, 1),
	(182, 80, 'nnn', '', 10, NULL, NULL, 0, 5, 1),
	(183, 81, '1st', '', 10, NULL, NULL, 0, 0, 1),
	(185, 81, '3rd', '', 10, NULL, NULL, 0, 3, 1),
	(186, 81, '4th', '', 10, NULL, NULL, 0, 4, 1),
	(187, 81, '5th', '', 10, NULL, NULL, 0, 5, 1);
/*!40000 ALTER TABLE `tbl_quiz_query` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_query_correct_answer_bk
CREATE TABLE IF NOT EXISTS `tbl_quiz_query_correct_answer_bk` (
  `correct_answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '正答ナンバー',
  `selection_id` int(10) unsigned NOT NULL COMMENT '選択肢の中の正答ナンバー',
  `quiz_id` int(10) unsigned NOT NULL,
  `query_id` int(10) unsigned NOT NULL COMMENT 'クエリーナンバー',
  PRIMARY KEY (`correct_answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_query_correct_answer_bk: ~0 rows (approximately)
DELETE FROM `tbl_quiz_query_correct_answer_bk`;
/*!40000 ALTER TABLE `tbl_quiz_query_correct_answer_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_query_correct_answer_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_query_file_bk
CREATE TABLE IF NOT EXISTS `tbl_quiz_query_file_bk` (
  `quiz_query_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_type` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '0:image 1:sound',
  `file_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `file_path` varchar(60) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`quiz_query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_quiz_query_file_bk: ~0 rows (approximately)
DELETE FROM `tbl_quiz_query_file_bk`;
/*!40000 ALTER TABLE `tbl_quiz_query_file_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_query_file_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_query_follow_common_contents_bk
CREATE TABLE IF NOT EXISTS `tbl_quiz_query_follow_common_contents_bk` (
  `quiz_query_id` int(10) unsigned NOT NULL,
  `common_contents_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_quiz_query_follow_common_contents_bk: ~0 rows (approximately)
DELETE FROM `tbl_quiz_query_follow_common_contents_bk`;
/*!40000 ALTER TABLE `tbl_quiz_query_follow_common_contents_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_query_follow_common_contents_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_query_follow_contents
CREATE TABLE IF NOT EXISTS `tbl_quiz_query_follow_contents` (
  `quiz_query_id` int(10) unsigned NOT NULL,
  `contents_id` int(10) unsigned NOT NULL,
  `contents_category_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_quiz_query_follow_contents: ~0 rows (approximately)
DELETE FROM `tbl_quiz_query_follow_contents`;
/*!40000 ALTER TABLE `tbl_quiz_query_follow_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_query_follow_contents` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_query_selection
CREATE TABLE IF NOT EXISTS `tbl_quiz_query_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '選択肢ナンバー',
  `quiz_id` int(10) unsigned NOT NULL,
  `query_id` int(10) unsigned NOT NULL COMMENT '問題ナンバー',
  `text` varchar(255) DEFAULT NULL COMMENT '選択肢',
  `display_order` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `correct_flg` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`selection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=779 DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_query_selection: ~670 rows (approximately)
DELETE FROM `tbl_quiz_query_selection`;
/*!40000 ALTER TABLE `tbl_quiz_query_selection` DISABLE KEYS */;
INSERT INTO `tbl_quiz_query_selection` (`selection_id`, `quiz_id`, `query_id`, `text`, `display_order`, `correct_flg`, `enable`) VALUES
	(1, 1, 1, 'g', 0, 0, 1),
	(2, 1, 1, 'j', 1, 0, 1),
	(3, 1, 1, 'm', 2, 0, 1),
	(4, 1, 1, 'n', 3, 0, 1),
	(10, 2, 3, 'Dhaka', 0, 1, 1),
	(11, 2, 3, 'Chittagong', 1, 0, 1),
	(12, 2, 3, 'Kulna', 2, 0, 1),
	(13, 2, 3, 'Tokyo', 3, 0, 1),
	(14, 3, 4, 'Dhaka', 0, 1, 1),
	(15, 3, 4, 'Chittagong', 1, 0, 1),
	(16, 3, 4, 'Kulna', 2, 0, 1),
	(17, 3, 4, 'Tokyo', 3, 0, 1),
	(18, 4, 5, 'Dhaka', 0, 0, 1),
	(19, 4, 5, 'Chittagong', 1, 0, 1),
	(20, 4, 5, 'Kulna', 2, 0, 1),
	(21, 4, 5, 'Tokyo', 3, 1, 1),
	(22, 5, 6, 'Dhaka', 0, 0, 1),
	(23, 5, 6, 'Chittagong', 1, 0, 1),
	(24, 5, 6, 'Kulna', 2, 0, 1),
	(25, 5, 6, 'Delhi', 3, 1, 1),
	(26, 6, 7, 'Dhaka', 0, 0, 1),
	(27, 6, 7, 'Chittagong', 1, 0, 1),
	(28, 6, 7, 'Kulna', 2, 0, 1),
	(29, 6, 7, 'Islamabad', 3, 1, 1),
	(30, 7, 8, 'Dhaka', 0, 0, 1),
	(31, 7, 8, 'Chittagong', 1, 0, 1),
	(32, 7, 8, 'Kulna', 2, 0, 1),
	(33, 7, 8, 'Kathmundu', 3, 1, 1),
	(34, 8, 9, 'Chess', 0, 0, 1),
	(35, 8, 9, 'Cricket', 1, 1, 1),
	(36, 8, 9, 'Table Tennis', 2, 0, 1),
	(37, 8, 9, 'Basket Ball', 3, 0, 1),
	(38, 9, 10, 'Base Ball', 0, 1, 1),
	(39, 9, 10, 'Football', 1, 0, 1),
	(40, 9, 10, 'Cricket', 2, 0, 1),
	(41, 9, 10, 'Kabadi', 3, 0, 1),
	(42, 10, 11, 'Football', 0, 1, 1),
	(43, 10, 11, 'Cricket', 1, 0, 1),
	(44, 10, 11, 'Table Tennis', 2, 0, 1),
	(45, 10, 11, 'Basket Ball', 3, 0, 1),
	(46, 11, 12, 'Chess', 0, 0, 1),
	(47, 11, 12, 'Cricket', 1, 1, 1),
	(48, 11, 12, 'Table Tennis', 2, 0, 1),
	(49, 11, 12, 'Basket Ball', 3, 0, 1),
	(50, 12, 13, 'Chess', 0, 1, 1),
	(51, 12, 13, 'Cricket', 1, 0, 1),
	(52, 12, 13, 'Table Tennis', 2, 0, 1),
	(53, 12, 13, 'Basket Ball', 3, 0, 1),
	(54, 13, 14, 'Biriani', 0, 1, 1),
	(55, 13, 14, 'Momo', 1, 0, 1),
	(56, 13, 14, 'Danbo', 2, 0, 1),
	(57, 13, 14, 'Nikujaga', 3, 0, 1),
	(58, 14, 15, 'Biriani', 0, 0, 1),
	(59, 14, 15, 'Momo', 1, 1, 1),
	(60, 14, 15, 'Danbo', 2, 0, 1),
	(61, 14, 15, 'Nikujaga', 3, 0, 1),
	(62, 15, 16, 'Biriani', 0, 0, 1),
	(63, 15, 16, 'Tempura', 1, 1, 1),
	(64, 15, 16, 'Sushi', 2, 0, 1),
	(65, 15, 16, 'Sashimi', 3, 0, 1),
	(66, 17, 17, 'Dosa', 0, 1, 1),
	(67, 17, 17, 'Sandwich', 1, 0, 1),
	(68, 17, 17, 'Sushi', 2, 0, 1),
	(69, 17, 17, 'Sa', 3, 0, 1),
	(70, 18, 18, 'Meat', 0, 1, 1),
	(71, 18, 18, 'Vegetable', 1, 0, 1),
	(72, 18, 18, 'Rice', 2, 0, 1),
	(73, 18, 18, 'Bread', 3, 0, 1),
	(74, 19, 19, 'Takachiho', 0, 1, 1),
	(75, 19, 19, 'Dhaka', 1, 0, 1),
	(76, 19, 19, 'Delhi', 2, 0, 1),
	(77, 19, 19, 'Islamabad', 3, 0, 1),
	(78, 20, 20, 'Kashmir', 0, 1, 1),
	(79, 20, 20, 'Dhaka', 1, 0, 1),
	(80, 20, 20, 'Takachiho', 2, 0, 1),
	(81, 20, 20, 'Kolombo', 3, 0, 1),
	(82, 21, 21, 'Rangamati', 0, 1, 1),
	(83, 21, 21, 'Takachiho', 1, 0, 1),
	(84, 21, 21, 'Delhi', 2, 0, 1),
	(85, 21, 21, 'Premadasa', 3, 0, 1),
	(86, 22, 22, 'Himalaya', 0, 1, 1),
	(87, 22, 22, 'Beijing', 1, 0, 1),
	(88, 22, 22, 'Kulna', 2, 0, 1),
	(89, 22, 22, 'Islamabad', 3, 0, 1),
	(90, 23, 23, 'Ladakh', 0, 1, 1),
	(91, 23, 23, 'Chittagong', 1, 0, 1),
	(92, 23, 23, 'Khulna', 2, 0, 1),
	(93, 23, 23, 'Islamabad', 3, 0, 1),
	(94, 28, 24, 'Base Ball', 0, 0, 1),
	(95, 28, 24, 'Beijing', 1, 0, 1),
	(96, 28, 24, 'b', 2, 1, 1),
	(97, 28, 25, 'Base Ball', 0, 0, 1),
	(98, 28, 25, 'Chittagong', 1, 1, 1),
	(99, 28, 25, '', 2, 0, 0),
	(100, 28, 25, '', 3, 0, 0),
	(101, 28, 25, '', 4, 0, 0),
	(102, 28, 26, 'Dhaka', 0, 0, 1),
	(103, 28, 26, 'Chittagong', 1, 0, 1),
	(104, 28, 26, 'Kulna', 2, 0, 1),
	(105, 28, 26, 'Islamabad', 3, 1, 1),
	(106, 28, 26, '', 4, 0, 0),
	(107, 29, 27, 'Yen', 0, 1, 1),
	(108, 29, 27, 'Dollar', 1, 0, 1),
	(109, 29, 27, 'Taka', 2, 0, 1),
	(110, 29, 28, 'Taka', 0, 1, 1),
	(111, 29, 28, 'Rupee', 1, 0, 1),
	(112, 29, 28, 'ringit', 2, 0, 1),
	(113, 29, 28, '', 3, 0, 0),
	(114, 29, 28, '', 4, 0, 0),
	(115, 30, 29, 'Bangla', 0, 0, 1),
	(116, 30, 29, 'English', 1, 0, 1),
	(117, 30, 29, 'Spanish', 2, 0, 1),
	(118, 30, 29, 'Japanese', 3, 1, 1),
	(119, 30, 30, 'Bangla', 0, 1, 1),
	(120, 30, 30, 'English', 1, 0, 1),
	(121, 30, 30, 'Spanish', 2, 0, 1),
	(122, 30, 30, 'Japanese', 3, 0, 1),
	(123, 30, 30, '', 4, 0, 0),
	(124, 30, 31, 'Bangla', 0, 0, 1),
	(125, 30, 31, 'English', 1, 0, 1),
	(126, 30, 31, 'Spanish', 2, 1, 1),
	(127, 30, 31, 'Japanese', 3, 0, 1),
	(128, 30, 31, '', 4, 0, 0),
	(129, 30, 32, 'Bangla', 0, 0, 1),
	(130, 30, 32, 'English', 1, 1, 1),
	(131, 30, 32, 'Spanish', 2, 0, 1),
	(132, 30, 32, 'Japanese', 3, 0, 1),
	(133, 30, 32, '', 4, 0, 0),
	(134, 30, 33, 'Bangla', 0, 0, 1),
	(135, 30, 33, 'English', 1, 0, 1),
	(136, 30, 33, 'Dutch', 2, 1, 1),
	(137, 30, 33, 'Japanese', 3, 0, 1),
	(138, 30, 33, '', 4, 0, 0),
	(139, 31, 34, 'Tiger', 0, 1, 1),
	(140, 31, 34, 'Cat', 1, 0, 1),
	(141, 31, 34, 'Dog', 2, 0, 1),
	(142, 31, 34, 'Chicken', 3, 0, 1),
	(143, 31, 35, 'Makhor', 0, 1, 1),
	(144, 31, 35, 'Cat', 1, 0, 1),
	(145, 31, 35, 'Dog', 2, 0, 1),
	(146, 31, 35, 'duck', 3, 0, 1),
	(147, 31, 35, '', 4, 0, 0),
	(148, 31, 36, 'Cow', 0, 1, 1),
	(149, 31, 36, 'Cat', 1, 0, 1),
	(150, 31, 36, 'Dog', 2, 0, 1),
	(151, 31, 36, 'duck', 3, 0, 1),
	(152, 31, 36, '', 4, 0, 0),
	(153, 31, 37, 'Bison', 0, 1, 1),
	(154, 31, 37, 'Tiger', 1, 0, 1),
	(155, 31, 37, 'Cow', 2, 0, 1),
	(156, 31, 37, 'Dog', 3, 0, 1),
	(157, 31, 37, '', 4, 0, 0),
	(158, 31, 38, 'Lion', 0, 1, 1),
	(159, 31, 38, 'Tiger', 1, 0, 1),
	(160, 31, 38, 'Dog', 2, 0, 1),
	(161, 31, 38, 'duck', 3, 0, 1),
	(162, 31, 38, '', 4, 0, 0),
	(163, 32, 39, 'Indian Rupee', 0, 1, 1),
	(164, 32, 39, 'Dinar', 1, 0, 1),
	(165, 32, 39, 'Dirham', 2, 0, 1),
	(166, 32, 39, 'Won', 3, 0, 1),
	(167, 32, 40, 'Pakistani Rupee', 0, 1, 1),
	(168, 32, 40, 'Dollar', 1, 0, 1),
	(169, 32, 40, 'Dinar', 2, 0, 1),
	(170, 32, 40, 'Dirham', 3, 0, 1),
	(171, 32, 40, '', 4, 0, 0),
	(172, 32, 41, 'Vietnamese Dong', 0, 1, 1),
	(173, 32, 41, 'Dollar', 1, 0, 1),
	(174, 32, 41, 'Dinar', 2, 0, 1),
	(175, 32, 41, 'Dirham', 3, 0, 1),
	(176, 32, 41, '', 4, 0, 0),
	(177, 32, 42, 'Pakistani Rupee', 0, 0, 1),
	(178, 32, 42, 'Dollar', 1, 1, 1),
	(179, 32, 42, 'Dinar', 2, 0, 1),
	(180, 32, 42, 'Dirham', 3, 0, 1),
	(181, 32, 42, '', 4, 0, 0),
	(182, 32, 43, 'Pakistani Rupee', 0, 0, 1),
	(183, 32, 43, 'Dollar', 1, 0, 1),
	(184, 32, 43, 'Dinar', 2, 1, 1),
	(185, 32, 43, 'Dirham', 3, 0, 1),
	(186, 32, 43, '', 4, 0, 0),
	(187, 32, 44, 'Euro', 0, 1, 1),
	(188, 32, 44, 'Dollar', 1, 0, 1),
	(189, 32, 44, 'Dinar', 2, 0, 1),
	(190, 32, 44, 'Dirham', 3, 0, 1),
	(191, 32, 44, '', 4, 0, 0),
	(192, 33, 45, 'Cherry Blossom', 0, 0, 1),
	(193, 33, 45, 'Lotus', 1, 1, 1),
	(194, 33, 45, 'Jasmine', 2, 0, 1),
	(195, 33, 45, 'Water Lily', 3, 0, 1),
	(196, 33, 46, 'Cherry Blossom', 0, 0, 1),
	(197, 33, 46, 'Lotus', 1, 0, 1),
	(198, 33, 46, 'Jasmine', 2, 1, 1),
	(199, 33, 46, 'Water Lily', 3, 0, 1),
	(200, 33, 46, '', 4, 0, 0),
	(201, 33, 47, 'Cherry Blossom', 0, 1, 1),
	(202, 33, 47, 'Lotus', 1, 0, 1),
	(203, 33, 47, 'Jasmine', 2, 0, 1),
	(204, 33, 47, 'Water Lily', 3, 0, 1),
	(205, 33, 47, '', 4, 0, 0),
	(206, 33, 48, 'Cherry Blossom', 0, 0, 1),
	(207, 33, 48, 'Lotus', 1, 0, 1),
	(208, 33, 48, 'Jasmine', 2, 0, 1),
	(209, 33, 48, 'Water Lily', 3, 1, 1),
	(210, 33, 48, '', 4, 0, 0),
	(211, 36, 51, 'relationsip1', 0, 1, 1),
	(212, 36, 51, 'a1', 1, 0, 1),
	(213, 36, 51, 'a1', 2, 0, 1),
	(214, 36, 51, 'a1', 3, 0, 1),
	(215, 39, 52, 'mapping', 0, 1, 1),
	(216, 39, 52, 's', 1, 0, 1),
	(217, 39, 52, 'a', 2, 0, 1),
	(218, 39, 52, 'f', 3, 0, 1),
	(219, 39, 52, 'v', 4, 0, 1),
	(220, 40, 53, 'mapping', 0, 1, 1),
	(221, 40, 53, 'a', 1, 0, 1),
	(222, 40, 53, 'c', 2, 0, 1),
	(223, 40, 53, 'a', 3, 0, 1),
	(224, 40, 53, 'a', 4, 0, 1),
	(225, 46, 58, 'Dhaka', 0, 1, 1),
	(226, 46, 58, 'Ch', 1, 0, 1),
	(227, 46, 59, 'Dhaka', 0, 0, 1),
	(228, 46, 59, 'Tokyo', 1, 1, 1),
	(229, 46, 59, '', 2, 0, 0),
	(230, 46, 59, '', 3, 0, 0),
	(231, 46, 59, '', 4, 0, 0),
	(237, 47, 62, '', 0, 0, 0),
	(238, 47, 62, '', 1, 0, 0),
	(239, 47, 62, '', 2, 0, 0),
	(240, 47, 62, '', 3, 0, 0),
	(241, 47, 62, '', 4, 0, 0),
	(242, 47, 60, 'fdg', 0, 1, 1),
	(243, 47, 63, '', 0, 0, 0),
	(244, 47, 63, '', 1, 0, 0),
	(245, 47, 63, '', 2, 0, 0),
	(246, 47, 63, '', 3, 0, 0),
	(247, 47, 63, '', 4, 0, 0),
	(249, 48, 65, 'o', 0, 0, 1),
	(250, 48, 66, '', 0, 0, 0),
	(251, 48, 66, '', 1, 0, 0),
	(252, 48, 66, '', 2, 0, 0),
	(253, 48, 66, '', 3, 0, 0),
	(254, 48, 66, '', 4, 0, 0),
	(262, 49, 69, 'kk', 0, 0, 1),
	(263, 50, 70, 'o', 0, 1, 1),
	(264, 50, 71, '', 0, 0, 0),
	(265, 50, 71, '', 1, 0, 0),
	(266, 50, 71, '', 2, 0, 0),
	(267, 50, 71, '', 3, 0, 0),
	(268, 50, 71, '', 4, 0, 0),
	(269, 50, 71, '\'', 0, 1, 1),
	(270, 51, 72, 'f', 0, 0, 1),
	(271, 51, 72, 'f', 1, 0, 1),
	(272, 51, 73, '', 0, 0, 0),
	(273, 51, 73, '', 1, 0, 0),
	(274, 51, 73, '', 2, 0, 0),
	(275, 51, 73, '', 3, 0, 0),
	(276, 51, 73, '', 4, 0, 0),
	(277, 51, 73, 'f', 0, 1, 1),
	(278, 52, 74, 'NO', 0, 1, 1),
	(279, 52, 74, 'YES', 1, 0, 1),
	(280, 52, 75, 'NO', 0, 1, 1),
	(281, 52, 75, 'YES', 1, 0, 1),
	(282, 52, 75, '', 2, 0, 0),
	(283, 52, 75, '', 3, 0, 0),
	(284, 52, 75, '', 4, 0, 0),
	(285, 52, 76, 'NO', 0, 1, 1),
	(286, 52, 76, 'YES', 1, 0, 1),
	(287, 52, 76, '', 2, 0, 0),
	(288, 52, 76, '', 3, 0, 0),
	(289, 52, 76, '', 4, 0, 0),
	(290, 52, 77, 'NO', 0, 1, 1),
	(291, 52, 77, 'YES', 1, 0, 1),
	(292, 52, 77, '', 2, 0, 0),
	(293, 52, 77, '', 3, 0, 0),
	(294, 52, 77, '', 4, 0, 0),
	(295, 52, 78, 'g', 0, 1, 1),
	(296, 52, 78, '', 1, 0, 0),
	(297, 52, 78, '', 2, 0, 0),
	(298, 52, 78, '', 3, 0, 0),
	(299, 52, 78, '', 4, 0, 0),
	(300, 52, 79, 'g', 0, 1, 1),
	(301, 52, 79, '', 1, 0, 0),
	(302, 52, 79, '', 2, 0, 0),
	(303, 52, 79, '', 3, 0, 0),
	(304, 52, 79, '', 4, 0, 0),
	(305, 52, 80, '', 0, 0, 1),
	(306, 52, 80, '', 1, 0, 1),
	(307, 52, 80, '', 2, 0, 1),
	(308, 52, 80, '', 3, 0, 1),
	(309, 52, 80, '', 4, 0, 1),
	(310, 53, 81, 'NO', 0, 1, 1),
	(311, 53, 81, 'YES', 1, 0, 1),
	(312, 53, 82, '', 0, 0, 0),
	(313, 53, 82, '', 1, 0, 0),
	(314, 53, 82, '', 2, 0, 0),
	(315, 53, 82, 'NO', 0, 0, 1),
	(316, 53, 82, 'YES', 1, 0, 1),
	(317, 53, 83, '', 0, 0, 1),
	(318, 53, 83, '', 1, 0, 1),
	(319, 53, 83, '', 2, 0, 1),
	(320, 53, 83, '', 3, 0, 1),
	(321, 53, 83, '', 4, 0, 1),
	(322, 54, 84, 'NO', 0, 1, 1),
	(323, 54, 84, 'YES', 1, 0, 1),
	(324, 54, 85, 'NO', 0, 1, 1),
	(325, 54, 85, 'YES', 1, 0, 1),
	(326, 54, 85, '', 2, 0, 0),
	(327, 54, 85, '', 3, 0, 0),
	(328, 54, 85, '', 4, 0, 0),
	(329, 54, 86, 'NO', 0, 1, 1),
	(330, 54, 86, 'YES', 1, 0, 1),
	(331, 54, 86, '', 2, 0, 0),
	(332, 54, 86, '', 3, 0, 0),
	(333, 54, 86, '', 4, 0, 0),
	(334, 54, 87, 'NO', 0, 1, 1),
	(335, 54, 87, 'YES', 1, 0, 1),
	(336, 54, 87, '', 2, 0, 0),
	(337, 54, 87, '', 3, 0, 0),
	(338, 54, 87, '', 4, 0, 0),
	(339, 54, 88, '', 0, 0, 1),
	(340, 54, 88, '', 1, 0, 1),
	(341, 54, 88, '', 2, 0, 1),
	(342, 54, 88, '', 3, 0, 1),
	(343, 54, 88, '', 4, 0, 1),
	(344, 55, 89, 'NO', 0, 1, 1),
	(345, 55, 89, 'YES', 1, 0, 1),
	(346, 55, 90, '', 0, 0, 0),
	(347, 55, 90, '', 1, 0, 0),
	(348, 55, 90, '', 2, 0, 0),
	(349, 55, 90, '', 3, 0, 0),
	(350, 55, 90, '', 4, 0, 0),
	(351, 56, 91, 'NO', 0, 1, 1),
	(352, 56, 92, 'NO', 0, 1, 1),
	(353, 56, 92, '', 1, 0, 0),
	(354, 56, 92, '', 2, 0, 0),
	(355, 56, 92, '', 3, 0, 0),
	(356, 56, 92, '', 4, 0, 0),
	(357, 56, 93, '', 0, 0, 1),
	(358, 56, 93, '', 1, 0, 1),
	(359, 56, 93, '', 2, 0, 1),
	(360, 56, 93, '', 3, 0, 1),
	(361, 56, 93, '', 4, 0, 1),
	(362, 57, 94, 'NO', 0, 1, 1),
	(363, 57, 94, 'YES', 1, 0, 1),
	(364, 57, 95, 'NO', 0, 1, 1),
	(365, 57, 95, 'YES', 1, 0, 1),
	(366, 57, 95, '', 2, 0, 0),
	(367, 57, 95, '', 3, 0, 0),
	(368, 57, 95, '', 4, 0, 0),
	(369, 57, 96, '', 0, 0, 1),
	(370, 57, 96, '', 1, 0, 1),
	(371, 57, 96, '', 2, 0, 1),
	(372, 57, 96, '', 3, 0, 1),
	(373, 57, 96, '', 4, 0, 1),
	(374, 58, 97, 'NO', 0, 1, 1),
	(375, 58, 97, 'YES', 1, 0, 1),
	(376, 58, 98, 'NO', 0, 0, 1),
	(377, 58, 98, 'YES', 1, 0, 1),
	(378, 58, 98, 'Almost', 2, 1, 1),
	(379, 58, 98, '', 3, 0, 0),
	(380, 58, 98, '', 4, 0, 0),
	(381, 58, 99, '', 0, 0, 1),
	(382, 58, 99, '', 1, 0, 1),
	(383, 58, 99, '', 2, 0, 1),
	(384, 58, 99, '', 3, 0, 1),
	(385, 58, 99, '', 4, 0, 1),
	(386, 59, 100, 'NO', 0, 1, 1),
	(387, 59, 100, 'YES', 1, 0, 1),
	(388, 59, 101, '', 0, 0, 0),
	(389, 59, 101, '', 1, 0, 0),
	(390, 59, 101, '', 2, 0, 0),
	(391, 59, 101, '', 3, 0, 0),
	(392, 59, 101, '', 4, 0, 0),
	(393, 60, 102, 'NO', 0, 1, 1),
	(394, 60, 102, 'YES', 1, 0, 1),
	(395, 60, 103, '', 0, 0, 0),
	(396, 60, 103, '', 1, 0, 0),
	(397, 60, 103, '', 2, 0, 0),
	(398, 60, 103, '', 3, 0, 0),
	(399, 60, 103, '', 4, 0, 0),
	(400, 61, 104, 'NO', 0, 1, 1),
	(401, 61, 104, 'YES', 1, 0, 1),
	(402, 61, 105, '', 0, 0, 0),
	(403, 61, 105, '', 1, 0, 0),
	(404, 61, 105, '', 2, 0, 0),
	(405, 61, 105, '', 3, 0, 0),
	(406, 61, 105, '', 4, 0, 0),
	(407, 61, 105, 'NO', 0, 0, 1),
	(408, 61, 105, 'YES', 1, 1, 1),
	(409, 61, 106, '', 0, 0, 0),
	(410, 61, 106, '', 1, 0, 0),
	(411, 61, 106, '', 2, 0, 0),
	(412, 61, 106, '', 3, 0, 0),
	(413, 61, 106, '', 4, 0, 0),
	(414, 63, 108, 'NO', 0, 1, 1),
	(415, 63, 108, 'YES', 1, 0, 1),
	(416, 63, 109, '', 0, 0, 0),
	(417, 63, 109, '', 1, 0, 0),
	(418, 63, 109, '', 2, 0, 0),
	(419, 63, 109, '', 3, 0, 0),
	(420, 63, 109, '', 4, 0, 0),
	(421, 64, 110, 'NO', 0, 1, 1),
	(422, 64, 110, 'YES', 1, 0, 1),
	(423, 64, 111, '', 0, 0, 1),
	(424, 64, 111, '', 1, 0, 1),
	(425, 64, 111, '', 2, 0, 1),
	(426, 64, 111, '', 3, 0, 1),
	(427, 64, 111, '', 4, 0, 1),
	(428, 65, 112, 'NO', 0, 1, 1),
	(429, 65, 112, 'YES', 1, 0, 1),
	(430, 65, 113, '', 0, 0, 1),
	(431, 65, 113, '', 1, 0, 1),
	(432, 65, 113, '', 2, 0, 1),
	(433, 65, 113, '', 3, 0, 1),
	(434, 65, 113, '', 4, 0, 1),
	(435, 66, 114, 'NO', 0, 1, 1),
	(436, 66, 114, 'YES', 1, 0, 1),
	(437, 66, 115, '', 0, 0, 1),
	(438, 66, 115, '', 1, 0, 1),
	(439, 66, 115, '', 2, 0, 1),
	(440, 66, 115, '', 3, 0, 1),
	(441, 66, 115, '', 4, 0, 1),
	(444, 67, 117, '', 0, 0, 0),
	(445, 67, 117, '', 1, 0, 0),
	(446, 67, 117, '', 2, 0, 0),
	(447, 67, 117, '', 3, 0, 0),
	(448, 67, 117, '', 4, 0, 0),
	(449, 68, 118, 'NO', 0, 1, 1),
	(450, 68, 118, 'YES', 1, 0, 1),
	(451, 68, 119, '', 0, 0, 0),
	(452, 68, 119, '', 1, 0, 0),
	(453, 68, 119, '', 2, 0, 0),
	(454, 68, 119, '', 3, 0, 0),
	(455, 68, 119, '', 4, 0, 0),
	(456, 69, 120, 'NO', 0, 1, 1),
	(457, 69, 120, 'YES', 1, 0, 1),
	(458, 69, 121, '', 0, 0, 0),
	(459, 69, 121, '', 1, 0, 0),
	(460, 69, 121, '', 2, 0, 0),
	(461, 69, 121, '', 3, 0, 0),
	(462, 69, 121, '', 4, 0, 0),
	(463, 70, 122, 'NO', 0, 1, 1),
	(464, 70, 122, 'YES', 1, 0, 1),
	(465, 70, 123, '', 0, 0, 1),
	(466, 70, 123, '', 1, 0, 1),
	(467, 70, 123, '', 2, 0, 1),
	(468, 70, 123, '', 3, 0, 1),
	(469, 70, 123, '', 4, 0, 1),
	(470, 71, 124, 'NO', 0, 1, 1),
	(471, 71, 124, 'YES', 1, 0, 1),
	(472, 71, 125, '', 0, 0, 0),
	(473, 71, 125, '', 1, 0, 0),
	(474, 71, 125, '', 2, 0, 0),
	(475, 71, 125, '', 3, 0, 0),
	(476, 71, 125, '', 4, 0, 0),
	(477, 71, 125, 'NO', 0, 1, 1),
	(478, 71, 125, 'YES', 1, 0, 1),
	(479, 71, 126, '', 0, 0, 0),
	(480, 71, 126, '', 1, 0, 0),
	(481, 71, 126, '', 2, 0, 0),
	(482, 71, 126, '', 3, 0, 0),
	(483, 71, 126, '', 4, 0, 0),
	(484, 71, 126, 'NO', 0, 1, 1),
	(485, 71, 126, 'YES', 1, 0, 1),
	(486, 71, 127, '', 0, 0, 0),
	(487, 71, 127, '', 1, 0, 0),
	(488, 71, 127, '', 2, 0, 0),
	(489, 71, 127, '', 3, 0, 0),
	(490, 71, 127, '', 4, 0, 0),
	(491, 71, 127, 'NO', 0, 1, 1),
	(492, 71, 127, 'YES', 1, 0, 1),
	(493, 71, 128, '', 0, 0, 0),
	(494, 71, 128, '', 1, 0, 0),
	(495, 71, 128, '', 2, 0, 0),
	(496, 71, 128, '', 3, 0, 0),
	(497, 71, 128, '', 4, 0, 0),
	(498, 71, 128, 'NO', 0, 1, 1),
	(499, 71, 128, 'YES', 1, 0, 1),
	(500, 71, 129, '', 0, 0, 0),
	(501, 71, 129, '', 1, 0, 0),
	(502, 71, 129, '', 2, 0, 0),
	(503, 71, 129, '', 3, 0, 0),
	(504, 71, 129, '', 4, 0, 0),
	(507, 72, 131, 'NO', 0, 1, 1),
	(508, 72, 131, 'YES', 1, 0, 1),
	(509, 72, 131, '', 2, 0, 0),
	(510, 72, 131, '', 3, 0, 0),
	(511, 72, 131, '', 4, 0, 0),
	(512, 72, 132, '', 0, 0, 0),
	(513, 72, 132, '', 1, 0, 0),
	(514, 72, 132, '', 2, 0, 0),
	(515, 72, 132, '', 3, 0, 0),
	(516, 72, 132, '', 4, 0, 0),
	(517, 72, 132, 'NO', 0, 1, 1),
	(518, 72, 132, 'YES', 1, 0, 1),
	(519, 72, 133, 'NO', 0, 1, 1),
	(520, 72, 133, 'YES', 1, 0, 1),
	(521, 72, 133, '', 2, 0, 0),
	(522, 72, 133, '', 3, 0, 0),
	(523, 72, 133, '', 4, 0, 0),
	(524, 72, 134, '', 0, 0, 0),
	(525, 72, 134, '', 1, 0, 0),
	(526, 72, 134, '', 2, 0, 0),
	(527, 72, 134, '', 3, 0, 0),
	(528, 72, 134, '', 4, 0, 0),
	(529, 72, 134, 'NO', 0, 1, 1),
	(530, 72, 134, 'YES', 1, 0, 1),
	(531, 72, 135, 'NO', 0, 1, 1),
	(532, 72, 135, 'YES', 1, 0, 1),
	(533, 72, 135, '', 2, 0, 0),
	(534, 72, 135, '', 3, 0, 0),
	(535, 72, 135, '', 4, 0, 0),
	(536, 72, 136, '', 0, 0, 0),
	(537, 72, 136, '', 1, 0, 0),
	(538, 72, 136, '', 2, 0, 0),
	(539, 72, 136, '', 3, 0, 0),
	(540, 72, 136, '', 4, 0, 0),
	(541, 72, 136, 'NO', 0, 1, 1),
	(542, 72, 136, 'YES', 1, 0, 1),
	(543, 72, 137, '', 0, 0, 0),
	(544, 72, 137, '', 1, 0, 0),
	(545, 72, 137, '', 2, 0, 0),
	(546, 72, 137, '', 3, 0, 0),
	(547, 72, 137, '', 4, 0, 0),
	(548, 72, 137, 'NO', 0, 1, 1),
	(549, 72, 137, 'YES', 1, 0, 1),
	(550, 72, 138, '', 0, 0, 0),
	(551, 72, 138, '', 1, 0, 0),
	(552, 72, 138, '', 2, 0, 0),
	(553, 72, 138, '', 3, 0, 0),
	(554, 72, 138, '', 4, 0, 0),
	(555, 72, 138, 'NO', 0, 1, 1),
	(556, 72, 138, 'YES', 1, 0, 1),
	(557, 72, 139, 'NO', 0, 1, 1),
	(558, 72, 139, 'YES', 1, 0, 1),
	(559, 72, 139, '', 2, 0, 0),
	(560, 72, 139, '', 3, 0, 0),
	(561, 72, 139, '', 4, 0, 0),
	(569, 72, 141, 'NO', 0, 1, 1),
	(570, 72, 141, 'YES', 1, 0, 1),
	(571, 72, 141, '', 2, 0, 0),
	(572, 72, 141, '', 3, 0, 0),
	(573, 72, 141, '', 4, 0, 0),
	(574, 72, 142, '', 0, 0, 0),
	(575, 72, 142, '', 1, 0, 0),
	(576, 72, 142, '', 2, 0, 0),
	(577, 72, 142, '', 3, 0, 0),
	(578, 72, 142, '', 4, 0, 0),
	(579, 73, 143, 'NO', 0, 1, 1),
	(580, 73, 143, 'YES', 1, 0, 1),
	(586, 73, 145, '', 0, 0, 0),
	(587, 73, 145, '', 1, 0, 0),
	(588, 73, 145, '', 2, 0, 0),
	(589, 73, 145, '', 3, 0, 0),
	(590, 73, 145, '', 4, 0, 0),
	(616, 75, 153, 'NO', 0, 1, 1),
	(617, 75, 153, 'YES', 1, 0, 1),
	(623, 75, 155, '', 0, 0, 0),
	(624, 75, 155, '', 1, 0, 0),
	(625, 75, 155, '', 2, 0, 0),
	(626, 75, 155, '', 3, 0, 0),
	(627, 75, 155, '', 4, 0, 0),
	(634, 76, 158, '', 0, 0, 0),
	(635, 76, 158, '', 1, 0, 0),
	(636, 76, 158, '', 2, 0, 0),
	(637, 76, 158, '', 3, 0, 0),
	(638, 76, 158, '', 4, 0, 0),
	(639, 76, 158, 'NO', 0, 1, 1),
	(640, 76, 159, '', 0, 0, 1),
	(641, 76, 159, '', 1, 0, 1),
	(642, 76, 159, '', 2, 0, 1),
	(643, 76, 159, '', 3, 0, 1),
	(644, 76, 159, '', 4, 0, 1),
	(669, 77, 165, '', 0, 0, 0),
	(670, 77, 165, '', 1, 0, 0),
	(671, 77, 165, '', 2, 0, 0),
	(672, 77, 165, '', 3, 0, 0),
	(673, 77, 165, '', 4, 0, 0),
	(674, 77, 165, 'NO', 0, 1, 1),
	(675, 77, 165, 'YES', 1, 0, 1),
	(676, 77, 166, '', 0, 0, 0),
	(677, 77, 166, '', 1, 0, 0),
	(678, 77, 166, '', 2, 0, 0),
	(679, 77, 166, '', 3, 0, 0),
	(680, 77, 166, '', 4, 0, 0),
	(681, 77, 166, 'NO', 0, 1, 1),
	(682, 77, 166, 'YES', 1, 0, 1),
	(688, 78, 168, 'NO', 0, 1, 1),
	(689, 78, 168, 'YES', 1, 0, 1),
	(690, 78, 169, 'NO', 0, 1, 1),
	(691, 78, 169, 'YES', 1, 0, 1),
	(692, 78, 169, '', 2, 0, 0),
	(693, 78, 169, '', 3, 0, 0),
	(694, 78, 169, '', 4, 0, 0),
	(695, 78, 170, 'NO', 0, 1, 1),
	(696, 78, 170, 'YES', 1, 0, 1),
	(697, 78, 170, '', 2, 0, 0),
	(698, 78, 170, '', 3, 0, 0),
	(699, 78, 170, '', 4, 0, 0),
	(700, 78, 171, 'NO', 0, 1, 1),
	(701, 78, 171, 'YES', 1, 0, 1),
	(702, 78, 171, '', 2, 0, 0),
	(703, 78, 171, '', 3, 0, 0),
	(704, 78, 171, '', 4, 0, 0),
	(705, 78, 172, '', 0, 0, 0),
	(706, 78, 172, '', 1, 0, 0),
	(707, 78, 172, '', 2, 0, 0),
	(708, 78, 172, '', 3, 0, 0),
	(709, 78, 172, '', 4, 0, 0),
	(710, 78, 173, '', 0, 0, 0),
	(711, 78, 173, '', 1, 0, 0),
	(712, 78, 173, '', 2, 0, 0),
	(713, 78, 173, '', 3, 0, 0),
	(714, 78, 173, '', 4, 0, 0),
	(715, 78, 173, 'NO', 0, 1, 1),
	(716, 78, 173, 'YES', 1, 0, 1),
	(717, 79, 175, 'NO', 0, 1, 1),
	(718, 79, 175, 'YES', 1, 0, 1),
	(719, 79, 175, '', 2, 0, 0),
	(720, 79, 175, '', 3, 0, 0),
	(721, 79, 175, '', 4, 0, 0),
	(722, 79, 176, '', 0, 0, 0),
	(723, 79, 176, '', 1, 0, 0),
	(724, 79, 176, '', 2, 0, 0),
	(725, 79, 176, '', 3, 0, 0),
	(726, 79, 176, '', 4, 0, 0),
	(727, 80, 177, 'NO', 0, 1, 1),
	(728, 80, 177, 'YES', 1, 0, 1),
	(729, 80, 178, 'NO', 0, 0, 1),
	(730, 80, 178, 'YES', 1, 1, 1),
	(731, 80, 178, '', 2, 0, 0),
	(732, 80, 178, '', 3, 0, 0),
	(733, 80, 178, '', 4, 0, 0),
	(739, 80, 180, '', 0, 0, 0),
	(740, 80, 180, '', 1, 0, 0),
	(741, 80, 180, '', 2, 0, 0),
	(742, 80, 180, '', 3, 0, 0),
	(743, 80, 180, '', 4, 0, 0),
	(744, 80, 181, 'NO', 0, 1, 1),
	(745, 80, 181, '', 1, 0, 0),
	(746, 80, 181, '', 2, 0, 0),
	(747, 80, 181, '', 3, 0, 0),
	(748, 80, 181, '', 4, 0, 0),
	(749, 80, 182, '', 0, 0, 0),
	(750, 80, 182, '', 1, 0, 0),
	(751, 80, 182, '', 2, 0, 0),
	(752, 80, 182, '', 3, 0, 0),
	(753, 80, 182, '', 4, 0, 0),
	(754, 80, 180, 'Dhaka', 0, 1, 1),
	(755, 80, 182, 'NO', 0, 1, 1),
	(756, 80, 182, 'YES', 1, 0, 1),
	(757, 81, 183, 'NO', 0, 1, 1),
	(758, 81, 183, 'YES', 1, 0, 1),
	(764, 81, 185, 'NO', 0, 1, 1),
	(765, 81, 185, 'YES', 1, 0, 1),
	(766, 81, 185, '', 2, 0, 0),
	(767, 81, 185, '', 3, 0, 0),
	(768, 81, 185, '', 4, 0, 0),
	(769, 81, 186, 'NO', 0, 1, 1),
	(770, 81, 186, '', 1, 0, 0),
	(771, 81, 186, '', 2, 0, 0),
	(772, 81, 186, '', 3, 0, 0),
	(773, 81, 186, '', 4, 0, 0),
	(774, 81, 187, 'NO', 0, 1, 1),
	(775, 81, 187, 'YES', 1, 0, 1),
	(776, 81, 187, '', 2, 0, 0),
	(777, 81, 187, '', 3, 0, 0),
	(778, 81, 187, '', 4, 0, 0);
/*!40000 ALTER TABLE `tbl_quiz_query_selection` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_target_access_restriction
CREATE TABLE IF NOT EXISTS `tbl_quiz_target_access_restriction` (
  `quiz_target_id` int(10) unsigned NOT NULL COMMENT 'ターゲットナンバー',
  `quiz_id` int(10) unsigned NOT NULL COMMENT 'テストナンバー',
  `grade_id` int(10) unsigned DEFAULT NULL COMMENT '対象の学年',
  `classroom_id` int(10) unsigned DEFAULT NULL COMMENT '対象のクラス',
  `course_id` int(10) unsigned DEFAULT NULL COMMENT '対象のコース',
  PRIMARY KEY (`quiz_target_id`),
  KEY `grade_id` (`grade_id`),
  KEY `classroom_id` (`classroom_id`),
  KEY `course_id` (`course_id`),
  KEY `cbt_id_UNIQUE` (`quiz_id`),
  CONSTRAINT `tbl_quiz_target_access_restriction_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `tbl_quiz` (`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='テストの対象ユーザー';

-- Dumping data for table kaizen.tbl_quiz_target_access_restriction: ~0 rows (approximately)
DELETE FROM `tbl_quiz_target_access_restriction`;
/*!40000 ALTER TABLE `tbl_quiz_target_access_restriction` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_target_access_restriction` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_target_range_common
CREATE TABLE IF NOT EXISTS `tbl_quiz_target_range_common` (
  `common_target_range_id` int(10) unsigned NOT NULL,
  `quiz_id` int(10) unsigned NOT NULL,
  `contents_category_id` tinyint(4) unsigned NOT NULL,
  `common_subject_id` int(10) unsigned NOT NULL,
  `common_subject_section_id` int(10) unsigned DEFAULT NULL,
  `common_contents_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`common_target_range_id`),
  KEY `quiz_id` (`quiz_id`),
  KEY `contents_category_id` (`contents_category_id`),
  KEY `subject_id` (`common_subject_id`),
  KEY `subject_section_id` (`common_subject_section_id`),
  KEY `contents_id` (`common_contents_id`),
  CONSTRAINT `tbl_quiz_target_range_common_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `tbl_quiz` (`quiz_id`),
  CONSTRAINT `tbl_quiz_target_range_common_ibfk_2` FOREIGN KEY (`contents_category_id`) REFERENCES `mst_contents_category` (`contents_category_id`),
  CONSTRAINT `tbl_quiz_target_range_common_ibfk_3` FOREIGN KEY (`common_subject_id`) REFERENCES `tbl_common_subject_bk` (`common_subject_id`),
  CONSTRAINT `tbl_quiz_target_range_common_ibfk_4` FOREIGN KEY (`common_subject_section_id`) REFERENCES `tbl_common_subject_section_bk` (`common_subject_section_id`),
  CONSTRAINT `tbl_quiz_target_range_common_ibfk_5` FOREIGN KEY (`common_contents_id`) REFERENCES `tbl_common_contents_bk` (`common_contents_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_quiz_target_range_common: ~0 rows (approximately)
DELETE FROM `tbl_quiz_target_range_common`;
/*!40000 ALTER TABLE `tbl_quiz_target_range_common` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_target_range_common` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_quiz_target_range_school
CREATE TABLE IF NOT EXISTS `tbl_quiz_target_range_school` (
  `school_target_range_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` int(10) unsigned NOT NULL,
  `contents_category_id` tinyint(4) unsigned NOT NULL,
  `subject_genre_id` int(10) unsigned NOT NULL,
  `subject_section_id` int(10) unsigned DEFAULT NULL,
  `school_contents_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`school_target_range_id`),
  KEY `quiz_id` (`quiz_id`),
  KEY `contents_category_id` (`contents_category_id`),
  KEY `subject_id` (`subject_genre_id`),
  KEY `subject_section_id` (`subject_section_id`),
  KEY `school_contents_id` (`school_contents_id`),
  CONSTRAINT `tbl_quiz_target_range_school_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `tbl_quiz` (`quiz_id`),
  CONSTRAINT `tbl_quiz_target_range_school_ibfk_2` FOREIGN KEY (`contents_category_id`) REFERENCES `mst_contents_category` (`contents_category_id`),
  CONSTRAINT `tbl_quiz_target_range_school_ibfk_3` FOREIGN KEY (`subject_genre_id`) REFERENCES `tbl_subject_genre` (`subject_genre_id`),
  CONSTRAINT `tbl_quiz_target_range_school_ibfk_4` FOREIGN KEY (`subject_section_id`) REFERENCES `tbl_subject_section` (`subject_section_id`),
  CONSTRAINT `tbl_quiz_target_range_school_ibfk_5` FOREIGN KEY (`school_contents_id`) REFERENCES `tbl_school_contents_bk` (`school_contents_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_quiz_target_range_school: ~0 rows (approximately)
DELETE FROM `tbl_quiz_target_range_school`;
/*!40000 ALTER TABLE `tbl_quiz_target_range_school` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_quiz_target_range_school` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_school
CREATE TABLE IF NOT EXISTS `tbl_school` (
  `school_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `call_sign` char(3) COLLATE utf8_bin NOT NULL,
  `max_id_of_admin` int(10) unsigned NOT NULL DEFAULT 0,
  `max_id_of_teacher` int(10) unsigned NOT NULL DEFAULT 0,
  `max_id_of_student` int(10) unsigned NOT NULL DEFAULT 0,
  `max_school_contents_total_giga_byte` bigint(20) unsigned NOT NULL DEFAULT 0,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`school_id`),
  UNIQUE KEY `call_sign` (`call_sign`),
  UNIQUE KEY `display_order` (`display_order`),
  KEY `enable` (`enable`),
  CONSTRAINT `tbl_school_ibfk_1` FOREIGN KEY (`enable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_school_ibfk_2` FOREIGN KEY (`display_order`) REFERENCES `tbl_school` (`school_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_school: ~0 rows (approximately)
DELETE FROM `tbl_school`;
/*!40000 ALTER TABLE `tbl_school` DISABLE KEYS */;
INSERT INTO `tbl_school` (`school_id`, `school_name`, `call_sign`, `max_id_of_admin`, `max_id_of_teacher`, `max_id_of_student`, `max_school_contents_total_giga_byte`, `enable`, `display_order`) VALUES
	(1, 'kaizen', 'kai', 10, 30, 1000, 0, 1, 1);
/*!40000 ALTER TABLE `tbl_school` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_school_access_restriction_bk
CREATE TABLE IF NOT EXISTS `tbl_school_access_restriction_bk` (
  `school_access_restriction_id` int(10) unsigned NOT NULL,
  `subject_section_id` int(10) unsigned NOT NULL,
  `grade_enable` tinyint(3) unsigned NOT NULL,
  `classroom_enable` tinyint(3) unsigned NOT NULL,
  `course_enable` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`school_access_restriction_id`),
  KEY `subject_section_id` (`subject_section_id`),
  KEY `grade_enable` (`grade_enable`),
  KEY `classroom_enable` (`classroom_enable`),
  KEY `course_enable` (`course_enable`),
  CONSTRAINT `tbl_school_access_restriction_bk_ibfk_1` FOREIGN KEY (`subject_section_id`) REFERENCES `tbl_subject_section` (`subject_section_id`),
  CONSTRAINT `tbl_school_access_restriction_bk_ibfk_2` FOREIGN KEY (`grade_enable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_school_access_restriction_bk_ibfk_3` FOREIGN KEY (`classroom_enable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_school_access_restriction_bk_ibfk_4` FOREIGN KEY (`course_enable`) REFERENCES `mst_boolean` (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_school_access_restriction_bk: ~0 rows (approximately)
DELETE FROM `tbl_school_access_restriction_bk`;
/*!40000 ALTER TABLE `tbl_school_access_restriction_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_school_access_restriction_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_school_access_restriction_classroom_bk
CREATE TABLE IF NOT EXISTS `tbl_school_access_restriction_classroom_bk` (
  `school_access_restriction_id` int(10) unsigned NOT NULL,
  `classroom_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`school_access_restriction_id`,`classroom_id`),
  KEY `classroom_id` (`classroom_id`),
  CONSTRAINT `tbl_school_access_restriction_classroom_bk_ibfk_1` FOREIGN KEY (`school_access_restriction_id`) REFERENCES `tbl_school_access_restriction_bk` (`school_access_restriction_id`),
  CONSTRAINT `tbl_school_access_restriction_classroom_bk_ibfk_2` FOREIGN KEY (`classroom_id`) REFERENCES `tbl_classroom` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_school_access_restriction_classroom_bk: ~0 rows (approximately)
DELETE FROM `tbl_school_access_restriction_classroom_bk`;
/*!40000 ALTER TABLE `tbl_school_access_restriction_classroom_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_school_access_restriction_classroom_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_school_access_restriction_course_bk
CREATE TABLE IF NOT EXISTS `tbl_school_access_restriction_course_bk` (
  `school_access_restriction_id` int(10) unsigned NOT NULL,
  `course_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`school_access_restriction_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `tbl_school_access_restriction_course_bk_ibfk_1` FOREIGN KEY (`school_access_restriction_id`) REFERENCES `tbl_school_access_restriction_bk` (`school_access_restriction_id`),
  CONSTRAINT `tbl_school_access_restriction_course_bk_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `tbl_course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_school_access_restriction_course_bk: ~0 rows (approximately)
DELETE FROM `tbl_school_access_restriction_course_bk`;
/*!40000 ALTER TABLE `tbl_school_access_restriction_course_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_school_access_restriction_course_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_school_access_restriction_grade_bk
CREATE TABLE IF NOT EXISTS `tbl_school_access_restriction_grade_bk` (
  `school_access_restriction_id` int(10) unsigned NOT NULL,
  `grade_id` int(10) unsigned NOT NULL,
  `subsection_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`school_access_restriction_id`,`grade_id`),
  KEY `grade_id` (`grade_id`),
  CONSTRAINT `tbl_school_access_restriction_grade_bk_ibfk_1` FOREIGN KEY (`school_access_restriction_id`) REFERENCES `tbl_school_access_restriction_bk` (`school_access_restriction_id`),
  CONSTRAINT `tbl_school_access_restriction_grade_bk_ibfk_2` FOREIGN KEY (`grade_id`) REFERENCES `tbl_grade` (`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_school_access_restriction_grade_bk: ~0 rows (approximately)
DELETE FROM `tbl_school_access_restriction_grade_bk`;
/*!40000 ALTER TABLE `tbl_school_access_restriction_grade_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_school_access_restriction_grade_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_school_contents_bk
CREATE TABLE IF NOT EXISTS `tbl_school_contents_bk` (
  `school_contents_id` int(10) unsigned NOT NULL,
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `subject_section_id` int(10) unsigned NOT NULL,
  `school_contents_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `comment` varchar(255) COLLATE utf8_bin NOT NULL,
  `first_day` date DEFAULT NULL,
  `last_day` date DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `user_level_id` int(10) unsigned DEFAULT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `contents_extension_id` tinyint(3) unsigned NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`school_contents_id`),
  UNIQUE KEY `display_order` (`display_order`),
  KEY `subject_section_id` (`subject_section_id`),
  KEY `contents_extension_id` (`contents_extension_id`),
  KEY `enable` (`enable`),
  KEY `registered_person_id` (`teacher_id`),
  KEY `FK_tbl_school_contents_mst_contents_category` (`contents_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_school_contents_bk: ~0 rows (approximately)
DELETE FROM `tbl_school_contents_bk`;
/*!40000 ALTER TABLE `tbl_school_contents_bk` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_school_contents_bk` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_student
CREATE TABLE IF NOT EXISTS `tbl_student` (
  `student_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` int(10) unsigned NOT NULL,
  `student_code` varchar(255) COLLATE utf8_bin NOT NULL,
  `student_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `joining` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `access_code` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `access_datetime` datetime DEFAULT NULL,
  `bit_subject` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `enable` tinyint(3) unsigned NOT NULL,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_student: ~6 rows (approximately)
DELETE FROM `tbl_student`;
/*!40000 ALTER TABLE `tbl_student` DISABLE KEYS */;
INSERT INTO `tbl_student` (`student_id`, `school_id`, `student_code`, `student_name`, `joining`, `id`, `password`, `access_code`, `access_datetime`, `bit_subject`, `enable`, `display_order`) VALUES
	(1, 1, '', 'kjsstudent1', 1, '8Cvpri/8lP0gwIq0rLiqFDFQV+13ItR/I2TBdnzKmek=', 'txB+mTpwwVqH3ASXoVzra0b8ZhZQ5NsUSER69tvfrPc=', NULL, '2019-12-11 11:05:35', '7', 1, 1),
	(2, 1, '', 'kjsstudent2', 1, '8Cvpri/8lP0gwIq0rLiqFI2/mkIyGyIkn3tVEL29phI=', '7Icwcme19gnrBoh7Y/nyNEb8ZhZQ5NsUSER69tvfrPc=', NULL, '2019-12-03 08:17:26', '7', 1, 2),
	(3, 1, '', 'Tanjilur', 1, '8Cvpri/8lP0gwIq0rLiqFCB9BQCx9HX/VNcm2jajybA=', 'KvWb4QidsY2wqQWFsQv32Ub8ZhZQ5NsUSER69tvfrPc=', NULL, NULL, '3', 0, 3),
	(4, 1, '', 'tanjil', 1, '6UrhpgRDpjImCpCYftOuVA==', 'Z4QMwSaA9+u8Qo3lkhn9oQ==', NULL, '2019-12-20 10:00:45', '3', 1, 4),
	(5, 1, '', 'Arivu San', 1, 'AbXudj4U4Q814T6bzwflKw==', 'zEoUXDB1JLm73VLobfmYhQ==', NULL, '2019-12-03 09:10:07', '3', 0, 5),
	(6, 1, '', 'Arivu', 1, '3FPyp8C2Wspjy6kiQxBdBA==', 'HeCF1kPeJCRpL6zhsMaLFg==', NULL, NULL, '3', 1, 6);
/*!40000 ALTER TABLE `tbl_student` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_student_classroom
CREATE TABLE IF NOT EXISTS `tbl_student_classroom` (
  `student_id` int(10) unsigned NOT NULL DEFAULT 0,
  `classroom_id` int(10) unsigned NOT NULL DEFAULT 0,
  KEY `student_id` (`student_id`),
  KEY `classroom_id` (`classroom_id`),
  CONSTRAINT `FK_tbl_student_classroom_tbl_classroom` FOREIGN KEY (`classroom_id`) REFERENCES `tbl_classroom` (`classroom_id`),
  CONSTRAINT `FK_tbl_student_classroom_tbl_student` FOREIGN KEY (`student_id`) REFERENCES `tbl_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_student_classroom: ~0 rows (approximately)
DELETE FROM `tbl_student_classroom`;
/*!40000 ALTER TABLE `tbl_student_classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_student_classroom` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_student_course
CREATE TABLE IF NOT EXISTS `tbl_student_course` (
  `student_id` int(10) unsigned NOT NULL DEFAULT 0,
  `course_id` int(10) unsigned NOT NULL DEFAULT 0,
  KEY `student_id` (`student_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `FK_tbl_sutudent_course_tbl_course` FOREIGN KEY (`course_id`) REFERENCES `tbl_course` (`course_id`),
  CONSTRAINT `FK_tbl_sutudent_course_tbl_student` FOREIGN KEY (`student_id`) REFERENCES `tbl_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_student_course: ~0 rows (approximately)
DELETE FROM `tbl_student_course`;
/*!40000 ALTER TABLE `tbl_student_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_student_course` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_student_grade
CREATE TABLE IF NOT EXISTS `tbl_student_grade` (
  `student_id` int(10) unsigned NOT NULL DEFAULT 0,
  `grade_id` int(10) unsigned NOT NULL DEFAULT 0,
  KEY `FK_tbl_student_grade_tbl_student` (`student_id`),
  KEY `FK_tbl_student_grade_tbl_grade` (`grade_id`),
  CONSTRAINT `FK_tbl_student_grade_tbl_grade` FOREIGN KEY (`grade_id`) REFERENCES `tbl_grade` (`grade_id`),
  CONSTRAINT `FK_tbl_student_grade_tbl_student` FOREIGN KEY (`student_id`) REFERENCES `tbl_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_student_grade: ~0 rows (approximately)
DELETE FROM `tbl_student_grade`;
/*!40000 ALTER TABLE `tbl_student_grade` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_student_grade` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_subject_genre
CREATE TABLE IF NOT EXISTS `tbl_subject_genre` (
  `subject_genre_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject_group_id` int(10) unsigned NOT NULL,
  `subject_genre_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '有効フラグ',
  `display_order` int(10) unsigned NOT NULL COMMENT '表示順',
  PRIMARY KEY (`subject_genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_subject_genre: ~0 rows (approximately)
DELETE FROM `tbl_subject_genre`;
/*!40000 ALTER TABLE `tbl_subject_genre` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_subject_genre` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_subject_group
CREATE TABLE IF NOT EXISTS `tbl_subject_group` (
  `subject_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '講座グループ',
  `subject_group_name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '講座グループ名',
  `school_id` int(10) unsigned NOT NULL DEFAULT 0 COMMENT 'スクールNo',
  `contents_category_id` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT 'コンテンツの種類',
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '有効フラグ',
  `display_order` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '表示順',
  PRIMARY KEY (`subject_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='講座グループテーブル';

-- Dumping data for table kaizen.tbl_subject_group: ~0 rows (approximately)
DELETE FROM `tbl_subject_group`;
/*!40000 ALTER TABLE `tbl_subject_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_subject_group` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_subject_section
CREATE TABLE IF NOT EXISTS `tbl_subject_section` (
  `subject_section_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject_section_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `subject_genre_id` int(10) unsigned NOT NULL,
  `subject_group_id` int(10) unsigned NOT NULL,
  `proportion` int(10) unsigned NOT NULL DEFAULT 50,
  `editable` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `enable` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '有効フラグ',
  `display_order` int(10) unsigned NOT NULL DEFAULT 1 COMMENT '表示順',
  PRIMARY KEY (`subject_section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='講義';

-- Dumping data for table kaizen.tbl_subject_section: ~0 rows (approximately)
DELETE FROM `tbl_subject_section`;
/*!40000 ALTER TABLE `tbl_subject_section` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_subject_section` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_teacher
CREATE TABLE IF NOT EXISTS `tbl_teacher` (
  `teacher_id` int(10) unsigned NOT NULL,
  `school_id` int(10) unsigned NOT NULL,
  `teacher_code` varchar(255) COLLATE utf8_bin NOT NULL,
  `classroom_id` int(10) unsigned DEFAULT NULL,
  `teacher_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `id` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '2015/03/10変更　NULLをYES　デフォルト値をNULL',
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `editable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `history_viewing_authority` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `student_edit_authority` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `access_code` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `access_datetime` datetime DEFAULT NULL,
  `enable` tinyint(3) unsigned NOT NULL,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `vertical index` (`display_order`),
  KEY `school_id` (`school_id`),
  KEY `classroom_id` (`classroom_id`),
  KEY `enable` (`enable`),
  KEY `editable` (`editable`),
  KEY `history_viewing_authority` (`history_viewing_authority`),
  KEY `student_edit_authority` (`student_edit_authority`),
  CONSTRAINT `tbl_teacher_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `tbl_school` (`school_id`),
  CONSTRAINT `tbl_teacher_ibfk_2` FOREIGN KEY (`classroom_id`) REFERENCES `tbl_classroom` (`classroom_id`),
  CONSTRAINT `tbl_teacher_ibfk_3` FOREIGN KEY (`enable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_teacher_ibfk_4` FOREIGN KEY (`display_order`) REFERENCES `tbl_teacher` (`teacher_id`),
  CONSTRAINT `tbl_teacher_ibfk_5` FOREIGN KEY (`editable`) REFERENCES `mst_boolean` (`boolean_id`),
  CONSTRAINT `tbl_teacher_ibfk_6` FOREIGN KEY (`history_viewing_authority`) REFERENCES `mst_boolean` (`boolean_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table kaizen.tbl_teacher: ~0 rows (approximately)
DELETE FROM `tbl_teacher`;
/*!40000 ALTER TABLE `tbl_teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_teacher` ENABLE KEYS */;

-- Dumping structure for table kaizen.tbl_testing
CREATE TABLE IF NOT EXISTS `tbl_testing` (
  `quiz_id` int(11) DEFAULT NULL,
  `query_id` int(11) DEFAULT NULL,
  `contents_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_testing: ~2 rows (approximately)
DELETE FROM `tbl_testing`;
/*!40000 ALTER TABLE `tbl_testing` DISABLE KEYS */;
INSERT INTO `tbl_testing` (`quiz_id`, `query_id`, `contents_id`) VALUES
	(82, 120, 31),
	(82, 120, 31);
/*!40000 ALTER TABLE `tbl_testing` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
