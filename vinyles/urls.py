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

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('gestion.urls')), # Accediendo a todo lo que tiene gestion.urls para filtrarlo
    path('accounts/', include('django.contrib.auth.urls')),

# from django.contrib.auth import views as auth_views
    # urlpatterns += [
    #     path('accounts/password_reset/', 
    #          auth_views.PasswordResetView.as_view(), 
    #          name='password_reset'),
    #     path('accounts/password_reset/done/',
    #          auth_views.PasswordResetDoneView.as_view(),
    #          name='password_reset_done'),
    #     path('accounts/reset/<uidb64>/<token>/',
    #          auth_views.PasswordResetConfirmView.as_view(),
    #          name='password_reset_confirm'),
    #     path('accounts/reset/done/',
    #          auth_views.PasswordResetCompleteView.as_view(),
    #          name='password_reset_complete'),
    # ]

]

# Configuración para servir archivos de medios (MEDIA_URL) durante el desarrollo.
# Esto es útil independientemente del valor de DEBUG para el desarrollo local.
# WhiteNoise no sirve archivos de MEDIA por defecto, así que esto sigue siendo útil para desarrollo.
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Nota: Si DEBUG es True, Django sirve los archivos estáticos automáticamente.
# Si DEBUG es False, WhiteNoise los servirá a través de su middleware.
