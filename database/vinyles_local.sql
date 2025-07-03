-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.8.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7070
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para vinyles_local
CREATE DATABASE IF NOT EXISTS `vinyles_local` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `vinyles_local`;

-- Volcando estructura para tabla vinyles_local.artistas
DROP TABLE IF EXISTS `artistas`;
CREATE TABLE IF NOT EXISTS `artistas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `informacion` longtext NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `discogs_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `discogs_id` (`discogs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.artistas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.auth_group
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.auth_permission: ~104 rows (aproximadamente)
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
	(25, 'Can add site', 7, 'add_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(26, 'Can change site', 7, 'change_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(27, 'Can delete site', 7, 'delete_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(28, 'Can view site', 7, 'view_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(29, 'Can add Artista', 8, 'add_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(30, 'Can change Artista', 8, 'change_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(31, 'Can delete Artista', 8, 'delete_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(32, 'Can view Artista', 8, 'view_artista');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(33, 'Can add CRUD', 9, 'add_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(34, 'Can change CRUD', 9, 'change_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(35, 'Can delete CRUD', 9, 'delete_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(36, 'Can view CRUD', 9, 'view_crud');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(37, 'Can add Departamento', 10, 'add_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(38, 'Can change Departamento', 10, 'change_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(39, 'Can delete Departamento', 10, 'delete_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(40, 'Can view Departamento', 10, 'view_departamento');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(41, 'Can add Género', 11, 'add_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(42, 'Can change Género', 11, 'change_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(43, 'Can delete Género', 11, 'delete_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(44, 'Can view Género', 11, 'view_genero');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(45, 'Can add Medio de Pago', 12, 'add_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(46, 'Can change Medio de Pago', 12, 'change_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(47, 'Can delete Medio de Pago', 12, 'delete_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(48, 'Can view Medio de Pago', 12, 'view_mediodepago');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(49, 'Can add País', 13, 'add_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(50, 'Can change País', 13, 'change_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(51, 'Can delete País', 13, 'delete_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(52, 'Can view País', 13, 'view_pais');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(53, 'Can add Productor', 14, 'add_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(54, 'Can change Productor', 14, 'change_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(55, 'Can delete Productor', 14, 'delete_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(56, 'Can view Productor', 14, 'view_productor');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(57, 'Can add Ciudad', 15, 'add_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(58, 'Can change Ciudad', 15, 'change_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(59, 'Can delete Ciudad', 15, 'delete_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(60, 'Can view Ciudad', 15, 'view_ciudad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(61, 'Can add estado usuario', 16, 'add_estadousuario');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(62, 'Can change estado usuario', 16, 'change_estadousuario');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(63, 'Can delete estado usuario', 16, 'delete_estadousuario');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(64, 'Can view estado usuario', 16, 'view_estadousuario');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(65, 'Can add Canción', 17, 'add_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(66, 'Can change Canción', 17, 'change_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(67, 'Can delete Canción', 17, 'delete_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(68, 'Can view Canción', 17, 'view_cancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(69, 'Can add Cliente', 18, 'add_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(70, 'Can change Cliente', 18, 'change_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(71, 'Can delete Cliente', 18, 'delete_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(72, 'Can view Cliente', 18, 'view_cliente');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(73, 'Can add Código de Restablecimiento de Contraseña', 19, 'add_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(74, 'Can change Código de Restablecimiento de Contraseña', 19, 'change_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(75, 'Can delete Código de Restablecimiento de Contraseña', 19, 'delete_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(76, 'Can view Código de Restablecimiento de Contraseña', 19, 'view_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(77, 'Can add Pedido', 20, 'add_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(78, 'Can change Pedido', 20, 'change_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(79, 'Can delete Pedido', 20, 'delete_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(80, 'Can view Pedido', 20, 'view_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(81, 'Can add Producto (Catálogo)', 21, 'add_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(82, 'Can change Producto (Catálogo)', 21, 'change_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(83, 'Can delete Producto (Catálogo)', 21, 'delete_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(84, 'Can view Producto (Catálogo)', 21, 'view_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(85, 'Can add Publicación (Oferta)', 22, 'add_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(86, 'Can change Publicación (Oferta)', 22, 'change_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(87, 'Can delete Publicación (Oferta)', 22, 'delete_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(88, 'Can view Publicación (Oferta)', 22, 'view_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(89, 'Can add Publicación del Pedido', 23, 'add_pedidopublicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(90, 'Can change Publicación del Pedido', 23, 'change_pedidopublicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(91, 'Can delete Publicación del Pedido', 23, 'delete_pedidopublicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(92, 'Can view Publicación del Pedido', 23, 'view_pedidopublicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(93, 'Can add Ticket de Soporte', 24, 'add_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(94, 'Can change Ticket de Soporte', 24, 'change_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(95, 'Can delete Ticket de Soporte', 24, 'delete_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(96, 'Can view Ticket de Soporte', 24, 'view_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(97, 'Can add Canción en Producto', 25, 'add_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(98, 'Can change Canción en Producto', 25, 'change_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(99, 'Can delete Canción en Producto', 25, 'delete_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(100, 'Can view Canción en Producto', 25, 'view_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(101, 'Can add Notificación', 26, 'add_notificacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(102, 'Can change Notificación', 26, 'change_notificacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(103, 'Can delete Notificación', 26, 'delete_notificacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(104, 'Can view Notificación', 26, 'view_notificacion');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.auth_user: ~2 rows (aproximadamente)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$1000000$k7MFk73uMFfgPr5h8p5bVk$BDWHNMgp47udCB9UR45tjO0/yUCD/TzjGh55B72rPsw=', NULL, 1, 'adminOne', '', '', 'adminone@gmail.com', 1, 1, '2025-06-30 12:49:23.007169');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(2, 'pbkdf2_sha256$1000000$tXKqj8WnpHx5l2w1lxFloX$wCAwkTfT+QlptsWY2lyvgGfUOK3Ymfh8N9HdO4gvM64=', '2025-06-30 12:51:21.591989', 0, 'stebanpls', 'Steban', 'Pulido', 'stebanpulido@gmail.com', 0, 1, '2025-06-30 12:50:43.209773');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.auth_user_user_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.canciones
DROP TABLE IF EXISTS `canciones`;
CREATE TABLE IF NOT EXISTS `canciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `discogs_id` varchar(255) DEFAULT NULL,
  `duracion` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discogs_id` (`discogs_id`),
  UNIQUE KEY `canciones_nombre_duracion_edbddb12_uniq` (`nombre`,`duracion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.clientes: ~2 rows (aproximadamente)
INSERT INTO `clientes` (`user_id`, `numero_documento`, `celular`, `direccion_residencia`, `foto_perfil`) VALUES
	(1, NULL, NULL, NULL, 'fotos_perfil/default/default_avatar.png');
INSERT INTO `clientes` (`user_id`, `numero_documento`, `celular`, `direccion_residencia`, `foto_perfil`) VALUES
	(2, NULL, NULL, NULL, 'fotos_perfil/user_2/d2a891130b064fc6a9a5c217c883d242.jpg');

-- Volcando estructura para tabla vinyles_local.clientes_generos_favoritos
DROP TABLE IF EXISTS `clientes_generos_favoritos`;
CREATE TABLE IF NOT EXISTS `clientes_generos_favoritos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `genero_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientes_generos_favoritos_cliente_id_genero_id_f7f0faef_uniq` (`cliente_id`,`genero_id`),
  KEY `clientes_generos_favoritos_genero_id_3d9af98c_fk_generos_id` (`genero_id`),
  CONSTRAINT `clientes_generos_fav_cliente_id_f9a37fec_fk_clientes_` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`user_id`),
  CONSTRAINT `clientes_generos_favoritos_genero_id_3d9af98c_fk_generos_id` FOREIGN KEY (`genero_id`) REFERENCES `generos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.cruds: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.departamentos
DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE IF NOT EXISTS `departamentos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `pais_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `departamentos_pais_id_4ba1a8e7_fk_paises_id` (`pais_id`),
  CONSTRAINT `departamentos_pais_id_4ba1a8e7_fk_paises_id` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.django_admin_log: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.django_content_type
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.django_content_type: ~26 rows (aproximadamente)
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
	(7, 'sites', 'site');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(8, 'gestion', 'artista');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(9, 'gestion', 'crud');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(10, 'gestion', 'departamento');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(11, 'gestion', 'genero');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(12, 'gestion', 'mediodepago');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(13, 'gestion', 'pais');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(14, 'gestion', 'productor');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(15, 'gestion', 'ciudad');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(16, 'gestion', 'estadousuario');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(17, 'gestion', 'cancion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(18, 'gestion', 'cliente');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(19, 'gestion', 'passwordresetcode');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(20, 'gestion', 'pedido');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(21, 'gestion', 'producto');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(22, 'gestion', 'publicacion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(23, 'gestion', 'pedidopublicacion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(24, 'gestion', 'ticketsoporte');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(25, 'gestion', 'productocancion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(26, 'gestion', 'notificacion');

-- Volcando estructura para tabla vinyles_local.django_migrations
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.django_migrations: ~22 rows (aproximadamente)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-06-30 12:47:14.918691');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(2, 'auth', '0001_initial', '2025-06-30 12:47:17.936848');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(3, 'admin', '0001_initial', '2025-06-30 12:47:18.459326');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-06-30 12:47:18.480078');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-30 12:47:18.502217');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-06-30 12:47:18.914498');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-06-30 12:47:19.140882');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(8, 'auth', '0003_alter_user_email_max_length', '2025-06-30 12:47:19.433532');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(9, 'auth', '0004_alter_user_username_opts', '2025-06-30 12:47:19.451682');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(10, 'auth', '0005_alter_user_last_login_null', '2025-06-30 12:47:19.672010');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(11, 'auth', '0006_require_contenttypes_0002', '2025-06-30 12:47:19.684143');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-06-30 12:47:19.706969');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(13, 'auth', '0008_alter_user_username_max_length', '2025-06-30 12:47:19.864864');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-06-30 12:47:20.046963');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(15, 'auth', '0010_alter_group_name_max_length', '2025-06-30 12:47:20.217479');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(16, 'auth', '0011_update_proxy_permissions', '2025-06-30 12:47:20.240373');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-06-30 12:47:20.398207');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(18, 'gestion', '0001_initial', '2025-06-30 12:47:31.920318');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(19, 'sessions', '0001_initial', '2025-06-30 12:47:32.332775');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(20, 'sites', '0001_initial', '2025-06-30 12:47:32.532345');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(21, 'sites', '0002_alter_domain_unique', '2025-06-30 12:47:32.735994');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(22, 'gestion', '0002_notificacion', '2025-07-02 04:08:09.857884');

