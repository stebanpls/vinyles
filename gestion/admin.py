from django.contrib import admin
from .models import Crud, ClienteProfile # Importamos los modelos

# Register your models here.
admin.site.register(Crud) # Registra el modelo "Crud" en el panel de administración de Django.
admin.site.register(ClienteProfile) # Registra el modelo ClienteProfile