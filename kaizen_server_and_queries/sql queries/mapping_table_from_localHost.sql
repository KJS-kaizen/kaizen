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

-- Dumping structure for table kaizen.tbl_quiz_contents_mapping
CREATE TABLE IF NOT EXISTS `tbl_quiz_contents_mapping` (
  `quiz_id` int(11) NOT NULL,
  `query_id` int(11) NOT NULL,
  `contents_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table kaizen.tbl_quiz_contents_mapping: ~36 rows (approximately)
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
	(33, 48, 67),
	(88, 198, 25),
	(88, 198, 26),
	(88, 200, 41),
	(96, 211, 39),
	(96, 210, 25),
	(96, 210, 26),
	(96, 210, 34);
/*!40000 ALTER TABLE `tbl_quiz_contents_mapping` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
