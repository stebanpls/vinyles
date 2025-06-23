-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.8.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7069
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para vinyles_local
CREATE DATABASE IF NOT EXISTS `vinyles_local` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `vinyles_local`;

-- Volcando estructura para tabla vinyles_local.artistas
DROP TABLE IF EXISTS `artistas`;
CREATE TABLE IF NOT EXISTS `artistas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `informacion` longtext NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.artistas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.auth_group
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_group: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.auth_group_permissions
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_group_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.auth_permission
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_permission: ~96 rows (aproximadamente)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(25, 'Can add crud', 7, 'add_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(26, 'Can change crud', 7, 'change_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(27, 'Can delete crud', 7, 'delete_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(28, 'Can view crud', 7, 'view_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(29, 'Can add cliente profile', 8, 'add_clienteprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(30, 'Can change cliente profile', 8, 'change_clienteprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(31, 'Can delete cliente profile', 8, 'delete_clienteprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(32, 'Can view cliente profile', 8, 'view_clienteprofile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(33, 'Can add Género', 9, 'add_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(34, 'Can change Género', 9, 'change_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(35, 'Can delete Género', 9, 'delete_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(36, 'Can view Género', 9, 'view_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(37, 'Can add Cliente', 10, 'add_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(38, 'Can change Cliente', 10, 'change_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(39, 'Can delete Cliente', 10, 'delete_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(40, 'Can view Cliente', 10, 'view_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(41, 'Can add Canción', 11, 'add_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(42, 'Can change Canción', 11, 'change_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(43, 'Can delete Canción', 11, 'delete_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(44, 'Can view Canción', 11, 'view_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(45, 'Can add Productor', 12, 'add_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(46, 'Can change Productor', 12, 'change_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(47, 'Can delete Productor', 12, 'delete_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(48, 'Can view Productor', 12, 'view_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(49, 'Can add Pedido', 13, 'add_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(50, 'Can change Pedido', 13, 'change_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(51, 'Can delete Pedido', 13, 'delete_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(52, 'Can view Pedido', 13, 'view_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(53, 'Can add País', 14, 'add_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(54, 'Can change País', 14, 'change_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(55, 'Can delete País', 14, 'delete_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(56, 'Can view País', 14, 'view_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(57, 'Can add Ciudad', 15, 'add_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(58, 'Can change Ciudad', 15, 'change_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(59, 'Can delete Ciudad', 15, 'delete_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(60, 'Can view Ciudad', 15, 'view_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(61, 'Can add Canción en Producto', 16, 'add_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(62, 'Can change Canción en Producto', 16, 'change_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(63, 'Can delete Canción en Producto', 16, 'delete_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(64, 'Can view Canción en Producto', 16, 'view_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(65, 'Can add Artista', 17, 'add_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(66, 'Can change Artista', 17, 'change_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(67, 'Can delete Artista', 17, 'delete_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(68, 'Can view Artista', 17, 'view_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(69, 'Can add Departamento', 18, 'add_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(70, 'Can change Departamento', 18, 'change_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(71, 'Can delete Departamento', 18, 'delete_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(72, 'Can view Departamento', 18, 'view_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(73, 'Can add Ticket de Soporte', 19, 'add_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(74, 'Can change Ticket de Soporte', 19, 'change_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(75, 'Can delete Ticket de Soporte', 19, 'delete_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(76, 'Can view Ticket de Soporte', 19, 'view_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(77, 'Can add Medio de Pago', 20, 'add_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(78, 'Can change Medio de Pago', 20, 'change_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(79, 'Can delete Medio de Pago', 20, 'delete_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(80, 'Can view Medio de Pago', 20, 'view_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(81, 'Can add Producto (Vinilo/Álbum)', 21, 'add_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(82, 'Can change Producto (Vinilo/Álbum)', 21, 'change_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(83, 'Can delete Producto (Vinilo/Álbum)', 21, 'delete_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(84, 'Can view Producto (Vinilo/Álbum)', 21, 'view_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(85, 'Can add Producto del Pedido', 22, 'add_pedidoproducto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(86, 'Can change Producto del Pedido', 22, 'change_pedidoproducto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(87, 'Can delete Producto del Pedido', 22, 'delete_pedidoproducto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(88, 'Can view Producto del Pedido', 22, 'view_pedidoproducto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(89, 'Can add Código de Restablecimiento de Contraseña', 23, 'add_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(90, 'Can change Código de Restablecimiento de Contraseña', 23, 'change_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(91, 'Can delete Código de Restablecimiento de Contraseña', 23, 'delete_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(92, 'Can view Código de Restablecimiento de Contraseña', 23, 'view_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(93, 'Can add site', 24, 'add_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(94, 'Can change site', 24, 'change_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(95, 'Can delete site', 24, 'delete_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(96, 'Can view site', 24, 'view_site');

-- Volcando estructura para tabla vinyles_local.auth_user
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_user: ~2 rows (aproximadamente)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$1000000$IHl9F1X4p8yHxkfwwwgJTB$ut5YyPEJJ2PdfJ2VZ/TVIHX5LGYg/rtgOOCrqKSJhPM=', '2025-06-23 04:33:14.776299', 1, 'adminOne', '', '', 'adminone@gmail.com', 1, 1, '2025-05-30 02:22:23.892608');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(2, 'pbkdf2_sha256$1000000$3uLNUO3WxlaOptKesonJEB$pevuoUC4lo5jN0rDv9LV3K6sm6U5b+ZQ97+87vTweq4=', '2025-06-18 01:27:23.837448', 0, 'stebanpls', 'Steban', '', 'stebanpulido@gmail.com', 0, 1, '2025-06-06 00:42:50.616501');

-- Volcando estructura para tabla vinyles_local.auth_user_groups
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_user_groups: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.auth_user_user_permissions
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_user_user_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.canciones
DROP TABLE IF EXISTS `canciones`;
CREATE TABLE IF NOT EXISTS `canciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `duracion` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.canciones: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.canciones_artistas
DROP TABLE IF EXISTS `canciones_artistas`;
CREATE TABLE IF NOT EXISTS `canciones_artistas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cancion_id` bigint(20) NOT NULL,
  `artista_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `canciones_artistas_cancion_id_artista_id_658a2234_uniq` (`cancion_id`,`artista_id`),
  KEY `canciones_artistas_artista_id_7e3ca9b6_fk_artistas_id` (`artista_id`),
  CONSTRAINT `canciones_artistas_artista_id_7e3ca9b6_fk_artistas_id` FOREIGN KEY (`artista_id`) REFERENCES `artistas` (`id`),
  CONSTRAINT `canciones_artistas_cancion_id_f63baf3e_fk_canciones_id` FOREIGN KEY (`cancion_id`) REFERENCES `canciones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.canciones_artistas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.canciones_generos
