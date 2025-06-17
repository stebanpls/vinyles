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

import logging # Añadir al inicio del archivo
logger = logging.getLogger(__name__) # Añadir al inicio del archivo, después de los imports

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
    numero_documento = models.CharField(
        max_length=20,
        blank=True,
        null=True,
        verbose_name="Número de Documento"
    )
    celular = models.CharField(
        max_length=20,
        blank=True,
        null=True,
        verbose_name="Celular"
    )
    direccion_residencia = models.CharField(max_length=255, blank=True, null=True)
    foto_perfil = models.ImageField(
        upload_to=user_directory_path, 
        null=True,
        blank=True,
        verbose_name="Foto de Perfil"
    )
    generos_favoritos = models.ManyToManyField(
        Genero,
        blank=True,
        verbose_name="Géneros Favoritos"
    )
    medios_de_pago_guardados = models.ManyToManyField(
        'MedioDePago', # Forward reference to MedioDePago model
        blank=True,
        verbose_name="Medios de Pago Guardados",
        db_table='cliente_medio_de_pago' # Explicitly naming the M2M table to match SQL
    )

    class Meta:
        db_table = 'clientes' # Nombre de tabla para los clientes
        verbose_name = "Cliente" # Singular
        verbose_name_plural = "Clientes" # Plural
    
    def __str__(self):
        return f"Cliente: {self.user.username}"

    def save(self, *args, **kwargs):
        procesar_imagen_nueva = False
        old_foto_perfil_instance = None

        if self.pk:
            try:
                old_instance = Cliente.objects.get(pk=self.pk)
                if old_instance.foto_perfil:
                    old_foto_perfil_instance = old_instance.foto_perfil

                if self.foto_perfil and self.foto_perfil != old_instance.foto_perfil:
                    procesar_imagen_nueva = True
                    if old_foto_perfil_instance and self.foto_perfil.name != old_foto_perfil_instance.name:
                        old_foto_perfil_instance.delete(save=False)
                elif not self.foto_perfil and old_foto_perfil_instance:
                    pass
            except Cliente.DoesNotExist:
                if self.foto_perfil:
                    procesar_imagen_nueva = True
        elif self.foto_perfil:
            procesar_imagen_nueva = True

        super().save(*args, **kwargs)

        if procesar_imagen_nueva and self.foto_perfil and hasattr(self.foto_perfil, 'path') and os.path.exists(self.foto_perfil.path):
            try:
                img = Image.open(self.foto_perfil.path)
                width, height = img.size
                if width != height:
                    short_side = min(width, height)
                    left = (width - short_side) / 2
                    top = (height - short_side) / 2
                    right = (width + short_side) / 2
                    bottom = (height + short_side) / 2
                    img = img.crop((left, top, right, bottom))

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
            # En lugar de 'pass', registra el error
            logger.error(f"Error al crear el perfil Cliente para el usuario {instance.username}: {e}")
            # pass # Puedes dejar el pass si no quieres que la falla de la señal detenga nada más

# --- Modelos para Catálogo de Música (Ajustados a vinyles.sql y convenciones) ---

class Artista(models.Model):
    nombre = models.CharField(max_length=200, unique=True, verbose_name="Nombre del Artista")
    informacion = models.TextField(blank=True, null=True, verbose_name="Información del Artista")
    foto = models.ImageField(upload_to='artistas/', blank=True, null=True, verbose_name="Foto del Artista")

    class Meta:
        db_table = 'artistas' # Convención: plural
        verbose_name = "Artista"
        verbose_name_plural = "Artistas"
        ordering = ['nombre']

    def __str__(self):
        return self.nombre

class Productor(models.Model):
    nombre = models.CharField(max_length=200, unique=True, verbose_name="Nombre del Productor")

    class Meta:
        db_table = 'productores' # Convención: plural
        verbose_name = "Productor"
        verbose_name_plural = "Productores"
        ordering = ['nombre']

    def __str__(self):
        return self.nombre

