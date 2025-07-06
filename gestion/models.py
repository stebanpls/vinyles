import datetime
import logging  # Añadir al inicio del archivo
import os  # Para construir rutas de archivo
import secrets
import string
from uuid import uuid4  # Para generar nombres de archivo únicos

from django.conf import (
    settings,  # Añadido para que la lógica de Cliente.save() funcione correctamente
)
from django.contrib.auth.models import User  # Importa el modelo User
from django.db import models
from django.db.models.signals import post_save  # Para crear el perfil automáticamente
from django.dispatch import receiver  # Para el decorador de la señal
from django.utils import timezone
from PIL import Image  # Importar Pillow

logger = logging.getLogger(__name__)  # Añadir al inicio del archivo, después de los imports


def user_directory_path(instance, filename):
    new_filename = f"{uuid4().hex}.jpg"  # Siempre usaremos extensión .jpg
    return os.path.join("fotos_perfil", f"user_{instance.user.id}", new_filename)


# Create your models here.
class Crud(models.Model):  # Es mejor nombrar la clase con mayúscula inicial, siguiendo las convenciones de Python
    nombre = models.CharField(max_length=50, verbose_name="Nombre")
    apellido = models.CharField(max_length=50, verbose_name="Apellidos")  # Cambiado a plural para consistencia
    foto = models.ImageField(
        upload_to="fotos_crud/", verbose_name="Foto", null=True, blank=True
    )  # Añadido blank=True, y ruta de subida más específica
    # Si 'clase' tiene una longitud máxima definida, CharField es más apropiado que TextField.
    clase = models.CharField(max_length=100, verbose_name="Clase", blank=True)
    direccion = models.CharField(max_length=250, verbose_name="Dirección", blank=True)
    fechaIngreso = models.DateField(verbose_name="Fecha de Ingreso", blank=True, null=True)

    class Meta:
        db_table = "cruds"  # Nombre de tabla en plural
        verbose_name = "CRUD"  # Singular
        verbose_name_plural = "CRUDS"  # Plural

    def __str__(self):
        return f"ID = {self.pk} y Nombres: {self.nombre} {self.apellido}"

    def delete(self, using=None, keep_parents=False):
        if self.foto:  # Buena práctica: verificar si la foto existe antes de intentar borrarla
            self.foto.storage.delete(self.foto.name)
        super().delete()


# Modelo para representar los géneros musicales
class Genero(models.Model):
    nombre = models.CharField(max_length=100, unique=True, verbose_name="Nombre del Género")
    foto = models.ImageField(
        upload_to="generos/",
        verbose_name="Foto del Género",
        null=True,
        blank=True,
        default="generos/default/default_genero.png",
    )  # Nuevo campo para la foto del género

    class Meta:
        db_table = "generos"  # Nombre de tabla corto
        verbose_name = "Género"  # Coincide con el concepto de la tabla
        verbose_name_plural = "Géneros"  # Plural del verbose_name

    def __str__(self):
        return self.nombre

    def save(self, *args, **kwargs):
        self.nombre = self.nombre.upper()  # 💥 Aquí convierte a mayúscula antes de guardar

        old_instance = None
        if self.pk:
            try:
                old_instance = Genero.objects.get(pk=self.pk)
            except Genero.DoesNotExist:
                pass  # El objeto es nuevo, no hay foto antigua.

        super().save(*args, **kwargs)

        if old_instance and old_instance.foto and self.foto != old_instance.foto:
            if "default" not in old_instance.foto.name:
                old_instance.foto.delete(save=False)


class EstadoUsuario(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="estado_usuario")
    bloqueado = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.user.username} - {'Bloqueado' if self.bloqueado else 'Activo'}"


