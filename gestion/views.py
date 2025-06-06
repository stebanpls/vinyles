from django.shortcuts import render, redirect

# Se importa el reverse para redireccionar a la vista de crud.
from django.urls import reverse
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required, user_passes_test # Para proteger vistas
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash

# Se importa los atributos de Crud 
from .models import Crud, Cliente, Genero # Importar modelos necesarios (Crud, Cliente, Genero)

from .forms import CrudForm, UserRegistrationForm, UserUpdateForm, ClienteUpdateForm # Importar formularios

# Importar las funciones de autenticación de Django
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout # Importa las funciones de autenticación
from django.contrib.auth.models import User # Importar el modelo User estándar
from django.contrib import messages # Para mensajes opcionales

# Create your views here.
"""
def saludo(request):
  return HttpResponse("<h1>Hasta Mañana, babys!</h1>")
"""


# VISTAS DE LA CARPETA "PUBLICO"
def pub_inicio(request):
  return render(request, 'paginas/publico/pub_inicio.html')

def pub_albumes(request):
  return render(request, 'paginas/publico/pub_albumes.html')

def pub_codigo_recuperacion(request):
  return render(request, 'paginas/publico/pub_codigo_recuperacion.html')
  
def pub_ddl(request):
  return render(request, 'paginas/publico/pub_ddl.html')

def pub_login(request):
    # Para repoblar el campo identificador en caso de error
    submitted_identifier = request.POST.get('login_identifier', '') if request.method == 'POST' else ''

    # Datos del álbum (si se pasan por GET para pre-llenar o mantener)
    album_name_get = request.GET.get('album_name')
    artist_get = request.GET.get('artist')
    price_get = request.GET.get('price')
    image_get = request.GET.get('image')

    # Obtener la URL de redirección 'next' si existe
    # Esto es útil si el usuario intentó acceder a una página protegida antes de loguearse
    next_url = request.GET.get('next') or request.POST.get('next')

    if request.user.is_authenticated:
        # Si el usuario ya está autenticado, redirigir según su rol
        if request.user.is_staff or request.user.is_superuser:
            # Priorizar next_url si existe
            return redirect(next_url or 'admin_administrador')
        else:
            return redirect(next_url or 'com_inicio')

    if request.method == 'POST':
        identifier = request.POST.get('login_identifier') # Cambiado de 'email'
        password = request.POST.get('password') 

        # Datos del álbum del POST, con fallback a los de GET si no están en POST
        post_album_name = request.POST.get('album_name', album_name_get)
        post_artist = request.POST.get('artist', artist_get)
        post_price = request.POST.get('price', price_get)
        post_image = request.POST.get('image', image_get)
        # Actualizar las variables _get para que el contexto refleje los datos del POST si existen
        album_name_get = post_album_name
        artist_get = post_artist
        price_get = post_price
        image_get = post_image

        # Autenticación real

        # Intentar autenticar con el input como username primero
        user = authenticate(request, username=identifier, password=password)
        specific_auth_error_occurred = False # Inicializar aquí

        if user is None:
            # Si falla, intentar encontrar usuario por email y autenticar con su username real
            try:
                user_by_email = User.objects.get(email__iexact=identifier) # Búsqueda case-insensitive
                user = authenticate(request, username=user_by_email.username, password=password)
            except User.DoesNotExist:
                # No se encontró usuario con ese email, 'user' sigue siendo None
                pass
            except User.MultipleObjectsReturned:
                # Hay múltiples usuarios con el mismo email (debería evitarse con unique=True en email)
                messages.error(request, "Múltiples cuentas están asociadas con este correo electrónico. Por favor, contacte a soporte.")
                specific_auth_error_occurred = True # Marcar que este error específico ocurrió
        if user is not None:
            auth_login(request, user)
            messages.success(request, f"¡Bienvenido de nuevo, {user.first_name or user.username}!")

            # Redirigir al usuario a la página 'next' si existe,
            # de lo contrario, redirigir según su rol.
            if next_url:
                return redirect(next_url)
            # Si no hay 'next', redirigir según el rol llamando a redirect()
            default_redirect_url_name = 'admin_administrador' if user.is_staff or user.is_superuser else 'com_inicio'
            return redirect(default_redirect_url_name)
        else:
            # Login fallido. Solo mostrar el error genérico si no hubo un error más específico.
            if not specific_auth_error_occurred:
                messages.error(request, "El nombre de usuario/email o la contraseña son incorrectos. Por favor, inténtalo de nuevo.")
    
    # Este bloque de código se ejecuta si la solicitud es GET,
    # o si la solicitud es POST pero la autenticación falló.
    # Prepara el contexto y renderiza la plantilla de login.
    context = {
        'submitted_identifier': submitted_identifier, # Cambiado de submitted_email
        'album_name_get': album_name_get, # Datos del álbum de GET
        'artist_get': artist_get,       # Datos del álbum de GET
        'price_get': price_get,         # Datos del álbum de GET
        'image_get': image_get,         # Datos del álbum de GET
        'next_url': next_url,           # URL 'next' de GET o POST
    }
    return render(request, 'paginas/publico/pub_login.html', context)

