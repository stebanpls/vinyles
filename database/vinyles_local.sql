-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.8.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7073
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.artistas: ~12 rows (aproximadamente)
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(1, 'BTS (4)', '', 'artistas/default/default_avatar.png', '5034422');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(2, 'Aespa', '', 'artistas/default/default_avatar.png', '8724412');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(3, 'Eminem', '', 'artistas/default/default_avatar.png', '38661');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(4, 'Chase Atlantic', '', 'artistas/default/default_avatar.png', '6360229');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(5, 'Le Sserafim', '', 'artistas/default/default_avatar.png', '11171795');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(6, 'Slipknot', '', 'artistas/default/default_avatar.png', '38523');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(7, 'Jisoo', '', 'artistas/default/default_avatar.png', '6771905');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(8, 'The Neighborhood Bullys', '', 'artistas/default/default_avatar.png', '6228421');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(9, 'Billie Eilish', '', 'artistas/default/default_avatar.png', '5590213');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(10, 'Arctic Monkeys', '', 'artistas/default/default_avatar.png', '391170');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(11, 'Romeo Santos', '', 'artistas/default/default_avatar.png', '3094075');
INSERT INTO `artistas` (`id`, `nombre`, `informacion`, `foto`, `discogs_id`) VALUES
	(12, 'The Blanche Hudson Weekend', '', 'artistas/default/default_avatar.png', '1654515');

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
	(73, 'Can add Notificación', 19, 'add_notificacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(74, 'Can change Notificación', 19, 'change_notificacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(75, 'Can delete Notificación', 19, 'delete_notificacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(76, 'Can view Notificación', 19, 'view_notificacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(77, 'Can add Código de Restablecimiento de Contraseña', 20, 'add_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(78, 'Can change Código de Restablecimiento de Contraseña', 20, 'change_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(79, 'Can delete Código de Restablecimiento de Contraseña', 20, 'delete_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(80, 'Can view Código de Restablecimiento de Contraseña', 20, 'view_passwordresetcode');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(81, 'Can add pedido', 21, 'add_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(82, 'Can change pedido', 21, 'change_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(83, 'Can delete pedido', 21, 'delete_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(84, 'Can view pedido', 21, 'view_pedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(85, 'Can add Producto (Catálogo)', 22, 'add_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(86, 'Can change Producto (Catálogo)', 22, 'change_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(87, 'Can delete Producto (Catálogo)', 22, 'delete_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(88, 'Can view Producto (Catálogo)', 22, 'view_producto');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(89, 'Can add Publicación (Oferta)', 23, 'add_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(90, 'Can change Publicación (Oferta)', 23, 'change_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(91, 'Can delete Publicación (Oferta)', 23, 'delete_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(92, 'Can view Publicación (Oferta)', 23, 'view_publicacion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(93, 'Can add detalle pedido', 24, 'add_detallepedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(94, 'Can change detalle pedido', 24, 'change_detallepedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(95, 'Can delete detalle pedido', 24, 'delete_detallepedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(96, 'Can view detalle pedido', 24, 'view_detallepedido');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(97, 'Can add Ticket de Soporte', 25, 'add_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(98, 'Can change Ticket de Soporte', 25, 'change_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(99, 'Can delete Ticket de Soporte', 25, 'delete_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(100, 'Can view Ticket de Soporte', 25, 'view_ticketsoporte');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(101, 'Can add Canción en Producto', 26, 'add_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(102, 'Can change Canción en Producto', 26, 'change_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(103, 'Can delete Canción en Producto', 26, 'delete_productocancion');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(104, 'Can view Canción en Producto', 26, 'view_productocancion');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.auth_user: ~4 rows (aproximadamente)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$1000000$BjevyAR20eHBa3wMBpgmYc$I5O6Q5uX/TprqDh36u9DC65iFkeNt9F/DZKplAKaQh4=', '2025-07-07 18:24:33.624246', 1, 'adminOne', '', '', 'adminone@gmail.com', 1, 1, '2025-07-05 20:46:08.878189');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(2, 'pbkdf2_sha256$1000000$3R7zKz0CAKnp2NEyA3NxGe$fTM+F+mIeZuJraPFGZ3YMbUzHeEIdr0uSW+iZiikBqk=', '2025-07-10 02:02:14.962425', 0, 'stebanpls', 'Steban', 'Pulido', 'stebanpulido@gmail.com', 0, 1, '2025-07-05 20:46:45.786394');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(3, 'pbkdf2_sha256$1000000$lWZMQ1f1Kn1KdbXNGUdvI4$DWpqEdiRfA9SiEPvEODayqFgoepGnDrcgxRV2F8i9eg=', '2025-07-05 20:49:00.802490', 0, 'elkpo', 'Edwin', 'Rojas', 'stebanpul@outlook.com', 0, 1, '2025-07-05 20:48:46.660878');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(4, 'pbkdf2_sha256$1000000$alnXci5pThwp5KgJWpyjgV$r2HunCZcnfHyArNNKwYm/FmpttG/QXA3FikfTnwOGpQ=', '2025-07-07 18:28:15.162175', 0, 'daniel', 'daniel', 'prias', 'pipeguepri23@gmail.com', 0, 1, '2025-07-07 18:22:05.458396');

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
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.canciones: ~169 rows (aproximadamente)
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(1, 'Born Singer', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(2, 'No More Dream', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(3, 'N.O', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(4, '상남자 (Boy In Luv)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(5, 'Danger', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(6, 'I Need U', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(7, 'Run', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(8, '불타오르네 (Fire)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(9, '피 땀 눈물', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(10, '봄날', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(11, 'DNA', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(12, 'Fake Love', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(13, 'Idol', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(14, '작은 것들을 위한 시 (Boy With Luv)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(15, 'On', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(16, 'Dynamite', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(17, 'Life Goes On', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(18, 'Butter', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(19, 'Yet To Come (The Most Beautiful Moment)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(20, '달려라 방탄', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(21, 'Intro : Persona', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(22, 'Stay', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(23, 'Moon', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(24, 'Jamais Vu', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(25, 'Trivia 轉 : Seesaw', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(26, 'BTS Cypher PT. 3 : Killer', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(27, 'Outro : Ego', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(28, 'Her', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(29, 'Filter', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(30, '친구', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(31, 'Singularity', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(32, '00:00 (Zero O\'Clock)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(33, 'Euphoria', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(34, '보조개', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(35, 'Jump (Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(36, '애매한 사이', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(37, '상남자 (Boy In Luv) (Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(38, '따옴표', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(39, 'I Need U (Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(40, '흥탄소년단 (Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(41, 'Tony Montana', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(42, 'Young Forever (RM Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(43, '봄날 (V Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(44, 'DNA (J-Hope Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(45, 'Epiphany (Jin Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(46, 'Seesaw (Demo Ver.)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(47, 'Still With You (Acapella)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(48, 'For Youth', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(49, 'Whiplash', NULL, 183000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(50, 'Kill It', NULL, 199000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(51, 'Flights, Not Feelings', NULL, 181000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(52, 'Pink Hoodie', NULL, 146000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(53, 'Flowers', NULL, 190000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(54, 'Just Another Girl', NULL, 184000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(55, 'Curtains Up (Skit)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(56, 'White America', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(57, 'Business', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(58, 'Cleanin Out My Closet', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(59, 'Square Dance', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(60, 'The Kiss (Skit)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(61, 'Soldier', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(62, 'Say Goodbye Hollywood', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(63, 'Drips', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(64, 'Without Me', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(65, 'Paul Rosenberg (Skit)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(66, 'Sing For The Moment', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(67, 'Superman', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(68, 'Hailie\'s Song', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(69, 'Steve Berman (Skit)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(70, 'When The Music Stops', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(71, 'Say What You Say', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(72, 'Till I Collapse', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(73, 'My Dad\'s Gone Crazy', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(74, 'Curtains Close (Skit)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(75, 'Intro', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(76, 'Angels', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(77, 'Phases', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(78, 'Love Is (Not) Easy', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(79, 'No Rainbows', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(80, 'Heaven And Back', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(81, 'Stuckinmybrain', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(82, 'Even Though I\'m Depressed', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(83, 'Too Late', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(84, 'I Never Existed', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(85, 'I Don\'t Like Darkness', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(86, 'Chasing Lightning', NULL, 205000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(87, 'Crazy', NULL, 164000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(88, 'Pierrot', NULL, 170000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(89, '1-800-hot-n-fun', NULL, 173000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(90, 'Crazier', NULL, 178000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(91, 'Prelude 3.0', NULL, 237000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(92, 'The Blister Exists', NULL, 319000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(93, 'Three Nil', NULL, 288000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(94, 'Duality', NULL, 252000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(95, 'Opium Of The People', NULL, 192000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(96, 'Circle', NULL, 262000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(97, 'Welcome', NULL, 195000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(98, 'Vermilion', NULL, 316000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(99, 'Pulse Of The Maggots', NULL, 259000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(100, 'Before I Forget', NULL, 278000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(101, 'Vermilion Pt. 2', NULL, 224000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(102, 'The Nameless', NULL, 268000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(103, 'The Virus Of Life', NULL, 325000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(104, 'Danger - Keep Away', NULL, 195000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(105, 'Earthquake', NULL, 190000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(106, 'Your Love', NULL, 173000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(107, 'Tears', NULL, 182000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(108, 'Hugs & Kisses', NULL, 189000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(109, 'Let Me Be Me', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(110, 'I\'m Bored, Let\'s Fight', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(111, 'Spin It', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(112, 'Lead With Your Lips', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(113, 'Why I Steal', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(114, 'All The Way Down', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(115, 'Our Time Is Coming', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(116, 'Sux 2 B U', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(117, 'Go Back (To Drinking)', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(118, 'Alive', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(119, 'High On Life', NULL, NULL);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(120, 'Skinny', NULL, 219000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(121, 'Lunch', NULL, 179000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(122, 'Chihiro', NULL, 303000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(123, 'Birds Of A Feather', NULL, 210000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(124, 'Wildflower', NULL, 261000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(125, 'The Greatest', NULL, 293000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(126, 'L\'amour De Ma Vie', NULL, 333000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(127, 'The Diner', NULL, 186000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(128, 'Bittersuite', NULL, 298000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(129, 'Blue', NULL, 343000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(130, 'Do I Wanna Know?', NULL, 272000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(131, 'R U Mine?', NULL, 201000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(132, 'One For The Road', NULL, 206000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(133, 'Arabella', NULL, 207000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(134, 'I Want It All', NULL, 185000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(135, 'No.1 Party Anthem', NULL, 243000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(136, 'Mad Sounds', NULL, 205000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(137, 'Fireside', NULL, 181000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(138, 'Why\'d You Only Call Me When You\'re High?', NULL, 161000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(139, 'Snap Out Of It ', NULL, 193000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(140, 'Knee Socks', NULL, 257000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(141, 'I Wanna Be Yours', NULL, 184000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(142, 'Intro: Soy Dominicano', NULL, 38000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(143, 'Canalla', NULL, 225000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(144, 'Payasos', NULL, 203000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(145, 'La Demanda', NULL, 234000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(146, 'Millonario', NULL, 240000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(147, 'El Beso Que No Le Di', NULL, 207000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(148, 'Ileso', NULL, 218000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(149, 'Amor Enterrado', NULL, 241000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(150, 'Me Quedo', NULL, 236000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(151, 'Los Últimos', NULL, 283000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(152, 'Años Luz', NULL, 220000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(153, 'Bellas', NULL, 243000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(154, 'Inmortal', NULL, 256000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(155, 'Intro', NULL, 65000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(156, 'Love Is A Poison', NULL, 207000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(157, 'Graduation Celebration', NULL, 213000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(158, 'Disintegrate', NULL, 214000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(159, '(Just Like) Susan George', NULL, 208000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(160, 'If You\'re Still Together', NULL, 242000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(161, 'Blood And Butter', NULL, 171000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(162, 'When All Is Said And Done', NULL, 302000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(163, 'Punk Rock Pogo Satellite', NULL, 134000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(164, 'Our Broken Dreams', NULL, 242000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(165, '(The Say Good Guys Are) Hard To Find', NULL, 208000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(166, 'Consume Me', NULL, 247000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(167, 'Impossible You', NULL, 261000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(168, 'To Be That Way Again', NULL, 427000000);
INSERT INTO `canciones` (`id`, `nombre`, `discogs_id`, `duracion`) VALUES
	(169, 'Someone Please Make It Rain', NULL, 236000000);

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
  `numero_documento` varchar(20) NOT NULL,
  `celular` varchar(20) NOT NULL,
  `direccion_residencia` varchar(255) NOT NULL,
  `foto_perfil` varchar(100) DEFAULT NULL,
  `ciudad_residencia` varchar(100) NOT NULL,
  `codigo_postal` varchar(20) NOT NULL,
  `direccion_extra` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `clientes_user_id_2e92d62d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.clientes: ~4 rows (aproximadamente)
INSERT INTO `clientes` (`user_id`, `numero_documento`, `celular`, `direccion_residencia`, `foto_perfil`, `ciudad_residencia`, `codigo_postal`, `direccion_extra`) VALUES
	(1, '', '', '', 'fotos_perfil/default/default_avatar.png', '', '', '');
INSERT INTO `clientes` (`user_id`, `numero_documento`, `celular`, `direccion_residencia`, `foto_perfil`, `ciudad_residencia`, `codigo_postal`, `direccion_extra`) VALUES
	(2, '', '', 'stebanpls', 'fotos_perfil/user_2/42c6abce6aa94e4b8457fba92ad1c077.jpg', '', '', '');
INSERT INTO `clientes` (`user_id`, `numero_documento`, `celular`, `direccion_residencia`, `foto_perfil`, `ciudad_residencia`, `codigo_postal`, `direccion_extra`) VALUES
	(3, '', '', '', 'fotos_perfil/user_3/2315b78357514210a8cd9d01407bc8d0.jpg', '', '', '');
INSERT INTO `clientes` (`user_id`, `numero_documento`, `celular`, `direccion_residencia`, `foto_perfil`, `ciudad_residencia`, `codigo_postal`, `direccion_extra`) VALUES
	(4, '', '', '', 'fotos_perfil/user_4/f2a0c38aa6014d7ca106c2180a661491.jpg', '', '', '');

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
  `clase` varchar(100) NOT NULL,
  `direccion` varchar(250) NOT NULL,
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
	(19, 'gestion', 'notificacion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(20, 'gestion', 'passwordresetcode');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(21, 'gestion', 'pedido');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(22, 'gestion', 'producto');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(23, 'gestion', 'publicacion');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(24, 'gestion', 'detallepedido');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(25, 'gestion', 'ticketsoporte');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(26, 'gestion', 'productocancion');

-- Volcando estructura para tabla vinyles_local.django_migrations
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.django_migrations: ~25 rows (aproximadamente)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-07-05 20:43:42.281399');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(2, 'auth', '0001_initial', '2025-07-05 20:43:45.120713');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(3, 'admin', '0001_initial', '2025-07-05 20:43:45.754880');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-07-05 20:43:45.774413');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-07-05 20:43:45.791789');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-07-05 20:43:46.176215');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-07-05 20:43:46.402071');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(8, 'auth', '0003_alter_user_email_max_length', '2025-07-05 20:43:46.582647');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(9, 'auth', '0004_alter_user_username_opts', '2025-07-05 20:43:46.604320');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(10, 'auth', '0005_alter_user_last_login_null', '2025-07-05 20:43:46.833666');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(11, 'auth', '0006_require_contenttypes_0002', '2025-07-05 20:43:46.846309');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-07-05 20:43:46.871120');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(13, 'auth', '0008_alter_user_username_max_length', '2025-07-05 20:43:47.137382');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-07-05 20:43:47.341864');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(15, 'auth', '0010_alter_group_name_max_length', '2025-07-05 20:43:47.511669');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(16, 'auth', '0011_update_proxy_permissions', '2025-07-05 20:43:47.534842');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-07-05 20:43:47.692235');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(18, 'gestion', '0001_initial', '2025-07-05 20:43:59.051591');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(19, 'sessions', '0001_initial', '2025-07-05 20:43:59.335079');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(20, 'sites', '0001_initial', '2025-07-05 20:43:59.436889');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(21, 'sites', '0002_alter_domain_unique', '2025-07-05 20:43:59.630367');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(22, 'gestion', '0002_alter_publicacion_unique_together', '2025-07-07 01:23:33.816648');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(23, 'gestion', '0003_pedido_costo_envio_pedido_subtotal', '2025-07-07 05:16:54.369402');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(24, 'gestion', '0004_alter_publicacion_producto', '2025-07-07 07:12:54.570254');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(25, 'gestion', '0005_cliente_ciudad_residencia_cliente_codigo_postal_and_more', '2025-07-07 17:47:38.090054');

-- Volcando estructura para tabla vinyles_local.django_session
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.django_session: ~2 rows (aproximadamente)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('uu19qfjepvd8b7zm9cxwcyqvo4f4d0fm', '.eJxVjMsOwiAQRf-FtSEwUx516d5vIMMAUjU0Ke3K-O_apAvd3nPOfYlA21rD1vMSpiTOYhCn3y0SP3LbQbpTu82S57YuU5S7Ig_a5XVO-Xk53L-DSr1-6wIWjE2ePWpC9IgAlCmPORbWHkxipUevnSODGDUr1MYhFEUQB4vi_QHOOTb7:1uYqZb:PLb0WkFkwsw73gbab8yV8lUHxVw_Mq0T7Mf6r6XyraU', '2025-07-21 18:28:15.162175');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('wgi28aiwhow69uobq95k3abo0lw2flkm', '.eJxVjMsOwiAQRf-FtSEwUx516d5vIMMAUjU0Ke3K-O_apAvd3nPOfYlA21rD1vMSpiTOYhCn3y0SP3LbQbpTu82S57YuU5S7Ig_a5XVO-Xk53L-DSr1-6wIWjE2ePWpC9IgAlCmPORbWHkxipUevnSODGDUr1MYhFEUQB4vi_QHOOTb7:1uYqXD:b88KksazhxNSPNNlaaAtF1AjXphA3BaZ5ErmIRGoCC0', '2025-07-21 18:25:47.836200');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.generos: ~6 rows (aproximadamente)
INSERT INTO `generos` (`id`, `nombre`, `foto`) VALUES
	(1, 'ELECTRONIC', 'generos/default/default_genero.png');
INSERT INTO `generos` (`id`, `nombre`, `foto`) VALUES
	(2, 'HIP HOP', 'generos/default/default_genero.png');
INSERT INTO `generos` (`id`, `nombre`, `foto`) VALUES
	(3, 'ROCK', 'generos/default/default_genero.png');
INSERT INTO `generos` (`id`, `nombre`, `foto`) VALUES
	(4, 'FUNK / SOUL', 'generos/default/default_genero.png');
INSERT INTO `generos` (`id`, `nombre`, `foto`) VALUES
	(5, 'POP', 'generos/default/default_genero.png');
INSERT INTO `generos` (`id`, `nombre`, `foto`) VALUES
	(6, 'LATIN', 'generos/default/default_genero.png');

-- Volcando estructura para tabla vinyles_local.gestion_detallepedido
DROP TABLE IF EXISTS `gestion_detallepedido`;
CREATE TABLE IF NOT EXISTS `gestion_detallepedido` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cantidad` int(10) unsigned NOT NULL CHECK (`cantidad` >= 0),
  `precio_unitario` decimal(10,2) NOT NULL,
  `pedido_id` bigint(20) NOT NULL,
  `publicacion_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestion_detallepedido_pedido_id_f5053ab7_fk_gestion_pedido_id` (`pedido_id`),
  KEY `gestion_detallepedid_publicacion_id_956570bd_fk_publicaci` (`publicacion_id`),
  CONSTRAINT `gestion_detallepedid_publicacion_id_956570bd_fk_publicaci` FOREIGN KEY (`publicacion_id`) REFERENCES `publicaciones` (`id`),
  CONSTRAINT `gestion_detallepedido_pedido_id_f5053ab7_fk_gestion_pedido_id` FOREIGN KEY (`pedido_id`) REFERENCES `gestion_pedido` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.gestion_detallepedido: ~0 rows (aproximadamente)

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
  `url_destino` varchar(255) NOT NULL,
  `usuario_destino_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestion_notificacion_usuario_destino_id_13b951b0_fk_auth_user_id` (`usuario_destino_id`),
  CONSTRAINT `gestion_notificacion_usuario_destino_id_13b951b0_fk_auth_user_id` FOREIGN KEY (`usuario_destino_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.gestion_notificacion: ~24 rows (aproximadamente)
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(1, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Proof\'.', 0, '2025-07-07 18:36:38.306731', '/panel-admin/productos/adpro/1/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(2, '📢 El vendedor \'daniel\' ha publicado el álbum \'Proof\'.', 0, '2025-07-07 18:36:38.306731', '/panel-admin/productos/adpro/1/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(3, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Whiplash (The 5th Mini Album)\'.', 0, '2025-07-07 18:38:19.904039', '/panel-admin/productos/adpro/2/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(4, '📢 El vendedor \'daniel\' ha publicado el álbum \'Whiplash (The 5th Mini Album)\'.', 0, '2025-07-07 18:38:19.907918', '/panel-admin/productos/adpro/2/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(5, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'The Eminem Show\'.', 0, '2025-07-07 18:39:35.014208', '/panel-admin/productos/adpro/3/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(6, '📢 El vendedor \'daniel\' ha publicado el álbum \'The Eminem Show\'.', 0, '2025-07-07 18:39:35.018389', '/panel-admin/productos/adpro/3/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(7, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Phases\'.', 0, '2025-07-07 18:40:47.254668', '/panel-admin/productos/adpro/4/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(8, '📢 El vendedor \'daniel\' ha publicado el álbum \'Phases\'.', 0, '2025-07-07 18:40:47.258189', '/panel-admin/productos/adpro/4/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(9, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Crazy\'.', 0, '2025-07-07 18:42:37.283859', '/panel-admin/productos/adpro/5/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(10, '📢 El vendedor \'daniel\' ha publicado el álbum \'Crazy\'.', 0, '2025-07-07 18:42:37.288490', '/panel-admin/productos/adpro/5/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(11, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Vol. 3: (The Subliminal Verses)\'.', 0, '2025-07-07 18:45:14.076517', '/panel-admin/productos/adpro/6/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(12, '📢 El vendedor \'daniel\' ha publicado el álbum \'Vol. 3: (The Subliminal Verses)\'.', 0, '2025-07-07 18:45:14.080372', '/panel-admin/productos/adpro/6/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(13, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Amortage\'.', 0, '2025-07-07 18:46:27.976907', '/panel-admin/productos/adpro/7/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(14, '📢 El vendedor \'daniel\' ha publicado el álbum \'Amortage\'.', 0, '2025-07-07 18:46:27.976907', '/panel-admin/productos/adpro/7/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(15, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'What?\'.', 0, '2025-07-07 18:50:42.434362', '/panel-admin/productos/adpro/8/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(16, '📢 El vendedor \'daniel\' ha publicado el álbum \'What?\'.', 0, '2025-07-07 18:50:42.434362', '/panel-admin/productos/adpro/8/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(17, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Hit Me Hard And Soft\'.', 0, '2025-07-07 18:55:20.458604', '/panel-admin/productos/adpro/9/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(18, '📢 El vendedor \'daniel\' ha publicado el álbum \'Hit Me Hard And Soft\'.', 0, '2025-07-07 18:55:20.458604', '/panel-admin/productos/adpro/9/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(19, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'AM\'.', 0, '2025-07-07 18:58:00.421127', '/panel-admin/productos/adpro/10/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(20, '📢 El vendedor \'daniel\' ha publicado el álbum \'AM\'.', 0, '2025-07-07 18:58:00.423089', '/panel-admin/productos/adpro/10/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(21, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'Utopía\'.', 0, '2025-07-07 18:59:07.855725', '/panel-admin/productos/adpro/11/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(22, '📢 El vendedor \'daniel\' ha publicado el álbum \'Utopía\'.', 0, '2025-07-07 18:59:07.860182', '/panel-admin/productos/adpro/11/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(23, '🆕 El vendedor \'daniel\' ha importado un nuevo producto: \'How Many Times Have You Let Me Die?\'.', 0, '2025-07-07 19:01:07.377567', '/panel-admin/productos/adpro/12/', 1);
INSERT INTO `gestion_notificacion` (`id`, `mensaje`, `leido`, `fecha_creacion`, `url_destino`, `usuario_destino_id`) VALUES
	(24, '📢 El vendedor \'daniel\' ha publicado el álbum \'How Many Times Have You Let Me Die?\'.', 0, '2025-07-07 19:01:07.381750', '/panel-admin/productos/adpro/12/', 1);

-- Volcando estructura para tabla vinyles_local.gestion_pedido
DROP TABLE IF EXISTS `gestion_pedido`;
CREATE TABLE IF NOT EXISTS `gestion_pedido` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fecha_pedido` datetime(6) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `direccion_envio` longtext NOT NULL,
  `estado` varchar(1) NOT NULL,
  `comprador_id` int(11) DEFAULT NULL,
  `costo_envio` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gestion_pedido_comprador_id_35cc19fe_fk_auth_user_id` (`comprador_id`),
  CONSTRAINT `gestion_pedido_comprador_id_35cc19fe_fk_auth_user_id` FOREIGN KEY (`comprador_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.gestion_pedido: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.productos: ~12 rows (aproximadamente)
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(1, 'Proof', '2022-01-01', 'BTS\' first anthology release.\n\nCompact Edition release includes:\n• 3 CDs\n• Booklet\n• Photocard (random 1 of 7)\n• Postcard (random 1 of 8)\n• Mini Poster\n• Discography Guide\n\nTechnical information, from booklet:\nTrack 1-1 is new song. It is a cover/reimagining of [a750828]\'s "Born Sinner" with new lyrics.\nOriginal publishers: Songs of Universal, Inc., Almo Music Corp., Underdog West Songs, Fauntleroy Music, Elite That\'s Me Publishing, Kobalt Music Publishing Ltd (KMP), Canei Live Music, EMI Blackwood Music Inc., ILLOGIKAL MUSIC, Copyright Control.\nSub-publishers: Universal Music Publishing Korea, EKKO Music Rights (powered by CTGA), EMI Music Publishing Korea.\n• Recorded @ Dogg Bounce\n• Mixed for KenLewis.com\n\nTrack 1-2 is from [m=1528153] (2013)\n• Recorded @ Dogg Bounce\n• Mixed @ Schmuzik Studios\n\nTrack 1-3 is from [m=1528163] (2013)\n• Recorded @ Dogg Bounce\n• Mixed @ Schmuzik Studios\n\nTrack 1-4 is from [m=1017059] (2014)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Sam Klempner @ Schmuzik Studios in London\n• Mixed @ Schmuzik Studios\n\nTrack 1-5 is from [m=1522998] (2014)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Eric Reichers @ Echo Bar STUDIO in N. Hollywood\n• Mixed @ Schmuzik Studios\n\nTrack 1-6 is from [m=963030] (2015)\n• Recorded @ Dogg Bounce\n• Mixed @ Schmuzik Studios\n\nTrack 1-7 is from [m=963033] (2015)\n• Recorded @ Dogg Bounce\n• Mixed @ Schmuzik Studios\n\nTrack 1-8 is from [m=1044804] (2016)\n• Recorded @ Dogg Bounce\n• Mixed @ Schmuzik Studios\n\nTrack 1-9 is from [r=9231043] (2016)\n• Recorded @ Dogg Bounce\n• Mixed @ Schmuzik Studios\n\nTrack 1-10 is from [r=25152820] (2017)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by 정우영 @ Big Hit Studio\n• Recorded by Peter Ibsen @ Sky Studios\n• Mixed @ Schmuzik Studios\n\nTrack 1-11 is from [m=1528122] (2017)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by 정우영 @ Big Hit Studio\n• Recorded by KASS @ KASS Cave\n• Recorded by Supreme Boi @ The Rock Pit\n• Mixed @ Schmuzik Studios\n\nTrack 1-12 is from [m=1385652] (2018)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by 정우영 @ Big Hit Studio\n• Mixed @ Schmuzik Studios\n\nTrack 1-13 is from [m=1528108] (2018)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Supreme Boi @ The Rock Pit\n• Mixed @ Schmuzik Studios\n\nTrack 1-14 is from [m=1532766] (2019)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by RM @ RKive\n• Recorded by 박진세 @ Big Hit Studio\n• Recorded by Michel "Lindgren" Schulz @ The One With The Big Bulb\n• Recorded by Alex Williams @ The Village Studios Los Angeles, CA\n• Mixed @ Larrabee Sound Studios, North Hollywood, CA\n\nTrack 1-15 is from [m=1692300] (2020)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by RM @ RKive\n• Recorded by Michel "Lindgren" Schulz @ The One With The Big Bulb\n• Recorded by Erik Reichers @ Echo Bar STUDIO in N. Hollywood\n• Mixed for The Penua Project @ Sphere Studios, Los Angeles, CA\n\nTrack 1-16 is from [m=1995718] (2020)\n• Recorded @ Dogg Bounce\n• Mixed @ MixStar Studios, Virginia Beach, VA\n\nTrack 1-17 is from [m=1995718] (2020)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by RM @ RKive\n• Mixed @ Henson Studios, Los Angeles, CA\n\nTrack 1-18 is from the non-album single [m=2199655] (2021)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Juan "Saucy" Peña @ Larry and George Studios\n• Recorded by Keith Parry @ Larry and George Studios\n• Mixed @ MixStar Studios, Virginia Beach, VA\n\nTrack 1-19 is a new song.\n• Recorded @ Dogg Bounce\n• Mixed @ Henson Studios, Los Angeles, CA\n\nTrack 2-1 is a new song.\nProduced by Dem Jointz for U Made Us What We Are LLC, GHSTLOOP.\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by YOUNG @ Studio YOUNG\n• Recorded by Melanie Joy Fontana @ The One With The Big Bulb\n• Mixed for The Penua Project @ Canton House Studios, Studio City, CA\n\nTrack 2-2 is from [m=1532766] (2019)\nContains a sample from BTS "Intro: Skool Luv Affair."\n• Recorded by Hiss noise @ Analog lab\n• Recorded by RM @ RKive\n• Recorded by 김지연 @ Big Hit Studio\n• Mixed for KenLewis.com\n\nTrack 2-3 is from [m=1995718] (2020)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by RM @ RKive\n• Mixed @ Schmuzik Studios\n\nTrack 2-4 is from [m=1692300] (2020)\n• Recorded by Slow Rabbit @ Carrot Express, Dogg Bounce\n• Recorded by 정우영 @ Big Hit Studio\n• Recorded by 박은정 @ Big Hit Studio\n• Recorded by ADORA @ Adorable Trap\n• Recorded by Jordan "DJ Swivel" Young @ House Thirty Three, Los Angeles\n• Recorded by Caesar & Loui, FRANTS @ Studio Bambi Gang\n• Mixed @ Schmuzik Studios\n\nTrack 2-5 is from [m=1532766] (2019)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Hiss noise @ Analog lab\n• Recorded by ADORA @ Adorable Trap\n• Recorded by 김지연 @ Big Hit Studio\n• Mixed @ Big Hit Studio\n\nTrack 2-6 is from [m=1528108] (2018)\n• Recorded by ADORA @ Adorable Trap\n• Recorded by SUGA @ Genius lab\n• Recorded by Slow Rabbit @ Carrot Express\n• Recorded by 정우영 @ Big Hit Studio\n• Mixed @ Big Hit Studio\n\nTrack 2-7 is from [m=1522998] (2014)\n• Recorded by Supreme Boi @ The Supreme Escape\n• Mixed for KenLewis.com\n\nTrack 2-8 is from [m=1692300] (2020)\nContains a sample from BTS "Intro: 2 COOL 4 SKOOL."\n• Recorded by j-hope @ Hope World\n• Recorded by ADORA @ Adorable Trap\n• Recorded by FRANTS @ Studio Bambi Gang\n• Recorded by Erik Reichers @ Echo Bar STUDIO in N. Hollywood\n• Mixed @ Big Hit Studio\n\nTrack 2-9 is from [m=1528108] (2018)\n• Recorded by Slow Rabbit @ Carrot Express\n• Recorded by RM @ RKive\n• Recorded by Supreme Boi @ The Rock Pit\n• Recorded by SUGA @ Genius lab\n• Recorded by 정우영 @ Big Hit Studio\n• Mixed @ Big Hit Studio\n\nTrack 2-10 is from [m=1692300] (2020)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by ADORA @ Adorable Trap\n• Mixed @ The Ninja Beat Club\n\nTrack 2-11 is from [m=1692300] (2020)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by ADORA @ Adorable Trap\n• Recorded by 정우영 @ Big Hit Studio\n• Recorded by Erik Reichers @ Echo Bar STUDIO in N. Hollywood\n\nTrack 2-12 is from [m=1385652] (2018)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Slow Rabbit @ Carrot Express\n• Mixed @ Big Hit Studio\n\nTrack 2-13 is from [m=1692300] (2020)\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by ADORA @ Adorable Trap\n• Recorded by 정우영 @ Big Hit Studio\n• Mixed @ Big Hit Studio\n\nTrack 2-14 is from Love [m=1528108] (2018)\n• Recorded by Slow Rabbit @ Carrot Express\n• Recorded by ADORA @ Adorable Trap\n• Mixed for DJ Swivel Music LLC\n\nTrack 2-15 is from [m=1528122] (2017)\nOriginally titled "Illegal."\nOriginal publishers: Laundromat Music, Quiet Lion Music.\nSub-publishers: Fujipacific Music Korea Inc., Ekko Music Rights.\n• Recorded @ Geimori Studio & Cloud Lodge SAPPORO\n• Mixed @ Big Hit Studio\n\nTrack 3-1\n• Recorded by RM @ Mon Studio\n• Recorded by SUGA @ Genius lab\n• Mixed @ Dogg Bounce\n\nTrack 3-2 is a new song.\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by RM @ Mon Studio\n• Mixed for KenLewis.com\n\nTrack 3-3\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Sam Klempner @ Schmuzik Studios in London\n• Mixed @ Dogg Bounce\n\nTrack 3-4 is a new song.\n• Recorded by RM @ Mon Studio\n• Recorded by j-hope @ Hope World\n• Recorded by Junk Kook @ Golden Closet\n• Mixed for KenLewis.com\n\nTrack 3-5\n• Recorded by RM @ Mon Studio\n• Recorded by j-hope @ Hope World\n• Recorded by SUGA @ Genius lab\n• Recorded by Junk Kook @ Golden Closet\n• Mixed @ Dogg Bounce\n\nTrack 3-6\n• Recorded @ Dogg Bounce\n\nTrack 3-7\n• Recorded @ Genius Lab\n• Mixed @ Dogg Bounce\n\nTrack 3-8\n• Recorded by RM @ Mon Studio\n• Mixed @ HYBE Studio\n\nTrack 3-9\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by 정우영 @ Big Hit Studio\n• Mixed @ HYBE Studio\n\nTrack 3-10\n• Recorded @ Hope World\n• Mixed @ HYBE Studio\n\nTrack 3-11\n• Recorded @ Carrot Express\n• Mixed @ HYBE Studio\n\nTrack 3-12\n• Mixed @ HYBE Studio\n\nTrack 3-13\n• Recorded @ Dogg Bounce\n• Mixed @ HYBE Studio\n\nTrack 3-14\nContains a sample from BTS "EPILOGUE: Young Forever."\n• Recorded by Pdogg @ Dogg Bounce\n• Recorded by Julian Vasquez @ Virtuoso Studios\n• Recorded by Hiss noise @ Analog lab\n• Mixed @ The Echo Bar, North Hollywood, CA \n\nMastering Engineers:\nAlex DeYoung @ Deyoung Masters\nChris Gehringer @ Sterling Sound\nRandy Merrill @ Sterling Sound\nTony Dawsey @ Masterdisk, NYC\nVlado Meller @ Masterdisk, NYC\nYang Ga @ HYBE Studio', 'Bighit Music', 'productos_portadas/master_2668997_42840a7429ccbc2a.jpeg', '23542562');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(2, 'Whiplash (The 5th Mini Album)', '2024-01-01', '', 'S.M. Entertainment', 'productos_portadas/master_3637077_5af5311fee337623.jpeg', '32114820');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(3, 'The Eminem Show', '2002-01-01', '℗© 2002 Aftermath Records\nManufactured & distributed in the United States by Universal Music & Video Distribution, Corp.\n\nIncluding a colored fold-out insert\nSticker on shrinkwrap says:\nFeaturing "Without Me" "Cleaning Out My Closet" "Say What You Say"', 'Aftermath Entertainment', 'productos_portadas/master_12344_58c245748f9090da.jpeg', '1734171');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(4, 'Phases', '2019-01-01', 'Info taken from official merch website.', 'BMG Rights Management', 'productos_portadas/master_1588674_8c47cc9e0f6f065e.jpeg', '13816798');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(5, 'Crazy', '2024-01-01', '', 'Source Music (4)', 'productos_portadas/master_3583729_87f02928fd8a45be.jpeg', '31608433');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(6, 'Vol. 3: (The Subliminal Verses)', '2004-01-01', '20-page booklet.\n\nNo tracks durations printed', 'Roadrunner Records', 'productos_portadas/master_53328_030e7f8cf23910ab.jpeg', '1826346');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(7, 'Amortage', '2025-01-01', 'Released on 2/14/25 by Warner Records\nWarner Records, © 2025 Warner Records Inc., under exclusive license from Blissoo Limited Warner Records, ℗ 2025 Warner Records Inc., under exclusive license from Blissoo Limited\nHi-Res 24-Bit/48 kHz Stereo', 'Warner Records', 'productos_portadas/master_3751917_96bcfdfb8f3cc0e8.jpeg', '33136149');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(8, 'What?', '2008-01-01', '', 'Ruf Mix Records', 'productos_portadas/master_1359167_436e603c7b2a0dc2.jpeg', '11962323');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(9, 'Hit Me Hard And Soft', '2024-01-01', '© 2024 Darkroom/Interscope Records ℗ 2024 Darkroom/Interscope Records', 'Darkroom (4)', 'productos_portadas/master_3487663_03b75cd38ab0d1b5.jpeg', '30771834');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(10, 'AM', '2013-01-01', 'Record stowed in an anti-static inner sleeve.\n\n\nRecorded at Sage & Sound Recording, LA & Rancho De La Luna, Joshua Tree\nTrack A2: Produced & engineered at McCall Sound Studios\nKeys recorded at Vox Recording Studios, LA\nMixed at Full Mongrel Studios, Wales\nLP Mastering at Bernie Grundman Mastering, LA\nManagement for Wildlife Entertainment Ltd.\n\nPublished by EMI Music Publishing Ltd. Except track B1: Published by EMI Music Publishing Ltd. / Copyright Control\n\nMade in the E.U.\n℗&©2013 Domino Recording Co. Ltd.', 'Domino', 'productos_portadas/master_593987_7782682bc5fd43fb.jpeg', '4883505');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(11, 'Utopía', '2019-01-01', '', 'Sony Music Latin', 'productos_portadas/master_1559676_742bd4556f6a89aa.jpeg', '13533251');
INSERT INTO `productos` (`id`, `nombre`, `lanzamiento`, `descripcion`, `discografica`, `imagen_portada`, `discogs_id`) VALUES
	(12, 'How Many Times Have You Let Me Die?', '2013-01-01', '', 'Odd Box Records', 'productos_portadas/master_1446867_bb30db226f78f093.jpeg', '5137197');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.productos_artistas: ~12 rows (aproximadamente)
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(1, 1, 1);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(2, 2, 2);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(3, 3, 3);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(4, 4, 4);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(5, 5, 5);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(6, 6, 6);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(7, 7, 7);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(8, 8, 8);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(9, 9, 9);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(10, 10, 10);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(11, 11, 11);
INSERT INTO `productos_artistas` (`id`, `producto_id`, `artista_id`) VALUES
	(12, 12, 12);

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.productos_genero_principal: ~21 rows (aproximadamente)
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(1, 1, 1);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(2, 1, 2);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(3, 1, 3);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(4, 1, 4);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(5, 1, 5);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(6, 2, 1);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(7, 2, 4);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(8, 2, 5);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(9, 3, 2);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(10, 4, 2);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(11, 4, 3);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(12, 4, 5);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(13, 5, 5);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(14, 6, 3);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(15, 7, 5);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(16, 8, 3);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(17, 9, 5);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(18, 10, 3);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(19, 11, 5);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(20, 11, 6);
INSERT INTO `productos_genero_principal` (`id`, `producto_id`, `genero_id`) VALUES
	(21, 12, 3);

-- Volcando estructura para tabla vinyles_local.producto_canciones
DROP TABLE IF EXISTS `producto_canciones`;
CREATE TABLE IF NOT EXISTS `producto_canciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero_pista` int(10) unsigned NOT NULL CHECK (`numero_pista` >= 0),
  `cancion_id` bigint(20) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `producto_canciones_producto_id_cancion_id_89617936_uniq` (`producto_id`,`cancion_id`),
  UNIQUE KEY `producto_canciones_producto_id_numero_pista_31e03927_uniq` (`producto_id`,`numero_pista`),
  KEY `producto_canciones_cancion_id_faa58a16_fk_canciones_id` (`cancion_id`),
  CONSTRAINT `producto_canciones_cancion_id_faa58a16_fk_canciones_id` FOREIGN KEY (`cancion_id`) REFERENCES `canciones` (`id`),
  CONSTRAINT `producto_canciones_producto_id_8a889b51_fk_productos_id` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.producto_canciones: ~170 rows (aproximadamente)
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(1, 1, 1, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(2, 2, 2, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(3, 3, 3, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(4, 4, 4, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(5, 5, 5, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(6, 6, 6, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(7, 7, 7, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(8, 8, 8, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(9, 9, 9, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(10, 10, 10, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(11, 11, 11, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(12, 12, 12, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(13, 13, 13, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(14, 14, 14, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(15, 15, 15, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(16, 16, 16, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(17, 17, 17, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(18, 18, 18, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(19, 19, 19, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(20, 20, 20, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(21, 21, 21, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(22, 22, 22, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(23, 23, 23, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(24, 24, 24, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(25, 25, 25, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(26, 26, 26, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(27, 27, 27, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(28, 28, 28, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(29, 29, 29, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(30, 30, 30, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(31, 31, 31, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(32, 32, 32, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(33, 33, 33, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(34, 34, 34, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(35, 35, 35, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(36, 36, 36, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(37, 37, 37, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(38, 38, 38, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(39, 39, 39, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(40, 40, 40, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(41, 41, 41, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(42, 42, 42, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(43, 43, 43, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(44, 44, 44, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(45, 45, 45, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(46, 46, 46, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(47, 47, 47, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(48, 48, 48, 1);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(49, 1, 49, 2);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(50, 2, 50, 2);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(51, 3, 51, 2);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(52, 4, 52, 2);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(53, 5, 53, 2);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(54, 6, 54, 2);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(55, 1, 55, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(56, 2, 56, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(57, 3, 57, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(58, 4, 58, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(59, 5, 59, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(60, 6, 60, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(61, 7, 61, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(62, 8, 62, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(63, 9, 63, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(64, 10, 64, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(65, 11, 65, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(66, 12, 66, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(67, 13, 67, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(68, 14, 68, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(69, 15, 69, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(70, 16, 70, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(71, 17, 71, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(72, 18, 72, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(73, 19, 73, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(74, 20, 74, 3);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(75, 1, 75, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(76, 2, 76, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(77, 3, 77, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(78, 4, 78, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(79, 5, 28, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(80, 6, 79, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(81, 7, 80, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(82, 8, 81, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(83, 9, 82, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(84, 10, 83, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(85, 11, 84, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(86, 12, 85, 4);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(87, 1, 86, 5);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(88, 2, 87, 5);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(89, 3, 88, 5);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(90, 4, 89, 5);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(91, 5, 90, 5);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(92, 1, 91, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(93, 2, 92, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(94, 3, 93, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(95, 4, 94, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(96, 5, 95, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(97, 6, 96, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(98, 7, 97, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(99, 8, 98, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(100, 9, 99, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(101, 10, 100, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(102, 11, 101, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(103, 12, 102, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(104, 13, 103, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(105, 14, 104, 6);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(106, 1, 105, 7);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(107, 2, 106, 7);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(108, 3, 107, 7);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(109, 4, 108, 7);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(110, 1, 109, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(111, 2, 110, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(112, 3, 111, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(113, 4, 112, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(114, 5, 113, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(115, 6, 114, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(116, 7, 115, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(117, 8, 116, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(118, 9, 117, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(119, 10, 118, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(120, 11, 119, 8);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(121, 1, 120, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(122, 2, 121, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(123, 3, 122, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(124, 4, 123, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(125, 5, 124, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(126, 6, 125, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(127, 7, 126, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(128, 8, 127, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(129, 9, 128, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(130, 10, 129, 9);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(131, 1, 130, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(132, 2, 131, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(133, 3, 132, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(134, 4, 133, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(135, 5, 134, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(136, 6, 135, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(137, 7, 136, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(138, 8, 137, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(139, 9, 138, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(140, 10, 139, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(141, 11, 140, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(142, 12, 141, 10);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(143, 1, 142, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(144, 2, 143, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(145, 3, 144, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(146, 4, 145, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(147, 5, 146, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(148, 6, 147, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(149, 7, 148, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(150, 8, 149, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(151, 9, 150, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(152, 10, 151, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(153, 11, 152, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(154, 12, 153, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(155, 13, 154, 11);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(156, 1, 155, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(157, 2, 156, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(158, 3, 157, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(159, 4, 158, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(160, 5, 159, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(161, 6, 160, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(162, 7, 161, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(163, 8, 162, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(164, 9, 163, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(165, 10, 164, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(166, 11, 165, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(167, 12, 166, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(168, 13, 167, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(169, 14, 168, 12);
INSERT INTO `producto_canciones` (`id`, `numero_pista`, `cancion_id`, `producto_id`) VALUES
	(170, 15, 169, 12);

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
  KEY `publicaciones_vendedor_id_3c072a5e_fk_auth_user_id` (`vendedor_id`),
  KEY `publicaciones_producto_id_e5f4d28c` (`producto_id`),
  CONSTRAINT `publicaciones_producto_id_e5f4d28c_fk_productos_id` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `publicaciones_vendedor_id_3c072a5e_fk_auth_user_id` FOREIGN KEY (`vendedor_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla vinyles_local.publicaciones: ~12 rows (aproximadamente)
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(1, 120000.00, 2, 'El album esta en buen estado', '2025-07-07 18:36:38.306731', 1, 1, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(2, 235000.00, 7, 'Excelente Estado, Te viene con una integrante y un chocorramo', '2025-07-07 18:38:19.905516', 1, 2, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(3, 150000.00, 5, 'En buen estado, solo que tiene un mordisco', '2025-07-07 18:39:35.016069', 1, 3, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(4, 200000.00, 6, 'Es un album que esta en muy buen estado, casi nuevo', '2025-07-07 18:40:47.255985', 1, 4, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(5, 85000.00, 2, 'Calidad Aceptable, Lo use pocas veces y viene con una phtocard algo dañada.', '2025-07-07 18:42:37.286158', 1, 5, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(6, 170000.00, 3, 'Buen estado, de segunda mano', '2025-07-07 18:45:14.078150', 1, 6, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(7, 160000.00, 8, 'Esta en muy buen estado esta aun sellado como nuevo', '2025-07-07 18:46:27.976907', 1, 7, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(8, 69000.00, 1, 'Esta en un estado un poco deplorable , pero es original, apto para coleccionistas', '2025-07-07 18:50:42.434362', 1, 8, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(9, 320000.00, 10, 'Esta en un excelente esta nuevo', '2025-07-07 18:55:20.458604', 1, 9, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(10, 95000.00, 21, 'Clasico del rock con excelente estado y disfrutable', '2025-07-07 18:58:00.423089', 1, 10, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(11, 125000.00, 3, 'Es apto para coleccionistas el carton esta un poco desgastado pero el disco funciona bien', '2025-07-07 18:59:07.857181', 1, 11, 4);
INSERT INTO `publicaciones` (`id`, `precio`, `stock`, `descripcion_condicion`, `fecha_publicacion`, `activa`, `producto_id`, `vendedor_id`) VALUES
	(12, 50000.00, 1, 'Es un album para coleccionistas, ya que si es original pero el disco no funciona', '2025-07-07 19:01:07.379420', 1, 12, 4);

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
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
