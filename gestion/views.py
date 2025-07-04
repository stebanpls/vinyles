import logging
import os  # Importar para obtener variables de entorno
from datetime import timedelta  # Importar timedelta

from django.conf import settings  # Para acceder a settings.py
from django.contrib import messages  # Para mensajes opcionales
from django.contrib.auth import (  # Importa las funciones de autenticación
    authenticate,
    update_session_auth_hash,
)
from django.contrib.auth import login as auth_login
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.decorators import login_required, user_passes_test  # Para proteger vistas
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth.models import User  # Importar el modelo User y Group estándar
from django.contrib.sites.shortcuts import get_current_site
from django.core.mail import EmailMultiAlternatives  # Importar para enviar correos HTML
from django.db import transaction
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.template.loader import render_to_string
from django.urls import reverse
from django.utils import timezone  # Importar timedelta también
from django.views.decorators.cache import never_cache  # Importar never_cache

from .discogs_api_utils import discogs_api
from .forms import (
    ArtistaForm,
    CancionForm,
    ClienteEditForm,
    ClienteUpdateForm,
    CrearUsuarioStaffForm,
    GeneroForm,
    LoginForm,
    PasswordResetConfirmForm,
    PasswordResetRequestForm,
    ProductorForm,
    PublicacionForm,
    UserEditForm,
    UserRegistrationForm,
    UserUpdateForm,
    VentaDesdeCatalogoForm,
)
from .models import (
    Artista,
    Cliente,
    EstadoUsuario,
    Genero,
    Notificacion,
    Producto,
    Publicacion,
)

logger = logging.getLogger(__name__)

# Vistas para los modales de creación


def artista_form_modal(request):
    if request.method == "POST":
        form = ArtistaForm(request.POST, request.FILES)
        if form.is_valid():
            artista = form.save()
            return JsonResponse({
                "success": True,
                "id": artista.id,
                "nombre": str(artista),  # Usar str(artista) para obtener la representación del modelo
            })
        else:
            print(f"Errores en el formulario de artista (modal): {form.errors.as_json()}")
            form_html = render_to_string("modales/modal_artista.html", {"form": form}, request=request)
            return JsonResponse({"success": False, "form_html": form_html})
    else:
        form = ArtistaForm()
    return render(request, "modales/modal_artista.html", {"form": form})


def modal_genero(request):
    if request.method == "POST":
        form = GeneroForm(request.POST, request.FILES)  # Ahora sí puede recibir archivos
        if form.is_valid():
            genero = form.save()
            return JsonResponse({"success": True, "id": genero.id, "nombre": str(genero)})
        else:
            print(f"Errores en el formulario de género (modal): {form.errors.as_json()}")
            form_html = render_to_string("modales/modal_genero.html", {"form": form}, request=request)
            return JsonResponse({"success": False, "form_html": form_html})
    else:
        form = GeneroForm()
    return render(request, "modales/modal_genero.html", {"form": form})


def modal_productor(request):
    if request.method == "POST":
        form = ProductorForm(request.POST)  # No necesita request.FILES
        if form.is_valid():
            productor = form.save()
            return JsonResponse({"success": True, "id": productor.id, "nombre": str(productor)})
        else:
            print(f"Errores en el formulario de productor (modal): {form.errors.as_json()}")
            form_html = render_to_string("modales/modal_productor.html", {"form": form}, request=request)
            return JsonResponse({"success": False, "form_html": form_html})
    else:
        form = ProductorForm()  # Corregido: Usar ProductorForm
    return render(request, "modales/modal_productor.html", {"form": form})


def modal_cancion(
    request,
):  # Esta vista es para crear una canción individualmente, no para asociarla a un producto.
    if request.method == "POST":
        form = CancionForm(request.POST)  # Asumiendo que CancionForm no maneja archivos directamente
        if form.is_valid():
            cancion = form.save()
            return JsonResponse({"success": True, "id": cancion.id, "nombre": str(cancion)})
        else:
            print(f"Errores en el formulario de canción (modal): {form.errors.as_json()}")
            form_html = render_to_string("modales/modal_cancion.html", {"form": form}, request=request)
            return JsonResponse({"success": False, "form_html": form_html})
    else:
        form = CancionForm()
    return render(request, "modales/modal_cancion.html", {"form": form})


# VISTAS DE LA CARPETA "PUBLICO"


def inicio_view(request):
    """
    Vista unificada para la página de inicio.
    Muestra la versión de comprador si el usuario está autenticado,
    de lo contrario muestra la versión pública.
    """
    publicaciones = (
        Publicacion.objects.filter(stock__gt=0, activa=True)
        .select_related("producto")
        .prefetch_related("producto__artistas")
        .order_by("-fecha_publicacion")[:15]
    )

    if request.user.is_authenticated:
        # Lógica para el comprador (com_inicio)
        usuario = request.user
        cliente = getattr(usuario, "cliente", None)

        try:
            estado_usuario = EstadoUsuario.objects.get(user=usuario)
            esta_bloqueado = estado_usuario.bloqueado
        except EstadoUsuario.DoesNotExist:
            esta_bloqueado = False

        if esta_bloqueado or not usuario.is_active:
            request.session["mostrar_alerta_bloqueado"] = True
        else:
            request.session.pop("mostrar_alerta_bloqueado", None)

        context = {"publicaciones": publicaciones, "usuario": usuario, "cliente": cliente}
        return render(request, "paginas/comprador/com_inicio.html", context)
    else:
        # Lógica para el público (pub_inicio)
        context = {"publicaciones": publicaciones}
        return render(request, "paginas/publico/pub_inicio.html", context)


def pub_albumes(request):
    publicaciones = (
        Publicacion.objects.filter(stock__gt=0, activa=True)
        .select_related("producto")
        .prefetch_related("producto__artistas", "producto__genero_principal")
        .order_by("-fecha_publicacion")
    )
    generos = Genero.objects.all().order_by("nombre")
    context = {
        "publicaciones": publicaciones,
        "generos": generos,
        "base_template": "plantillas/plantilla_publico.html",  # <-- AÑADE ESTA LÍNEA
    }
    return render(request, "paginas/publico/pub_albumes.html", context)


def pub_ddl(request):
    return render(request, "paginas/publico/pub_ddl.html")