-- Volcando estructura para tabla vinyles_local.django_session
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.django_session: ~1 rows (aproximadamente)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('8lk9c81rfi7ajnc31tn9xfvjhlku9jzi', '.eJxVjDEOwjAMRe-SGUVx7ABhZOcMUewYUkCp1LQT4u5QqQOs_733XyblZa5p6TqloZiT8Wb3u3GWh7YVlHtut9HK2OZpYLsqdqPdXsaiz_Pm_h3U3Ou3VvIakMkVVCZllIAQAQ7k98FF9oTuiAJwpcgxAgZlF4SdSgZSMO8Pxaw3IA:1uWDyj:2TmJ-USdmS_RyKegBhnJrMvQ_qaFmXV_3ECojNNB26E', '2025-07-14 12:51:21.627168');

-- Volcando estructura para tabla vinyles_local.django_site
DROP TABLE IF EXISTS `django_site`;
CREATE TABLE IF NOT EXISTS `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.django_site: ~1 rows (aproximadamente)
INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
	(1, 'example.com', 'example.com');

-- Volcando estructura para tabla vinyles_local.generos
DROP TABLE IF EXISTS `generos`;
CREATE TABLE IF NOT EXISTS `generos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.generos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.gestion_estadousuario
DROP TABLE IF EXISTS `gestion_estadousuario`;
CREATE TABLE IF NOT EXISTS `gestion_estadousuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bloqueado` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `gestion_estadousuario_user_id_6641d8e7_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.gestion_estadousuario: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.gestion_notificacion
DROP TABLE IF EXISTS `gestion_notificacion`;
CREATE TABLE IF NOT EXISTS `gestion_notificacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mensaje` longtext NOT NULL,
  `leido` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `url_destino` varchar(255) DEFAULT NULL,
  `usuario_destino_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestion_notificacion_usuario_destino_id_13b951b0_fk_auth_user_id` (`usuario_destino_id`),
  CONSTRAINT `gestion_notificacion_usuario_destino_id_13b951b0_fk_auth_user_id` FOREIGN KEY (`usuario_destino_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.gestion_notificacion: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.medios_de_pago