# Modelo para extender el modelo User de Django con información específica del cliente
class Cliente(models.Model):  # Renombrado de ClienteProfile a Cliente
    user = models.OneToOneField(
        User, on_delete=models.CASCADE, primary_key=True, related_name="cliente"
    )  # Cambiado related_name a 'cliente'
    numero_documento = models.CharField(max_length=20, blank=True, verbose_name="Número de Documento")
    celular = models.CharField(max_length=20, blank=True, verbose_name="Celular")
    direccion_residencia = models.CharField(max_length=255, blank=True)
    foto_perfil = models.ImageField(
        upload_to=user_directory_path,
        null=True,
        blank=True,
        verbose_name="Foto de Perfil",
        default="fotos_perfil/default/default_avatar.png",  # Asegúrate de que esta ruta sea correcta
    )
    generos_favoritos = models.ManyToManyField(Genero, blank=True, verbose_name="Géneros Favoritos")
    medios_de_pago_guardados = models.ManyToManyField(
        "MedioDePago",  # Forward reference to MedioDePago model
        blank=True,
        verbose_name="Medios de Pago Guardados",
        db_table="cliente_medio_de_pago",  # Explicitly naming the M2M table to match SQL
    )

    class Meta:
        db_table = "clientes"  # Nombre de tabla para los clientes
        verbose_name = "Cliente"  # Singular
        verbose_name_plural = "Clientes"  # Plural

    def __str__(self):
        return f"Cliente: {self.user.username}"

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        self._clean_orphan_profile_photos()
        self._process_profile_image()

    def _clean_orphan_profile_photos(self):
        """Elimina fotos de perfil antiguas y directorios vacíos."""
        user_photo_dir = os.path.join(settings.MEDIA_ROOT, "fotos_perfil", f"user_{self.user.id}")
        current_photo_filename = None
        if self.foto_perfil and "default" not in self.foto_perfil.name:
            current_photo_filename = os.path.basename(self.foto_perfil.name)

        if os.path.exists(user_photo_dir):
            for filename in os.listdir(user_photo_dir):
                if filename != current_photo_filename:
                    file_path_to_delete = os.path.join(user_photo_dir, filename)
                    try:
                        os.remove(file_path_to_delete)
                        logger.info("Archivo de perfil huérfano eliminado: %s", file_path_to_delete)
                    except OSError as e:
                        logger.error("Error al eliminar archivo huérfano %s: %s", file_path_to_delete, e)

            if not os.listdir(user_photo_dir):
                try:
                    os.rmdir(user_photo_dir)
                    logger.info("Directorio de usuario vacío eliminado: %s", user_photo_dir)
                except OSError as e:
                    logger.warning("No se pudo eliminar el directorio vacío %s: %s", user_photo_dir, e)

    def _process_profile_image(self):
        """Recorta, convierte y optimiza la imagen de perfil."""
        if self.foto_perfil and hasattr(self.foto_perfil, "path") and "default" not in self.foto_perfil.name:
            try:
                img = Image.open(self.foto_perfil.path)
                width, height = img.size
                if width != height:
                    short_side = min(width, height)
                    left = (width - short_side) / 2
                    top = (height - short_side) / 2
                    right = (width + short_side) / 2
                    bottom = (height + short_side) / 2
                    img = img.crop((int(left), int(top), int(right), int(bottom)))

                if img.mode in ("RGBA", "LA") or (img.mode == "P" and "transparency" in img.info):
                    background = Image.new("RGB", img.size, (255, 255, 255))
                    mask = img.split()[-1] if img.mode in ("RGBA", "LA") else img.convert("RGBA").split()[-1]
                    background.paste(img, (0, 0), mask)
                    img = background
                elif img.mode != "RGB":
                    img = img.convert("RGB")

                img.save(self.foto_perfil.path, format="JPEG", quality=85, optimize=True)
                logger.info("Imagen de perfil procesada para %s", self.user.username)
            except FileNotFoundError:
                logger.error("Archivo no encontrado para procesar: %s", self.foto_perfil.path)
            except Exception as e:
                logger.error("Error procesando imagen de perfil para %s: %s", self.user.username, e)


class PasswordResetCode(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="reset_codes", verbose_name="Usuario")
    code = models.CharField(max_length=6, unique=True, verbose_name="Código")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Fecha de Creación")
    expires_at = models.DateTimeField(verbose_name="Fecha de Expiración")

    class Meta:
        db_table = "password_reset_codes"
        verbose_name = "Código de Restablecimiento de Contraseña"
        verbose_name_plural = "Códigos de Restablecimiento de Contraseña"
        ordering = ["-created_at"]

    def __str__(self):
        return f"Código para {self.user.username}"

    def save(self, *args, **kwargs):
        if not self.pk:
            self.code = "".join(secrets.choice(string.digits) for _ in range(6))
            while PasswordResetCode.objects.filter(code=self.code).exists():
                self.code = "".join(secrets.choice(string.digits) for _ in range(6))
            self.expires_at = timezone.now() + datetime.timedelta(minutes=10)  # Código válido por 10 minutos
        super().save(*args, **kwargs)

    def is_valid(self):
        """Verifica si el código aún es válido."""
        return timezone.now() < self.expires_at