def pub_login(request):
    album_name_get = request.GET.get("album_name")
    artist_get = request.GET.get("artist")
    price_get = request.GET.get("price")
    image_get = request.GET.get("image")

    next_url = request.GET.get("next") or request.POST.get("next")

    if request.user.is_authenticated:
        if request.user.is_staff or request.user.is_superuser:
            return redirect(next_url or "admin_administrador")
        else:
            return redirect(next_url or "com_inicio")

    form = LoginForm()  # Inicializar el formulario para GET requests

    if request.method == "POST":
        form = LoginForm(request.POST)  # Vincular datos del POST al formulario

        post_album_name = request.POST.get("album_name", album_name_get)
        post_artist = request.POST.get("artist", artist_get)
        post_price = request.POST.get("price", price_get)
        post_image = request.POST.get("image", image_get)
        album_name_get = post_album_name
        artist_get = post_artist
        price_get = post_price
        image_get = post_image

        if form.is_valid():  # Esto validará el reCAPTCHA y los otros campos
            identifier = form.cleaned_data["login_identifier"]
            password = form.cleaned_data["password"]
            specific_auth_error_occurred = False

            user = authenticate(request, username=identifier, password=password)

            if user is None:
                try:
                    user_by_email = User.objects.get(email__iexact=identifier)  # Búsqueda case-insensitive
                    user = authenticate(request, username=user_by_email.username, password=password)
                except User.DoesNotExist:
                    pass
                except User.MultipleObjectsReturned:
                    messages.error(
                        request,
                        "Múltiples cuentas están asociadas con este correo electrónico. Por favor, contacte a soporte.",
                    )
                    specific_auth_error_occurred = True  # Marcar que este error específico ocurrió

            if user is not None:
                estado = getattr(user, "estado", None)

                if estado and estado.bloqueado:
                    request.session["mostrar_alerta_bloqueado"] = True

                auth_login(request, user)
                messages.success(request, f"¡Bienvenido de nuevo, {user.username}!")

                default_redirect_url_name = "com_inicio"  # Default para usuarios normales
                if user.is_staff or user.is_superuser:
                    default_redirect_url_name = "admin_administrador"
                if next_url:
                    return redirect(next_url)
                return redirect(default_redirect_url_name)
            else:
                if not specific_auth_error_occurred:
                    messages.error(
                        request,
                        "El nombre de usuario/email o la contraseña son incorrectos. Por favor, inténtalo de nuevo.",
                    )
    context = {
        "form": form,  # Pasar el formulario al contexto
        "album_name_get": album_name_get,  # Datos del álbum de GET
        "artist_get": artist_get,  # Datos del álbum de GET
        "price_get": price_get,  # Datos del álbum de GET
        "image_get": image_get,  # Datos del álbum de GET
        "next_url": next_url,  # URL 'next' de GET o POST
    }
    return render(request, "paginas/publico/pub_login.html", context)


def pub_log_out(request):
    auth_logout(request)  # 🔒 Cierra la sesión del usuario
    request.session.flush()  # 💥 Limpia completamente la sesión

    messages.info(request, "Has cerrado sesión exitosamente. ¡Hasta luego!")
    return render(request, "paginas/publico/pub_log_out.html")  # Página de sesión cerrada


def pub_nosotros(request):
    return render(request, "paginas/publico/pub_nosotros.html")  # Se crea un renderizado de este archivo HTML.


def pub_registro(request):
    if request.user.is_authenticated:
        messages.info(
            request,
            "Ya has iniciado sesión. Si deseas registrar una nueva cuenta, por favor cierra tu sesión actual primero.",
        )
        if hasattr(request.user, "is_staff") and request.user.is_staff:
            return redirect(
                "admin_administrador"
            )  # Asegúrate que 'admin_administrador' es el name de tu URL del panel de admin
        else:
            return redirect("com_inicio")  # Asegúrate que 'com_inicio' es el name de tu URL del dashboard de comprador

    if request.method == "POST":
        user_form = UserRegistrationForm(request.POST)  # Crea una instancia del formulario con los datos enviados
        if user_form.is_valid():
            user_form.save()

            messages.success(request, "¡Registro exitoso! Ahora puedes iniciar sesión.")
            return redirect("pub_login")  # Redirigir al login después del registro exitoso
        else:
            messages.error(request, "Por favor corrige los errores presentados en el formulario.")
    else:
        user_form = UserRegistrationForm()  # Si no es POST, crea un formulario vacío
    return render(request, "paginas/publico/pub_registro.html", {"user_form": user_form})


def pub_reembolsos(request):
    return render(request, "paginas/publico/pub_reembolsos.html")


def pub_soporte(request):
    return render(request, "paginas/publico/pub_soporte.html")


def pub_terminos(request):
    return render(request, "paginas/publico/pub_terminos.html")


def pub_vinilo(request, producto_id):
    producto = get_object_or_404(Producto, pk=producto_id)
    # Opcional: podrías querer mostrar todas las publicaciones activas para este producto
    publicaciones = Publicacion.objects.filter(producto=producto, activa=True, stock__gt=0).select_related("vendedor")

    context = {
        "producto": producto,
        "publicaciones": publicaciones,
        # Aquí puedes añadir más detalles si los necesitas, como las canciones
        "canciones": producto.tracks.all().order_by("numero_pista").select_related("cancion"),
    }
    return render(request, "paginas/publico/pub_vinilo.html", context)


def password_reset_request(request):
    if request.user.is_authenticated:
        return redirect("com_inicio")

    if request.method == "POST":
        form = PasswordResetRequestForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data["email"]
            user = User.objects.get(email__iexact=email, is_active=True)

            from .models import PasswordResetCode  # Import here to avoid circular dependency

            PasswordResetCode.objects.filter(user=user).delete()
            reset_code = PasswordResetCode.objects.create(user=user)

            current_site = get_current_site(request)
            email_context = {
                "user": user,
                "code": reset_code.code,
                "expiration_minutes": 10,  # El modelo ya lo establece, pero lo pasamos para el mensaje
                "domain": current_site.domain,
                "site_name": current_site.name,
                "protocol": "https" if request.is_secure() else "http",
            }

            mail_subject = render_to_string("registration/password_reset_subject.txt", email_context).strip()
            html_message = render_to_string("registration/password_reset_email.html", email_context)
            text_message = render_to_string("registration/password_reset_email.txt", email_context)

            email_message = EmailMultiAlternatives(
                mail_subject,
                text_message,
                f"Vinyles <{os.environ.get('EMAIL_HOST_USER')}>",
                [email],
            )
            email_message.attach_alternative(html_message, "text/html")
            email_message.send()

            request.session["reset_user_id"] = user.id

            messages.success(request, "Te hemos enviado un correo con un código de verificación.")
            return redirect("password_reset_done")
        else:
            messages.error(request, "Por favor, corrige los errores en el formulario.")
    else:
        form = PasswordResetRequestForm()

    return render(request, "paginas/publico/pub_solicitar_reseteo.html", {"form": form})