class Cancion(models.Model):
    nombre = models.CharField(max_length=200, verbose_name="Nombre de la Canción")
    artistas = models.ManyToManyField(
        Artista,
        related_name='canciones_realizadas',
        blank=True,
        verbose_name="Artistas"
    )
    productores = models.ManyToManyField(
        Productor,
        related_name='canciones_producidas',
        blank=True,
        verbose_name="Productores"
    )
    generos = models.ManyToManyField(
        Genero,
        related_name='canciones_genero',
        blank=True,
        verbose_name="Géneros"
    )
    duracion = models.DurationField(verbose_name="Duración (ej: 00:03:46)", blank=True, null=True)

    class Meta:
        db_table = 'canciones' # Convención: plural
        verbose_name = "Canción"
        verbose_name_plural = "Canciones"
        ordering = ['nombre']

    def __str__(self):
        return self.nombre

class Producto(models.Model):
    nombre = models.CharField(max_length=255, verbose_name="Nombre del Producto/Álbum")
    artistas = models.ManyToManyField(
        Artista,
        related_name="productos",
        verbose_name="Artista(s) Principal(es)"
    )
    lanzamiento = models.DateField(blank=True, null=True, verbose_name="Fecha de Lanzamiento")
    precio = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="Precio")
    stock = models.PositiveIntegerField(default=0, verbose_name="Cantidad en Stock")
    descripcion = models.TextField(blank=True, null=True, verbose_name="Descripción del Producto")
    discografica = models.CharField(max_length=200, blank=True, null=True, verbose_name="Compañía Discográfica")
    imagen_portada = models.ImageField(upload_to='productos_portadas/', blank=True, null=True, verbose_name="Imagen de Portada")
    genero_principal = models.ManyToManyField(
        Genero,
        related_name="productos_principales",
        verbose_name="Género(s) Principal(es) del Álbum",
        blank=True
    )

    class Meta:
        db_table = 'productos' # Convención: plural
        verbose_name = "Producto (Vinilo/Álbum)"
        verbose_name_plural = "Productos (Vinilos/Álbumes)"
        ordering = ['nombre']

    def __str__(self):
        artistas_nombres = ", ".join(art.nombre for art in self.artistas.all())
        return f"{self.nombre} - {artistas_nombres}"

class ProductoCancion(models.Model):
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE, related_name="tracks", verbose_name="Producto")
    cancion = models.ForeignKey(Cancion, on_delete=models.CASCADE, related_name="apariciones_en_productos", verbose_name="Canción")
    numero_pista = models.PositiveIntegerField(verbose_name="Número de Pista")

    class Meta:
        db_table = 'producto_canciones' # Convención: plural
        verbose_name = "Canción en Producto"
        verbose_name_plural = "Canciones en Productos"
        ordering = ['producto', 'numero_pista']
        unique_together = (('producto', 'cancion'), ('producto', 'numero_pista'))

    def __str__(self):
        return f"Pista {self.numero_pista}: {self.cancion.nombre} (Álbum: {self.producto.nombre})"

# --- Modelos para Localización Geográfica (Pedidos) ---

class Pais(models.Model):
    nombre = models.CharField(max_length=100, verbose_name="Nombre del País")

    class Meta:
        db_table = 'paises'
        verbose_name = "País"
        verbose_name_plural = "Países"
        ordering = ['nombre']

    def __str__(self):
        return self.nombre

class Departamento(models.Model):
    nombre = models.CharField(max_length=100, verbose_name="Nombre del Departamento")
    pais = models.ForeignKey(Pais, on_delete=models.CASCADE, related_name='departamentos', verbose_name="País")

    class Meta:
        db_table = 'departamentos'
        verbose_name = "Departamento"
        verbose_name_plural = "Departamentos"
        ordering = ['pais', 'nombre']

    def __str__(self):
        return f"{self.nombre}, {self.pais.nombre}"

class Ciudad(models.Model):
    nombre = models.CharField(max_length=100, verbose_name="Nombre de la Ciudad")
    departamento = models.ForeignKey(Departamento, on_delete=models.CASCADE, related_name='ciudades', verbose_name="Departamento")

    class Meta:
        db_table = 'ciudades'
        verbose_name = "Ciudad"
        verbose_name_plural = "Ciudades"
        ordering = ['departamento', 'nombre']

    def __str__(self):
        return f"{self.nombre}, {self.departamento.nombre}"