def pub_log_out(request):
    # Esta vista es el destino de LOGOUT_REDIRECT_URL en settings.py.
    # La LogoutView de Django ya ha cerrado la sesión antes de redirigir aquí.
    # Simplemente renderiza la página de confirmación.
    # messages.info(request, "Has cerrado sesión exitosamente. ¡Hasta luego!") # Eliminamos este mensaje
    return render(request, 'paginas/publico/pub_log_out.html') # Renderiza tu página de sesión cerrada

def pub_nosotros(request):
  return render(request, 'paginas/publico/pub_nosotros.html') # Se crea un renderizado de este archivo HTML.

def pub_registro(request):
    if request.user.is_authenticated:
        messages.info(request, 'Ya has iniciado sesión. Si deseas registrar una nueva cuenta, por favor cierra tu sesión actual primero.')
        # Redirige al usuario a una página apropiada.
        if hasattr(request.user, 'is_staff') and request.user.is_staff:
            # Si es staff/admin, redirigir al panel de administrador
            return redirect('admin_administrador') # Asegúrate que 'admin_administrador' es el name de tu URL del panel de admin
        else:
            # Si es un usuario normal, redirigir a su inicio de comprador
            return redirect('com_inicio') # Asegúrate que 'com_inicio' es el name de tu URL del dashboard de comprador

    if request.method == 'POST':
        user_form = UserRegistrationForm(request.POST) # Crea una instancia del formulario con los datos enviados
        if user_form.is_valid():
            # Crear un nuevo objeto usuario pero sin guardarlo todavía
            new_user = user_form.save(commit=False)
            # Establecer la contraseña elegida de forma segura
            new_user.set_password(user_form.cleaned_data['password'])
            # Guardar el objeto User en la base de datos
            new_user.save()

            # Crear el perfil de Cliente asociado al nuevo usuario
            # La señal post_save ya hace esto automáticamente,
            # pero si no usaras la señal, lo harías aquí:
            # Cliente.objects.create(user=new_user)
            # Aquí podrías crear el ClienteProfile si lo tienes: ClienteProfile.objects.create(user=new_user, ...)
            messages.success(request, '¡Registro exitoso! Ahora puedes iniciar sesión.')
            return redirect('pub_login') # Redirigir al login después del registro exitoso
        else:
            messages.error(request, 'Por favor corrige los errores presentados en el formulario.')
    else:
        user_form = UserRegistrationForm() # Si no es POST, crea un formulario vacío
    return render(request, 'paginas/publico/pub_registro.html', {'user_form': user_form})

def pub_reembolsos(request):
  return render(request, 'paginas/publico/pub_reembolsos.html')


def pub_restablecer_contrasena(request):
  return render(request, 'paginas/publico/pub_restablecer_contrasena.html')

def pub_restablecer_contrasena_admin(request):
  return render(request, 'paginas/publico/pub_restablecer_contrasena_admin.html')

def pub_terminos(request):
  return render(request, 'paginas/publico/pub_terminos.html')

"""
def pub_vinilo(request):
  return render(request, 'paginas/publico/pub_vinilo.html') # Porqué esta repetida?
"""