def password_reset_confirm_code(request):
    user_id = request.session.get("reset_user_id")
    if not user_id:
        messages.error(
            request,
            "La sesión de restablecimiento ha expirado o no es válida. Por favor, inténtalo de nuevo.",
        )
        return redirect("password_reset")  # Redirige al inicio del flujo de reseteo

    try:
        user = User.objects.get(pk=user_id)
    except User.DoesNotExist:
        messages.error(
            request,
            "Usuario no encontrado. Por favor, solicita un nuevo restablecimiento de contraseña.",
        )
        return redirect("password_reset")

    if request.method == "POST":
        form = PasswordResetConfirmForm(user, request.POST)
        if form.is_valid():
            form.save()  # Guarda la nueva contraseña y elimina el código
            del request.session["reset_user_id"]  # Limpia la sesión
            messages.success(
                request,
                "Tu contraseña ha sido restablecida exitosamente. Ahora puedes iniciar sesión.",
            )
            return redirect("password_reset_complete")  # Redirige a la página de éxito
        else:
            messages.error(request, "Por favor, corrige los errores señalados.")
    else:
        form = PasswordResetConfirmForm(user)

    return render(
        request,
        "paginas/publico/pub_restablecer_contrasena_codigo.html",
        {"form": form, "validlink": True},
    )


# VISTAS DE LA CARPETA "COMPRADOR"


@never_cache
@login_required
def com_inicio(request):
    # Esta vista ahora es manejada por inicio_view, pero la mantenemos para que la URL 'com_inicio' funcione.
    # El decorador @login_required se asegura de que solo usuarios autenticados lleguen aquí.
    return inicio_view(request)


@never_cache
@login_required
def com_albumes(request):
    publicaciones = (
        Publicacion.objects.filter(stock__gt=0, activa=True)
        .select_related("producto")
        .prefetch_related("producto__artistas", "producto__genero_principal")
        .order_by("-fecha_publicacion")
    )
    generos = Genero.objects.all().order_by("nombre")
    context = {
        "publicaciones": publicaciones,
        "generos": generos,
        "base_template": "plantillas/plantilla_comprador.html",  # <-- AÑADE ESTA LÍNEA
    }
    return render(request, "paginas/comprador/com_albumes.html", context)


@never_cache
@login_required
def com_carrito(request):
    return render(
        request,
        "paginas/comprador/com_carrito.html",
    )


@never_cache
@login_required
def com_checkout(request):
    cart = request.session.get("cart", [])

    if not cart:
        return redirect("com_carrito")

    total = sum(item["price"] for item in cart)

    return render(request, "paginas/comprador/com_checkout.html", {"cart_items": cart, "total": total})


@never_cache
@login_required
def com_nosotros(request):
    return render(request, "paginas/comprador/com_nosotros.html")


# Vista para MOSTRAR el perfil del comprador


@never_cache
@login_required
def com_perfil(request, user_mode="comprador"):  # Acepta user_mode
    user = request.user
    # Asegurarse de que el perfil del cliente exista o crearlo
    cliente_instance, created = Cliente.objects.get_or_create(user=user)
    titulo_pagina = "Mi Perfil de Vendedor" if user_mode == "vendedor" else "Mi Perfil"  # Título dinámico
    base_template = (
        "plantillas/plantilla_vendedor.html" if user_mode == "vendedor" else "plantillas/plantilla_comprador.html"
    )
    context = {
        "cliente_instance": cliente_instance,  # Pasar la instancia para mostrar datos del cliente
        "user": user,  # Pasar el objeto user para mostrar datos como email, nombre, etc.
        "titulo_pagina": titulo_pagina,
        "user_mode": user_mode,  # Pasar el modo a la plantilla para que sepa qué botones/base usar
        "base_template": base_template,
    }
    return render(request, "paginas/comprador/com_perfil.html", context)


# Vista para EDITAR el perfil del comprador


@never_cache
@login_required
def com_perfil_editar(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)

    user_form = UserUpdateForm(instance=user)
    cliente_form = ClienteUpdateForm(instance=cliente_instance)
    password_form = PasswordChangeForm(user=user)

    if request.method == "POST":
        user_form = UserUpdateForm(request.POST, instance=user)
        cliente_form = ClienteUpdateForm(request.POST, request.FILES, instance=cliente_instance)

        intent_to_change_password = bool(
            request.POST.get("old_password") or request.POST.get("new_password1") or request.POST.get("new_password2")
        )

        if intent_to_change_password:
            password_form = PasswordChangeForm(user=user, data=request.POST)

        forms_to_validate = [user_form, cliente_form]
        if intent_to_change_password:
            forms_to_validate.append(password_form)

        all_forms_are_valid = all(f.is_valid() for f in forms_to_validate)

        if all_forms_are_valid:
            user_form.save()

            new_profile_photo_uploaded = request.FILES.get("foto_perfil")
            delete_profile_photo_flag = cliente_form.cleaned_data.get("_delete_profile_photo")

            if new_profile_photo_uploaded:
                pass
            elif delete_profile_photo_flag:
                cliente_form.instance.foto_perfil = None

            cliente_form.save()  # Guarda el cliente_form (incluyendo la posible nueva foto o ninguna)

            if intent_to_change_password:  # password_form ya fue validado y es válido
                password_form.save()
                update_session_auth_hash(request, password_form.user)
                messages.success(request, "¡Tu perfil y contraseña han sido actualizados exitosamente!")
            else:  # No hubo intento de cambiar contraseña, y user_form/cliente_form fueron válidos
                messages.success(request, "¡Tu perfil ha sido actualizado exitosamente!")

            if request.GET.get("from") == "vendedor":
                return redirect("ven_perfil")
            else:
                return redirect("com_perfil")
        else:
            messages.error(request, "Por favor, corrige los errores señalados en el formulario.")

    user_mode = request.GET.get("from", "comprador")
    base_template = (
        "plantillas/plantilla_vendedor.html" if user_mode == "vendedor" else "plantillas/plantilla_comprador.html"
    )
    context = {
        "user_form": user_form,
        "cliente_form": cliente_form,
        "password_form": password_form,
        "titulo_pagina": "Editar Mi Perfil",
        "cliente_instance": cliente_instance,
        "user_mode": user_mode,  # Pasa el modo a la plantilla de edición
        "base_template": base_template,
    }
    return render(request, "paginas/comprador/com_perfil_editar.html", context)


