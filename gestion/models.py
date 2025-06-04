from typing import Any
from django.db import models
from django.contrib.auth.models import User # Importa el modelo User
from django.db.models.signals import post_save # Para crear el perfil automáticamente
from django.dispatch import receiver # Para el decorador de la señal

# Create your models here.
class Crud(models.Model): # Es mejor nombrar la clase con mayúscula inicial, siguiendo las convenciones de Python
  id = models.AutoField(primary_key = True)
  nombre = models.CharField(max_length = 50, verbose_name = "Nombre")
  apellido = models.CharField(max_length = 50, verbose_name = "Apellido")
  foto = models.ImageField(upload_to = 'fotos/', verbose_name = "Foto", null = True)
  clase = models.TextField(max_length = 100, verbose_name = "Clase", null = True)
  direccion = models.CharField(max_length = 250, verbose_name = "Dirección", blank = True, null = True)
  fechaIngreso = models.DateField(verbose_name = "Fecha de Ingreso", blank = True, null = True)

  class Meta:
    verbose_name_plural = "Crud" # Aquí especificas el nombre plural

  def __str__(self):
    return f"ID = {self.id} y Nombres: {self.nombre} {self.apellido}" # Es usar f-string para formatear cadenas de texto
  
  def delete(self, using = None, keep_parents = False):
    if self.foto: # Buena práctica: verificar si la foto existe antes de intentar borrarla
      self.foto.storage.delete(self.foto.name)
      super().delete()

class ClienteProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True, related_name='profile')
    # Campos de tu tabla 'cliente' que no están en el modelo 'User' de Django
    # Ajusta los tipos de datos y longitudes según tu SQL si es necesario.
    # El SQL usa INT para numeroDocumento y celular, pero CharField es más flexible
    # si pueden contener ceros a la izquierda o caracteres no numéricos.
    numero_documento = models.CharField(
        max_length=20,  # Ajusta según la longitud máxima esperada
        unique=True,    # Asumiendo que el número de documento debe ser único
        blank=True,     # Permite que el campo esté vacío en el formulario
        null=True       # Permite que el campo sea NULL en la base de datos
    )
    celular = models.CharField(max_length=20, blank=True, null=True)
    direccion_residencia = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"Perfil de {self.user.username}"

# Señal para crear automáticamente un ClienteProfile cuando se crea un User
@receiver(post_save, sender=User)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    if created:
        ClienteProfile.objects.create(user=instance)
    else:
        # Opcional: Asegurarse de que el perfil exista si el usuario se actualiza
        # y no se creó antes por alguna razón (poco común si la señal siempre estuvo activa).
        # O si quieres guardar el perfil cada vez que el usuario se guarda (cuidado con bucles).
        try:
            instance.profile.save() # Intenta guardar el perfil existente
        except ClienteProfile.DoesNotExist: # Si el perfil no existe por alguna razón
            ClienteProfile.objects.create(user=instance) # Créalo