DROP TABLE IF EXISTS `canciones_generos`;
CREATE TABLE IF NOT EXISTS `canciones_generos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cancion_id` bigint(20) NOT NULL,
  `genero_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `canciones_generos_cancion_id_genero_id_f5b48d74_uniq` (`cancion_id`,`genero_id`),
  KEY `canciones_generos_genero_id_a160c320_fk_generos_id` (`genero_id`),
  CONSTRAINT `canciones_generos_cancion_id_efa4578e_fk_canciones_id` FOREIGN KEY (`cancion_id`) REFERENCES `canciones` (`id`),
  CONSTRAINT `canciones_generos_genero_id_a160c320_fk_generos_id` FOREIGN KEY (`genero_id`) REFERENCES `generos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.canciones_generos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.canciones_productores
DROP TABLE IF EXISTS `canciones_productores`;
CREATE TABLE IF NOT EXISTS `canciones_productores` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cancion_id` bigint(20) NOT NULL,
  `productor_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `canciones_productores_cancion_id_productor_id_69fc0ac1_uniq` (`cancion_id`,`productor_id`),
  KEY `canciones_productores_productor_id_a8b93e9f_fk_productores_id` (`productor_id`),
  CONSTRAINT `canciones_productores_cancion_id_13a8a67c_fk_canciones_id` FOREIGN KEY (`cancion_id`) REFERENCES `canciones` (`id`),
  CONSTRAINT `canciones_productores_productor_id_a8b93e9f_fk_productores_id` FOREIGN KEY (`productor_id`) REFERENCES `productores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.canciones_productores: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.ciudades
DROP TABLE IF EXISTS `ciudades`;
CREATE TABLE IF NOT EXISTS `ciudades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `departamento_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ciudades_departamento_id_55a1aff1_fk_departamentos_id` (`departamento_id`),
  CONSTRAINT `ciudades_departamento_id_55a1aff1_fk_departamentos_id` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.ciudades: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.clientes
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `user_id` int(11) NOT NULL,
  `numero_documento` varchar(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `direccion_residencia` varchar(255) DEFAULT NULL,
  `foto_perfil` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `clientes_user_id_2e92d62d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.clientes: ~1 rows (aproximadamente)
INSERT INTO `clientes` (`user_id`, `numero_documento`, `celular`, `direccion_residencia`, `foto_perfil`) VALUES
	(2, NULL, NULL, NULL, 'fotos_perfil/user_2/24d51a2db4ab4573a18a25983f375526.jpg');

-- Volcando estructura para tabla vinyles_local.clientes_generos_favoritos
DROP TABLE IF EXISTS `clientes_generos_favoritos`;
CREATE TABLE IF NOT EXISTS `clientes_generos_favoritos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `genero_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientes_generos_favoritos_cliente_id_genero_id_f7f0faef_uniq` (`cliente_id`,`genero_id`),
  KEY `cliente_generos_favoritos_genero_id_78206544_fk` (`genero_id`),
  CONSTRAINT `cliente_generos_favoritos_genero_id_78206544_fk` FOREIGN KEY (`genero_id`) REFERENCES `generos` (`id`),
  CONSTRAINT `clientes_generos_fav_cliente_id_f9a37fec_fk_clientes_` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.clientes_generos_favoritos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.cliente_medio_de_pago
DROP TABLE IF EXISTS `cliente_medio_de_pago`;
CREATE TABLE IF NOT EXISTS `cliente_medio_de_pago` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `mediodepago_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cliente_medio_de_pago_cliente_id_mediodepago_id_5d030f7d_uniq` (`cliente_id`,`mediodepago_id`),
  KEY `cliente_medio_de_pag_mediodepago_id_5f374dc4_fk_medios_de` (`mediodepago_id`),
  CONSTRAINT `cliente_medio_de_pag_mediodepago_id_5f374dc4_fk_medios_de` FOREIGN KEY (`mediodepago_id`) REFERENCES `medios_de_pago` (`id`),
  CONSTRAINT `cliente_medio_de_pago_cliente_id_22c9b106_fk_clientes_user_id` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.cliente_medio_de_pago: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.cruds
DROP TABLE IF EXISTS `cruds`;
CREATE TABLE IF NOT EXISTS `cruds` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `clase` varchar(100) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `fechaIngreso` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.cruds: ~1 rows (aproximadamente)
INSERT INTO `cruds` (`id`, `nombre`, `apellido`, `foto`, `clase`, `direccion`, `fechaIngreso`) VALUES
	(1, 'Edwin Steban', 'Pulido Rojas', 'fotos/foto7_GWzFezF.jpg', 'TPS', '182 Peel Street', '2025-05-30');

-- Volcando estructura para tabla vinyles_local.departamentos
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE IF NOT EXISTS `departamentos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `pais_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `departamentos_pais_id_4ba1a8e7_fk_paises_id` (`pais_id`),
  CONSTRAINT `departamentos_pais_id_4ba1a8e7_fk_paises_id` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.departamentos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.django_admin_log
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_admin_log: ~1 rows (aproximadamente)
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2025-06-23 04:38:29.276113', '1', '127.0.0.1:8000', 2, '[{"changed": {"fields": ["Domain name", "Display name"]}}]', 24, 1);

-- Volcando estructura para tabla vinyles_local.django_content_type
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_content_type: ~24 rows (aproximadamente)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(2, 'auth', 'permission');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(3, 'auth', 'group');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(4, 'auth', 'user');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(6, 'sessions', 'session');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(7, 'gestion', 'crud');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(8, 'gestion', 'clienteprofile');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(9, 'gestion', 'genero');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(10, 'gestion', 'cliente');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(11, 'gestion', 'cancion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(12, 'gestion', 'productor');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(13, 'gestion', 'pedido');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(14, 'gestion', 'pais');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(15, 'gestion', 'ciudad');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(16, 'gestion', 'productocancion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(17, 'gestion', 'artista');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(18, 'gestion', 'departamento');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(19, 'gestion', 'ticketsoporte');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(20, 'gestion', 'mediodepago');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(21, 'gestion', 'producto');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(22, 'gestion', 'pedidoproducto');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(23, 'gestion', 'passwordresetcode');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(24, 'sites', 'site');

-- Volcando estructura para tabla vinyles_local.django_migrations
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_migrations: ~31 rows (aproximadamente)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-05-30 01:52:14.584499');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(2, 'auth', '0001_initial', '2025-05-30 01:52:17.499973');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(3, 'admin', '0001_initial', '2025-05-30 01:52:18.145306');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-05-30 01:52:18.180389');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-05-30 01:52:18.196710');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-05-30 01:52:18.564194');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-05-30 01:52:18.791994');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(8, 'auth', '0003_alter_user_email_max_length', '2025-05-30 01:52:18.939686');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(9, 'auth', '0004_alter_user_username_opts', '2025-05-30 01:52:18.955900');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(10, 'auth', '0005_alter_user_last_login_null', '2025-05-30 01:52:19.166494');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(11, 'auth', '0006_require_contenttypes_0002', '2025-05-30 01:52:19.178094');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-05-30 01:52:19.196025');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(13, 'auth', '0008_alter_user_username_max_length', '2025-05-30 01:52:19.337395');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-05-30 01:52:19.607656');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(15, 'auth', '0010_alter_group_name_max_length', '2025-05-30 01:52:19.766213');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(16, 'auth', '0011_update_proxy_permissions', '2025-05-30 01:52:19.781799');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-05-30 01:52:19.946518');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(18, 'gestion', '0001_initial', '2025-05-30 01:52:20.038931');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(19, 'sessions', '0001_initial', '2025-05-30 01:52:20.300382');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(20, 'gestion', '0002_clienteprofile', '2025-06-04 04:07:44.037796');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(21, 'gestion', '0003_genero_clienteprofile_foto_perfil_and_more', '2025-06-06 14:27:16.729124');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(22, 'gestion', '0004_cliente_delete_clienteprofile', '2025-06-06 14:38:43.453390');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(23, 'gestion', '0005_alter_cliente_table', '2025-06-10 02:11:01.108547');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(24, 'gestion', '0006_alter_crud_options_alter_crud_clase_alter_crud_id_and_more', '2025-06-10 02:29:34.209690');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(25, 'gestion', '0007_alter_crud_options_alter_cliente_foto_perfil_and_more', '2025-06-12 03:03:05.681229');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(26, 'gestion', '0008_artista_departamento_mediodepago_pais_productor_and_more', '2025-06-17 01:23:59.769130');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(27, 'gestion', '0009_alter_artista_foto_alter_artista_informacion_and_more', '2025-06-18 02:40:45.423345');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(28, 'gestion', '0010_alter_producto_descripcion_and_more', '2025-06-22 20:18:15.702223');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(29, 'gestion', '0011_alter_artista_foto_alter_artista_informacion_and_more', '2025-06-22 20:18:16.326290');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(30, 'sites', '0001_initial', '2025-06-23 04:31:00.019228');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(31, 'sites', '0002_alter_domain_unique', '2025-06-23 04:31:00.467858');

