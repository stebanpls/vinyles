-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.7.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.10.0.7000
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
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_group: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.auth_group_permissions
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.auth_user: ~2 rows (aproximadamente)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$1000000$IHl9F1X4p8yHxkfwwwgJTB$ut5YyPEJJ2PdfJ2VZ/TVIHX5LGYg/rtgOOCrqKSJhPM=', '2025-06-09 17:32:08.930587', 1, 'adminOne', '', '', 'adminone@gmail.com', 1, 1, '2025-05-30 02:22:23.892000');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(8, 'pbkdf2_sha256$1000000$3WjHXqoGVRUFpM1JZgOPPU$i7aPa0MhA9qA/6DWSht1C5DDr2c0k+ju1Io4B/3wSVI=', '2025-06-09 17:51:21.262326', 0, 'stebanpls', 'Steban', '', 'stebanpulido@gmail.com', 0, 1, '2025-06-09 17:49:09.894709');

-- Volcando estructura para tabla vinyles_local.auth_user_groups
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
	(8, NULL, NULL, NULL, 'fotos_perfil/foto7.jpg');

-- Volcando estructura para tabla vinyles_local.clientes_generos_favoritos
CREATE TABLE IF NOT EXISTS `clientes_generos_favoritos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `genero_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientes_generos_favoritos_cliente_id_genero_id_f7f0faef_uniq` (`cliente_id`,`genero_id`),
  KEY `clientes_generos_fav_genero_id_3d9af98c_fk_gestion_g` (`genero_id`),
  CONSTRAINT `clientes_generos_fav_cliente_id_f9a37fec_fk_clientes_` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`user_id`),
  CONSTRAINT `clientes_generos_fav_genero_id_3d9af98c_fk_gestion_g` FOREIGN KEY (`genero_id`) REFERENCES `gestion_genero` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.clientes_generos_favoritos: ~0 rows (aproximadamente)

-- Volcando estructura para tabla vinyles_local.django_admin_log
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_admin_log: ~6 rows (aproximadamente)
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2025-06-09 16:14:38.249089', '4', 'aeri', 3, '', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(2, '2025-06-09 16:14:42.672274', '5', 'omar1', 3, '', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(3, '2025-06-09 16:14:46.589325', '3', 'OWl', 3, '', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(4, '2025-06-09 16:14:50.460012', '2', 'stebanpls', 3, '', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(5, '2025-06-09 16:24:22.432296', '6', 'stebanplz', 3, '', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(6, '2025-06-09 17:41:13.271286', '7', 'stebanpls', 3, '', 4, 1);

-- Volcando estructura para tabla vinyles_local.django_content_type
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
	(3, 'auth', 'group');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(2, 'auth', 'permission');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(4, 'auth', 'user');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(10, 'gestion', 'cliente');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(8, 'gestion', 'clienteprofile');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(7, 'gestion', 'crud');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(9, 'gestion', 'genero');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(6, 'sessions', 'session');

-- Volcando estructura para tabla vinyles_local.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_migrations: ~22 rows (aproximadamente)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2025-05-30 15:45:19.179271');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(2, 'auth', '0001_initial', '2025-05-30 15:45:19.455595');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(3, 'admin', '0001_initial', '2025-05-30 15:45:19.526716');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(4, 'admin', '0002_logentry_remove_auto_add', '2025-05-30 15:45:19.536338');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-05-30 15:45:19.547027');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(6, 'contenttypes', '0002_remove_content_type_name', '2025-05-30 15:45:19.604852');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(7, 'auth', '0002_alter_permission_name_max_length', '2025-05-30 15:45:19.638945');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(8, 'auth', '0003_alter_user_email_max_length', '2025-05-30 15:45:19.661355');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(9, 'auth', '0004_alter_user_username_opts', '2025-05-30 15:45:19.671063');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(10, 'auth', '0005_alter_user_last_login_null', '2025-05-30 15:45:19.698343');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(11, 'auth', '0006_require_contenttypes_0002', '2025-05-30 15:45:19.700114');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(12, 'auth', '0007_alter_validators_add_error_messages', '2025-05-30 15:45:19.711830');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(13, 'auth', '0008_alter_user_username_max_length', '2025-05-30 15:45:19.735207');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(14, 'auth', '0009_alter_user_last_name_max_length', '2025-05-30 15:45:19.756878');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(15, 'auth', '0010_alter_group_name_max_length', '2025-05-30 15:45:19.778532');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(16, 'auth', '0011_update_proxy_permissions', '2025-05-30 15:45:19.790292');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(17, 'auth', '0012_alter_user_first_name_max_length', '2025-05-30 15:45:19.811013');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(18, 'gestion', '0001_initial', '2025-05-30 15:45:19.823356');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(19, 'sessions', '0001_initial', '2025-05-30 15:45:19.846536');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(20, 'gestion', '0002_clienteprofile', '2025-06-04 12:29:35.564275');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(21, 'gestion', '0003_genero_clienteprofile_foto_perfil_and_more', '2025-06-06 16:37:03.422041');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(22, 'gestion', '0004_cliente_delete_clienteprofile', '2025-06-06 16:37:03.556682');

-- Volcando estructura para tabla vinyles_local.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.django_session: ~12 rows (aproximadamente)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('0yjopemynybe17tsjym7c4top51ybitw', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uMsp5:AzCNt6tqzVjimuuuICNdTDdUuX_SKhUAycwJ69JmeRM', '2025-06-18 18:26:47.493919');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('1a0sc3lcguu56tyqxpap4qtbs0u2nhy0', '.eJxVjLEOAiEQRP-F2hA8WCCW9n4D2WVBTg0kx11l_He55AotppiZN_MWAbe1hK2nJcwsLsKJ029GGJ-p7gU_sN6bjK2uy0xyR-TRdnlrnF7Xg_07KNjLWGtDOOicyU-UhrMK2EyQXdTJoIlAYIwd8pDZg8Wzy6w8K9COFYvPFwViODA:1uOfJi:4Sdll4PHpTaiapbpqCpLktko63wvxprmLNTtdTnYr90', '2025-06-23 16:25:46.829532');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('1bh6pjagvgp0iz9k0jy5efwxilppmtjy', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uMnUf:yKM1QicfaY7ZGVbnsLeK7UUAomfmtT0gawXiTmucipc', '2025-06-18 12:45:21.902347');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('4jh8er8a8fuzrzvwyhxx18ijopbgvucb', '.eJxVjLEOAiEQRP-F2hA8WCCW9n4D2WVBTg0kx11l_He55AotppiZN_MWAbe1hK2nJcwsLsKJ029GGJ-p7gU_sN6bjK2uy0xyR-TRdnlrnF7Xg_07KNjLWGtDOOicyU-UhrMK2EyQXdTJoIlAYIwd8pDZg8Wzy6w8K9COFYvPFwViODA:1uOfMw:K7hgP1AfFg2pgzO0rZ6M0qJA3BJZHek0mkHJR4tnr-k', '2025-06-23 16:29:06.352531');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('5ry9l448sqd7upo8cj728b3d9tqi71i3', 'e30:1uMnuc:rlFIaEXu6QE5x60F1kJy89KUOMQwYsIXFVeG-KkwHcM', '2025-06-18 13:12:10.502703');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('d99jryr1gq5ugyxuqenuwl18w71aj15w', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uL1z1:a4z16zYIpu23bOk-ThoTHjRNJtN1LQ_Ulv6NXIcWm9o', '2025-06-13 15:49:23.024392');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('e5bc7gigkifwmtvgdp0ugg0zy5w0wqvf', '.eJxVjMEOwiAQRP-FsyGwpYAevfsNZBcWqRqalPZk_Hdp0oOeZjJvZt4i4LaWsDVewpTERYA4_WaE8cl1B-mB9T7LONd1mUjuFXnQJm9z4tf16P4dFGylr60_E2TkmMh6A6RV6sKguhk1u4HMGJXN2mk9eGcMggFwGZEVayLx-QLX-Td_:1uNa5O:bPutndZ4pMq9lQex1zT4jMC_IcuQw-Yo_1nujmIvk2Y', '2025-06-20 16:38:30.352446');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('glds6unhre7q5wo4ye35sbff6hczh8sx', '.eJxVjMEOwiAQRP-FsyGwpYAevfsNZBcWqRqalPZk_Hdp0oOeZjJvZt4i4LaWsDVewpTERYA4_WaE8cl1B-mB9T7LONd1mUjuFXnQJm9z4tf16P4dFGylr60_E2TkmMh6A6RV6sKguhk1u4HMGJXN2mk9eGcMggFwGZEVayLx-QLX-Td_:1uNbF0:ZpJ0FnEOHYGMO6u80ch_yLNWs7mOIgyFDtRzdeb0bDw', '2025-06-20 17:52:30.796084');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('lekdzlo5orzccbm6hrn7whgu0gqp5nma', '.eJxVjDsOwjAQRO_iGln-xGubkj5nsPzZxQHkSHFSIe5OIqWAZop5b-bNQtzWGraOS5gKuzLHLr9divmJ7QDlEdt95nlu6zIlfij8pJ2Pc8HX7XT_DmrsdV8DaC-IdM7F6wF1IQXGSComkhBGJT2AAW-FRXQWBLnspVAS90SPkn2-1-o3KA:1uOgeX:yf-Kap2IScS9gABqPVgsQZ-KdZenSJXz9oIRyeBc4qw', '2025-06-23 17:51:21.265193');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('rfac9v28x0xboawjc7bc1d8e889yyvcc', '.eJxVjMEOwiAQRP-FsyGwpYAevfsNZBcWqRqalPZk_Hdp0oOeZjJvZt4i4LaWsDVewpTERYA4_WaE8cl1B-mB9T7LONd1mUjuFXnQJm9z4tf16P4dFGylr60_E2TkmMh6A6RV6sKguhk1u4HMGJXN2mk9eGcMggFwGZEVayLx-QLX-Td_:1uMo0b:ZejibWr7h8JX_rCtNihujv9PfIy_koobAK49i08-akU', '2025-06-18 13:18:21.997030');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('vaygsx7nuluw2jh9elxoh81rjwtn71he', 'e30:1uMnvK:Lt8zHgd_G0Cg1RED9qO2UTObl4q7TdiV6phyf5z-4M4', '2025-06-18 13:12:54.966525');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('w3kf2813ldkhfp1q3m1m5oymatsr9ihf', '.eJxVjMsOwiAQRf-FtSHyBpfu_QYyMINUDSSlXRn_3TbpQrfnnHvfLMK61LgOmuOE7MIEO_2yBPlJbRf4gHbvPPe2zFPie8IPO_itI72uR_t3UGHUbZ0JCnmwhEFKRI3OpOCcVSAyeOetUEa7fFYejPI-IW7YSocJS9AF2OcLA8c4qw:1uOfHy:Qmw9jQgvDJt0hiKtvG6yAylnTUy4qhqMOzGy2dxGK3M', '2025-06-23 16:23:58.625722');

-- Volcando estructura para tabla vinyles_local.gestion_crud
CREATE TABLE IF NOT EXISTS `gestion_crud` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `clase` longtext DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `fechaIngreso` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.gestion_crud: ~0 rows (aproximadamente)
INSERT INTO `gestion_crud` (`id`, `nombre`, `apellido`, `foto`, `clase`, `direccion`, `fechaIngreso`) VALUES
	(1, 'Steban', 'Pulido', 'fotos/foto7.jpg', 'TPS', '192 street', '2025-05-30');

-- Volcando estructura para tabla vinyles_local.gestion_genero
CREATE TABLE IF NOT EXISTS `gestion_genero` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla vinyles_local.gestion_genero: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