@never_cache
@login_required
def com_progreso_envio(request):
    return render(request, "paginas/comprador/com_progreso_envio.html")


@never_cache
@login_required
def com_reembolsos(request):
    return render(request, "paginas/publico/pub_reembolsos.html")


@never_cache
@login_required
def com_soporte(request):
    return render(request, "paginas/comprador/com_soporte.html")


@never_cache
@login_required
def com_terminos(request):
    return render(request, "paginas/comprador/com_terminos.html")


# VISTAS DE LA CARPETA "VENDEDOR"


@never_cache
@login_required  # Solo requiere que el usuario esté autenticado
def ven_bad(request):
    return render(request, "paginas/vendedor/ven_bad.html")


def _get_or_import_producto_from_discogs(master_id, request_user):
    """
    Función auxiliar para obtener o importar un Producto desde un Master ID de Discogs.
    Esta función contiene la lógica de importación y solo debe ser llamada cuando
    se confirma una venta.
    """
    try:
        master = discogs_api.client.master(int(master_id))
        release_details = master.main_release
    except Exception as e:
        logger.error(f"Error al obtener el main_release para el master {master_id}: {e}")
        return None

    # Comprobar si el producto ya existe por su discogs_id de la release principal
    try:
        producto = Producto.objects.get(discogs_id=str(release_details.id))
        return producto
    except Producto.DoesNotExist:
        pass  # El producto no existe, proceder a importarlo.

    # Si llegamos aquí, el producto no existe y debe ser importado.
    with transaction.atomic():
        # Crear o encontrar artistas
        artistas_objs = []
        if hasattr(release_details, "artists"):
            for artist_data in release_details.artists:
                artista, _ = Artista.objects.get_or_create(
                    discogs_id=str(artist_data.id),
                    defaults={"nombre": artist_data.name},
                )
                artistas_objs.append(artista)

        # Crear o encontrar géneros
        generos_objs = []
        if hasattr(release_details, "genres"):
            for genre_name in release_details.genres:
                genero, _ = Genero.objects.get_or_create(nombre=genre_name.upper())
                generos_objs.append(genero)

        # Descargar imagen
        image_path = None
        if hasattr(release_details, "images") and release_details.images:
            image_url = release_details.images[0].get("uri")
            if image_url:
                image_path = discogs_api.download_image(image_url, filename_prefix=f"release_{master_id}")

        # Crear el producto
        producto = Producto(
            nombre=release_details.title,
            lanzamiento=f"{release_details.year}-01-01" if release_details.year and release_details.year > 0 else None,
            discografica=release_details.labels[0].name
            if hasattr(release_details, "labels") and release_details.labels
            else "Desconocida",
            imagen_portada=image_path,
            discogs_id=str(release_details.id),
        )
        producto.save()
        producto.artistas.set(artistas_objs)
        producto.genero_principal.set(generos_objs)

        return producto


def crear_notificacion_para_admins(mensaje, url_destino=None):
    """
    Crea un objeto Notificacion para cada administrador del sitio.
    """
    # Obtenemos todos los usuarios que son staff o superusers
    admins = User.objects.filter(Q(is_staff=True) | Q(is_superuser=True))
    for admin in admins:
        Notificacion.objects.create(usuario_destino=admin, mensaje=mensaje, url_destino=url_destino)


@login_required
def ven_crear(request):
    """
    VISTA PRINCIPAL PARA VENDER.
    GET: Muestra la página de búsqueda.
    POST: Procesa el formulario final de venta, importando el producto si es necesario.
    """
    if request.method == "POST":
        form = VentaDesdeCatalogoForm(request.POST)
        if form.is_valid():
            producto = form.cleaned_data.get("producto")
            discogs_master_id = form.cleaned_data.get("discogs_master_id")

            if not producto and discogs_master_id:
                # Es un nuevo producto de Discogs, hay que importarlo.
                producto = _get_or_import_producto_from_discogs(discogs_master_id, request.user)
                if not producto:
                    messages.error(request, "No se pudo importar el álbum desde Discogs. Inténtalo de nuevo.")
                    # Redirigir de vuelta al formulario de venta para que no pierda los datos
                    return render(request, "paginas/vendedor/ven_vender_desde_catalogo.html", {"form": form})
                else:
                    messages.info(request, f"Se ha añadido '{producto.nombre}' al catálogo de Vinyles.")
                    # Crear notificación para admins
                    mensaje_notificacion = (
                        f"El vendedor '{request.user.username}' ha importado un nuevo producto: '{producto.nombre}'."
                    )
                    crear_notificacion_para_admins(mensaje_notificacion)

            # A este punto, ya sea que existía o se acaba de importar, tenemos un objeto `producto`.
            # Ahora creamos la Publicación.
            publicacion = Publicacion(
                producto=producto,
                vendedor=request.user,
                precio=form.cleaned_data["precio"],
                stock=form.cleaned_data["stock"],
                descripcion_condicion=form.cleaned_data["descripcion_condicion"],
            )

            try:
                publicacion.save()
                messages.success(request, f"¡Has publicado '{producto.nombre}' para la venta!")
                return redirect("ven_producto")
            except Exception:
                # Esto podría pasar si el unique_together falla (el usuario ya tiene una publicación)
                messages.warning(
                    request,
                    f"Ya tienes una publicación para '{producto.nombre}'. Puedes editarla desde 'Mis Productos'.",
                )
                return redirect("ven_producto")

        else:
            messages.error(request, "Por favor, corrige los errores en el formulario.")
            # Volver a renderizar la página de venta, pero esta vez con el formulario que contiene errores.
    else:
        form = VentaDesdeCatalogoForm()

    context = {
        "titulo_pagina": "Vender un Vinilo",
        "form": form,
    }
    return render(request, "paginas/vendedor/ven_vender_desde_catalogo.html", context)


