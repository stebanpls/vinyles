from typing import Any
from django.db import models
from django.contrib.auth.models import User # Importa el modelo User
from django.core.exceptions import ValidationError # Para validaciones
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

# Modelo para representar los géneros musicales
class Genero(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100, unique=True, verbose_name="Nombre del Género")

    class Meta:
        verbose_name = "Género"
        verbose_name_plural = "Géneros"

    def __str__(self):
        return self.nombre

# Modelo para extender el modelo User de Django con información específica del cliente
class Cliente(models.Model): # Renombrado de ClienteProfile a Cliente
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True, related_name='cliente') # Cambiado related_name a 'cliente'
    # Campos de tu tabla 'cliente' que no están en el modelo 'User' de Django
    # Ajusta los tipos de datos y longitudes según tu SQL si es necesario.
    # El SQL usa INT para numeroDocumento y celular, pero CharField es más flexible
    # si pueden contener ceros a la izquierda o caracteres no numéricos.
    # Asegúrate de que estos nombres de campo coincidan con los que esperas en tu base de datos SQL
    # si estás mapeando a una base de datos existente.
    numero_documento = models.CharField(
        max_length=20,  # Ajusta según la longitud máxima esperada
        # unique=True,    # Asumiendo que el número de documento debe ser único. Comenta si no es una restricción estricta.
        blank=True,     # Permite que el campo esté vacío en el formulario
        null=True,      # Permite que el campo sea NULL en la base de datos
        verbose_name="Número de Documento"
    )
    # Se elimina la definición duplicada de 'celular'
    celular = models.CharField(
        max_length=20,
        blank=True,
        null=True,      # Permite que el campo sea NULL en la base de datos
        verbose_name="Celular" # Añadido verbose_name para claridad
    )
    direccion_residencia = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"Cliente: {self.user.username}" # Actualizado string representation

    # Campo para la foto de perfil. Usamos ImageField para manejar subidas de archivos.
    # 'upload_to' define la subcarpeta dentro de MEDIA_ROOT donde se guardarán las imágenes.
    # Asegúrate de que MEDIA_ROOT y MEDIA_URL estén configurados en settings.py
    foto_perfil = models.ImageField(
        upload_to='fotos_perfil/', # Las imágenes se guardarán en MEDIA_ROOT/fotos_perfil/
        null=True,
        blank=True,
        verbose_name="Foto de Perfil"
    )

    # Campo Many-to-Many para los géneros favoritos.
    # Django creará automáticamente la tabla intermedia (cliente_genero_favorito)
    # si no la especificas con 'through'. Si ya la creaste manualmente,
    # podrías necesitar usar 'through' para apuntar a tu tabla existente.
    generos_favoritos = models.ManyToManyField(
        Genero,
        blank=True, # Permite que un usuario no tenga géneros favoritos
        verbose_name="Géneros Favoritos"
    )

    class Meta:
        db_table = 'clientes' # Aquí especificas el nombre de la tabla
        verbose_name = "Cliente" # Actualizado verbose_name
        verbose_name_plural = "Clientes" # Actualizado verbose_name_plural

# Señal para crear automáticamente un ClienteProfile cuando se crea un User
@receiver(post_save, sender=User)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    if created:
        Cliente.objects.create(user=instance) # Referencia actualizada a Cliente