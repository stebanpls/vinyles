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

from django.contrib import admin
from django.urls import path, include
# Importar settings para acceder a DEBUG, MEDIA_URL, etc.
from django.conf import settings
# Importar static para servir archivos de MEDIA_URL en desarrollo
from django.conf.urls.static import static
# from django.contrib.staticfiles.urls import staticfiles_urlpatterns # Ya no es necesario con WhiteNoise
from django.contrib.auth import views as auth_views # Necesario para personalizar las vistas de auth
from django.urls import reverse_lazy # Para success_url

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('gestion.urls')), # Accediendo a todo lo que tiene gestion.urls para filtrarlo

    # URLs de autenticación de Django, personalizadas
    # Login y Logout (asumiendo que tienes plantillas para esto o usarás las de Django)
    # Asegúrate que la plantilla 'paginas/publico/pub_login.html' exista o ajusta el nombre.
    path('accounts/login/', auth_views.LoginView.as_view(template_name='paginas/publico/pub_login.html'), name='login'),
    # Cambia 'pub_index' al nombre de la URL de tu página de inicio si es diferente.
    path('accounts/logout/', auth_views.LogoutView.as_view(next_page=reverse_lazy('pub_index')), name='logout'),

    # Las URLs estándar para el cambio de contraseña de usuarios autenticados se eliminan,
    # ya que esta funcionalidad se integrará en las vistas de edición de perfil (ej. com_perfil_editar).
    # path('accounts/password_change/', auth_views.PasswordChangeView.as_view(template_name='registration/password_change_form.html'), name='password_change'),
    # path('accounts/password_change/done/', auth_views.PasswordChangeDoneView.as_view(template_name='registration/password_change_done.html'), name='password_change_done'),

    # Flujo de Reseteo de Contraseña (para usuarios no logueados)
    path('accounts/password_reset/',
        auth_views.PasswordResetView.as_view(
            template_name='paginas/publico/pub_solicitar_reseteo.html', # Tu plantilla para ingresar email
            email_template_name='registration/password_reset_email.html', # Django usará una por defecto si no existe
            subject_template_name='registration/password_reset_subject.txt', # Django usará uno por defecto si no existe
            success_url=reverse_lazy('password_reset_done')
        ),
        name='password_reset'),
    path('accounts/password_reset/done/',
        auth_views.PasswordResetDoneView.as_view(
            template_name='paginas/publico/pub_reseteo_enviado.html' # Tu plantilla para "email enviado"
        ),
        name='password_reset_done'),
    path('accounts/reset/<uidb64>/<token>/', # uidb64 y token vienen del enlace en el email
        auth_views.PasswordResetConfirmView.as_view(
            template_name='paginas/publico/pub_restablecer_contrasena.html', # Tu plantilla para ingresar nueva contraseña
            success_url=reverse_lazy('password_reset_complete')
        ),
        name='password_reset_confirm'),
    path('accounts/reset/done/',
        auth_views.PasswordResetCompleteView.as_view(
            template_name='paginas/publico/pub_reseteo_completo.html' # Tu plantilla para "reseteo completo"
        ),
        name='password_reset_complete'),

]

# Configuración para servir archivos de medios (MEDIA_URL) durante el desarrollo.
# Esto es útil independientemente del valor de DEBUG para el desarrollo local.
# WhiteNoise no sirve archivos de MEDIA por defecto, así que esto sigue siendo útil para desarrollo.
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Nota: Si DEBUG es True, Django sirve los archivos estáticos automáticamente.
# Si DEBUG es False, WhiteNoise los servirá a través de su middleware.
