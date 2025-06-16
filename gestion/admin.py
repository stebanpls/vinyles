from django.contrib import admin
from .models import (
    Crud, Cliente, Genero, Artista, Productor, Cancion, Producto, ProductoCancion,
    Pais, Departamento, Ciudad, MedioDePago, Pedido, PedidoProducto, TicketSoporte
)


class ProductoCancionInline(admin.TabularInline):
    model = ProductoCancion
    extra = 1 # Número de formularios extra para añadir canciones
    ordering = ['numero_pista']
    autocomplete_fields = ['cancion'] # Para usar autocompletado si CancionAdmin tiene search_fields

@admin.register(Producto)
class ProductoAdmin(admin.ModelAdmin):
    # Ajustado para coincidir con los nombres de campo en models.py: 'nombre' y 'lanzamiento'
    list_display = ('nombre', 'mostrar_artistas', 'lanzamiento', 'precio', 'stock')
    # Ajustado para coincidir con los nombres de campo: 'nombre' y 'artistas__nombre'
    search_fields = ('nombre', 'artistas__nombre')
    list_filter = ('genero_principal', 'lanzamiento') # 'lanzamiento' es correcto
    inlines = [ProductoCancionInline]
    # Ajustado para coincidir con el nombre del campo: 'artistas'
    filter_horizontal = ('artistas', 'genero_principal',)
    autocomplete_fields = ['artistas', 'genero_principal'] # Mejora la UI para ManyToMany

    def mostrar_artistas(self, obj):
        # Ajustado para usar obj.artistas
        return ", ".join([art.nombre for art in obj.artistas.all()])
    mostrar_artistas.short_description = 'Artistas'

@admin.register(Cancion)
class CancionAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'mostrar_duracion_formateada') # Añadido para mostrar duración
    search_fields = ('nombre', 'artistas__nombre', 'productores__nombre', 'generos__nombre')
    list_filter = ('generos',)
    filter_horizontal = ('artistas', 'productores', 'generos')
    autocomplete_fields = ['artistas', 'productores', 'generos']

    def mostrar_duracion_formateada(self, obj):
        if obj.duracion:
            total_seconds = int(obj.duracion.total_seconds())
            minutes = total_seconds // 60
            seconds = total_seconds % 60
            return f"{minutes:02d}:{seconds:02d}"
        return "N/A"
    mostrar_duracion_formateada.short_description = 'Duración'

@admin.register(Artista)
class ArtistaAdmin(admin.ModelAdmin):
    list_display = ('nombre',)
    search_fields = ('nombre',)

@admin.register(Productor)
class ProductorAdmin(admin.ModelAdmin):
    list_display = ('nombre',)
    search_fields = ('nombre',)

@admin.register(Genero)
class GeneroAdmin(admin.ModelAdmin):
    list_display = ('nombre',)
    search_fields = ('nombre',)

@admin.register(Crud)
class CrudAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'apellido', 'clase', 'fechaIngreso', 'foto')
    search_fields = ('nombre', 'apellido', 'clase')
    list_filter = ('fechaIngreso',)

@admin.register(Cliente)
class ClienteAdmin(admin.ModelAdmin):
    list_display = ('user', 'get_full_name', 'numero_documento', 'celular')
    search_fields = ('user__username', 'user__first_name', 'user__last_name', 'numero_documento', 'celular')
    raw_id_fields = ('user',) # Mejora la interfaz para seleccionar el usuario
    filter_horizontal = ('generos_favoritos', 'medios_de_pago_guardados')

    @admin.display(description='Nombre completo')
    def get_full_name(self, obj):
        return obj.user.get_full_name() or obj.user.username

@admin.register(Pais)
class PaisAdmin(admin.ModelAdmin):
    list_display = ('nombre',)
    search_fields = ('nombre',)
    ordering = ['nombre']

@admin.register(Departamento)
class DepartamentoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'pais')
    search_fields = ('nombre', 'pais__nombre')
    list_filter = ('pais',)
    ordering = ['pais__nombre', 'nombre']
    autocomplete_fields = ['pais']

@admin.register(Ciudad)
class CiudadAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'departamento_nombre', 'pais_nombre')
    search_fields = ('nombre', 'departamento__nombre', 'departamento__pais__nombre')
    list_filter = ('departamento__pais', 'departamento')
    ordering = ['departamento__pais__nombre', 'departamento__nombre', 'nombre']
    autocomplete_fields = ['departamento']

    @admin.display(description='Departamento', ordering='departamento__nombre')
    def departamento_nombre(self, obj):
        return obj.departamento.nombre

    @admin.display(description='País', ordering='departamento__pais__nombre')
    def pais_nombre(self, obj):
        return obj.departamento.pais.nombre

@admin.register(MedioDePago)
class MedioDePagoAdmin(admin.ModelAdmin):
    list_display = ('nombre',)
    search_fields = ('nombre',)

class PedidoProductoInline(admin.TabularInline):
    model = PedidoProducto
    extra = 1
    autocomplete_fields = ['producto']

@admin.register(Pedido)
class PedidoAdmin(admin.ModelAdmin):
    list_display = ('id', 'cliente', 'fecha', 'total', 'ciudad_envio', 'medio_de_pago')
    list_filter = ('fecha', 'medio_de_pago', 'ciudad_envio__departamento__pais', 'ciudad_envio__departamento')
    search_fields = ('id', 'cliente__user__username', 'cliente__user__first_name', 'cliente__user__last_name', 'direccion_envio')
    date_hierarchy = 'fecha'
    autocomplete_fields = ['cliente', 'ciudad_envio', 'medio_de_pago']
    inlines = [PedidoProductoInline]

@admin.register(PedidoProducto)
class PedidoProductoAdmin(admin.ModelAdmin):
    list_display = ('pedido', 'producto', 'cantidad', 'valor_unitario')
    search_fields = ('pedido__id', 'producto__nombre', 'pedido__cliente__user__username')
    list_filter = ('producto__genero_principal', 'producto')
    autocomplete_fields = ['pedido', 'producto']
    list_select_related = ('pedido__cliente__user', 'producto') # Optimiza consultas

@admin.register(TicketSoporte)
class TicketSoporteAdmin(admin.ModelAdmin):
    list_display = ('id', 'cliente', 'estado', 'fecha_creacion', 'fecha_actualizacion')
    list_filter = ('estado', 'fecha_creacion')
    search_fields = ('id', 'cliente__user__username', 'descripcion')
    date_hierarchy = 'fecha_creacion'
    readonly_fields = ('fecha_creacion', 'fecha_actualizacion')
    autocomplete_fields = ['cliente']