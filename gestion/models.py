from typing import Any
from django.db import models
from django.contrib.auth.models import User # Importa el modelo User
from django.core.exceptions import ValidationError # Para validaciones
from django.db.models.signals import post_save # Para crear el perfil automáticamente
from django.dispatch import receiver # Para el decorador de la señal
import os # Para construir rutas de archivo
from uuid import uuid4 # Para generar nombres de archivo únicos
from PIL import Image # Importar Pillow
from django.core.files.base import ContentFile # Para guardar la imagen procesada
import io # Para manejar el stream de bytes de la imagen

def user_directory_path(instance, filename):
    new_filename = f"{uuid4().hex}.jpg" # Siempre usaremos extensión .jpg
    return os.path.join('fotos_perfil', f'user_{instance.user.id}', new_filename)

# Create your models here.
class Crud(models.Model): # Es mejor nombrar la clase con mayúscula inicial, siguiendo las convenciones de Python
    # id = models.AutoField(primary_key = True) # Django lo añade automáticamente
    nombre = models.CharField(max_length = 50, verbose_name = "Nombre")
    apellido = models.CharField(max_length = 50, verbose_name = "Apellidos") # Cambiado a plural para consistencia
    foto = models.ImageField(upload_to = 'fotos_crud/', verbose_name = "Foto", null = True, blank=True) # Añadido blank=True, y ruta de subida más específica
    # Si 'clase' tiene una longitud máxima definida, CharField es más apropiado que TextField.
    clase = models.CharField(max_length = 100, verbose_name = "Clase", null = True, blank = True)
    direccion = models.CharField(max_length = 250, verbose_name = "Dirección", blank = True, null = True)
    fechaIngreso = models.DateField(verbose_name = "Fecha de Ingreso", blank = True, null = True)

    class Meta:
        db_table = 'cruds' # Nombre de tabla en plural
        verbose_name = "CRUD"    # Singular
        verbose_name_plural = "CRUDS"  # Plural

    def __str__(self):
        return f"ID = {self.pk} y Nombres: {self.nombre} {self.apellido}" # Usar self.pk es una forma genérica de referirse a la clave primaria
    
    def delete(self, using = None, keep_parents = False):
        if self.foto: # Buena práctica: verificar si la foto existe antes de intentar borrarla
            self.foto.storage.delete(self.foto.name)
            super().delete()

# Modelo para representar los géneros musicales
class Genero(models.Model):
    # id = models.AutoField(primary_key=True) # Django lo añade automáticamente
    nombre = models.CharField(max_length=100, unique=True, verbose_name="Nombre del Género")

    class Meta:
        db_table = 'generos' # Nombre de tabla corto
        verbose_name = "Género" # Coincide con el concepto de la tabla
        verbose_name_plural = "Géneros" # Plural del verbose_name
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

    # Campo para la foto de perfil. Usamos ImageField para manejar subidas de archivos.
    # 'upload_to' define la subcarpeta dentro de MEDIA_ROOT donde se guardarán las imágenes.
    # Asegúrate de que MEDIA_ROOT y MEDIA_URL estén configurados en settings.py
    foto_perfil = models.ImageField(
        upload_to=user_directory_path, 
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
        db_table = 'clientes' # Nombre de tabla para los clientes
        verbose_name = "Cliente" # Singular
        verbose_name_plural = "Clientes" # Plural
    
    def __str__(self):
        return f"Cliente: {self.user.username}"

    def save(self, *args, **kwargs):
        # Determinar si la foto ha cambiado o es nueva
        procesar_imagen_nueva = False # Flag para decidir si la imagen actual (nueva o cambiada) necesita procesamiento
        # Guardar una referencia a la foto antigua ANTES de que super().save() la sobrescriba
        # si se está subiendo una nueva.
        old_foto_perfil_instance = None

        if self.pk: # Si el objeto ya existe (actualización)
            try:
                old_instance = Cliente.objects.get(pk=self.pk)
                if old_instance.foto_perfil:
                    old_foto_perfil_instance = old_instance.foto_perfil # Foto actualmente en la BD

                # Si se subió una nueva foto (diferente a la anterior o no había)
                if self.foto_perfil and self.foto_perfil != old_instance.foto_perfil:
                    procesar_imagen_nueva = True
                    # Si hay una foto antigua y la nueva es diferente, eliminar la antigua.
                    # Esto maneja el caso de REEMPLAZO.
                    if old_foto_perfil_instance and self.foto_perfil.name != old_foto_perfil_instance.name:
                        old_foto_perfil_instance.delete(save=False)
                elif not self.foto_perfil and old_foto_perfil_instance:
                    # Foto eliminada a través del formulario (la vista ya llamó a .delete() sobre el archivo)
                    # procesar_imagen_nueva permanece False, lo cual es correcto.
                    pass
            except Cliente.DoesNotExist:
                if self.foto_perfil: # Should not happen if self.pk is set, but for safety
                    procesar_imagen_nueva = True
        elif self.foto_perfil: # Nuevo objeto con foto
            procesar_imagen_nueva = True

        super().save(*args, **kwargs)

        # Procesar la imagen (recortar, convertir) si es una foto nueva o cambiada y existe.
        if procesar_imagen_nueva and self.foto_perfil and hasattr(self.foto_perfil, 'path') and os.path.exists(self.foto_perfil.path):
            try:
                img = Image.open(self.foto_perfil.path)

                # 1. Recortar a cuadrado (desde el centro)
                width, height = img.size
                if width != height:
                    short_side = min(width, height)
                    left = (width - short_side) / 2
                    top = (height - short_side) / 2
                    right = (width + short_side) / 2
                    bottom = (height + short_side) / 2
                    img = img.crop((left, top, right, bottom))

                # 2. Convertir a RGB (necesario para JPG si tiene canal alfa) y guardar como JPG
                if img.mode == 'RGBA' or img.mode == 'LA' or (img.mode == 'P' and 'transparency' in img.info):
                    background = Image.new('RGB', img.size, (255, 255, 255))
                    mask = img.convert('RGBA').split()[-1] if (img.mode == 'RGBA' or img.mode == 'LA' or (img.mode == 'P' and 'transparency' in img.info)) else None
                    background.paste(img, (0, 0), mask)
                    img = background
                elif img.mode != 'RGB':
                    img = img.convert('RGB')

                img.save(self.foto_perfil.path, format='JPEG', quality=85, optimize=True)
            except Exception as e:
                print(f"Error procesando imagen de perfil para {self.user.username}: {e}")

# Señal para crear automáticamente un ClienteProfile cuando se crea un User
@receiver(post_save, sender=User)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    if created:
        try:
            Cliente.objects.create(user=instance)
        except Exception as e:
            # Considera registrar este error de forma más formal si es necesario para producción
            pass # O maneja el error de otra manera