-- Volcando estructura para tabla vinyles_local.django_session
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_session: ~17 rows (aproximadamente)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('1dvxcmft5ji1ogcz0s2qg8kgqxcsv1cp', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uNhTw:1pSTf5z3gEjs5AN4vtxT1yYTBsOXMyZAf5O2LInuWKU', '2025-06-21 00:32:20.172182');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('2hcnz8m19t3j6zlefnclbydz1c70y82n', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPNkT:J-pdZEet3PrDfNie64HAhbdNW7R7pOahmG7fv_sZYIg', '2025-06-25 15:52:21.037461');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('49hewy99icpah3oac381rrh3slvgs5k3', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uNjKs:Q9U9kZYvU56Jrw86clvODk5uF78WasIo0DjeM8e-Qrs', '2025-06-21 02:31:06.949944');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('7at0tgb22w0vjpsflcckd6v6kd79y8ce', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPYNq:gHzhFz_vO5rlY2NzGXX2tia4pLZ7YwemOl9HCqN-cDc', '2025-06-26 03:13:42.735023');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('9gs7n6s4ny52e6wgubrylkola0j2laya', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uKpP2:0x47VD61OcSqbmZbznEgnSgSPJMHGTYpeg0nQA176x0', '2025-06-13 02:23:24.420717');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('bb2ao6ajh36g86a5p31iqgjbujkkhxby', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPRK5:n9juK0ZHoATuYCgzItxxR4Qu8TW4wZlcJoeUDXd6DQ8', '2025-06-25 19:41:21.708170');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('bj9jy8f2mnjwspzjin3gs7lgrymos24g', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPRMn:n4Vce4a5W_uBgpHC2b2PymD8yTnpwlvUxWpF6pJ-kig', '2025-06-25 19:44:09.456001');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('d0bzx9ihwl95qx9qle2nfcioou5bc9se', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uNj8j:d1xxBauBmbER5RHrErQXr0Zrr-79FYjfmADNhnQANPA', '2025-06-21 02:18:33.726168');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('htzel3d6vlr80ffsh4xrmpmhn1rpu6m5', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uRh1g:O3voLEsWhVbVn3-fwWUORetH2jegNqw-nIzhc-0ucT8', '2025-07-02 00:51:40.479461');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('ija118w66rbpnrje2t8bo22v1tbazup4', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uL0ch:qvQwroSRpkC_4OWVcmGfhZcS9zSYjQ_HuoYpvX1MVRg', '2025-06-13 14:22:15.284156');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('kdqm7spw1m4ly2kx2hvmypasaon73djl', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPZ5G:Y0n4EPaXjivxidHo3Qy_aPDeIlQBtlW1wyLxD2E3Ifc', '2025-06-26 03:58:34.181983');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('kjua7go4ui3ywyxhzfrtepyow0dcp85c', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uRgeF:mR6TDPze7zaSz-4uGVKktMyiKlMMSEZg9RdXFIPV8J4', '2025-07-02 00:27:27.968062');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('qep9uj1e9ow8fkh1ahuqchc9w7munuof', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uNijT:QEYOPomMHGivpVgyLfO8czwE3QcPjhl9242QnSApjKI', '2025-06-21 01:52:27.320475');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('tfsrm3rld6oxni0i8lpf1dksdtqz2ko9', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPYcd:RfB8xuuY2h2EkpFT-ZcL5wAaCB-84vcEJTrF8PFuz48', '2025-06-26 03:28:59.260107');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('tuy3wbgs55uyhrsege82ixoy9ylg9opb', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPXZn:sKqs4gfvKkBCkCThWs9l9GW6Eq2Ow9Meh33CZvomtso', '2025-06-26 02:21:59.323981');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('ui7eu8umi3ny1h6ihn9l51glaudnzw2k', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uOpp5:zUoPmXm724Qf9yIXe7qZapn0A6OVp3Q03JDEL6og-9M', '2025-06-24 03:38:51.474837');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('usipjcco3u3knf22g7h1awjnv4h73lvn', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uTYrq:Ht37ipeByaXFFA2iP3is0jQ3hJHcvL9Mg0EuCcerPtg', '2025-07-07 04:33:14.787826');

-- Volcando estructura para tabla vinyles_local.django_site
DROP TABLE IF EXISTS `django_site`;
CREATE TABLE IF NOT EXISTS `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_site: ~1 rows (aproximadamente)
INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
	(1, '127.0.0.1:8000', 'Vinyles');

-- Volcando estructura para tabla vinyles_local.generos
DROP TABLE IF EXISTS `generos`;
CREATE TABLE IF NOT EXISTS `generos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.generos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.medios_de_pago
DROP TABLE IF EXISTS `medios_de_pago`;
CREATE TABLE IF NOT EXISTS `medios_de_pago` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.medios_de_pago: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.paises
DROP TABLE IF EXISTS `paises`;
CREATE TABLE IF NOT EXISTS `paises` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.paises: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.password_reset_codes
DROP TABLE IF EXISTS `password_reset_codes`;
CREATE TABLE IF NOT EXISTS `password_reset_codes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `password_reset_codes_user_id_d2e81cee_fk_auth_user_id` (`user_id`),
  CONSTRAINT `password_reset_codes_user_id_d2e81cee_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.password_reset_codes: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.pedidos
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `direccion_envio` varchar(255) NOT NULL,
  `ciudad_envio_id` bigint(20) DEFAULT NULL,
  `cliente_id` int(11) NOT NULL,
  `medio_de_pago_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedidos_ciudad_envio_id_625e6773_fk_ciudades_id` (`ciudad_envio_id`),
  KEY `pedidos_cliente_id_0591b0b3_fk_clientes_user_id` (`cliente_id`),
  KEY `pedidos_medio_de_pago_id_07a30f33_fk_medios_de_pago_id` (`medio_de_pago_id`),
  CONSTRAINT `pedidos_ciudad_envio_id_625e6773_fk_ciudades_id` FOREIGN KEY (`ciudad_envio_id`) REFERENCES `ciudades` (`id`),
  CONSTRAINT `pedidos_cliente_id_0591b0b3_fk_clientes_user_id` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`user_id`),
  CONSTRAINT `pedidos_medio_de_pago_id_07a30f33_fk_medios_de_pago_id` FOREIGN KEY (`medio_de_pago_id`) REFERENCES `medios_de_pago` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.pedidos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.pedido_productos