@login_required
def ven_importar_desde_discogs(request):
    """
    VISTA PARA IMPORTAR: Busca en Discogs para añadir un nuevo producto al catálogo.
    """
    from .discogs_api_utils import discogs_api  # Importamos la utilidad de la API

    query = request.GET.get("q", "")
    results = []

    if query:
        try:
            discogs_results = discogs_api.search_releases(query, type="release", per_page=20)
            if discogs_results:
                for release in discogs_results:
                    results.append({
                        "id": release.id,
                        "title": release.title,
                        "artist": ", ".join([a.name for a in release.artists])
                        if hasattr(release, "artists") and release.artists
                        else "Desconocido",
                        "year": release.year if hasattr(release, "year") else "N/A",
                        "image": release.thumb or settings.STATIC_URL + "images/albumes/default/default_album.png",
                        "country": release.country if hasattr(release, "country") else "N/A",
                    })
            else:
                messages.warning(request, "No se encontraron resultados para tu búsqueda en Discogs.")
        except Exception as e:
            messages.error(request, f"Ocurrió un error al conectar con Discogs: {e}")

    context = {
        "titulo_pagina": "Importar desde Discogs",
        "query": query,
        "results": results,
    }
    return render(request, "paginas/vendedor/ven_importar_desde_discogs.html", context)


@never_cache
@login_required
def ven_crear_producto_nuevo(request):
    """
    VISTA AVANZADA: Renderiza el formulario complejo para crear un producto desde cero.
    La lógica de POST de este formulario está manejada por JavaScript (fetch).
    """
    # Aquí podrías pasar cualquier contexto inicial que necesite tu formulario complejo,
    # como listas de canciones, artistas, etc.
    context = {
        "titulo_pagina": "Crear Nuevo Producto en el Catálogo",
        # 'canciones': Cancion.objects.all(), # Ejemplo
    }
    return render(request, "paginas/vendedor/ven_crear.html", context)


@login_required
def ajax_cargar_albumes(request):
    """
    Vista AJAX para cargar dinámicamente los álbumes de un artista,
    ya sea desde la base de datos local o desde Discogs.
    """
    # Obtenemos tanto el ID del artista como el término de búsqueda del álbum
    artista_id_str = request.GET.get("artista_id", "")
    term = request.GET.get("term", "").strip()
    albumes_data = []

    if artista_id_str.startswith("local-"):
        try:
            artista_id = int(artista_id_str.split("-")[1])
            # Filtramos los álbumes locales por el artista Y por el término de búsqueda
            albumes = Producto.objects.filter(artistas__id=artista_id, nombre__icontains=term).order_by("nombre")
            for album in albumes:
                albumes_data.append({"id": f"local-{album.id}", "text": album.nombre})
        except (ValueError, IndexError):
            pass  # ID inválido

    elif artista_id_str.startswith("discogs-"):
        try:
            discogs_artist_id = int(artista_id_str.split("-")[1])
            artist = discogs_api.client.artist(discogs_artist_id)
            processed_titles = set()

            # Búsqueda más precisa y eficiente:
            # - type='master': Solo queremos las entradas principales, no cada reedición.
            # - format='album': Filtramos directamente en la API para que solo devuelva álbumes.
            # - artist=artist.name: Buscamos por el nombre del artista.
            # - term: Incluimos el término de búsqueda del usuario si lo hay.
            # - per_page=50: Le pedimos a la API que nos devuelva un máximo de 50 resultados.
            search_results = discogs_api.client.search(
                term, artist=artist.name, type="master", format="album", per_page=50
            )

            valid_masters = []
            # 1. Recopilamos todos los álbumes válidos y oficiales
            for master in search_results:
                # Evitar duplicados por título
                if master.title.lower() in processed_titles:
                    continue

                # Asegurarnos de que es un master válido con una release principal
                if hasattr(master, "main_release") and master.main_release:
                    # Filtro para excluir lanzamientos no oficiales (bootlegs)
                    is_unofficial = False
                    if hasattr(master.main_release, "formats"):
                        for f in master.main_release.formats:
                            if "unofficial release" in [d.lower() for d in f.get("descriptions", [])]:
                                is_unofficial = True
                                break
                    if is_unofficial:
                        continue  # Si es no oficial, lo saltamos

                    valid_masters.append(master)
                    processed_titles.add(master.title.lower())

            # 2. Ordenamos la lista de álbumes válidos por año (los más antiguos primero)
            valid_masters.sort(key=lambda m: m.year if hasattr(m, "year") and m.year else 9999)

            # 3. Creamos la lista final para Select2 a partir de los resultados ordenados
            for master in valid_masters:
                year_str = f" ({master.year})" if hasattr(master, "year") and master.year else ""
                albumes_data.append({"id": f"discogs-master-{master.id}", "text": f"{master.title}{year_str}"})

        except Exception as e:
            logger.error(f"Error al buscar álbumes en Discogs para el artista {artista_id_str}: {e}")

    # Devolvemos los resultados en el formato que Select2 espera
    return JsonResponse({"results": albumes_data})


def ajax_buscar_artistas(request):
    """
    Vista AJAX para la búsqueda de artistas. Devuelve una lista de resultados.
    """
    term = request.GET.get("term", "").strip()
    if len(term) < 3:
        return JsonResponse({"results": []})

    results = []
    processed_artists = set()

    # 1. Buscar en la base de datos local primero
    artistas_locales = Artista.objects.filter(nombre__icontains=term)[:5]
    for artista in artistas_locales:
        if artista.nombre.lower() not in processed_artists:
            results.append({"id": f"local-{artista.id}", "text": artista.nombre, "type": "Local"})
            processed_artists.add(artista.nombre.lower())

    # 2. Buscar en Discogs para complementar
    try:
        # Pedimos hasta 10 para tener margen de filtrado
        discogs_results = discogs_api.client.search(term, type="artist", per_page=10)
        if discogs_results:
            for artist in discogs_results:
                if len(results) >= 7:  # Limitar el total de resultados
                    break
                if hasattr(artist, "name") and artist.name.lower() not in processed_artists:
                    results.append({"id": f"discogs-{artist.id}", "text": artist.name, "type": "Discogs"})
                    processed_artists.add(artist.name.lower())
    except Exception as e:
        logger.error(f"Error al buscar artistas en Discogs con término '{term}': {e}")

    return JsonResponse({"results": results})