def pub_vinilo(request):
    album_key = request.GET.get('album', '')  # ejemplo: 'bad', 'master', etc.

    # Diccionario que contiene la info de cada álbum, indexada por 'album_key'
    albums_info = {
        'bad': {

    'title': 'Bad',
    'artist': 'Michael Jackson',
    'price': 105000,
    'genre': 'Pop',
    'release_date': '31 de agosto de 1987',
    'label': 'Epic Records',
    'producers': 'Michael Jackson, Quincy Jones',
    'artist_info': (
        'Michael Jackson fue un cantante, compositor y bailarín estadounidense apodado el "Rey del Pop". '
        'Es considerado uno de los artistas más importantes e influyentes del siglo XX.'
    ),
    'image': 'images/bad.jpg',
    'audio': 'audio/bad.mp3',
    'song_list': [
        'Bad',
        'The Way You Make Me Feel',
        'Speed Demon',
        'Liberian Girl',
        'Just Good Friends (con Stevie Wonder)',
        'Another Part of Me',
        'Man in the Mirror',
        'I Just Can\'t Stop Loving You (con Siedah Garrett)',
        'Dirty Diana',
        'Smooth Criminal',
        'Leave Me Alone'
    ],
    'comments': [
        {'username': 'musicLover', 'comment': 'Un álbum icónico con ritmos pegadizos y la energía inigualable de Michael!'},
        {'username': 'popFanatic', 'comment': 'Cada canción es un hit, la producción es impecable.'}
    ]
        },
        'master': {
'title': 'Master of Puppets',
    'artist': 'Metallica',
    'price': 105000,
    'genre': 'Thrash Metal',
    'release_date': '3 de marzo de 1986',
    'label': 'Elektra Records',
    'producers': 'Flemming Rasmussen, Metallica',
    'artist_info': (
        'Metallica es una banda estadounidense de heavy metal formada en 1981. '
        'Es una de las bandas más influyentes y exitosas en la historia del metal.'
    ),
    'image': 'images/master.jpg',
    'audio': 'audio/master.mp3',
    'song_list': [
        'Battery',
        'Master of Puppets',
        'The Thing That Should Not Be',
        'Welcome Home (Sanitarium)',
        'Disposable Heroes',
        'Leper Messiah',
        'Orion',
        'Damage, Inc.'
    ],
    'comments': [
        {'username': 'metalHead', 'comment': 'Una obra maestra del thrash metal, cada riff es легендарный!'},
        {'username': 'guitarHero', 'comment': 'La composición y la ejecución instrumental son de otro nivel.'}
    ]
},
        'joe': {
    'title': 'Grandes Éxitos',
    'artist': 'Joe Arroyo',
    'price': 80000,
    'genre': 'Salsa, Cumbia',
    'release_date': 'Recopilación de varios lanzamientos',
    'label': 'Discos Fuentes',
    'producers': 'Varios productores a lo largo de su carrera',
    'artist_info': (
        'Álvaro José Arroyo González, conocido como Joe Arroyo, fue un cantautor colombiano, '
        'considerado uno de los más grandes exponentes de la música caribeña en su país.'
    ),
    'image': 'images/joe.jpg',
    'audio': 'audio/joe.mp3',
    'song_list': [
        'Rebelión',
        'La Noche',
        'Tania',
        'El Centurión de la Noche',
        'Yamulemau',
        'Te Quiero Más',
        'En Barranquilla Me Quedo',
        'Mary',
        'Sobreviviré',
        'A Mi Pueblo'
        # ... y más éxitos dependiendo de la recopilación específica
    ],
    'comments': [
        {'username': 'salsaQueen', 'comment': '¡Un verdadero legado de la salsa colombiana, imposible no bailar!'},
        {'username': 'caribeSoul', 'comment': 'La voz y el sabor de Joe Arroyo son únicos e inigualables.'}
    ]
},
        'thriller': {
    'title': 'Thriller',
    'artist': 'Michael Jackson',
    'price': 110000,
    'genre': 'Pop',
    'release_date': '30 de noviembre de 1982',
    'label': 'Epic Records',
    'producers': 'Quincy Jones',
    'artist_info': (
        'Michael Jackson, el "Rey del Pop", revolucionó la música y la cultura popular con su voz, '
        'sus bailes y su visión artística innovadora.'
    ),
    'image': 'images/thriller.jpg',
    'audio': 'audio/thriller.mp3',
    'song_list': [
        'Wanna Be Startin\' Somethin\'',
        'Baby Be Mine',
        'The Girl Is Mine (con Paul McCartney)',
        'Thriller',
        'Beat It',
        'Billie Jean',
        'Human Nature',
        'P.Y.T. (Pretty Young Thing)',
        'The Lady in My Life'
    ],
    'comments': [
        {'username': 'classicPop', 'comment': 'El álbum más vendido de todos los tiempos por una razón, ¡cada canción es perfecta!'},
        {'username': 'moonwalker', 'comment': 'Thriller no solo es música, es un evento cultural.'}
    ]
},
        'lonely': {
    'title': 'Sgt. Pepper\'s Lonely Hearts Club Band',
    'artist': 'The Beatles',
    'price': 95000,
    'genre': 'Rock Psicodélico, Pop',
    'release_date': '1 de junio de 1967',
    'label': 'Parlophone',
    'producers': 'George Martin',
    'artist_info': (
        'The Beatles fue una banda británica de rock formada en Liverpool. '
        'Considerada la banda más influyente en la historia de la música popular.'
    ),
    'image': 'images/lonely.jpg',
    'audio': 'audio/lonely.mp3',
    'song_list': [
        'Sgt. Pepper\'s Lonely Hearts Club Band',
        'With a Little Help from My Friends',
        'Lucy in the Sky with Diamonds',
        'Getting Better',
        'Fixing a Hole',
        'She\'s Leaving Home',
        'Being for the Benefit of Mr. Kite!',
        'Within You Without You',
        'When I\'m Sixty-Four',
        'Lovely Rita',
        'Good Morning Good Morning',
        'Sgt. Pepper\'s Lonely Hearts Club Band (Reprise)',
        'A Day in the Life'
    ],
    'comments': [
        {'username': 'beatlemania', 'comment': 'Un álbum revolucionario que expandió los límites de la música pop y rock.'},
        {'username': 'sixtiesSound', 'comment': 'La creatividad y la experimentación en este álbum son asombrosas.'}
    ]
},
        # Puedes agregar 2 álbumes más según tu preferencia
        'destruction': {
    'title': 'Appetite for Destruction',
    'artist': 'Guns N\' Roses',
    'price': 120000,
    'genre': 'Hard Rock',
    'release_date': '21 de julio de 1987',
    'label': 'Geffen Records',
    'producers': 'Mike Clink',
    'artist_info': (
        'Guns N\' Roses es una banda estadounidense de hard rock formada en Los Ángeles. '
        'Con su sonido crudo y enérgico, se convirtieron en un fenómeno a finales de los 80.'
    ),
    'image': 'images/destruction.jpg',
    'audio': 'audio/destruction.mp3',
    'song_list': [
        'Welcome to the Jungle',
        'It\'s So Easy',
        'Nightrain',
        'Out ta Get Me',
        'Mr. Brownstone',
        'Paradise City',
        'My Michelle',
        'Think About You',
        'Sweet Child o\' Mine',
        'You\'re Crazy',
        'Anything Goes',
        'Rocket Queen'
    ],
    'comments': [
        {'username': 'rockNRoll', 'comment': 'Un álbum debut explosivo que revitalizó el hard rock para una nueva generación.'},
        {'username': 'axlRoseFan', 'comment': 'La voz de Axl y los riffs de Slash son simplemente legendarios.'}
    ]
},
        'music': {
    'title': 'MUSIC',
    'artist': 'Playboi Carti',
    'price': 90000,
    'genre': 'Hip Hop, Trap',
    'release_date': '14 de marzo de 2025',
    'label': 'Opium, Interscope Records',
    'producers': 'Ojivolta, Cardo, F1lthy, Bnyx, Maaly Raw, Metro Boomin, TM88, Wheezy, Kanye West, Travis Scott',
    'artist_info': (
        'Playboi Carti es un rapero y compositor estadounidense conocido por su estilo experimental '
        'y su influencia en la escena del trap contemporáneo.'
    ),
    'image': 'images/music.jpg',
    'audio': 'audio/music.mp3',
    'song_list': [
        'Pop Out',
        'Crush (feat. Travis Scott)',
        'K Pop',
        'Evil J0rdan',
        'Mojo Jojo',
        'Philly',
        'Radar',
        'Rather Lie',
        'Fine Shit',
        'Backd00r',
        'Toxic',
        'Munyun',
        'Crank',
        'Charge Dem Hoes a Fee',
        'Good Credit',
        'I Seeeeee You Baby Boi',
        'Wake Up F1lthy',
        'Jumpin',
        'Trim',
        'Cocaine Nose',
        'We Need All Da Vibes',
        'Olympian',
        'Opm Babi',
        'Twin Trim',
        'Like Weezy',
        'Dis 1 Got It',
        'Walk',
        'HBA',
        'Overly',
        'South Atlanta Baby',
        # ... la lista de canciones puede variar según la edición
    ],
    'comments': [
        {'username': 'trapLord', 'comment': 'El sonido vanguardista de Carti sigue evolucionando, este álbum es otro viaje.'},
        {'username': 'opiumGang', 'comment': 'La producción es de otro nivel, Carti siempre innovando.'}
    ]}
}

    # Si no existe la clave, usar una 'base' o un álbum vacío
    album_data = albums_info.get(album_key, {
        'title': 'Álbum Desconocido',
        'artist': '',
        'price': 0,
        'genre': '',
        'release_date': '',
        'label': '',
        'producers': '',
        'artist_info': '',
        'image': 'images/default.jpg',
        'audio': '',
        'song_list': [],
        'comments': []
    })

    context = {
        'album_data': album_data
    }
    return render(request, 'paginas/publico/pub_vinilo.html', context)


