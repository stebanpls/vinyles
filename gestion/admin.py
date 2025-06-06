from django.contrib import admin
from .models import Crud, Cliente # Importamos los modelos (ClienteProfile renombrado a Cliente)

# Register your models here.
admin.site.register(Crud) # Registra el modelo "Crud" en el panel de administración de Django.
admin.site.register(Cliente) # Registra el modelo Cliente