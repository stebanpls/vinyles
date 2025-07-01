# Proyecto Vinyles Store

Este es el repositorio para el proyecto de la tienda de vinilos.

## Configuración Inicial (Una sola vez)

Sigue estos pasos para configurar tu entorno de desarrollo local.

### 1. Prerrequisitos

Asegúrate de tener instalado:
- Git
- Python 3.11
- MariaDB (o MySQL)

### 2. Clonar y Preparar el Proyecto

```bash
# Clona el repositorio
git clone <URL_DEL_REPOSITORIO>
cd vinyles

# Crea y activa el entorno virtual
# En Windows:
python -m venv .venv
.venv\Scripts\activate

# En macOS/Linux:
python -m venv .venv
source .venv/bin/activate
```

### 3. Instalar Dependencias

```bash
pip install -r requirements.txt
```

### 4. Configurar el Entorno Local

Crea un archivo llamado `.env` en la raíz del proyecto. Puedes copiar el contenido de `.env.example` y ajustarlo a tu configuración local.

```bash
cp .env.example .env
```

### 5. Configurar la Base de Datos

1.  Abre tu cliente de MariaDB/MySQL y ejecuta:
    ```sql
    CREATE DATABASE vinyles_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    ```
2.  Aplica las migraciones de Django:
    ```bash
    python manage.py migrate
    ```

### 6. Activar Ganchos de Pre-commit

Esto instalará las herramientas de calidad que se ejecutan antes de cada commit.

```bash
pre-commit install
```

¡Listo! Ahora puedes ejecutar el servidor de desarrollo:

```bash
python manage.py runserver
```

## Flujo de Trabajo Diario

1.  **Programa tus cambios.**
2.  **Haz commit:** `git add .` y `git commit -m "Tu mensaje"`. `pre-commit` revisará tu código automáticamente.
3.  **(Opcional) Corre las pruebas:** `python manage.py test`.
4.  **Sube tus cambios:** `git push`. GitHub Actions ejecutará la batería completa de pruebas.
