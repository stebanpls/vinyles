# from django.contrib import admin
from django.urls import path, include
from . import views
# Importar settings y los archivos estáticos
# from django.conf import settings # Ya no es necesario aquí si se maneja en urls.py del proyecto
# from django.conf.urls.static import static # Ya no es necesario aquí

urlpatterns = [
    # URL DE ADMIN
    # path('admin/', admin.site.urls, name='admin'),

    # URLS DE AUTENTICACIÓN
    path('accounts/', include('django.contrib.auth.urls')), # Esto incluye login, logout, password_change, password_reset, etc.

    # URLS DE LA CARPETA "ADMINISTRADOR"
    path('admin_adPro/', views.admin_adPro, name = 'admin_adPro'),
    path('admin_administrador/', views.admin_administrador, name = 'admin_administrador'),
    path('admin_bloq_users/', views.admin_bloq_users, name='admin_bloq_users'), # Añadido '/' al final
    path('admin_generos/', views.admin_generos, name='admin_generos'),
    path('admin_gestion_users/', views.admin_gestion_users, name='admin_gestion_users'),
    path('admin_new_users/', views.admin_new_users, name='admin_new_users'), # Añadido '/' al final
    path('admin_nosotros/', views.admin_nosotros, name='admin_nosotros'), # Renombrado desde admin_sobre_nosotros
    path('admin_notificaciones/', views.admin_notificaciones, name='admin_notificaciones'),
    path('admin_pedido/', views.admin_pedido, name = 'admin_pedido'),
    path('admin_pedido_pendiente/', views.admin_pedido_pendiente, name='admin_pedido_pendiente'), # Añadido '/' al final
    path('admin_pedido_realizado/', views.admin_pedido_realizado, name='admin_pedido_realizado'), # Añadido '/' al final
    path('admin_producto/', views.admin_producto, name = 'admin_producto'),
    path('admin_reembolsos/', views.admin_reembolsos, name='admin_reembolsos'), # Añadido '/' al final
    path('admin_terminos/', views.admin_terminos, name='admin_terminos'),
    path('admin_usuario/', views.admin_usuario, name = 'admin_usuario'),
    path('admin_ventas/', views.admin_ventas, name='admin_ventas'),
    path('admin_verificacion/', views.admin_verificacion, name = 'admin_verificacion'),
    path('admin_mas_vendidos/', views.admin_mas_vendidos, name = 'admin_mas_vendidos'),


    # URLS DE LA CARPETA "COMPRADOR"
    path('com_albumes/', views.com_albumes, name='com_albumes'),
    path('com_carrito/', views.com_carrito, name='com_carrito'),
    path('com_checkout/', views.com_checkout, name='com_checkout'),
    path('com_inicio/', views.com_inicio, name='com_inicio'),
    path('com_nosotros/', views.com_nosotros, name='com_nosotros'),
    # URLs para el perfil del comprador
    path('com_perfil/', views.com_perfil, name='com_perfil'), # Vista para mostrar el perfil
    path('com_perfil/editar/', views.com_perfil_editar, name='com_perfil_editar'), # Vista para editar el perfil
    path('com_progreso_envio/', views.com_progreso_envio, name='com_progreso_envio'),
    path('com_reembolsos/', views.com_reembolsos, name='com_reembolsos'),
    path('com_soporte/', views.com_soporte, name='com_soporte'),
    path('com_terminos/', views.com_terminos, name='com_terminos'),

    # URLS DE LA CARPETA "CRUD"
    path('crud/', views.crud, name='crud'), # Asegúrate que esta vista exista
    path('crud/crear/', views.crud_crear, name='crud_crear'),
    path('crud/editar/<int:id>', views.crud_editar, name='crud_editar'),
    path('crud/eliminar/<int:id>', views.crud_eliminar, name='crud_eliminar'), # Actualizado para consistencia

    # URLS DE LA CARPETA "PUBLICO"
    path('', views.pub_inicio, name='pub_inicio'), # Cuando vamos a acceder a una URL, vamos a usar este nombre
    path('pub_albumes/', views.pub_albumes, name='pub_albumes'),
    path('pub_codigo_recuperacion/', views.pub_codigo_recuperacion, name='pub_codigo_recuperacion'),
    path('pub_ddl/', views.pub_ddl, name='pub_ddl'), # Mantener si tienes la vista pub_ddl
    path('pub_log_out/', views.pub_log_out, name='pub_log_out'),
    path('pub_login/', views.pub_login, name='pub_login'),
    path('pub_nosotros/', views.pub_nosotros, name='pub_nosotros'),
    path('pub_reembolsos/', views.pub_reembolsos, name='pub_reembolsos'),
    path('pub_registro/', views.pub_registro, name='pub_registro'),
    path('pub_restablecer_contrasena/', views.pub_restablecer_contrasena, name="pub_restablecer_contrasena"), # Asegúrate que esta vista exista
    path('pub_restablecer_contrasena_admin/', views.pub_restablecer_contrasena_admin, name='pub_restablecer_contrasena_admin'),
    path('pub_soporte/', views.pub_soporte, name='pub_soporte'),
    path('pub_terminos/', views.pub_terminos, name='pub_terminos'),
    path('pub_vinilo/', views.pub_vinilo, name='pub_vinilo'), # Asegúrate que esta vista exista

    # URLS DELA CARPETA "PLANTILLAS"
    # path('plantilla_publico/', views.plantilla_publico, name='plantilla_publico'), # <-- Eliminar esta URL, las plantillas base no suelen tener URL directa

    # URLS DE LA CARPETA "VENDEDOR"
    path('ven_bad/', views.ven_bad, name='ven_bad'),
    path('ven_crear/', views.ven_crear, name='ven_crear'),
    path('ven_nosotros/', views.ven_nosotros, name='ven_nosotros'),
    path('ven_notificaciones/', views.ven_notificaciones, name='ven_notificaciones'),
    # URLs para el perfil del vendedor
    path('ven_perfil/', views.ven_perfil, name='ven_perfil'), # Vista para mostrar el perfil
    path('ven_perfil/editar/', views.ven_perfil_editar, name='ven_perfil_editar'), # Vista para editar el perfil
    path('ven_producto/', views.ven_producto, name='ven_producto'),
    path('ven_terminos/', views.ven_terminos, name='ven_terminos'),

    # URLS DE LOS ÁLBUMES (Considerar si deben estar prefijadas, ej: 'admin/albumes/bts/')
    path('bts/', views.bts, name='bts'), # Asegúrate que esta vista exista
    path('cartiMusic/', views.cartiMusic, name='cartiMusic'),
    path('eminemShow/', views.eminemShow, name='eminemShow'), # Añadido '/' al final
    path('exitosJoe/', views.exitosJoe, name='exitosJoe'),
    path('gnrAppetite/', views.gnrAppetite, name='gnrAppetite'),
    path('master/', views.master, name='master'),
    path('mjBad/', views.mjBad, name='mjBad'), # Añadido '/' al final
    path('mjThriller/', views.mjThriller, name='mjThriller'),
    path('nirvana/', views.nirvana, name='nirvana'),
    path('theBeatles/', views.theBeatles, name='theBeatles'),


    # URLS DE LOS USUARIOS (Considerar si deben estar prefijadas, ej: 'admin/usuarios/lauraG/')
    path('alex_r/', views.alex_r, name='alex_r'),
    path('andrea_villalobos/', views.andrea_villalobos, name='andrea_villalobos'),
    path('andrea_villalobos_2/', views.andrea_villalobos_2, name='andrea_villalobos_2'),
    path('angela_torres/', views.angela_torres, name='angela_torres'),
    path('angela_torres_2/', views.angela_torres_2, name='angela_torres_2'),
    path('benjamin_castro/', views.benjamin_castro, name='benjamin_castro'),
    path('benjamin_castro_2/', views.benjamin_castro_2, name='benjamin_castro_2'),
    path('camila_q/', views.camila_q, name='camila_q'),
    path('carlos_r/', views.carlos_r, name='carlos_r'),
    path('cristian_dominguez/', views.cristian_dominguez, name='cristian_dominguez'),
    path('cristian_dominguez_2/', views.cristian_dominguez_2, name='cristian_dominguez_2'),
    path('elisa_naranjo/', views.elisa_naranjo, name='elisa_naranjo'),
    path('elisa_naranjo_2/', views.elisa_naranjo_2, name='elisa_naranjo_2'),
    path('emilio_torres/', views.emilio_torres, name='emilio_torres'),
    path('emilio_torres_2/', views.emilio_torres_2, name='emilio_torres_2'),
    path('esperanza_barrera/', views.esperanza_barrera, name='esperanza_barrera'),
    path('fernando_molina/', views.fernando_molina, name='fernando_molina'),
    path('jhon_m/', views.jhon_m, name='jhon_m'),
    path('laura_g/', views.laura_g, name='laura_g'),
    path('sofia_ramirez/', views.sofia_ramirez, name='sofia_ramirez'),
]