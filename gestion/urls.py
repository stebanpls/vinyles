# from django.contrib import admin
from django.urls import path
from . import views
# Importar settings y los archivos estáticos
from django.conf import settings
# from django.contrib.staticfiles.urls import static # Esta funciona, pero la de abajo es más convencional para MEDIA_URL
from django.conf.urls.static import static # Recomendada para servir MEDIA_URL en desarrollo

urlpatterns = [
    # URL DE ADMIN
    # path('admin/', admin.site.urls, name='admin'),

    # URLS DE LA CARPETA "PUBLICO"
    path('', views.pub_inicio, name='pub_inicio'), # Cuando vamos a acceder a una URL, vamos a usar este nombre
    path('pub_albumes/', views.pub_albumes, name='pub_albumes'),
    path('pub_codigo_recuperacion/', views.pub_codigo_recuperacion, name='pub_codigo_recuperacion'),
    path('pub_ddl/', views.pub_ddl, name='pub_ddl'),
    path('pub_login/', views.pub_login, name='pub_login'),
    path('pub_login_administrador/', views.pub_login_administrador, name='pub_login_administrador'),
    path('pub_logOut/', views.pub_logOut, name='pub_logOut'),
    path('pub_nosotros/', views.pub_nosotros, name='pub_nosotros'),
    path('pub_reembolsos/', views.pub_reembolsos, name='pub_reembolsos'),
    path('pub_registro/', views.pub_registro, name='pub_registro'),
    path('pub_restablecer_contrasena/', views.pub_restablecer_contrasena, name="pub_restablecer_contrasena"),
    path('pub_restablecer_contrasena_admin/', views.pub_restablecer_contrasena_admin, name='pub_restablecer_contrasena_admin'),
    path('pub_soporte/', views.pub_soporte, name='pub_soporte'),
    path('pub_terminos/', views.pub_terminos, name='pub_terminos'),
    path('pub_vinilo/', views.pub_vinilo, name='pub_vinilo'),
    
    # URLS DE LA CARPETA "COMPRADOR"
    path('com_inicio/', views.com_inicio, name='com_inicio'),
    path('com_albumes/', views.com_albumes, name='com_albumes'),
    path('com_carrito/', views.com_carrito, name='com_carrito'),
    path('com_checkout/', views.com_checkout, name='com_checkout'),
    path('com_nosotros/', views.com_nosotros, name='com_nosotros'),
    path('com_perfil/', views.com_perfil, name='com_perfil'),
    path('com_progreso_envio/', views.com_progreso_envio, name='com_progreso_envio'),
    path('com_reembolsos/', views.com_reembolsos, name='com_reembolsos'),
    path('com_soporte/', views.com_soporte, name='com_soporte'),
    path('com_terminos/', views.com_terminos, name='com_terminos'),
    
    # URLS DE LA CARPETA "VENDEDOR"
    path('ven_bad/', views.ven_bad, name='ven_bad'),
    path('ven_crear/', views.ven_crear, name='ven_crear'),
    path('ven_notificaciones/', views.ven_notificaciones, name='ven_notificaciones'),
    path('ven_perfil/', views.ven_perfil, name='ven_perfil'),
    path('ven_producto/', views.ven_producto, name='ven_producto'),
    path('ven_sobre_nosotros/', views.ven_sobre_nosotros, name='ven_sobre_nosotros'),
    
    # URLS DE LA CARPETA "ADMINISTRADOR"
    path('admin_administrador/', views.admin_administrador, name = 'admin_administrador'),
    path('admin_notificaciones/', views.admin_notificaciones, name='admin_notificaciones'),
    path('admin_pedido/', views.admin_pedido, name = 'admin_pedido'),
    path('admin_producto/', views.admin_producto, name = 'admin_producto'),
    path('admin_reembolsos', views.admin_reembolsos, name='admin_reembolsos'),
    path('admin_usuario/', views.admin_usuario, name = 'admin_usuario'),
    path('admin_verificacion/', views.admin_verificacion, name = 'admin_verificacion'),
    path('admin_adPro/', views.admin_adPro, name = 'admin_adPro'),
    path('admin_bloq_users', views.admin_bloq_users, name='admin_bloq_users'),
    path('admin_generos/', views.admin_generos, name='admin_generos'),
    path('admin_gestion_users/', views.admin_gestion_users, name='admin_gestion_users'),
    path('admin_new_users', views.admin_new_users, name='admin_new_users'),
    path('admin_pedido_pendiente', views.admin_pedido_pendiente, name='admin_pedido_pendiente'),
    path('admin_pedido_realizado', views.admin_pedido_realizado, name='admin_pedido_realizado'),
    path('admin_ventas/', views.admin_ventas, name='admin_ventas'),
    path('admin_sobre_nosotros/', views.admin_sobre_nosotros, name='admin_sobre_nosotros'),
    
    # URLS DE LOS ÁLBUMES
    path('bts/', views.bts, name='bts'),
    path('cartiMusic/', views.cartiMusic, name='cartiMusic'),
    path('eminemShow', views.eminemShow, name='eminemShow'),
    path('exitosJoe/', views.exitosJoe, name='exitosJoe'),
    path('gnrAppetite/', views.gnrAppetite, name='gnrAppetite'),
    path('master/', views.master, name='master'),
    path('mjBad', views.mjBad, name='mjBad'),
    path('mjThriller/', views.mjThriller, name='mjThriller'),
    path('nirvana/', views.nirvana, name='nirvana'),
    path('theBeatles/', views.theBeatles, name='theBeatles'),
    
    # URLS DE LOS USUARIOS
    path('lauraG/', views.lauraG, name='lauraG'),
    path('carlosR/', views.carlosR, name='carlosR'),
    path('camilaQ/', views.camilaQ, name='camilaQ'),
    path('jhonM/', views.jhonM, name='jhonM'),
    path('alexR/', views.alexR, name='alexR'),
    path('andreaVillalobos', views.andreaVillalobos, name='andreaVillalobos'),
    path('benjaminCastro', views.benjaminCastro, name='benjaminCastro'),
    path('crisitanDominguez', views.cristianDominguez, name='cristianDominguez'),
    path('angelaTorres', views.angelaTorres, name='angelaTorres'),
    path('elisaNaranjo', views.elisaNaranjo, name='elisaNaranjo'),
    path('emilioTorres', views.emilioTorres, name='emilioTorres'),
    path('andreaVillalobos2', views.andreaVillalobos2, name='andreaVillalobos2'),
    path('benjaminCastro2', views.benjaminCastro2, name='benjaminCastro2'),
    path('crisitanDominguez2', views.cristianDominguez2, name='cristianDominguez2'),
    path('angelaTorres2', views.angelaTorres2, name='angelaTorres2'),
    path('elisaNaranjo2', views.elisaNaranjo2, name='elisaNaranjo2'),
    path('emilioTorres2', views.emilioTorres2, name='emilioTorres2'),
    path('sofiaRamirez', views.sofiaRamirez, name='sofiaRamirez'),
    path('esperanzaBarrera', views.esperanzaBarrera, name='esperanzaBarrera'),
    path('fernandoMolina', views.fernandoMolina, name='fernandoMolina'),

    # URLS DE LA CARPETA "CRUD"
    path('crud/', views.crud, name='crud'),
    path('crud/crear/', views.crud_crear, name='crud_crear'),
    path('crud/editar/<int:id>', views.crud_editar, name='crud_editar'),
    path('crud/eliminar/<int:id>', views.crud_eliminar, name='crud_eliminar'), # Actualizado para consistencia

    # URLS DELA CARPETA "PLANTILLAS"
    path('plantilla_publico/', views.plantilla_publico, name='plantilla_publico'),
] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT) # Esta línea muestra los archivos de medios durante el desarrollo