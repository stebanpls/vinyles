from django.contrib import admin
from .models import Crud # Importamos el modelo Crud desde el archivo models.py

# Register your models here.
admin.site.register(Crud) # Registra el modelo "Crud" en el panel de administración de Django.