def ajax_get_album_details(request):
    """
    Vista AJAX para obtener detalles de un 'master release' de Discogs para la vista previa. Es más robusta para manejar datos faltantes.
    """
    master_id = request.GET.get("master_id")
    if not master_id:
        return JsonResponse({"success": False, "error": "No se proporcionó ID"}, status=400)

    try:
        master = discogs_api.client.master(int(master_id))

        # Obtener artistas de forma segura
        artist_str = "Artista Desconocido"
        if hasattr(master, "main_release") and master.main_release and hasattr(master.main_release, "artists"):
            artist_str = ", ".join(artist.name for artist in master.main_release.artists)

        details = {
            "success": True,
            "title": master.title,
            "artist": artist_str,
            "year": master.year if hasattr(master, "year") and master.year else "N/A",
            "image_url": master.images[0].get("uri")
            if hasattr(master, "images") and master.images
            else settings.STATIC_URL + "images/albumes/default/default_album.png",
        }
        return JsonResponse(details)
    except Exception as e:
        logger.error(f"Error al obtener detalles del master {master_id} desde Discogs: {e}")
        return JsonResponse({"success": False, "error": "No se pudieron obtener los detalles."}, status=500)


@login_required
def ajax_importar_album(request):
    if request.method != "POST":
        return JsonResponse({"success": False, "error": "Método no permitido"}, status=405)

    # Esta vista ya no se usa para importar, la lógica se movió a ven_crear.
    # La mantenemos por si se necesita en el futuro, pero devolvemos un error claro.
    return JsonResponse({"success": False, "error": "Esta función de importación está obsoleta."}, status=410)


@never_cache
@login_required  # Solo requiere que el usuario esté autenticado
def ven_notificaciones(request):
    # Esta vista es para el vendedor, no para el admin.
    # Si quieres notificaciones para el vendedor, la lógica iría aquí.
    # Por ahora, la dejamos como una página estática.
    context = {
        "titulo_pagina": "Mis Notificaciones",
    }
    return render(request, "paginas/vendedor/ven_notificaciones.html", context)


@never_cache
@login_required
def ven_seleccionar_version(request, release_id):
    from .discogs_api_utils import discogs_api

    try:
        producto = Producto.objects.get(discogs_id=str(release_id))
        if Publicacion.objects.filter(producto=producto, vendedor=request.user).exists():
            messages.warning(
                request,
                f"Ya tienes una publicación para '{producto.nombre}'. Puedes editarla desde 'Mis Productos'.",
            )
            return redirect("ven_producto")  # Redirigir a la lista de productos del vendedor

    except Producto.DoesNotExist:
        release_details = discogs_api.get_release_details(release_id)
        if not release_details:
            messages.error(
                request,
                "No se pudieron obtener los detalles de este álbum desde Discogs. Inténtalo de nuevo.",
            )
            return redirect("ven_importar_desde_discogs")

        try:
            artistas_objs = []
            if hasattr(release_details, "artists"):
                for artist_data in release_details.artists:
                    artista, _ = Artista.objects.get_or_create(
                        nombre=artist_data.name, defaults={"discogs_id": str(artist_data.id)}
                    )
                    artistas_objs.append(artista)

            generos_objs = []
            if hasattr(release_details, "genres"):
                for genre_name in release_details.genres:
                    genero, _ = Genero.objects.get_or_create(nombre=genre_name.upper())
                    generos_objs.append(genero)

            image_path = None
            if hasattr(release_details, "images") and release_details.images:
                image_url = release_details.images[0].get("uri")
                if image_url:
                    image_path = discogs_api.download_image(image_url, filename_prefix=f"release_{release_id}")

            producto = Producto(
                nombre=release_details.title,
                lanzamiento=f"{release_details.year}-01-01"
                if release_details.year and release_details.year > 0
                else None,
                discografica=release_details.labels[0].name
                if hasattr(release_details, "labels") and release_details.labels
                else "Desconocida",
                imagen_portada=image_path,
                discogs_id=str(release_id),
            )
            producto.save()  # Guardar para poder establecer relaciones M2M
            producto.artistas.set(artistas_objs)
            producto.genero_principal.set(generos_objs)
            messages.info(request, f"Se ha añadido '{producto.nombre}' al catálogo de Vinyles.")

        except Exception as e:
            logger.error(f"Error al crear el producto desde Discogs release {release_id}: {e}")
            messages.error(request, "Hubo un error al guardar la información del álbum.")
            return redirect("ven_importar_desde_discogs")

    if request.method == "POST":
        form = PublicacionForm(request.POST)
        if form.is_valid():
            nueva_publicacion = form.save(commit=False)
            nueva_publicacion.producto = producto
            nueva_publicacion.vendedor = request.user
            nueva_publicacion.save()  # Ahora sí, guardar en la BD
            messages.success(request, f"¡Has publicado '{producto.nombre}' para la venta!")

            # --- AÑADIR NOTIFICACIÓN PARA ADMINS ---
            mensaje_notificacion = f"El vendedor '{request.user.username}' ha importado y publicado un nuevo producto: '{producto.nombre}'."
            crear_notificacion_para_admins(mensaje_notificacion)
            # --- FIN DE NOTIFICACIÓN ---

            return redirect("ven_producto")  # Redirigir a la lista de productos del vendedor
    else:
        form = PublicacionForm()

    context = {"titulo_pagina": f"Vender: {producto.nombre}", "producto": producto, "form": form}
    return render(request, "paginas/vendedor/ven_seleccionar_version.html", context)


@never_cache
@login_required  # Solo los vendedores pueden ver esto
def ven_producto(request):
    publicaciones = (
        Publicacion.objects.filter(vendedor=request.user)
        .select_related("producto")
        .prefetch_related("producto__artistas")
    )
    context = {"publicaciones": publicaciones}
    return render(request, "paginas/vendedor/ven_producto.html", context)


@never_cache
@login_required
def ven_editar_producto(request, publicacion_id):
    publicacion = get_object_or_404(Publicacion, pk=publicacion_id, vendedor=request.user)

    if request.method == "POST":
        form = PublicacionForm(request.POST, instance=publicacion)
        if form.is_valid():
            form.save()
            messages.success(request, f"La publicación de '{publicacion.producto.nombre}' ha sido actualizada.")
            return redirect("ven_producto")
        else:
            messages.error(request, "Por favor, corrige los errores en el formulario.")
    else:
        form = PublicacionForm(instance=publicacion)

    context = {
        "titulo_pagina": f"Editar: {publicacion.producto.nombre}",
        "form": form,
        "publicacion": publicacion,
    }
    return render(request, "paginas/vendedor/ven_editar_producto.html", context)


@never_cache
@login_required
def ven_eliminar_producto(request, publicacion_id):
    publicacion = get_object_or_404(Publicacion, pk=publicacion_id, vendedor=request.user)

    if request.method == "POST":
        nombre_producto = publicacion.producto.nombre
        publicacion.delete()
        messages.success(request, f"La publicación de '{nombre_producto}' ha sido eliminada.")
        return redirect("ven_producto")

    return redirect("ven_producto")