# VISTAS DE LA CARPETA "COMPRADOR"
@login_required
def com_inicio(request):
  return render(request, 'paginas/comprador/com_inicio.html')

@login_required
def com_albumes(request):
  return render(request, 'paginas/comprador/com_albumes.html')

@login_required
def com_carrito(request):
    # 1) Mini-diccionario de álbumes
    albums_info = {
        'bad':   {'title': 'Bad',   'artist': 'Michael Jackson', 'price': 105000, 'image': 'images/bad.jpg'},
        'master':{'title': 'Master of Puppets', 'artist': 'Metallica', 'price': 105000, 'image': 'images/master.jpg'},
        'joe':   {'title': 'Grandes Éxitos',    'artist': 'Joe Arroyo',   'price': 80000,  'image': 'images/joe.jpg'},
        'thriller': {'title': 'Thriller',      'artist': 'Michael Jackson','price':110000,'image':'images/thriller.jpg'},
        'lonely':   {'title': "Sgt. Pepper's Lonely Hearts Club Band", 'artist': 'The Beatles','price':95000,'image':'images/lonely.jpg'},
        'destruction':{'title':'Appetite for Destruction','artist':"Guns N' Roses",'price':120000,'image':'images/destruction.jpg'},
        'music':{'title':'MUSIC','artist':'Playboi Carti','price':90000,'image':'images/music.jpg'}
    }

    # 2) Carga (o inicializa) tu carrito
    cart = request.session.get('cart', [])

