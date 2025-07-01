from django.contrib import admin
from django.contrib.auth.admin import GroupAdmin, UserAdmin
from django.contrib.auth.models import Group, User
from django.contrib.sites.admin import SiteAdmin
from django.contrib.sites.models import Site

from vinyles.admin import custom_admin_site

from .models import (
    Artista,
    Cancion,
    Ciudad,
    Cliente,
    Crud,
    Departamento,
    Genero,
    MedioDePago,
    Pais,
    Pedido,
    PedidoPublicacion,
    Producto,
    ProductoCancion,
    Productor,
    Publicacion,
    TicketSoporte,
)

# --- INLINES ---


class PublicacionInline(admin.TabularInline):
    """Muestra las publicaciones de un producto en la página del catálogo."""

    model = Publicacion
    extra = 0  # No mostrar formularios extra por defecto
    readonly_fields = ("vendedor", "precio", "stock", "activa", "fecha_publicacion")
    can_delete = False

    def has_add_permission(self, request, obj=None):
        return False


class ProductoCancionInline(admin.TabularInline):
    """Permite añadir canciones a un producto del catálogo."""

    model = ProductoCancion
    extra = 1
    ordering = ["numero_pista"]
    autocomplete_fields = ["cancion"]


class PedidoPublicacionInline(admin.TabularInline):
    """Muestra las publicaciones compradas en un pedido."""

    model = PedidoPublicacion
    extra = 0
    autocomplete_fields = ["publicacion"]


# --- MODEL ADMINS ---


class ProductoAdmin(admin.ModelAdmin):
    """Admin para el catálogo de Productos."""

    list_display = ("nombre", "mostrar_artistas", "lanzamiento", "discografica")
    search_fields = ("nombre", "artistas__nombre", "discogs_id")
    list_filter = ("genero_principal", "lanzamiento")
    inlines = [ProductoCancionInline, PublicacionInline]  # Añadimos ambos inlines
    filter_horizontal = (
        "artistas",
        "genero_principal",
    )
    autocomplete_fields = ["artistas", "genero_principal"]

    def mostrar_artistas(self, obj):
        return ", ".join([art.nombre for art in obj.artistas.all()])

    mostrar_artistas.short_description = "Artistas"


class PublicacionAdmin(admin.ModelAdmin):
    """Admin para las Publicaciones (ofertas de los vendedores)."""

    list_display = ("producto", "vendedor", "precio", "stock", "activa", "fecha_publicacion")
    list_filter = ("activa", "vendedor")
    search_fields = ("producto__nombre", "vendedor__username", "producto__discogs_id")
    autocomplete_fields = ["producto", "vendedor"]
    list_editable = ("precio", "stock", "activa")


class CancionAdmin(admin.ModelAdmin):
    list_display = ("nombre", "mostrar_duracion_formateada")
    search_fields = ("nombre", "artistas__nombre", "productores__nombre", "generos__nombre")
    list_filter = ("generos",)
    filter_horizontal = ("artistas", "productores", "generos")
    autocomplete_fields = ["artistas", "productores", "generos"]

    def mostrar_duracion_formateada(self, obj):
        if obj.duracion:
            total_seconds = int(obj.duracion.total_seconds())
            minutes = total_seconds // 60
            seconds = total_seconds % 60
            return f"{minutes:02d}:{seconds:02d}"
        return "N/A"

    mostrar_duracion_formateada.short_description = "Duración"


class PedidoAdmin(admin.ModelAdmin):
    list_display = ("id", "cliente", "fecha", "total", "ciudad_envio", "medio_de_pago")
    list_filter = ("fecha", "medio_de_pago", "ciudad_envio__departamento__pais")
    search_fields = ("id", "cliente__user__username")
    date_hierarchy = "fecha"
    autocomplete_fields = ["cliente", "ciudad_envio", "medio_de_pago"]
    inlines = [PedidoPublicacionInline]  # Usamos el nuevo inline


# --- OTROS ADMINS (sin cambios mayores) ---


class ArtistaAdmin(admin.ModelAdmin):
    list_display = ("nombre",)
    search_fields = ("nombre",)