DROP TABLE IF EXISTS `pedido_productos`;
CREATE TABLE IF NOT EXISTS `pedido_productos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cantidad` int(10) unsigned NOT NULL CHECK (`cantidad` >= 0),
  `valor_unitario` decimal(10,2) NOT NULL,
  `pedido_id` bigint(20) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pedido_productos_pedido_id_producto_id_c0c450b8_uniq` (`pedido_id`,`producto_id`),
  KEY `pedido_productos_producto_id_9b5f11d8_fk_productos_id` (`producto_id`),
  CONSTRAINT `pedido_productos_pedido_id_a0f53d95_fk_pedidos_id` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  CONSTRAINT `pedido_productos_producto_id_9b5f11d8_fk_productos_id` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.pedido_productos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.productores
DROP TABLE IF EXISTS `productores`;
CREATE TABLE IF NOT EXISTS `productores` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.productores: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.productos
DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `lanzamiento` date NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(10) unsigned NOT NULL CHECK (`stock` >= 0),
  `descripcion` longtext NOT NULL,
  `discografica` varchar(200) NOT NULL,
  `imagen_portada` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.productos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.productos_artistas
DROP TABLE IF EXISTS `productos_artistas`;
CREATE TABLE IF NOT EXISTS `productos_artistas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `producto_id` bigint(20) NOT NULL,
  `artista_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productos_artistas_producto_id_artista_id_1d704be9_uniq` (`producto_id`,`artista_id`),
  KEY `productos_artistas_artista_id_750b8d1c_fk_artistas_id` (`artista_id`),
  CONSTRAINT `productos_artistas_artista_id_750b8d1c_fk_artistas_id` FOREIGN KEY (`artista_id`) REFERENCES `artistas` (`id`),
  CONSTRAINT `productos_artistas_producto_id_ccb2281e_fk_productos_id` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.productos_artistas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.productos_genero_principal