# Señal para crear automáticamente un ClienteProfile cuando se crea un User
@receiver(post_save, sender=User)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    if created:
        try:
            Cliente.objects.create(user=instance)
        except Exception as e:
            # En lugar de 'pass', registra el error
            logger.error("Error al crear el perfil Cliente para el usuario %s: %s", instance.username, e)


# --- Modelos para Catálogo de Música (Ajustados a vinyles.sql y convenciones) ---


class Artista(models.Model):
    nombre = models.CharField(max_length=200, unique=True, verbose_name="Nombre del Artista")
    informacion = models.TextField(verbose_name="Información del Artista", blank=True, default="")
    foto = models.ImageField(
        upload_to="artistas/",
        verbose_name="Foto del Artista",
        null=True,
        blank=True,
        default="artistas/default/default_avatar.png",
    )
    discogs_id = models.CharField(max_length=255, unique=True, null=True, blank=True, verbose_name="ID de Discogs")

    class Meta:
        db_table = "artistas"  # Convención: plural
        verbose_name = "Artista"
        verbose_name_plural = "Artistas"
        ordering = ["nombre"]

    def __str__(self):
        return self.nombre

    def save(self, *args, **kwargs):
        old_instance = None
        if self.pk:
            try:
                old_instance = Artista.objects.get(pk=self.pk)
            except Artista.DoesNotExist:
                pass  # El objeto es nuevo, no hay foto antigua.

        super().save(*args, **kwargs)

        if old_instance and old_instance.foto and self.foto != old_instance.foto:
            if "default" not in old_instance.foto.name:
                old_instance.foto.delete(save=False)


class Productor(models.Model):
    nombre = models.CharField(max_length=200, unique=True, verbose_name="Nombre del Productor")
    discogs_id = models.CharField(max_length=255, unique=True, null=True, blank=True, verbose_name="ID de Discogs")

    class Meta:
        db_table = "productores"  # Convención: plural
        verbose_name = "Productor"
        verbose_name_plural = "Productores"
        ordering = ["nombre"]

    def __str__(self):
        return self.nombre


class Cancion(models.Model):
    nombre = models.CharField(max_length=200, verbose_name="Nombre de la Canción")
    artistas = models.ManyToManyField(Artista, related_name="canciones_realizadas", blank=True, verbose_name="Artistas")
    productores = models.ManyToManyField(
        Productor, related_name="canciones_producidas", blank=True, verbose_name="Productores"
    )
    generos = models.ManyToManyField(Genero, related_name="canciones_genero", blank=True, verbose_name="Géneros")
    discogs_id = models.CharField(max_length=255, unique=True, null=True, blank=True, verbose_name="ID de Discogs")
    duracion = models.DurationField(verbose_name="Duración (ej: 00:03:46)", blank=True, null=True)

    class Meta:
        db_table = "canciones"  # Convención: plural
        verbose_name = "Canción"
        verbose_name_plural = "Canciones"
        ordering = ["nombre"]
        # Evitar duplicados basados en nombre y duración, que es un buen proxy
        # para la unicidad antes de tener IDs de Discogs para todo.
        unique_together = (("nombre", "duracion"),)

    def __str__(self):
        return self.nombre


# --- MODELO PRODUCTO (CATÁLOGO MAESTRO) ---
class Producto(models.Model):
    nombre = models.CharField(max_length=255, verbose_name="Nombre del Producto/Álbum")
    artistas = models.ManyToManyField(Artista, related_name="productos", verbose_name="Artista(s) Principal(es)")
    lanzamiento = models.DateField(verbose_name="Fecha de Lanzamiento", null=True, blank=True)
    descripcion = models.TextField(verbose_name="Descripción del Producto", blank=True)
    discografica = models.CharField(max_length=200, verbose_name="Compañía Discográfica", blank=True)
    imagen_portada = models.ImageField(
        upload_to="productos_portadas/",
        verbose_name="Imagen de Portada",
        default="albumes/default/default_album.png",
    )
    genero_principal = models.ManyToManyField(
        Genero,
        related_name="productos_principales",
        verbose_name="Género(s) Principal(es) del Álbum",
        blank=True,
    )
    discogs_id = models.CharField(max_length=255, unique=True, null=True, blank=True, verbose_name="ID de Discogs")

    class Meta:
        db_table = "productos"
        verbose_name = "Producto (Catálogo)"
        verbose_name_plural = "Productos (Catálogo)"
        ordering = ["nombre"]

    def __str__(self):
        artistas_nombres = ", ".join(art.nombre for art in self.artistas.all())
        return f"{self.nombre} - {artistas_nombres}"

    def save(self, *args, **kwargs):
        old_instance = None
        if self.pk:
            try:
                old_instance = Producto.objects.get(pk=self.pk)
            except Producto.DoesNotExist:
                pass

        super().save(*args, **kwargs)

        if old_instance and old_instance.imagen_portada and self.imagen_portada != old_instance.imagen_portada:
            if "default" not in old_instance.imagen_portada.name:
                old_instance.imagen_portada.delete(save=False)


