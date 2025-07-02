"""
URL configuration for vinyles project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

# Importar settings para acceder a DEBUG, MEDIA_URL, etc.
from django.conf import settings

# Importar static para servir archivos de MEDIA_URL en desarrollo
from django.conf.urls.static import static

# from django.contrib.staticfiles.urls import staticfiles_urlpatterns # Ya no es necesario con WhiteNoise
from django.contrib.auth import (
    views as auth_views,  # Necesario para personalizar las vistas de auth
)
from django.urls import (
    include,
    path,
    reverse_lazy,  # Para success_url
)

from gestion import views as gestion_views  # Añadir import para las vistas de gestion

# Importa la instancia del sitio de administración personalizado
from .admin import custom_admin_site

urlpatterns = [
    path("", include("gestion.urls")),  # Accediendo a todo lo que tiene gestion.urls para filtrarlo
    path("admin/", custom_admin_site.urls),  # Usa tu instancia personalizada para la URL del administrador
    # URLs de autenticación de Django, personalizadas
    path("accounts/login/", gestion_views.pub_login, name="login"),  # Modificado para usar tu vista personalizada
    # Redirigir a la URL nombrada 'pub_log_out' después del logout, que está definida en gestion.urls
    path(
        "accounts/logout/",
        auth_views.LogoutView.as_view(next_page=reverse_lazy("pub_log_out")),
        name="logout",
    ),
    # --- NUEVO FLUJO DE RESTABLECIMIENTO DE CONTRASEÑA (BASADO EN CÓDIGO) ---
    # 1. Solicitar reseteo (ingresar email)
    path(
        "accounts/password_reset/",
        gestion_views.password_reset_request,  # Usa tu vista personalizada para enviar el código
        name="password_reset",
    ),
    # 2. Mostrar confirmación de "email enviado"
    path(
        "accounts/password_reset/done/",
        auth_views.PasswordResetDoneView.as_view(
            template_name="paginas/publico/pub_reseteo_enviado.html"  # Tu plantilla para "email enviado"
        ),
        name="password_reset_done",
    ),
    # 3. Ingresar código y nueva contraseña
    path(
        "accounts/reset/code/",  # Nueva URL para la confirmación con código
        gestion_views.password_reset_confirm_code,  # Usa tu vista personalizada para verificar el código y cambiar la contraseña
        name="password_reset_confirm",
    ),
    # 4. Mostrar confirmación de "reseteo completo"
    path(
        "accounts/reset/done/",
        auth_views.PasswordResetCompleteView.as_view(
            template_name="paginas/publico/pub_reseteo_completo.html"  # Tu plantilla para "reseteo completo"
        ),
        name="password_reset_complete",
    ),
]

# Configuración para servir archivos de medios (MEDIA_URL) durante el desarrollo.
# Esto es útil independientemente del valor de DEBUG para el desarrollo local.
# WhiteNoise no sirve archivos de MEDIA por defecto, así que esto sigue siendo útil para desarrollo.
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Nota: Si DEBUG es True, Django sirve los archivos estáticos automáticamente.
# Si DEBUG es False, WhiteNoise los servirá a través de su middleware.