# 2a) Si llega ?remove=<índice>, lo eliminamos
    remove = request.GET.get('remove')
    if remove is not None:
        try:
            idx = int(remove)
            if 0 <= idx < len(cart):
                cart.pop(idx)
                request.session['cart'] = cart
        except ValueError:
            pass
        return redirect('com_carrito')

    # 3) Si llega ?album=<clave>, añádelo
    album_key = request.GET.get('album')
    if album_key in albums_info:
        cart.append(albums_info[album_key])
        request.session['cart'] = cart

        # 2a) Si viene &checkout=true, enviar a checkout directo
        if request.GET.get('com_checkout') == 'true':
            return redirect('com_checkout')

        # 2b) sino, volver a la vista de carrito
        return redirect('com_carrito')

    # 3) Si no hubo album en GET, renderiza normalmente
    total = sum(item['price'] for item in cart)
    return render(request, 'paginas/comprador/com_carrito.html', {
        'cart_items': cart,
        'total': total
    })
    return render(request, 'paginas/comprador/com_checkout.html')
  
@login_required
def com_checkout(request):
    # 1) Recupera el carrito de la sesión (puede estar vacío)
    cart = request.session.get('cart', [])

    # 2) Si el carrito está vacío, lo mandamos de vuelta al carrito
    if not cart:
        return redirect('com_carrito')

    # 3) Calcula el total
    total = sum(item['price'] for item in cart)

    # 4) Renderiza el template de checkout con cart_items y total
    return render(request, 'paginas/comprador/com_checkout.html', {
        'cart_items': cart,
        'total': total
    })
    
@login_required
def com_nosotros(request):
  return render(request, 'paginas/comprador/com_nosotros.html')