DROP TABLE IF EXISTS `productos_genero_principal`;
CREATE TABLE IF NOT EXISTS `productos_genero_principal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `producto_id` bigint(20) NOT NULL,
  `genero_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productos_genero_principal_producto_id_genero_id_e6096a75_uniq` (`producto_id`,`genero_id`),
  KEY `productos_genero_principal_genero_id_67fa962f_fk_generos_id` (`genero_id`),
  CONSTRAINT `productos_genero_principal_genero_id_67fa962f_fk_generos_id` FOREIGN KEY (`genero_id`) REFERENCES `generos` (`id`),
  CONSTRAINT `productos_genero_principal_producto_id_e9b51d06_fk_productos_id` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.productos_genero_principal: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.producto_canciones
DROP TABLE IF EXISTS `producto_canciones`;
CREATE TABLE IF NOT EXISTS `producto_canciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero_pista` int(10) unsigned NOT NULL CHECK (`numero_pista` >= 0),
  `cancion_id` bigint(20) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `producto_canciones_producto_id_numero_pista_31e03927_uniq` (`producto_id`,`numero_pista`),
  UNIQUE KEY `producto_canciones_producto_id_cancion_id_89617936_uniq` (`producto_id`,`cancion_id`),
  KEY `producto_canciones_cancion_id_faa58a16_fk_canciones_id` (`cancion_id`),
  CONSTRAINT `producto_canciones_cancion_id_faa58a16_fk_canciones_id` FOREIGN KEY (`cancion_id`) REFERENCES `canciones` (`id`),
  CONSTRAINT `producto_canciones_producto_id_8a889b51_fk_productos_id` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.producto_canciones: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.tickets_soporte
DROP TABLE IF EXISTS `tickets_soporte`;
CREATE TABLE IF NOT EXISTS `tickets_soporte` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descripcion` longtext NOT NULL,
  `estado` varchar(20) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `fecha_actualizacion` datetime(6) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_soporte_cliente_id_9ae8f092_fk_clientes_user_id` (`cliente_id`),
  CONSTRAINT `tickets_soporte_cliente_id_9ae8f092_fk_clientes_user_id` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.tickets_soporte: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