class ProductorAdmin(admin.ModelAdmin):
    list_display = ("nombre",)
    search_fields = ("nombre",)


class GeneroAdmin(admin.ModelAdmin):
    list_display = ("nombre",)
    search_fields = ("nombre",)


class CrudAdmin(admin.ModelAdmin):
    list_display = ("nombre", "apellido", "clase", "fechaIngreso", "foto")
    search_fields = ("nombre", "apellido", "clase")
    list_filter = ("fechaIngreso",)


class ClienteAdmin(admin.ModelAdmin):
    list_display = ("user", "get_full_name", "numero_documento", "celular")
    search_fields = (
        "user__username",
        "user__first_name",
        "user__last_name",
        "numero_documento",
        "celular",
    )
    raw_id_fields = ("user",)
    filter_horizontal = ("generos_favoritos", "medios_de_pago_guardados")

    @admin.display(description="Nombre completo")
    def get_full_name(self, obj):
        return obj.user.get_full_name() or obj.user.username


class PaisAdmin(admin.ModelAdmin):
    list_display = ("nombre",)
    search_fields = ("nombre",)
    ordering = ["nombre"]


class DepartamentoAdmin(admin.ModelAdmin):
    list_display = ("nombre", "pais")
    search_fields = ("nombre", "pais__nombre")
    list_filter = ("pais",)
    ordering = ["pais__nombre", "nombre"]
    autocomplete_fields = ["pais"]


class CiudadAdmin(admin.ModelAdmin):
    list_display = ("nombre", "departamento_nombre", "pais_nombre")
    search_fields = ("nombre", "departamento__nombre", "departamento__pais__nombre")
    list_filter = ("departamento__pais", "departamento")
    ordering = ["departamento__pais__nombre", "departamento__nombre", "nombre"]
    autocomplete_fields = ["departamento"]

    @admin.display(description="Departamento", ordering="departamento__nombre")
    def departamento_nombre(self, obj):
        return obj.departamento.nombre

    @admin.display(description="País", ordering="departamento__pais__nombre")
    def pais_nombre(self, obj):
        return obj.departamento.pais.nombre


class MedioDePagoAdmin(admin.ModelAdmin):
    list_display = ("nombre",)
    search_fields = ("nombre",)


class TicketSoporteAdmin(admin.ModelAdmin):
    list_display = ("id", "cliente", "estado", "fecha_creacion", "fecha_actualizacion")
    list_filter = ("estado", "fecha_creacion")
    search_fields = ("id", "cliente__user__username", "descripcion")
    date_hierarchy = "fecha_creacion"
    readonly_fields = ("fecha_creacion", "fecha_actualizacion")
    autocomplete_fields = ["cliente"]


# --- REGISTRO EN EL SITIO DE ADMIN ---

# Registrar los modelos de Django con el sitio personalizado
custom_admin_site.register(User, UserAdmin)
custom_admin_site.register(Group, GroupAdmin)
custom_admin_site.register(Site, SiteAdmin)

# Registrar nuestros modelos
custom_admin_site.register(Producto, ProductoAdmin)
custom_admin_site.register(Publicacion, PublicacionAdmin)  # Nuevo
custom_admin_site.register(Cancion, CancionAdmin)
custom_admin_site.register(Artista, ArtistaAdmin)
custom_admin_site.register(Productor, ProductorAdmin)
custom_admin_site.register(Genero, GeneroAdmin)
custom_admin_site.register(Crud, CrudAdmin)
custom_admin_site.register(Cliente, ClienteAdmin)
custom_admin_site.register(Pais, PaisAdmin)
custom_admin_site.register(Departamento, DepartamentoAdmin)
custom_admin_site.register(Ciudad, CiudadAdmin)
custom_admin_site.register(MedioDePago, MedioDePagoAdmin)
custom_admin_site.register(Pedido, PedidoAdmin)
custom_admin_site.register(TicketSoporte, TicketSoporteAdmin)
# No registramos PedidoPublicacion directamente, se maneja a través del inline en PedidoAdmin
