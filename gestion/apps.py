from django.apps import AppConfig


class GestionConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "gestion"

    def ready(self):
        # Importar las señales para que se registren correctamente.
        pass  # Esto importará gestion/models.py donde está tu señal.