# --- NUEVO MODELO: PUBLICACION (OFERTA DEL VENDEDOR) ---
class Publicacion(models.Model):
    producto = models.ForeignKey(
        Producto,
        on_delete=models.CASCADE,
        related_name="publicaciones",
        verbose_name="Producto del Catálogo",
    )
    vendedor = models.ForeignKey(User, on_delete=models.CASCADE, related_name="publicaciones", verbose_name="Vendedor")
    precio = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="Precio de Venta")
    stock = models.PositiveIntegerField(default=1, verbose_name="Cantidad en Venta")
    descripcion_condicion = models.TextField(
        verbose_name="Descripción de la Condición",
        help_text="Ej: 'Casi nuevo, solo se usó una vez.' o 'La portada tiene un ligero desgaste en la esquina.'",
    )
    fecha_publicacion = models.DateTimeField(auto_now_add=True, verbose_name="Fecha de Publicación")
    activa = models.BooleanField(default=True, verbose_name="Publicación Activa")

    class Meta:
        db_table = "publicaciones"
        verbose_name = "Publicación (Oferta)"
        verbose_name_plural = "Publicaciones (Ofertas)"
        ordering = ["-fecha_publicacion"]
        unique_together = (
            ("producto", "vendedor"),
        )  # Un vendedor solo puede tener una publicación activa por producto

    def __str__(self):
        return f"Oferta de {self.vendedor.username} para {self.producto.nombre} por ${self.precio}"


class ProductoCancion(models.Model):
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE, related_name="tracks", verbose_name="Producto")
    cancion = models.ForeignKey(
        Cancion,
        on_delete=models.CASCADE,
        related_name="apariciones_en_productos",
        verbose_name="Canción",
    )
    numero_pista = models.PositiveIntegerField(verbose_name="Número de Pista")

    class Meta:
        db_table = "producto_canciones"  # Convención: plural
        verbose_name = "Canción en Producto"
        verbose_name_plural = "Canciones en Productos"
        ordering = ["producto", "numero_pista"]
        unique_together = (("producto", "cancion"), ("producto", "numero_pista"))

    def __str__(self):
        return f"Pista {self.numero_pista}: {self.cancion.nombre} (Álbum: {self.producto.nombre})"


# --- Modelos para Localización Geográfica (Pedidos) ---


class Pais(models.Model):
    nombre = models.CharField(max_length=100, verbose_name="Nombre del País")

    class Meta:
        db_table = "paises"
        verbose_name = "País"
        verbose_name_plural = "Países"
        ordering = ["nombre"]

    def __str__(self):
        return self.nombre


class Departamento(models.Model):
    nombre = models.CharField(max_length=100, verbose_name="Nombre del Departamento")
    pais = models.ForeignKey(Pais, on_delete=models.CASCADE, related_name="departamentos", verbose_name="País")

    class Meta:
        db_table = "departamentos"
        verbose_name = "Departamento"
        verbose_name_plural = "Departamentos"
        ordering = ["pais", "nombre"]

    def __str__(self):
        return f"{self.nombre}, {self.pais.nombre}"


class Ciudad(models.Model):
    nombre = models.CharField(max_length=100, verbose_name="Nombre de la Ciudad")
    departamento = models.ForeignKey(
        Departamento,
        on_delete=models.CASCADE,
        related_name="ciudades",
        verbose_name="Departamento",
    )

    class Meta:
        db_table = "ciudades"
        verbose_name = "Ciudad"
        verbose_name_plural = "Ciudades"
        ordering = ["departamento", "nombre"]

    def __str__(self):
        return f"{self.nombre}, {self.departamento.nombre}"


# --- Modelos para Pedidos y Pagos ---


