# Vinyles 🎶

[![Django CI](https://github.com/stebanpls/vinyles/actions/workflows/ci.yml/badge.svg)](https://github.com/stebanpls/vinyles/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Sistema de Información para la compra y venta de vinilos. Un proyecto desarrollado para facilitar la interacción entre coleccionistas y vendedores de discos de vinilo, ofreciendo una plataforma para descubrir, comprar y vender música en este formato clásico.

![Captura de pantalla de la aplicación](URL_A_LA_IMAGEN_O_GIF_AQUI)

## Estado del Proyecto

Actualmente en desarrollo activo (Versión 25.06.14 - puedes poner tu versión actual o una fecha).

## Características Principales ✨

*   Navegación y búsqueda de álbumes de vinilo.
*   Registro e inicio de sesión para usuarios (compradores y vendedores).
*   Perfiles de usuario personalizables.
*   Sistema de carrito de compras.
*   Proceso de checkout (simulado o integrado).
*   Panel de administración para la gestión de usuarios, productos y pedidos.
*   (Añade más características específicas de tu proyecto aquí)

## Tecnologías Utilizadas 🛠️

*   **Backend**: Python, Django
*   **Frontend**: HTML, CSS, JavaScript (puedes especificar frameworks si usas, ej. Bootstrap)
*   **Base de Datos**: MariaDB
*   **Servidor de Desarrollo**: Django Development Server
*   **Servicio de CAPTCHA**: Google reCAPTCHA
*   **Otros**: `python-dotenv`, `django-widget-tweaks`, `whitenoise`, etc.

## Requisitos Previos (Para Desarrolladores) 📋

*   Python (versión 3.11 o compatible)
*   Pip (gestor de paquetes de Python, usualmente viene con Python)
*   Git (para control de versiones)
*   Una instancia de MariaDB (versión 11.8.2 o compatible) en ejecución.
*   Un navegador web moderno.

## Instalación y Configuración Local 🚀

Sigue estos pasos para poner en marcha el proyecto en tu entorno local:

1.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/stebanpls/vinyles.git
    cd vinyles
    ```

2.  **Crea y activa un entorno virtual:**
    ```bash
    python -m venv .venv
    # En Windows
    .\.venv\Scripts\activate
    # En macOS/Linux
    source .venv/bin/activate
    ```

3.  **Instala las dependencias:**
    El proyecto usa un único archivo `requirements.txt` para simplificar.
    ```bash
    pip install -r requirements.txt
    ```

4.  **Configura los ganchos (hooks) de pre-commit (¡Muy recomendado!)**
    Esto instalará un asistente que revisará y formateará tu código automáticamente antes de cada commit, asegurando la calidad y consistencia.
    ```bash
    # Instala la herramienta (ya debería estar en requirements.txt)
    pip install pre-commit
    # Instala los ganchos en tu repositorio local de Git
    pre-commit install
    ```

5.  **Configura las variables de entorno:**
    *   Crea un archivo `.env` en la raíz del proyecto (al mismo nivel que `manage.py`) a partir del archivo de ejemplo `.env.example` (si lo tienes).
    *   Rellena las siguientes variables con tus propios valores:
        ```env
        DJANGO_SECRET_KEY='tu_super_secreto_aqui'
        DJANGO_DEBUG='True'

        DB_ENGINE='django.db.backends.mysql'
        DB_NAME='nombre_de_tu_bd'
        DB_USER='tu_usuario_bd'
        DB_PASSWORD='tu_contraseña_bd'
        DB_HOST='localhost' # o la IP de tu servidor MariaDB
        DB_PORT='3307'      # o el puerto que estés usando para MariaDB

        RECAPTCHA_SITE_KEY='tu_site_key_de_recaptcha_v2_checkbox'
        RECAPTCHA_SECRET_KEY='tu_secret_key_de_recaptcha_v2_checkbox'
        ```

6.  **Aplica las migraciones de la base de datos:**
    ```bash
    python manage.py migrate
    ```

7.  **Crea un superusuario (opcional, para acceder al admin de Django):**
    ```bash
    python manage.py createsuperuser
    ```

8.  **Ejecuta el servidor de desarrollo:**
    ```bash
    python manage.py runserver
    ```
    El sitio estará disponible en `http://127.0.0.1:8000/`.

## Uso Básico 🖱️

*   **Visitantes**: Pueden navegar por los álbumes, ver detalles de los vinilos.
*   **Registro**: Los nuevos usuarios pueden crear una cuenta.
*   **Inicio de Sesión**: Los usuarios registrados pueden acceder a sus perfiles y funcionalidades específicas.
*   **Compradores**: Pueden añadir vinilos al carrito y proceder al checkout.
*   **Administradores**: Pueden gestionar el contenido del sitio a través del panel de Django (`/admin/`).

## Contribuciones 🤝

¡Las contribuciones son bienvenidas! Si deseas contribuir, por favor:
1.  Haz un Fork del proyecto.
2.  Crea una nueva rama (`git checkout -b feature/nueva-caracteristica`).
3.  Realiza tus cambios y haz commit (`git commit -m 'Añade nueva característica'`).
4.  Haz Push a la rama (`git push origin feature/nueva-caracteristica`).
5.  Abre un Pull Request.

## Equipo de Desarrollo (Grupo 4 - Ficha: 3069239) 🧑‍💻

*   Cristiam David Galeano Marín
*   Daniel Felipe Guerrero Prias
*   Edwin Steban Pulido Rojas
*   Luz Angela Forero Martínez
*   Sebastián Rodríguez Gómez

## Licencia 📄

Este proyecto está bajo la Licencia MIT. Ver el archivo LICENSE para más detalles.
