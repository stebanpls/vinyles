-- SQL de Workbench
-- Eliminar Base de Datos
DROP DATABASE IF EXISTS vinyles;

-- Crear Base de Datos
CREATE DATABASE IF NOT EXISTS vinyles;

-- Ingresar BD
USE vinyles;

--
-- Estructuras de tabla de vinyles_local.sql adaptados
--

-- Crear tabla Artistas
DROP TABLE IF EXISTS `artistas`;
CREATE TABLE IF NOT EXISTS `artistas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Artistas',
  `nombre` varchar(200) NOT NULL COMMENT 'Nombres de los Artistas',
  `informacion` longtext NOT NULL COMMENT 'Información biográfica del Artista',
  `foto` varchar(100) DEFAULT NULL COMMENT 'Ruta de la foto del Artista',
  `discogs_id` varchar(255) DEFAULT NULL COMMENT 'ID del Artista en Discogs para integración',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `discogs_id` (`discogs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Artistas';

-- Crear tabla Canciones
DROP TABLE IF EXISTS `canciones`;
CREATE TABLE IF NOT EXISTS `canciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de las Canciones',
  `nombre` varchar(200) NOT NULL COMMENT 'Nombres de las Canciones',
  `duracion` time(6) NOT NULL COMMENT 'Duración de la Canción',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de las Canciones';

-- Crear tabla Clientes
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Clientes',
  `numeroDocumento` varchar(20) NOT NULL COMMENT 'Número de documento de identificación del Cliente',
  `tipoDocumento` varchar(50) NOT NULL COMMENT 'Tipo de documento de identificación del Cliente',
  `foto` varchar(100) DEFAULT NULL COMMENT 'Ruta de la foto del Cliente',
  `direccion` varchar(255) DEFAULT NULL COMMENT 'Dirección de residencia del Cliente',
  `telefono` varchar(20) DEFAULT NULL COMMENT 'Número de teléfono del Cliente',
  `fecha_nacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento del Cliente',
  `genero` varchar(1) DEFAULT NULL COMMENT 'Género del Cliente (M/F/O)',
  `user_id` int(11) NOT NULL COMMENT 'ID, y Llave Foránea del Usuario asociado (Django Auth User)',
  `estado_id` int(11) NOT NULL COMMENT 'ID, y Llave Foránea del estado del usuario',
  PRIMARY KEY (`id`),
  UNIQUE KEY `numeroDocumento` (`numeroDocumento`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `fk_cliente_estado` (`estado_id`),
  CONSTRAINT `fk_cliente_estado` FOREIGN KEY (`estado_id`) REFERENCES `clientes_estadousuario` (`id`),
  CONSTRAINT `fk_cliente_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Clientes';

-- Crear tabla EstadoUsuario (para el estado de los clientes)
DROP TABLE IF EXISTS `clientes_estadousuario`;
CREATE TABLE IF NOT EXISTS `clientes_estadousuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del estado de usuario',
  `estado` varchar(50) NOT NULL COMMENT 'Nombre del estado (e.g., Activo, Inactivo)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena los estados posibles de un cliente';

-- Crear tabla Generos
DROP TABLE IF EXISTS `generos`;
CREATE TABLE IF NOT EXISTS `generos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Géneros musicales',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombres de los Géneros musicales',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Géneros musicales';

-- Crear tabla Medios de Pago
DROP TABLE IF EXISTS `medios_de_pago`;
CREATE TABLE IF NOT EXISTS `medios_de_pago` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Medios de Pago',
  `tipo` varchar(50) NOT NULL COMMENT 'Tipo de medio de pago (e.g., Tarjeta de Crédito, PayPal)',
  `nombre_titular` varchar(255) DEFAULT NULL COMMENT 'Nombre del titular del medio de pago',
  `numero_tarjeta` varchar(20) DEFAULT NULL COMMENT 'Número de tarjeta (si aplica)',
  `fecha_expiracion` date DEFAULT NULL COMMENT 'Fecha de expiración de la tarjeta (si aplica)',
  `cvv` varchar(4) DEFAULT NULL COMMENT 'Código de seguridad de la tarjeta (si aplica)',
  `cliente_id` int(11) NOT NULL COMMENT 'ID, y Llave Foránea del Cliente, que llamará la id de la tabla cliente',
  PRIMARY KEY (`id`),
  KEY `fk_mediodepago_cliente` (`cliente_id`),
  CONSTRAINT `fk_mediodepago_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Medios de Pago';

-- Crear tabla Pedidos
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Pedidos',
  `fecha_pedido` datetime(6) NOT NULL COMMENT 'Fecha y hora en que se realizó el pedido',
  `subtotal` decimal(10,2) NOT NULL COMMENT 'Suma de los precios de los productos sin envío',
  `costo_envio` decimal(10,2) NOT NULL COMMENT 'Costo del envío del pedido',
  `total` decimal(10,2) NOT NULL COMMENT 'Total del pedido (subtotal + costo_envio)',
  `direccion_envio` longtext NOT NULL COMMENT 'Dirección completa para el envío del pedido',
  `estado` varchar(1) NOT NULL COMMENT 'Estado actual del pedido (P=Procesando, E=Enviado, C=Completado, X=Cancelado)',
  `comprador_id` int(11) DEFAULT NULL COMMENT 'ID, y Llave Foránea del Comprador (Django Auth User)',
  PRIMARY KEY (`id`),
  KEY `fk_pedido_comprador` (`comprador_id`),
  CONSTRAINT `fk_pedido_comprador` FOREIGN KEY (`comprador_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Pedidos';

-- Crear tabla Productos
DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Productos',
  `nombre` varchar(200) NOT NULL COMMENT 'Nombres de los Productos (álbum, sencillo, etc.)',
  `descripcion` longtext DEFAULT NULL COMMENT 'Descripción detallada del Producto',
  `anio_lanzamiento` int(11) DEFAULT NULL COMMENT 'Año de lanzamiento del Producto',
  `imagen` varchar(100) DEFAULT NULL COMMENT 'Ruta de la imagen de portada del Producto',
  `artista_id` bigint(20) DEFAULT NULL COMMENT 'ID, y Llave Foránea del Artista principal del Producto',
  `genero_id` bigint(20) DEFAULT NULL COMMENT 'ID, y Llave Foránea del Género musical principal del Producto',
  `productor_id` bigint(20) DEFAULT NULL COMMENT 'ID, y Llave Foránea del Productor principal del Producto',
  PRIMARY KEY (`id`),
  KEY `fk_producto_artista` (`artista_id`),
  KEY `fk_producto_genero` (`genero_id`),
  KEY `fk_producto_productor` (`productor_id`),
  CONSTRAINT `fk_producto_artista` FOREIGN KEY (`artista_id`) REFERENCES `artistas` (`id`),
  CONSTRAINT `fk_producto_genero` FOREIGN KEY (`genero_id`) REFERENCES `generos` (`id`),
  CONSTRAINT `fk_producto_productor` FOREIGN KEY (`productor_id`) REFERENCES `productores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Productos (vinilos)';

-- Crear tabla Productores
DROP TABLE IF EXISTS `productores`;
CREATE TABLE IF NOT EXISTS `productores` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Productores',
  `nombre` varchar(200) NOT NULL COMMENT 'Nombres de los Productores',
  `informacion` longtext NOT NULL COMMENT 'Información sobre el Productor (sello discográfico, etc.)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Productores musicales';

-- Crear tabla Publicaciones
DROP TABLE IF EXISTS `publicaciones`;
CREATE TABLE IF NOT EXISTS `publicaciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de las Publicaciones (ofertas de venta)',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio de venta del Producto en esta publicación',
  `stock` int(10) unsigned NOT NULL COMMENT 'Cantidad de unidades disponibles para esta publicación',
  `descripcion_condicion` longtext NOT NULL COMMENT 'Descripción de la condición física del vinilo/producto',
  `fecha_publicacion` datetime(6) NOT NULL COMMENT 'Fecha y hora en que se realizó la publicación',
  `activa` tinyint(1) NOT NULL COMMENT 'Indica si la publicación está activa (1=Sí, 0=No)',
  `producto_id` bigint(20) NOT NULL COMMENT 'ID, y Llave Foránea del Producto que se está publicando',
  `vendedor_id` int(11) NOT NULL COMMENT 'ID, y Llave Foránea del Vendedor (Django Auth User)',
  PRIMARY KEY (`id`),
  KEY `fk_publicacion_producto` (`producto_id`),
  KEY `fk_publicacion_vendedor` (`vendedor_id`),
  CONSTRAINT `fk_publicacion_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `fk_publicacion_vendedor` FOREIGN KEY (`vendedor_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de las Publicaciones de productos';

-- Crear tabla Tickets de Soporte
DROP TABLE IF EXISTS `tickets_soporte`;
CREATE TABLE IF NOT EXISTS `tickets_soporte` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de los Tickets de Soporte',
  `descripcion` longtext NOT NULL COMMENT 'Descripción detallada del problema o consulta',
  `estado` varchar(20) NOT NULL COMMENT 'Estado actual del ticket (e.g., Abierto, En Proceso, Cerrado)',
  `fecha_creacion` datetime(6) NOT NULL COMMENT 'Fecha y hora de creación del ticket',
  `fecha_actualizacion` datetime(6) NOT NULL COMMENT 'Última fecha y hora de actualización del ticket',
  `cliente_id` int(11) NOT NULL COMMENT 'ID, y Llave Foránea del Cliente que generó el ticket (Django Auth User)',
  PRIMARY KEY (`id`),
  KEY `fk_ticket_cliente` (`cliente_id`),
  CONSTRAINT `fk_ticket_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Casos de nuestro Soporte Técnico';

-- Crear tabla Detalle de Pedido
DROP TABLE IF EXISTS `pedidos_detallepedido`;
CREATE TABLE IF NOT EXISTS `pedidos_detallepedido` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID del detalle del pedido',
  `cantidad` int(10) unsigned NOT NULL COMMENT 'Cantidad de unidades de este producto en el pedido',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio unitario del producto al momento de la compra',
  `pedido_id` bigint(20) NOT NULL COMMENT 'ID, y Llave Foránea del Pedido al que pertenece este detalle',
  `publicacion_id` bigint(20) NOT NULL COMMENT 'ID, y Llave Foránea de la Publicación (oferta) de la cual se compró el producto',
  PRIMARY KEY (`id`),
  KEY `fk_detallepedido_pedido` (`pedido_id`),
  KEY `fk_detallepedido_publicacion` (`publicacion_id`),
  CONSTRAINT `fk_detallepedido_publicacion` FOREIGN KEY (`publicacion_id`) REFERENCES `publicaciones` (`id`),
  CONSTRAINT `fk_detallepedido_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  CONSTRAINT `pedidos_detallepedido_cantidad_check` CHECK (`cantidad` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la información de los Productos de cada Pedido';

-- Crear tabla Producto Cancion (relación muchos a muchos entre productos y canciones)
DROP TABLE IF EXISTS `productos_productocancion`;
CREATE TABLE IF NOT EXISTS `productos_productocancion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de la relación Producto-Canción',
  `cancion_id` bigint(20) NOT NULL COMMENT 'ID, y Llave Foránea de la Canción',
  `producto_id` bigint(20) NOT NULL COMMENT 'ID, y Llave Foránea del Producto',
  PRIMARY KEY (`id`),
  UNIQUE KEY `productos_productocancion_producto_id_cancion_id_44f8087d_uniq` (`producto_id`,`cancion_id`),
  KEY `fk_prodcancion_cancion` (`cancion_id`),
  CONSTRAINT `fk_prodcancion_cancion` FOREIGN KEY (`cancion_id`) REFERENCES `canciones` (`id`),
  CONSTRAINT `fk_prodcancion_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Esta es la tabla que almacena la relación entre Productos y Canciones';

-- Crear tabla auth_user (Tabla de usuarios de Django)
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del usuario',
  `password` varchar(128) NOT NULL COMMENT 'Hash de la contraseña del usuario',
  `last_login` datetime(6) DEFAULT NULL COMMENT 'Fecha y hora del último inicio de sesión',
  `is_superuser` tinyint(1) NOT NULL COMMENT 'Indica si el usuario tiene todos los permisos sin asignarlos explícitamente',
  `username` varchar(150) NOT NULL COMMENT 'Nombre de usuario',
  `first_name` varchar(150) NOT NULL COMMENT 'Primer nombre del usuario',
  `last_name` varchar(150) NOT NULL COMMENT 'Apellido del usuario',
  `email` varchar(254) NOT NULL COMMENT 'Dirección de correo electrónico del usuario',
  `is_staff` tinyint(1) NOT NULL COMMENT 'Indica si el usuario puede acceder al sitio de administración',
  `is_active` tinyint(1) NOT NULL COMMENT 'Indica si la cuenta del usuario está activa (1=Sí, 0=No)',
  `date_joined` datetime(6) NOT NULL COMMENT 'Fecha y hora de registro del usuario',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de usuarios de autenticación de Django';

-- Crear tabla auth_group (Grupos de usuarios de Django)
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del grupo',
  `name` varchar(150) NOT NULL COMMENT 'Nombre del grupo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de grupos de usuarios de autenticación de Django';

-- Crear tabla auth_permission (Permisos de Django)
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del permiso',
  `name` varchar(255) NOT NULL COMMENT 'Nombre legible del permiso',
  `content_type_id` int(11) NOT NULL COMMENT 'ID del tipo de contenido asociado al permiso',
  `codename` varchar(100) NOT NULL COMMENT 'Nombre corto del permiso (código)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `fk_perm_contenttype` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de permisos de autenticación de Django';

-- Crear tabla auth_group_permissions (Relación entre grupos y permisos)
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de la relación grupo-permiso',
  `group_id` int(11) NOT NULL COMMENT 'ID del grupo',
  `permission_id` int(11) NOT NULL COMMENT 'ID del permiso',
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `fk_groupperm_perm` (`permission_id`),
  CONSTRAINT `fk_groupperm_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `fk_groupperm_group` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de unión entre grupos y permisos de Django';

-- Crear tabla auth_user_groups (Relación entre usuarios y grupos)
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de la relación usuario-grupo',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario',
  `group_id` int(11) NOT NULL COMMENT 'ID del grupo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `fk_usergroup_group` (`group_id`),
  CONSTRAINT `fk_usergroup_group` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `fk_usergroup_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de unión entre usuarios y grupos de Django';

-- Crear tabla auth_user_user_permissions (Relación entre usuarios y permisos directos)
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de la relación usuario-permiso',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario',
  `permission_id` int(11) NOT NULL COMMENT 'ID del permiso',
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `fk_userperm_perm` (`permission_id`),
  CONSTRAINT `fk_userperm_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `fk_userperm_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de unión entre usuarios y permisos directos de Django';

-- Crear tabla django_admin_log (Registro de acciones en el administrador de Django)
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del registro',
  `action_time` datetime(6) NOT NULL COMMENT 'Fecha y hora de la acción',
  `object_id` longtext DEFAULT NULL COMMENT 'ID del objeto afectado por la acción',
  `object_repr` varchar(200) NOT NULL COMMENT 'Representación textual del objeto afectado',
  `action_flag` smallint(5) unsigned NOT NULL COMMENT 'Tipo de acción (1=Adición, 2=Cambio, 3=Eliminación)',
  `change_message` longtext NOT NULL COMMENT 'Mensaje describiendo los cambios',
  `content_type_id` int(11) DEFAULT NULL COMMENT 'ID del tipo de contenido del objeto afectado',
  `user_id` int(11) NOT NULL COMMENT 'ID del usuario que realizó la acción',
  PRIMARY KEY (`id`),
  KEY `fk_adminlog_contenttype` (`content_type_id`),
  KEY `fk_adminlog_user` (`user_id`),
  CONSTRAINT `fk_adminlog_contenttype` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `fk_adminlog_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Registro de acciones en el administrador de Django';

-- Crear tabla django_content_type (Tipos de contenido de Django)
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del tipo de contenido',
  `app_label` varchar(100) NOT NULL COMMENT 'Etiqueta de la aplicación a la que pertenece el modelo',
  `model` varchar(100) NOT NULL COMMENT 'Nombre del modelo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla que almacena los tipos de contenido para los modelos de Django';

-- Crear tabla django_migrations (Migraciones de Django)
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID de la migración',
  `app` varchar(255) NOT NULL COMMENT 'Nombre de la aplicación de Django',
  `name` varchar(255) NOT NULL COMMENT 'Nombre del archivo de migración',
  `applied` datetime(6) NOT NULL COMMENT 'Fecha y hora en que se aplicó la migración',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Registro de migraciones de la base de datos de Django';

-- Crear tabla django_session (Sesiones de Django)
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL COMMENT 'Clave única de la sesión',
  `session_data` longtext NOT NULL COMMENT 'Datos de la sesión (serializados)',
  `expire_date` datetime(6) NOT NULL COMMENT 'Fecha y hora de expiración de la sesión',
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla que almacena las sesiones de usuario de Django';