DROP TABLE IF EXISTS `medios_de_pago`;
CREATE TABLE IF NOT EXISTS `medios_de_pago` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.medios_de_pago: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.paises
DROP TABLE IF EXISTS `paises`;
CREATE TABLE IF NOT EXISTS `paises` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.pedidos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.pedido_publicaciones
DROP TABLE IF EXISTS `pedido_publicaciones`;
CREATE TABLE IF NOT EXISTS `pedido_publicaciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cantidad` int(10) unsigned NOT NULL CHECK (`cantidad` >= 0),
  `valor_unitario` decimal(10,2) NOT NULL,
  `pedido_id` bigint(20) NOT NULL,
  `publicacion_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pedido_publicaciones_pedido_id_publicacion_id_072abb0b_uniq` (`pedido_id`,`publicacion_id`),
  KEY `pedido_publicaciones_publicacion_id_cbc69642_fk_publicaciones_id` (`publicacion_id`),
  CONSTRAINT `pedido_publicaciones_pedido_id_626f6bb2_fk_pedidos_id` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  CONSTRAINT `pedido_publicaciones_publicacion_id_cbc69642_fk_publicaciones_id` FOREIGN KEY (`publicacion_id`) REFERENCES `publicaciones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.pedido_publicaciones: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.productores
DROP TABLE IF EXISTS `productores`;
CREATE TABLE IF NOT EXISTS `productores` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `discogs_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `discogs_id` (`discogs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.productores: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.productos
DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `lanzamiento` date DEFAULT NULL,
  `descripcion` longtext NOT NULL,
  `discografica` varchar(200) NOT NULL,
  `imagen_portada` varchar(100) NOT NULL,
  `discogs_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discogs_id` (`discogs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.producto_canciones: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.publicaciones
DROP TABLE IF EXISTS `publicaciones`;
CREATE TABLE IF NOT EXISTS `publicaciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(10) unsigned NOT NULL CHECK (`stock` >= 0),
  `descripcion_condicion` longtext NOT NULL,
  `fecha_publicacion` datetime(6) NOT NULL,
  `activa` tinyint(1) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  `vendedor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publicaciones_producto_id_vendedor_id_56a427bd_uniq` (`producto_id`,`vendedor_id`),
  KEY `publicaciones_vendedor_id_3c072a5e_fk_auth_user_id` (`vendedor_id`),
  CONSTRAINT `publicaciones_producto_id_e5f4d28c_fk_productos_id` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `publicaciones_vendedor_id_3c072a5e_fk_auth_user_id` FOREIGN KEY (`vendedor_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.publicaciones: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.tickets_soporte: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
