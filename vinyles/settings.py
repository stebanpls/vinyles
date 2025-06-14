"""
Django settings for vinyles project.

Generated by 'django-admin startproject' using Django 5.2.1.

For more information on this file, see
https://docs.djangoproject.com/en/5.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/5.2/ref/settings/
"""

# Se agregó el import de os
import os
from pathlib import Path
# Importar python-dotenv
from dotenv import load_dotenv

load_dotenv()  # Carga variables desde el archivo .env que estará en la raíz del proyecto

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY', 'django-insecure--byrce+$%&e!-0xl%$40w=-hry&3oc09wvsyd^9l9bk-g0%h20') # Valor por defecto si no está en .env

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = os.environ.get('DJANGO_DEBUG', 'True') == 'True' # Convertir string a Boolean
# DEBUG = False # FORZAR DEBUG A FALSE PARA PRUEBAS DE ESTÁTICOS

# Cuando DEBUG es False, debes especificar los hosts permitidos.
# Para desarrollo local, esto es usualmente suficiente.
# En producción, reemplaza esto con tu dominio real.
ALLOWED_HOSTS = ['127.0.0.1', 'localhost']


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'gestion.apps.GestionConfig', # Tu aplicación
    'django_recaptcha',         # Para django-recaptcha. La próxima vez toca asegurarnos de que se llame como se llama en la dependencia.
    'widget_tweaks', # Si lo vas a usar
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware', # WhiteNoise va aquí
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',

]

ROOT_URLCONF = 'vinyles.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        # Aquí le decimos a Django que busque plantillas en una carpeta 'templates'
        # en la raíz de tu proyecto (al mismo nivel que manage.py).
        # Aquí es donde deberías poner tu 404.html, 500.html, etc.
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                # Se agregó el debug
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'vinyles.wsgi.application'


# Database
# https://docs.djangoproject.com/en/5.2/ref/settings/#databases

"""
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'vinyles.sqlite3',
    }
}
"""

# Leer configuraciones de la base de datos desde variables de entorno
# Se pueden poner valores por defecto si se desea.
DB_ENGINE = os.environ.get('DB_ENGINE', 'django.db.backends.mysql')
DB_NAME = os.environ.get('DB_NAME') # Obligatorio en .env
DB_USER = os.environ.get('DB_USER') # Obligatorio en .env
DB_PASSWORD = os.environ.get('DB_PASSWORD') # Obligatorio en .env
DB_HOST = os.environ.get('DB_HOST', 'localhost') # Valor por defecto común para desarrollo
DB_PORT = os.environ.get('DB_PORT', '3307') # Valor por defecto común para desarrollo (ajusta si es necesario). El puerto por defecto de MySQL es 3306, pero aquí se usa 3307.

DATABASES = {
    'default': {
        'ENGINE': DB_ENGINE,
        'NAME': DB_NAME,
        'USER': DB_USER,
        'PASSWORD': DB_PASSWORD,
        'HOST': DB_HOST,
        'PORT': DB_PORT,
        'OPTIONS': {
            'charset': 'utf8mb4',
            'use_unicode': True,
            # 'read_default_file': os.path.join(BASE_DIR, 'my.cnf'), # Puedes comentar o quitar esto si usas .env exclusivamente
        },
    }
}



# Password validation
# https://docs.djangoproject.com/en/5.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/5.2/topics/i18n/

LANGUAGE_CODE = 'es-co' # o 'es-es', 'es-ar', 'es-mx', etc.

# Configura esto a tu zona horaria local. Para Colombia, sería 'America/Bogota'.
TIME_ZONE = 'America/Bogota' # Por defecto, Django usa UTC, pero puedes cambiarlo a tu zona horaria local.

USE_I18N = True # Esto activa la internacionalización, permitiendo que Django use traducciones y formatos localizados.

USE_L10N = True # Importante para que los formatos localizados funcionen

USE_TZ = True # Esto permite que Django maneje las zonas horarias correctamente.


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.2/howto/static-files/

STATIC_URL = 'static/'
# Se agregó la ruta de los archivos estáticos
STATICFILES_DIRS = [
    BASE_DIR / "static",
] # Todos los archivos estáticos se busquen dentro de la carpeta "static"

# STATIC_ROOT es donde `collectstatic` copiará los archivos para producción.
# WhiteNoise también puede usarlo si DEBUG = False.
STATIC_ROOT = BASE_DIR / 'staticfiles'

# Default primary key field type
# https://docs.djangoproject.com/en/5.2/ref/settings/#default-auto-field

# MEDIA_ROOT es donde se guardarán los archivos subidos por los usuarios.
MEDIA_ROOT = BASE_DIR / 'media'  # Carpeta 'media' en la raíz del proyecto
MEDIA_URL = '/media/' # URL base para acceder a estos archivos

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# CONFIGURACIÓN DE AUTENTICACIÓN
LOGIN_REDIRECT_URL = 'com_inicio'  # O 'dashboard' como en el video, apunta a tu vista post-login
LOGIN_URL = 'pub_login'            # URL de tu vista de login principal
LOGOUT_REDIRECT_URL = 'pub_log_out'  # Redirigir a la URL nombrada 'pub_log_out' después de cerrar sesión



# 2) Si quieres usar Gmail (en modo real), comentas la línea anterior y descomentas estas:
# EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
#EMAIL_HOST = 'smtp.gmail.com'
#EMAIL_PORT = 587
#EMAIL_USE_TLS = True
#EMAIL_HOST_USER = 'sebastian.rg303@gmail.com'
#EMAIL_HOST_PASSWORD = 'aericita1234'
#DEFAULT_FROM_EMAIL = 'Vinyles <sebastian.rg303@gmail.com>'

# CONFIGURACIÓN DE reCAPTCHA
# Estas variables se leen desde tu archivo .env
# Asegúrate de haber definido RECAPTCHA_SITE_KEY y RECAPTCHA_SECRET_KEY en .env
RECAPTCHA_PUBLIC_KEY = os.environ.get('RECAPTCHA_SITE_KEY')
RECAPTCHA_PRIVATE_KEY = os.environ.get('RECAPTCHA_SECRET_KEY')

# Silenciar la advertencia de claves de prueba de reCAPTCHA para desarrollo
# Dejar comentado en lo posible.
# SILENCED_SYSTEM_CHECKS = ['django_recaptcha.recaptcha_test_key_error']
