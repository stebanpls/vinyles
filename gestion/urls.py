# from django.contrib import admin
from django.urls import include, path

from . import views

# ==============================================================================
# URLs de la aplicación 'gestion'
# ==============================================================================
# Este archivo ahora organiza las URLs por su función (públicas, de comprador,
# de vendedor, de panel de admin) para mayor claridad y mantenimiento.

# --- URLs Públicas (accesibles para todos) ---
public_patterns = [
    path("", views.inicio_view, name="pub_inicio"),
    path("albumes/", views.pub_albumes, name="pub_albumes"),
    path("vinilo/<int:producto_id>/", views.pub_vinilo, name="pub_vinilo"),
    path("nosotros/", views.pub_nosotros, name="pub_nosotros"),
    path("terminos-y-condiciones/", views.pub_terminos, name="pub_terminos"),
    path("reembolsos/", views.pub_reembolsos, name="pub_reembolsos"),
    path("soporte/", views.pub_soporte, name="pub_soporte"),
    path("ddl/", views.pub_ddl, name="pub_ddl"),
]

# --- URLs de Autenticación (login, logout, registro) ---
auth_patterns = [
    path("login/", views.pub_login, name="pub_login"),
    path("logout/", views.pub_log_out, name="pub_log_out"),
    path("registro/", views.pub_registro, name="pub_registro"),
    path("desactivar-cuenta/", views.desactivar_usuario_y_logout, name="desactivar_usuario"),
]

# --- URLs del Comprador (requieren inicio de sesión) ---
buyer_patterns = [
    path("inicio/", views.com_inicio, name="com_inicio"),
    path("albumes/", views.com_albumes, name="com_albumes"),
    path("carrito/", views.com_carrito, name="com_carrito"),
    path("pago/", views.com_checkout, name="com_checkout"),
    path("perfil/", views.com_perfil, name="com_perfil"),
    path("perfil/editar/", views.com_perfil_editar, name="com_perfil_editar"),
    path("envio/progreso/", views.com_progreso_envio, name="com_progreso_envio"),
    # Las páginas de 'nosotros', 'terminos', etc. pueden reutilizar las públicas o tener su propia versión
    path("nosotros/", views.com_nosotros, name="com_nosotros"),
    path("terminos/", views.com_terminos, name="com_terminos"),
    path("reembolsos/", views.com_reembolsos, name="com_reembolsos"),
    path("soporte/", views.com_soporte, name="com_soporte"),
]

# --- URLs del Vendedor (requieren inicio de sesión y permisos de vendedor) ---
seller_patterns = [
    path("vender/", views.ven_crear, name="ven_crear"),
    path("vender/importar/", views.ven_importar_desde_discogs, name="ven_importar_desde_discogs"),
    path(
        "vender/importar/seleccionar/<int:release_id>/", views.ven_seleccionar_version, name="ven_seleccionar_version"
    ),
    path("vender/crear-catalogo/", views.ven_crear_producto_nuevo, name="ven_crear_producto_nuevo"),
    path("mis-productos/", views.ven_producto, name="ven_producto"),
    path("mis-productos/<int:publicacion_id>/editar/", views.ven_editar_producto, name="ven_editar_producto"),
    path("mis-productos/<int:publicacion_id>/eliminar/", views.ven_eliminar_producto, name="ven_eliminar_producto"),
    path("perfil/", views.com_perfil, {"user_mode": "vendedor"}, name="ven_perfil"),
    path("notificaciones/", views.ven_notificaciones, name="ven_notificaciones"),
    path("nosotros/", views.ven_nosotros, name="ven_nosotros"),
    path("terminos/", views.ven_terminos, name="ven_terminos"),
    path("bad/", views.ven_bad, name="ven_bad"),
]

# --- URLs del Panel de Administración (requieren permisos de staff) ---
admin_patterns = [
    path("", views.admin_administrador, name="admin_administrador"),
    path("productos/", views.admin_producto, name="admin_producto"),
    path("productos/adpro/", views.admin_adPro, name="admin_adPro"),
    path("productos/buscar-discogs/", views.admin_buscar_album_discogs, name="admin_buscar_album_discogs"),
    path("productos/importar-discogs/", views.admin_importar_album_discogs, name="admin_importar_album_discogs"),
    path("generos/", views.admin_generos, name="admin_generos"),
    path("usuarios/", views.admin_gestion_users, name="admin_gestion_users"),
    path("usuarios/nuevos/", views.admin_new_users, name="admin_new_users"),
    path("usuarios/bloqueados/", views.admin_bloq_users, name="admin_bloq_users"),
    path("usuarios/<int:user_id>/", views.admin_ver_perfil_usuario, name="admin_ver_perfil_usuario"),
    path("usuarios/<int:user_id>/editar/", views.admin_user_edit, name="admin_user_edit"),
    path("usuarios/<int:usuario_id>/eliminar/", views.admin_eliminar_usuario, name="admin_eliminar_usuario"),
    path("usuarios/<int:usuario_id>/bloquear/", views.admin_bloquear_usuario, name="admin_bloquear_usuario"),
    path("administradores/", views.admin_gestion_administradores, name="admin_gestion_administradores"),
    path("administradores/registrar/", views.admin_registrar_staff, name="admin_registrar_staff"),
    path("pedidos/", views.admin_pedido, name="admin_pedido"),
    path("pedidos/pendientes/", views.admin_pedido_pendiente, name="admin_pedido_pendiente"),
    path("pedidos/realizados/", views.admin_pedido_realizado, name="admin_pedido_realizado"),
    path("ventas/", views.admin_ventas, name="admin_ventas"),
    path("ventas/top/", views.admin_mas_vendidos, name="admin_mas_vendidos"),
    path("reembolsos/", views.admin_reembolsos, name="admin_reembolsos"),
    path("verificacion/", views.admin_verificacion, name="admin_verificacion"),
    path("notificaciones/", views.admin_notificaciones, name="admin_notificaciones"),
    path("nosotros/", views.admin_nosotros, name="admin_nosotros"),
    path("terminos/", views.admin_terminos, name="admin_terminos"),
]

# --- URLs para llamadas AJAX (no destinadas a ser visitadas directamente) ---
ajax_patterns = [
    path("cargar-albumes/", views.ajax_cargar_albumes, name="ajax_cargar_albumes"),
    path("buscar-artistas/", views.ajax_buscar_artistas, name="ajax_buscar_artistas"),
    path("get-album-details/", views.ajax_get_album_details, name="ajax_get_album_details"),
    path("importar-album/", views.ajax_importar_album, name="ajax_importar_album"),
    path("modal/artista/crear/", views.artista_form_modal, name="modal_artista_crear"),
    path("modal/genero/crear/", views.modal_genero, name="modal_genero_crear"),
    path("modal/cancion/crear/", views.modal_cancion, name="modal_cancion_crear"),
    path("modal/productor/crear/", views.modal_productor, name="modal_productor_crear"),
]

# --- URL PATTERNS PRINCIPAL ---
# Aquí combinamos todos los patrones de URL bajo prefijos claros.
urlpatterns = [
    path("", include(public_patterns)),
    path("cuenta/", include(auth_patterns)),
    path("comprador/", include(buyer_patterns)),
    path("vendedor/", include(seller_patterns)),
    path("panel-admin/", include(admin_patterns)),
    path("ajax/", include(ajax_patterns)),
]
