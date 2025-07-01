from django.contrib.admin import AdminSite


class VinylesAdminSite(AdminSite):
    site_header = (
        "Administración de Vinyles"  # Encabezado que aparece en la parte superior de la página
    )
    site_title = (
        "Panel de Administración de Vinyles"  # Título que aparece en la pestaña del navegador
    )
    index_title = "Bienvenido al Panel de Administración de Vinyles"  # Título de la página de índice del admin


# Crea una instancia única del sitio de administración personalizado
custom_admin_site = VinylesAdminSite(name="admin")
