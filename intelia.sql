-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.12 - MySQL Community Server - GPL
-- SO del servidor:              Linux
-- HeidiSQL Versión:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para intelia
CREATE DATABASE IF NOT EXISTS `intelia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `intelia`;

-- Volcando estructura para tabla intelia.doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla intelia.doctrine_migration_versions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20240619115017', '2024-06-19 13:50:35', 364);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;

-- Volcando estructura para tabla intelia.image
CREATE TABLE IF NOT EXISTS `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C53D045FA76ED395` (`user_id`),
  CONSTRAINT `FK_C53D045FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla intelia.image: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` (`id`, `user_id`, `file_name`, `status`, `created_at`, `modified_at`) VALUES
	(1, 1, 'aplicacionregistrohora-6673de5b73545.png', 'Pending', '2024-06-20 09:46:35', NULL),
	(2, 1, 'capturadepantalla20240115154252-6673decad7bbb.png', 'Pending', '2024-06-20 09:48:26', NULL),
	(3, 1, 'modal-66740de033254.png', 'Pending', '2024-06-20 13:09:20', NULL),
	(4, 1, 'modal-66740e5e653f4.png', 'Pending', '2024-06-20 13:11:26', NULL),
	(5, 1, 'modal-66740ebf2317c.png', 'Completed', '2024-06-20 13:13:03', '2024-06-20 13:13:07'),
	(6, 1, 'capturadepantalla20240115154252-6674102eaabad.png', 'Completed', '2024-06-20 13:19:10', '2024-06-20 13:19:11'),
	(7, 1, 'capturadepantalla20240115154252-667428730bc53.png', 'Pending', '2024-06-20 15:02:43', NULL),
	(8, 1, 'aplicacionregistrohora-6675524ae6b1d.png', 'Pending', '2024-06-21 12:13:30', NULL),
	(9, 1, 'modal-667552c829737.png', 'Pending', '2024-06-21 12:15:36', NULL),
	(10, 1, 'modal-667552d530d55.png', 'Pending', '2024-06-21 12:15:49', NULL),
	(11, 1, 'modal-667552f82d7cc.png', 'Pending', '2024-06-21 12:16:24', NULL),
	(12, 1, 'capturadepantalla20240115154252-6675530e6e920.png', 'Pending', '2024-06-21 12:16:46', NULL),
	(13, 1, 'capturadepantalla20240115154252-667553554d0da.png', 'Pending', '2024-06-21 12:17:57', NULL),
	(14, 1, 'aplicacionregistrohora-667554280d513.png', 'Pending', '2024-06-21 12:21:28', NULL);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;

-- Volcando estructura para tabla intelia.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla intelia.user: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `email`, `roles`, `password`, `created_at`) VALUES
	(1, 'pruebas@gmail.com', '["ROLE_USER"]', '$2y$13$KbPoGf1AHrx9O03KF9KS/.Ut36o8rQxzmF7mioHpst6XWdEdNaz1O', '2024-06-19 16:42:12'),
	(3, 'jaime@gmail.com', '["ROLE_USER"]', '$2y$13$CJeNSD2UgBhqftgUSxPyvOQZTlVI9OcDokzlLsKFc3HOnCRHqDVe2', '2024-06-19 17:00:26');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
