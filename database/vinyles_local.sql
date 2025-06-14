-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.8.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7067
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_permission: ~40 rows (aproximadamente)
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
	(1, 'pbkdf2_sha256$1000000$IHl9F1X4p8yHxkfwwwgJTB$ut5YyPEJJ2PdfJ2VZ/TVIHX5LGYg/rtgOOCrqKSJhPM=', '2025-06-06 01:57:09.850898', 1, 'adminOne', '', '', 'adminone@gmail.com', 1, 1, '2025-05-30 02:22:23.892608');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(2, 'pbkdf2_sha256$1000000$3uLNUO3WxlaOptKesonJEB$pevuoUC4lo5jN0rDv9LV3K6sm6U5b+ZQ97+87vTweq4=', '2025-06-12 03:58:34.159328', 0, 'stebanpls', 'Steban', '', 'stebanpulido@gmail.com', 0, 1, '2025-06-06 00:42:50.616501');

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
	(2, NULL, NULL, NULL, 'fotos_perfil/user_2/8f55b4dc52444bc68618511dd82b5391.jpg');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_admin_log: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.django_content_type
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_content_type: ~10 rows (aproximadamente)
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

-- Volcando estructura para tabla vinyles_local.django_migrations
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_migrations: ~25 rows (aproximadamente)
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

-- Volcando estructura para tabla vinyles_local.django_session
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_session: ~14 rows (aproximadamente)
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
	('ija118w66rbpnrje2t8bo22v1tbazup4', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uL0ch:qvQwroSRpkC_4OWVcmGfhZcS9zSYjQ_HuoYpvX1MVRg', '2025-06-13 14:22:15.284156');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('kdqm7spw1m4ly2kx2hvmypasaon73djl', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPZ5G:Y0n4EPaXjivxidHo3Qy_aPDeIlQBtlW1wyLxD2E3Ifc', '2025-06-26 03:58:34.181983');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('qep9uj1e9ow8fkh1ahuqchc9w7munuof', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uNijT:QEYOPomMHGivpVgyLfO8czwE3QcPjhl9242QnSApjKI', '2025-06-21 01:52:27.320475');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('tfsrm3rld6oxni0i8lpf1dksdtqz2ko9', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPYcd:RfB8xuuY2h2EkpFT-ZcL5wAaCB-84vcEJTrF8PFuz48', '2025-06-26 03:28:59.260107');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('tuy3wbgs55uyhrsege82ixoy9ylg9opb', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uPXZn:sKqs4gfvKkBCkCThWs9l9GW6Eq2Ow9Meh33CZvomtso', '2025-06-26 02:21:59.323981');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('ui7eu8umi3ny1h6ihn9l51glaudnzw2k', '.eJxVjDsOwjAQBe_iGllafzaYkp4zWOv1GgeQI8VJFXF3iJQC2jczb1OR1qXGtcscx6wuyqjT75aIn9J2kB_U7pPmqS3zmPSu6IN2fZuyvK6H-3dQqddvzSIueQ-FeUBAy64goQvGFGesScE64ACckMuAnMGfLQKRp5ycEKr3B-naOCk:1uOpp5:zUoPmXm724Qf9yIXe7qZapn0A6OVp3Q03JDEL6og-9M', '2025-06-24 03:38:51.474837');

-- Volcando estructura para tabla vinyles_local.generos
DROP TABLE IF EXISTS `generos`;
CREATE TABLE IF NOT EXISTS `generos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.generos: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