class MedioDePago(models.Model):
    nombre = models.CharField(max_length=100, unique=True, verbose_name="Nombre del Medio de Pago")

    class Meta:
        db_table = "medios_de_pago"
        verbose_name = "Medio de Pago"
        verbose_name_plural = "Medios de Pago"
        ordering = ["nombre"]

    def __str__(self):
        return self.nombre


# --- Modelo para Soporte ---


class TicketSoporte(models.Model):
    # Definimos las constantes para los estados
    ESTADO_ABIERTO = "ABIERTO"
    ESTADO_EN_PROCESO = "EN_PROCESO"
    ESTADO_RESUELTO = "RESUELTO"
    ESTADO_CERRADO = "CERRADO"

    ESTADO_CHOICES = [
        (ESTADO_ABIERTO, "Abierto"),
        (ESTADO_EN_PROCESO, "En Proceso"),
        (ESTADO_RESUELTO, "Resuelto"),
        (ESTADO_CERRADO, "Cerrado"),
    ]
    cliente = models.ForeignKey(
        Cliente, on_delete=models.CASCADE, related_name="tickets_soporte", verbose_name="Cliente"
    )
    descripcion = models.TextField(verbose_name="Descripción del Caso")
    estado = models.CharField(
        max_length=20,
        choices=ESTADO_CHOICES,
        default=ESTADO_ABIERTO,  # Usamos la constante aquí
        verbose_name="Estado del Caso",
    )
    fecha_creacion = models.DateTimeField(auto_now_add=True, verbose_name="Fecha de Creación")
    fecha_actualizacion = models.DateTimeField(auto_now=True, verbose_name="Última Actualización")

    class Meta:
        db_table = "tickets_soporte"
        verbose_name = "Ticket de Soporte"
        verbose_name_plural = "Tickets de Soporte"
        ordering = ["-fecha_creacion"]

    def __str__(self):
        return f"Ticket #{self.pk} de {self.cliente.user.username} ({self.get_estado_display()})"  # get_estado_display() es útil aquí


class Notificacion(models.Model):
    """
    Modelo para guardar notificaciones para los usuarios, especialmente administradores.
    """

    # El usuario que recibe la notificación.
    usuario_destino = models.ForeignKey(User, on_delete=models.CASCADE, related_name="notificaciones")
    mensaje = models.TextField(help_text="El contenido de la notificación.")
    leido = models.BooleanField(default=False)
    fecha_creacion = models.DateTimeField(default=timezone.now)
    # URL opcional para que la notificación sea un enlace (ej. al producto editado)
    url_destino = models.CharField(max_length=255, blank=True, help_text="URL a la que debe dirigir la notificación.")

    class Meta:
        ordering = ["-fecha_creacion"]
        verbose_name = "Notificación"
        verbose_name_plural = "Notificaciones"

    def __str__(self):
        return f"Notificación para {self.usuario_destino.username}: {self.mensaje[:30]}..."


class Pedido(models.Model):
    comprador = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name="pedidos")
    fecha_pedido = models.DateTimeField(auto_now_add=True)
    total = models.DecimalField(max_digits=10, decimal_places=2)
    direccion_envio = models.TextField()
    ESTADOS_PEDIDO = [
        ("P", "Procesando"),
        ("E", "Enviado"),
        ("C", "Completado"),
        ("X", "Cancelado"),
    ]
    estado = models.CharField(max_length=1, choices=ESTADOS_PEDIDO, default="P")

    class Meta:
        ordering = ["-fecha_pedido"]

    def __str__(self):
        return f"Pedido #{self.id} de {self.comprador.username if self.comprador else 'Usuario Eliminado'}"

    @property
    def subtotal(self):
        """Calcula el subtotal del pedido sumando los subtotales de los detalles."""
        # Usamos prefetch_related en la vista para optimizar esto
        return sum(detalle.subtotal for detalle in self.detalles.all())

    @property
    def costo_envio(self):
        """Calcula el costo de envío restando el subtotal del total."""
        return self.total - self.subtotal


class DetallePedido(models.Model):
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE, related_name="detalles")
    publicacion = models.ForeignKey(Publicacion, on_delete=models.PROTECT, related_name="detalles_pedido")
    cantidad = models.PositiveIntegerField(default=1)
    precio_unitario = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"{self.cantidad} x {self.publicacion.producto.nombre} en Pedido #{self.pedido.id}"

    @property
    def subtotal(self):
        return self.cantidad * self.precio_unitario