# Vista para MOSTRAR el perfil del comprador
@login_required
def com_perfil(request):
    user = request.user
    # Asegurarse de que el perfil del cliente exista o crearlo
    cliente_instance, created = Cliente.objects.get_or_create(user=user)
    context = {
        'cliente_instance': cliente_instance, # Pasar la instancia para mostrar datos del cliente
        'user': user, # Pasar el objeto user para mostrar datos como email, nombre, etc.
        'titulo_pagina': 'Mi Perfil'
    }
    # Esta vista ahora solo muestra la información del perfil.
    return render(request, 'paginas/comprador/com_perfil.html', context)
# Vista para EDITAR el perfil del comprador
@login_required
def com_perfil_editar(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)

    if request.method == 'POST':
        user_form = UserUpdateForm(request.POST, instance=user)
        # Incluir request.FILES para el campo de imagen (foto_perfil)
        cliente_form = ClienteUpdateForm(request.POST, request.FILES, instance=cliente_instance)
        password_form = PasswordChangeForm(user, request.POST)

        intent_to_change_password = bool(request.POST.get('new_password1'))
        user_cliente_forms_valid = user_form.is_valid() and cliente_form.is_valid()
        password_form_valid_if_intended = True

        if intent_to_change_password:
            if password_form.is_valid():
                password_form.save()
                update_session_auth_hash(request, password_form.user)
            else:
                password_form_valid_if_intended = False

        if user_cliente_forms_valid and password_form_valid_if_intended:
            user_form.save()
            cliente_form.save()

            if intent_to_change_password and password_form_valid_if_intended:
                messages.success(request, '¡Tu perfil y contraseña han sido actualizados exitosamente!')
            elif not intent_to_change_password:
                messages.success(request, '¡Tu perfil ha sido actualizado exitosamente!')

            if not (intent_to_change_password and not password_form_valid_if_intended):
                # Redirige a la página de visualización del perfil después de guardar
                return redirect('com_perfil') 

        if not user_cliente_forms_valid or (intent_to_change_password and not password_form_valid_if_intended):
            messages.error(request, 'Por favor corrige los errores señalados abajo.')

    else: # GET request (cuando el usuario visita la página de edición por primera vez)
        user_form = UserUpdateForm(instance=user)
        cliente_form = ClienteUpdateForm(instance=cliente_instance)
        password_form = PasswordChangeForm(user)

    context = {
        'user_form': user_form,
        'cliente_form': cliente_form,
        'password_form': password_form,
        'titulo_pagina': 'Mi Perfil',
        'cliente_instance': cliente_instance # Para mostrar la foto actual en el formulario, etc.
    }
    # Renderiza la nueva plantilla de edición
    return render(request, 'paginas/comprador/com_perfil_editar.html', context)

@login_required
def com_progreso_envio(request):
    return render(request, 'paginas/comprador/com_progreso_envio.html')
  
@login_required
def com_reembolsos(request):
  return render(request, 'paginas/publico/pub_reembolsos.html')

@login_required
def com_soporte(request):
  return render(request, 'paginas/comprador/com_soporte.html')

@login_required
def com_terminos(request):
  return render(request, 'paginas/comprador/com_terminos.html')


# VISTAS DE LA CARPETA "VENDEDOR"
# Para estas vistas, además de @login_required, probablemente necesites
# un @user_passes_test para verificar que el usuario es un vendedor.
# Por ahora, solo añadiremos @login_required.
@login_required
# @user_passes_test(lambda u: u.es_vendedor, login_url='com_inicio') # Ejemplo si tuvieras u.es_vendedor
def ven_bad(request):
  return render(request, 'paginas/vendedor/vinilos/ven_bad.html')

@login_required
def ven_crear(request):
  return render(request, 'paginas/vendedor/ven_crear.html')

@login_required
def ven_notificaciones(request):
  return render(request, 'paginas/vendedor/ven_notificaciones.html')

# Vista para MOSTRAR el perfil del vendedor
@login_required
def ven_perfil(request):
    user = request.user
    # Asegurarse de que el perfil del cliente exista o crearlo
    cliente_instance, created = Cliente.objects.get_or_create(user=user)
    context = {
        'cliente_instance': cliente_instance,
        'user': user,
        'titulo_pagina': 'Mi Perfil de Vendedor'
    }
    # Esta vista ahora solo muestra la información del perfil.
    return render(request, 'paginas/vendedor/ven_perfil.html', context)