@never_cache
@login_required  # Solo requiere que el usuario esté autenticado
def ven_nosotros(request):
    return render(request, "paginas/vendedor/ven_nosotros.html")


@never_cache
@login_required  # Solo requiere que el usuario esté autenticado
def ven_terminos(request):
    return render(request, "paginas/vendedor/ven_terminos.html")


# VISTAS DE LA CARPETA "ADMINISTRADOR"


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_administrador(request):
    now_local = timezone.localtime()
    today_start = now_local.replace(hour=0, minute=0, second=0, microsecond=0)
    today_end = today_start + timedelta(days=1)

    usuarios_hoy = User.objects.filter(date_joined__gte=today_start, date_joined__lt=today_end).count()

    usuario = request.user
    try:
        estado = EstadoUsuario.objects.get(user=usuario)
        bloqueado = estado.bloqueado
    except EstadoUsuario.DoesNotExist:
        bloqueado = False

    if bloqueado or not usuario.is_active:
        request.session["mostrar_alerta_bloqueado"] = True
    else:
        request.session.pop("mostrar_alerta_bloqueado", None)

    return render(request, "paginas/Administrador/admin_administrador.html", {"usuarios_hoy": usuarios_hoy})


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_notificaciones(request):
    # Obtenemos todas las notificaciones para el admin actual
    notificaciones = Notificacion.objects.filter(usuario_destino=request.user)

    # Opcional: Marcar todas como leídas al visitar la página
    notificaciones_no_leidas = notificaciones.filter(leido=False)
    notificaciones_no_leidas.update(leido=True)

    context = {
        "notificaciones": notificaciones,
        "titulo_pagina": "Mis Notificaciones",
    }
    return render(request, "paginas/administrador/admin_notificaciones.html", context)


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_pedido(request):
    return render(request, "paginas/administrador/admin_pedido.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_producto(request):
    return render(request, "paginas/administrador/admin_producto.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_reembolsos(request):
    return render(request, "paginas/administrador/admin_reembolsos.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_usuario(request):
    return render(request, "paginas/Administrador/admin_usuario.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_verificacion(request):
    return render(request, "paginas/Administrador/admin_verificacion.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_adPro(request):
    return render(request, "paginas/administrador/admin_adPro.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_buscar_album_discogs(request):
    from .discogs_api_utils import discogs_api  # Importa tu utilidad aquí

    query = request.GET.get("q", "")
    results = []
    if query:
        discogs_results = discogs_api.search_releases(query, type="release", per_page=10)
        if discogs_results:
            for release in discogs_results:
                results.append({
                    "id": release.id,
                    "title": release.title,
                    "artist": ", ".join([a.name for a in release.artists])
                    if hasattr(release, "artists") and release.artists
                    else "Desconocido",
                    "year": release.year if hasattr(release, "year") else "N/A",
                    "image": release.images[0]["uri"] if hasattr(release, "images") and release.images else "",
                    "formats": ", ".join(release.formats) if hasattr(release, "formats") and release.formats else "N/A",
                })
        else:
            messages.warning(
                request,
                "No se pudieron obtener resultados de Discogs. Inténtalo de nuevo más tarde.",
            )

    if request.headers.get("x-requested-with") == "XMLHttpRequest":
        return JsonResponse({"results": results})

    return render(
        request,
        "paginas/administrador/admin_buscar_album_discogs.html",
        {"query": query, "results": results},
    )


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_importar_album_discogs(request):
    from .discogs_api_utils import discogs_api  # Importa tu utilidad aquí

    if request.method == "POST":
        release_id = request.POST.get("release_id")
        if release_id:
            release_details = discogs_api.get_release_details(int(release_id))
            if release_details:
                try:
                    if Producto.objects.filter(discogs_id=release_details.id).exists():
                        messages.warning(request, f"El álbum '{release_details.title}' ya ha sido importado.")
                        return JsonResponse({"success": False, "error": "Álbum ya existe"})

                    artistas_objs = []
                    if hasattr(release_details, "artists") and release_details.artists:
                        for artist_data in release_details.artists:
                            artist_obj, created = Artista.objects.get_or_create(
                                nombre=artist_data.name,
                                defaults={"discogs_id": artist_data.id if hasattr(artist_data, "id") else None},
                            )
                            if created:
                                messages.info(request, f"Artista '{artist_data.name}' creado.")
                            artistas_objs.append(artist_obj)

                    generos_objs = []
                    if hasattr(release_details, "genres") and release_details.genres:
                        for genre_name in release_details.genres:
                            # Tu modelo Genero convierte a mayúsculas al guardar
                            genero_obj, created = Genero.objects.get_or_create(nombre=genre_name.upper())
                            if created:
                                messages.info(request, f"Género '{genre_name}' creado.")
                            generos_objs.append(genero_obj)

                    image_path = None
                    if hasattr(release_details, "images") and release_details.images:
                        image_url = release_details.images[0]["uri"]
                        image_path = discogs_api.download_image(image_url, filename_prefix=f"{release_details.id}")
                        if not image_path:
                            messages.warning(
                                request,
                                f"No se pudo descargar la imagen para '{release_details.title}'.",
                            )

                    producto = Producto.objects.create(
                        nombre=release_details.title,
                        lanzamiento=f"{release_details.year}-01-01"
                        if hasattr(release_details, "year")
                        else "2000-01-01",  # Discogs a menudo solo da el año
                        precio=0,  # Precio inicial, el admin lo ajustará
                        stock=0,  # Stock inicial
                        descripcion=f"Álbum importado desde Discogs. Formato(s): {', '.join(release_details.formats) if hasattr(release_details, 'formats') else 'N/A'}",
                        discografica=release_details.labels[0].name
                        if hasattr(release_details, "labels") and release_details.labels
                        else "Desconocida",
                        imagen_portada=image_path,
                        discogs_id=str(release_details.id),
                    )
                    producto.artistas.set(artistas_objs)  # Asigna los artistas
                    producto.genero_principal.set(generos_objs)  # Asigna los géneros

                    messages.success(request, f"Álbum '{producto.nombre}' importado exitosamente desde Discogs.")
                    return JsonResponse({
                        "success": True,
                        "redirect_url": reverse("admin_adPro"),
                    })  # Redirige a la página de edición del producto
                except Exception as e:
                    messages.error(request, f"Error al importar el álbum: {e}")
                    logger.exception("Error durante la importación de álbum desde Discogs")
                    return JsonResponse({"success": False, "error": str(e)})
            else:
                messages.error(request, "No se pudieron obtener los detalles del lanzamiento de Discogs.")
                return JsonResponse({"success": False, "error": "Detalles no encontrados"})
        else:
            messages.error(request, "ID de lanzamiento no proporcionado.")
            return JsonResponse({"success": False, "error": "ID no proporcionado"})
    return JsonResponse({"success": False, "error": "Método no permitido"})


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_bloq_users(request):
    usuarios_bloqueados = User.objects.filter(
        Q(is_active=False) | Q(estado_usuario__bloqueado=True), cliente__isnull=False
    ).distinct()

    return render(request, "paginas/administrador/admin_bloq_users.html", {"usuarios": usuarios_bloqueados})


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_generos(request):
    return render(request, "paginas/administrador/admin_generos.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_gestion_users(request):
    usuarios = User.objects.filter(cliente__isnull=False, is_active=True, is_staff=False).exclude(
        estado_usuario__bloqueado=True  # 🔥 Excluir bloqueados
    )
    return render(request, "paginas/administrador/admin_gestion_users.html", {"usuarios": usuarios})


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_gestion_administradores(request):
    admins = (
        User.objects.filter(is_staff=True, is_active=True, cliente__isnull=False)
        .exclude(estado_usuario__bloqueado=True)
        .select_related("cliente")
    )

    return render(request, "paginas/administrador/admin_gestion_administradores.html", {"admins": admins})


def admin_registrar_staff(request):
    if request.method == "POST":
        form = CrearUsuarioStaffForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect("admin_gestion_administradores")  # o cualquier vista de confirmación
    else:
        form = CrearUsuarioStaffForm()
    return render(request, "paginas/administrador/admin_registrar_staff.html", {"form": form})


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_ver_perfil_usuario(request, user_id):
    user = get_object_or_404(User, id=user_id)
    cliente = Cliente.objects.filter(user=user).first()
    estado_usuario = EstadoUsuario.objects.filter(user=user).first()
    esta_bloqueado = estado_usuario.bloqueado if estado_usuario else False

    return render(
        request,
        "paginas/administrador/admin_ver_perfil_usuario.html",
        {
            "usuario": user,
            "cliente": cliente,
            "esta_bloqueado": esta_bloqueado,
        },
    )


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_user_edit(request, user_id):
    usuario = get_object_or_404(User, pk=user_id, cliente__isnull=False)
    cliente = usuario.cliente

    if request.method == "POST":
        user_form = UserEditForm(request.POST, instance=usuario)
        cliente_form = ClienteEditForm(request.POST, request.FILES, instance=cliente)

        if user_form.is_valid() and cliente_form.is_valid():
            user_form.save()

            if not cliente_form.cleaned_data.get("foto_perfil"):
                cliente.foto_perfil = "fotos_perfil/default/default_avatar.png"

            cliente_form.save()
            messages.success(request, "Perfil actualizado con éxito ✅")
            return redirect("admin_ver_perfil_usuario", user_id=usuario.id)
    else:
        user_form = UserEditForm(instance=usuario)
        cliente_form = ClienteEditForm(instance=cliente)

    tiene_foto_personalizada = (
        cliente.foto_perfil and cliente.foto_perfil.name != "fotos_perfil/default/default_avatar.png"
    )

    return render(
        request,
        "paginas/administrador/admin_user_edit.html",
        {
            "user_form": user_form,
            "cliente_form": cliente_form,
            "usuario": usuario,
            "tiene_foto_personalizada": tiene_foto_personalizada,  # 👈 se manda al template
        },
    )


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_eliminar_usuario(request, usuario_id):
    if request.method == "POST":
        usuario = get_object_or_404(User, id=usuario_id)
        nombre = f"{usuario.first_name} {usuario.last_name}"
        usuario.delete()
        messages.success(request, f"El usuario {nombre} fue eliminado exitosamente.")
        return redirect("admin_gestion_users")  # Cambia esto por la vista real donde muestras los usuarios
    else:
        messages.error(request, "Acceso no permitido.")
        return redirect("admin_gestion_users")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_bloquear_usuario(request, usuario_id):
    if request.method == "POST":
        user = get_object_or_404(User, id=usuario_id)
        estado_usuario, _ = EstadoUsuario.objects.get_or_create(user=user)

        if estado_usuario.bloqueado:
            estado_usuario.bloqueado = False
            estado_usuario.save()
            if not user.is_active:
                user.is_active = True
                user.save()
            mensaje_estado = "desbloqueado"

        elif not user.is_active:
            user.is_active = True
            user.save()
            mensaje_estado = "activado"

        else:
            estado_usuario.bloqueado = True
            estado_usuario.save()
            mensaje_estado = "bloqueado"

        messages.success(
            request,
            f"El usuario {user.get_full_name() or user.username} ha sido {mensaje_estado}.",
        )
        return redirect("admin_ver_perfil_usuario", user_id=usuario_id)

    messages.error(request, "Acción no permitida.")
    return redirect("admin_gestion_users")


@never_cache
@login_required
def desactivar_usuario_y_logout(request):
    if request.user.is_authenticated:
        request.user.is_active = False
        request.user.save()
        auth_logout(request)
    return redirect("pub_login")  # Cambia esto si tu login tiene otro nombre


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_new_users(request):
    now_local = timezone.localtime()
    today_start = now_local.replace(hour=0, minute=0, second=0, microsecond=0)
    today_end = today_start + timedelta(days=1)
    usuarios = User.objects.filter(date_joined__gte=today_start, date_joined__lt=today_end).select_related("cliente")
    return render(request, "paginas/Administrador/admin_new_users.html", {"usuarios": usuarios})


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_pedido_pendiente(request):
    return render(request, "paginas/administrador/admin_pedido_pendiente.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_pedido_realizado(request):
    return render(request, "paginas/administrador/admin_pedido_realizado.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_ventas(request):
    return render(request, "paginas/Administrador/admin_ventas.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_nosotros(request):
    return render(request, "paginas/administrador/admin_nosotros.html")


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_terminos(request):
    return render(request, "paginas/administrador/admin_terminos.html")


# Vista placeholder para "Más Vendidos" (Asegúrate de que esta plantilla exista)


@never_cache
@login_required
@user_passes_test(lambda u: u.is_staff, login_url="pub_login")
def admin_mas_vendidos(request):
    return render(request, "paginas/administrador/admin_mas_vendidos.html")