# --- Modelos para Pedidos y Pagos ---

class MedioDePago(models.Model):
    nombre = models.CharField(max_length=100, unique=True, verbose_name="Nombre del Medio de Pago")

    class Meta:
        db_table = 'medios_de_pago'
        verbose_name = "Medio de Pago"
        verbose_name_plural = "Medios de Pago"
        ordering = ['nombre']

    def __str__(self):
        return self.nombre

class Pedido(models.Model):
    fecha = models.DateField(verbose_name="Fecha del Pedido")
    total = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="Total del Pedido")
    direccion_envio = models.CharField(max_length=255, verbose_name="Dirección de Envío")
    ciudad_envio = models.ForeignKey(Ciudad, on_delete=models.SET_NULL, null=True, blank=True, related_name='pedidos_enviados_aqui', verbose_name="Ciudad de Envío")
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE, related_name='pedidos', verbose_name="Cliente")
    medio_de_pago = models.ForeignKey(MedioDePago, on_delete=models.SET_NULL, null=True, blank=True, related_name='pedidos_pagados_con', verbose_name="Medio de Pago")
    productos = models.ManyToManyField(Producto, through='PedidoProducto', related_name='en_pedidos', verbose_name="Productos en el Pedido")

    class Meta:
        db_table = 'pedidos'
        verbose_name = "Pedido"
        verbose_name_plural = "Pedidos"
        ordering = ['-fecha', 'cliente']

    def __str__(self):
        return f"Pedido #{self.pk} de {self.cliente.user.username} - {self.fecha}"

class PedidoProducto(models.Model): # Modelo intermedio para Pedido <-> Producto
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE, related_name="items_pedido", verbose_name="Pedido")
    producto = models.ForeignKey(Producto, on_delete=models.PROTECT, related_name="lineas_de_pedido", verbose_name="Producto")
    cantidad = models.PositiveIntegerField(default=1, verbose_name="Cantidad")
    valor_unitario = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="Valor Unitario en el Momento de la Compra")

    class Meta:
        db_table = 'pedido_productos'
        verbose_name = "Producto del Pedido"
        verbose_name_plural = "Productos del Pedido"
        ordering = ['pedido', 'producto']
        unique_together = (('pedido', 'producto'),)

    def __str__(self):
        return f"{self.cantidad} x {self.producto.nombre} en Pedido #{self.pedido.pk}"

# --- Modelo para Soporte ---

class TicketSoporte(models.Model):
    # Definimos las constantes para los estados
    ESTADO_ABIERTO = 'ABIERTO'
    ESTADO_EN_PROCESO = 'EN_PROCESO'
    ESTADO_RESUELTO = 'RESUELTO'
    ESTADO_CERRADO = 'CERRADO'
    
    ESTADO_CHOICES = [
        (ESTADO_ABIERTO, 'Abierto'),
        (ESTADO_EN_PROCESO, 'En Proceso'),
        (ESTADO_RESUELTO, 'Resuelto'),
        (ESTADO_CERRADO, 'Cerrado'),
    ]
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE, related_name='tickets_soporte', verbose_name="Cliente")
    descripcion = models.TextField(verbose_name="Descripción del Caso")
    estado = models.CharField(
        max_length=20,
        choices=ESTADO_CHOICES,
        default=ESTADO_ABIERTO, # Usamos la constante aquí
        verbose_name="Estado del Caso"
    )
    fecha_creacion = models.DateTimeField(auto_now_add=True, verbose_name="Fecha de Creación")
    fecha_actualizacion = models.DateTimeField(auto_now=True, verbose_name="Última Actualización")

    class Meta:
        db_table = 'tickets_soporte'
        verbose_name = "Ticket de Soporte"
        verbose_name_plural = "Tickets de Soporte"
        ordering = ['-fecha_creacion']

    def __str__(self):
        return f"Ticket #{self.pk} de {self.cliente.user.username} ({self.get_estado_display()})" # get_estado_display() es útil aquí