# Vista para EDITAR el perfil del vendedor
@login_required
def ven_perfil_editar(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)

    if request.method == 'POST':
        user_form = UserUpdateForm(request.POST, instance=user)
        cliente_form = ClienteUpdateForm(request.POST, request.FILES, instance=cliente_instance)
        password_form = PasswordChangeForm(user, request.POST)

        intent_to_change_password = bool(request.POST.get('new_password1'))
        user_cliente_forms_valid = user_form.is_valid() and cliente_form.is_valid()
        password_form_valid_if_intended = True

        if intent_to_change_password:
            if password_form.is_valid():
                password_form.save()
                update_session_auth_hash(request, password_form.user)
            else:
                password_form_valid_if_intended = False

        if user_cliente_forms_valid and password_form_valid_if_intended:
            user_form.save()
            cliente_form.save()

            if intent_to_change_password and password_form_valid_if_intended:
                messages.success(request, '¡Tu perfil y contraseña han sido actualizados exitosamente!')
            elif not intent_to_change_password:
                messages.success(request, '¡Tu perfil ha sido actualizado exitosamente!')

            if not (intent_to_change_password and not password_form_valid_if_intended):
                # Redirige a la página de visualización del perfil después de guardar
                return redirect('ven_perfil') 

        if not user_cliente_forms_valid or (intent_to_change_password and not password_form_valid_if_intended):
            messages.error(request, 'Por favor corrige los errores señalados abajo.')
    
    else: # GET request (cuando el usuario visita la página de edición por primera vez)
        user_form = UserUpdateForm(instance=user)
        cliente_form = ClienteUpdateForm(instance=cliente_instance)
        password_form = PasswordChangeForm(user)

    context = {
        'user_form': user_form,
        'cliente_form': cliente_form,
        'password_form': password_form,
        'titulo_pagina': 'Mi Perfil de Vendedor',
        'cliente_instance': cliente_instance
    }
    # Renderiza la nueva plantilla de edición
    return render(request, 'paginas/vendedor/ven_perfil_editar.html', context)

@login_required
def ven_producto(request):
  return render(request, 'paginas/vendedor/ven_producto.html')

@login_required
def ven_nosotros(request):
  return render(request, 'paginas/vendedor/ven_nosotros.html')

@login_required
def ven_terminos(request):
  return render(request, 'paginas/vendedor/ven_terminos.html')


# VISTAS DE LA CARPETA "ADMINISTRADOR"
@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login') # Redirige a pub_login si no es staff
def admin_administrador(request):
  return render(request, 'paginas/Administrador/admin_administrador.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_notificaciones(request):
  return render(request, 'paginas/administrador/admin_notificaciones.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_pedido(request):
  return render(request, 'paginas/administrador/admin_pedido.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_producto(request):
  return render(request, 'paginas/administrador/admin_producto.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_reembolsos(request):
  return render(request, 'paginas/administrador/admin_reembolsos.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_usuario(request):
  return render(request, 'paginas/Administrador/admin_usuario.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_verificacion(request):
  return render(request, 'paginas/Administrador/admin_verificacion.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_adPro(request):
  return render(request, 'paginas/administrador/admin_adPro.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_bloq_users(request):
  return render(request, 'paginas/administrador/admin_bloq_users.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_generos(request):
  return render(request, 'paginas/admin_generos.html') # Se crea la rendererización de este archivo .HTML

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_gestion_users(request):
  return render(request, 'paginas/administrador/admin_gestion_users.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_new_users(request):
  return render(request, 'paginas/Administrador/admin_new_users.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_pedido_pendiente(request):
  return render(request, 'paginas/administrador/admin_pedido_pendiente.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_pedido_realizado(request):
  return render(request, 'paginas/administrador/admin_pedido_realizado.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_ventas(request):
  return render(request, 'paginas/Administrador/admin_ventas.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_nosotros(request):
  return render(request, 'paginas/administrador/admin_nosotros.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_terminos(request):
  return render(request, 'paginas/administrador/admin_terminos.html')

# Vista placeholder para "Más Vendidos" (Asegúrate de que esta plantilla exista)
@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_mas_vendidos(request):
  return render(request, 'paginas/administrador/admin_mas_vendidos.html') # ¿Este qué?


# VISTAS DE VINILOS, SUBCARPETA DE ADMINISTRADOR
@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def bts(request):
  return render(request, 'paginas/administrador/ventas/bts.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def cartiMusic(request):
    return render(request, 'paginas/administrador/ventas/cartiMusic.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def eminemShow(request):
  return render(request, 'paginas/administrador/ventas/eminemShow.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def exitosJoe(request):
    return render(request, 'paginas/administrador/ventas/exitosJoe.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def gnrAppetite(request):
    return render(request, 'paginas/administrador/ventas/gnrAppetite.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def master(request):
    return render(request, 'paginas/administrador/ventas/master.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def mjBad(request):
  return render(request, 'paginas/administrador/ventas/mjBad.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def mjThriller(request):
    return render(request, 'paginas/administrador/ventas/mjThriller.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def nirvana(request):
  return render(request, 'paginas/administrador/ventas/nirvana.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def theBeatles(request):
  return render(request, 'paginas/administrador/ventas/theBeatles.html')


# VISTAS DE LOS USUARIOS
@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def lauraG(request):
  return render(request, 'paginas/administrador/usuarios/lauraG.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def carlosR(request):
  return render(request, 'paginas/administrador/usuarios/carlosR.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def camilaQ(request):
  return render(request, 'paginas/administrador/usuarios/camilaQ.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def jhonM(request):
  return render(request, 'paginas/administrador/usuarios/jhonM.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def alexR(request):
  return render(request, 'paginas/administrador/usuarios/alexR.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def andreaVillalobos(request):
  return render(request, 'paginas/administrador/usuarios/andreaVillalobos.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def benjaminCastro(request):
  return render(request, 'paginas/administrador/usuarios/benjaminCastro.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def cristianDominguez(request):
  return render(request, 'paginas/administrador/usuarios/cristianDominguez.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def angelaTorres(request):
  return render(request, 'paginas/administrador/usuarios/angelaTorres.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def elisaNaranjo(request):
  return render(request, 'paginas/administrador/usuarios/elisaNaranjo.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def emilioTorres(request):
  return render(request, 'paginas/administrador/usuarios/emilioTorres.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def andreaVillalobos2(request):
  return render(request, 'paginas/administrador/usuarios/andreaVillalobos2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def benjaminCastro2(request):
  return render(request, 'paginas/administrador/usuarios/benjaminCastro2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def cristianDominguez2(request):
  return render(request, 'paginas/administrador/usuarios/cristianDominguez2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def angelaTorres2(request):
  return render(request, 'paginas/administrador/usuarios/angelaTorres2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def elisaNaranjo2(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/elisaNaranjo2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def emilioTorres2(request):
  return render(request, 'paginas/administrador/usuarios/emilioTorres2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def sofiaRamirez(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/sofiaRamirez.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def esperanzaBarrera(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/esperanzaBarrera.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def fernandoMolina(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/fernandoMolina.html')

def pub_soporte(request):
  return render(request, 'paginas/publico/pub_soporte.html')


# VISTAS DE LA CARPETA "CRUD"
def crud(request):
  elementos_crud = Crud.objects.all() # Obtiene todos los elementos del modelo Crud
  # print(elementos_crud)  # Imprime en la consola los elementos del modelo Crud
  return render(request, 'crud/crud_inicio.html', { 'elementos_crud': elementos_crud })

def crud_crear(request):
  if request.method == 'POST':
    formulario = CrudForm(request.POST, request.FILES) # Se crea el formulario con los datos POST
    if formulario.is_valid():
      formulario.save() # Se guarda el formulario
      return redirect('crud') # Se redirecciona a la página de listado del CRUD
  else: # Si es una solicitud GET
    formulario = CrudForm() # Se crea un formulario vacío
  return render(request, 'crud/crud_crear.html', { 'formulario': formulario })

def crud_editar(request, id):
  editar_elemento = Crud.objects.get(id = id) # Obtiene el elemento del modelo Crud por su ID
  if request.method == 'POST':
    # Se crea el formulario con los datos POST y la instancia existente
    formulario = CrudForm(request.POST, request.FILES, instance = editar_elemento)
    if formulario.is_valid():
      formulario.save() # Se guarda el formulario
      return redirect('crud') # Se redirecciona a la página de listado del CRUD
  else: # Si es una solicitud GET
    # Se crea un formulario pre-poblado con los datos de la instancia
    formulario = CrudForm(instance = editar_elemento)
  return render(request, 'crud/crud_editar.html', {'formulario': formulario})

def crud_eliminar(request, id):
  eliminar_elemento = Crud.objects.get(id = id)
  eliminar_elemento.delete()
  return redirect('crud') # Redirecciona a la lista del CRUD