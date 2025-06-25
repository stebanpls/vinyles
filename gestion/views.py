from django.shortcuts import render, redirect
from django.shortcuts import render, get_object_or_404
# Se agregó el import de os
# Se importa el reverse para redireccionar a la vista de crud.
from django.urls import reverse
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required, user_passes_test # Para proteger vistas
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.template.loader import render_to_string
from django.core.mail import send_mail
from django.contrib.sites.shortcuts import get_current_site
from django.utils import timezone # Importar timedelta también
# Se importa los atributos de Crud 
from .models import Crud, Cliente, Genero, Producto, Artista, Productor, Cancion

from .forms import (
    CrudForm, UserRegistrationForm, UserUpdateForm, ClienteUpdateForm, LoginForm,
    ProductoForm, CancionForm, ArtistaForm, GeneroForm, ProductorForm,ClienteEditForm,UserEditForm,
    PasswordResetRequestForm, PasswordResetConfirmForm
) # Importar formularios

# Importar las funciones de autenticación de Django
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout # Importa las funciones de autenticación
import os # Importar para obtener variables de entorno
from django.contrib.auth.models import User, Group # Importar el modelo User y Group estándar
from django.core.mail import EmailMultiAlternatives # Importar para enviar correos HTML
from django.contrib import messages # Para mensajes opcionales
from datetime import timedelta # Importar timedelta

# Create your views here.
"""
def saludo(request):
    return HttpResponse("<h1>Hasta Mañana, babys!</h1>")
"""

# Vistas para los modales de creación
def artista_form_modal(request):
    if request.method == "POST":
        form = ArtistaForm(request.POST, request.FILES)
        if form.is_valid():
            artista = form.save()
            return JsonResponse({
                'success': True,
                'id': artista.id,
                'nombre': str(artista) # Usar str(artista) para obtener la representación del modelo
            })
        else:
            # Para depuración en el servidor:
            print(f"Errores en el formulario de artista (modal): {form.errors.as_json()}")
            # Devolver el HTML del formulario con errores para AJAX
            form_html = render_to_string('modales/modal_artista.html', {'form': form}, request=request)
            return JsonResponse({'success': False, 'form_html': form_html})
    else:
        form = ArtistaForm()
    return render(request, 'modales/modal_artista.html', {'form': form})

def modal_genero(request):
    if request.method == "POST":
        form = GeneroForm(request.POST) # No necesita request.FILES si no hay subida de archivos
        if form.is_valid():
            genero = form.save()
            return JsonResponse({
                'success': True,
                'id': genero.id,
                'nombre': str(genero)
            })
        else:
            # Para depuración en el servidor:
            print(f"Errores en el formulario de género (modal): {form.errors.as_json()}")
            form_html = render_to_string('modales/modal_genero.html', {'form': form}, request=request)
            return JsonResponse({'success': False, 'form_html': form_html})
    else:
        form = GeneroForm()
    return render(request, 'modales/modal_genero.html', {'form': form})

def modal_productor(request):
    if request.method == "POST":
        form = ProductorForm(request.POST) # No necesita request.FILES
        if form.is_valid():
            productor = form.save()
            return JsonResponse({
                'success': True,
                'id': productor.id,
                'nombre': str(productor)
            })
        else:
            # Para depuración en el servidor:
            print(f"Errores en el formulario de productor (modal): {form.errors.as_json()}")
            form_html = render_to_string('modales/modal_productor.html', {'form': form}, request=request)
            return JsonResponse({'success': False, 'form_html': form_html})
    else:
        form = ProductorForm() # Corregido: Usar ProductorForm
    return render(request, 'modales/modal_productor.html', {'form': form})

def modal_cancion(request): # Esta vista es para crear una canción individualmente, no para asociarla a un producto.
    if request.method == "POST":
        form = CancionForm(request.POST) # Asumiendo que CancionForm no maneja archivos directamente
        if form.is_valid():
            cancion = form.save()
            return JsonResponse({'success': True, 'id': cancion.id, 'nombre': str(cancion)})
        else:
            # Para depuración en el servidor:
            print(f"Errores en el formulario de canción (modal): {form.errors.as_json()}")
            form_html = render_to_string('modales/modal_cancion.html', {'form': form}, request=request)
            return JsonResponse({'success': False, 'form_html': form_html})
    else:
        form = CancionForm()
    return render(request, 'modales/modal_cancion.html', {'form': form})

# VISTAS DE LA CARPETA "PUBLICO"
def pub_inicio(request):
    return render(request, 'paginas/publico/pub_inicio.html')

def pub_albumes(request):
    return render(request, 'paginas/publico/pub_albumes.html')

def pub_ddl(request):
    return render(request, 'paginas/publico/pub_ddl.html')

def pub_login(request):
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

    form = LoginForm() # Inicializar el formulario para GET requests

    if request.method == 'POST':
        form = LoginForm(request.POST) # Vincular datos del POST al formulario

        # Datos del álbum del POST, con fallback a los de GET si no están en POST
        post_album_name = request.POST.get('album_name', album_name_get)
        post_artist = request.POST.get('artist', artist_get)
        post_price = request.POST.get('price', price_get)
        post_image = request.POST.get('image', image_get)
        # Actualizar las variables _get para que el contexto refleje los datos del POST si existen,
        # o si el formulario no es válido y se vuelve a renderizar.
        album_name_get = post_album_name
        artist_get = post_artist
        price_get = post_price
        image_get = post_image
        
        if form.is_valid(): # Esto validará el reCAPTCHA y los otros campos
            identifier = form.cleaned_data['login_identifier']
            password = form.cleaned_data['password']
            specific_auth_error_occurred = False

            # Intentar autenticar con el input como username primero
            user = authenticate(request, username=identifier, password=password)

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
                messages.success(request, f"¡Bienvenido de nuevo, {user.username}!")

                # Redirigir al usuario a la página 'next' si existe,
                # de lo contrario, redirigir según su rol (usando grupos).
                default_redirect_url_name = 'com_inicio' # Default para usuarios normales
                if user.is_staff or user.is_superuser:
                    default_redirect_url_name = 'admin_administrador'
                # No se necesita un 'elif' para vendedores, ya que todos los usuarios autenticados son compradores/vendedores
                    
                if next_url:
                    return redirect(next_url)
                return redirect(default_redirect_url_name)
            else:
                # Login fallido. Solo mostrar el error genérico si no hubo un error más específico.
                if not specific_auth_error_occurred:
                    # Puedes añadir el error al formulario para mostrarlo cerca de los campos,
                    # o mantener el mensaje global.
                    # form.add_error(None, "El nombre de usuario/email o la contraseña son incorrectos.")
                    messages.error(request, "El nombre de usuario/email o la contraseña son incorrectos. Por favor, inténtalo de nuevo.")
        # Si el formulario no es válido (ej. captcha falló), se re-renderizará la página
        # con los errores del formulario. No es necesario un 'else' explícito aquí para messages.error
        # si los errores del formulario son suficientes.
    
    # Este bloque de código se ejecuta si la solicitud es GET,
    # o si la solicitud es POST pero la autenticación falló.
    # Prepara el contexto y renderiza la plantilla de login.
    context = {
        'form': form, # Pasar el formulario al contexto
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
    # Simplemente renderiza la página de confirmación y muestra un mensaje.
    messages.info(request, "Has cerrado sesión exitosamente. ¡Hasta luego!")
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
            # El método .save() de UserCreationForm (del que ahora heredamos)
            # ya se encarga de hashear la contraseña y guardar el usuario.
            user_form.save()

            # La señal post_save que configuramos en models.py se encargará
            # de crear automáticamente el perfil de Cliente asociado.
            messages.success(request, '¡Registro exitoso! Ahora puedes iniciar sesión.')
            return redirect('pub_login') # Redirigir al login después del registro exitoso
        else:
            messages.error(request, 'Por favor corrige los errores presentados en el formulario.')
    else:
        user_form = UserRegistrationForm() # Si no es POST, crea un formulario vacío
    return render(request, 'paginas/publico/pub_registro.html', {'user_form': user_form})

def pub_reembolsos(request):
  return render(request, 'paginas/publico/pub_reembolsos.html')

def pub_soporte(request):
  return render(request, 'paginas/publico/pub_soporte.html')

def pub_terminos(request):
  return render(request, 'paginas/publico/pub_terminos.html')

def pub_vinilo(request):
    album_key = request.GET.get('album', '')  # ejemplo: 'michael_jackson_bad', 'metallica_master', etc.

    # Diccionario que contiene la info de cada álbum, indexada por 'album_key'
    # Asegúrate que las claves aquí coincidan con los parámetros ?album= que usas en los enlaces
    albums_info = {
        'michael_jackson_bad': {
            'key': 'michael_jackson_bad',
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
            'image': 'images/albumes/michael_jackson_bad.jpg',
            'audio': 'audio/bad.mp3',
            'song_list': [
                'Bad', 'The Way You Make Me Feel', 'Speed Demon', 'Liberian Girl',
                'Just Good Friends (con Stevie Wonder)', 'Another Part of Me', 'Man in the Mirror',
                'I Just Can\'t Stop Loving You (con Siedah Garrett)', 'Dirty Diana', 'Smooth Criminal', 'Leave Me Alone'
            ],
            'comments': [
                {'username': 'musicLover', 'comment': 'Un álbum icónico con ritmos pegadizos y la energía inigualable de Michael!'},
                {'username': 'popFanatic', 'comment': 'Cada canción es un hit, la producción es impecable.'}
            ]
        },
        'metallica_master': {
            'key': 'metallica_master',
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
            'image': 'images/albumes/metallica_master.jpg',
            'audio': 'audio/master.mp3',
            'song_list': [
                'Battery', 'Master of Puppets', 'The Thing That Should Not Be', 'Welcome Home (Sanitarium)',
                'Disposable Heroes', 'Leper Messiah', 'Orion', 'Damage, Inc.'
            ],
            'comments': [
                {'username': 'metalHead', 'comment': 'Una obra maestra del thrash metal, cada riff es легендарный!'},
                {'username': 'guitarHero', 'comment': 'La composición y la ejecución instrumental son de otro nivel.'}
            ]
        },
        'joe_arroyo_la_verdad': {
            'key': 'joe_arroyo_la_verdad',
            'title': 'La Verdad de Joe Arroyo: el Original',
            'artist': 'Joe Arroyo',
            'price': 80000,
            'genre': 'Salsa, Cumbia',
            'release_date': 'Recopilación de varios lanzamientos', # Ajustar si es un álbum específico
            'label': 'Discos Fuentes',
            'producers': 'Varios productores a lo largo de su carrera',
            'artist_info': (
                'Álvaro José Arroyo González, conocido como Joe Arroyo, fue un cantautor colombiano, '
                'considerado uno de los más grandes exponentes de la música caribeña en su país.'
            ),
            'image': 'images/albumes/joe_arroyo_la_verdad.jpg',
            'audio': 'audio/joe.mp3', # Asume que tienes este audio
            'song_list': [
                'Rebelión', 'La Noche', 'Tania', 'El Centurión de la Noche', 'Yamulemau',
                'Te Quiero Más', 'En Barranquilla Me Quedo', 'Mary', 'Sobreviviré', 'A Mi Pueblo'
            ],
            'comments': [
                {'username': 'salsaQueen', 'comment': '¡Un verdadero legado de la salsa colombiana, imposible no bailar!'},
                {'username': 'caribeSoul', 'comment': 'La voz y el sabor de Joe Arroyo son únicos e inigualables.'}
            ]
        },
        'michael_jackson_thriller': {
            'key': 'michael_jackson_thriller',
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
            'image': 'images/albumes/michael_jackson_thriller.jpg',
            'audio': 'audio/thriller.mp3',
            'song_list': [
                'Wanna Be Startin\' Somethin\'', 'Baby Be Mine', 'The Girl Is Mine (con Paul McCartney)', 'Thriller',
                'Beat It', 'Billie Jean', 'Human Nature', 'P.Y.T. (Pretty Young Thing)', 'The Lady in My Life'
            ],
            'comments': [
                {'username': 'classicPop', 'comment': 'El álbum más vendido de todos los tiempos por una razón, ¡cada canción es perfecta!'},
                {'username': 'moonwalker', 'comment': 'Thriller no solo es música, es un evento cultural.'}
            ]
        },
        'the_beatles_sgt_pepper': {
            'key': 'the_beatles_sgt_pepper',
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
            'image': 'images/albumes/the_beatles_sgt_pepper.jpg',
            'audio': 'audio/lonely.mp3', # Asume que tienes este audio
            'song_list': [
                'Sgt. Pepper\'s Lonely Hearts Club Band', 'With a Little Help from My Friends', 'Lucy in the Sky with Diamonds',
                'Getting Better', 'Fixing a Hole', 'She\'s Leaving Home', 'Being for the Benefit of Mr. Kite!',
                'Within You Without You', 'When I\'m Sixty-Four', 'Lovely Rita', 'Good Morning Good Morning',
                'Sgt. Pepper\'s Lonely Hearts Club Band (Reprise)', 'A Day in the Life'
            ],
            'comments': [
                {'username': 'beatlemania', 'comment': 'Un álbum revolucionario que expandió los límites de la música pop y rock.'},
                {'username': 'sixtiesSound', 'comment': 'La creatividad y la experimentación en este álbum son asombrosas.'}
            ]
        },
        'guns_n_roses_appetite': {
            'key': 'guns_n_roses_appetite',
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
            'image': 'images/albumes/guns_n_roses_appetite.jpg',
            'audio': 'audio/destruction.mp3', # Asume que tienes este audio
            'song_list': [
                'Welcome to the Jungle', 'It\'s So Easy', 'Nightrain', 'Out ta Get Me', 'Mr. Brownstone',
                'Paradise City', 'My Michelle', 'Think About You', 'Sweet Child o\' Mine', 'You\'re Crazy',
                'Anything Goes', 'Rocket Queen'
            ],
            'comments': [
                {'username': 'rockNRoll', 'comment': 'Un álbum debut explosivo que revitalizó el hard rock para una nueva generación.'},
                {'username': 'axlRoseFan', 'comment': 'La voz de Axl y los riffs de Slash son simplemente legendarios.'}
            ]
        },
        'playboi_carti_music': {
            'key': 'playboi_carti_music',
            'title': 'Music',
            'artist': 'Playboi Carti',
            'price': 90000,
            'genre': 'Hip Hop, Trap',
            'release_date': '14 de marzo de 2025', # Ejemplo, ajustar
            'label': 'Opium, Interscope Records',
            'producers': 'Ojivolta, Cardo, F1lthy, Bnyx, Maaly Raw, Metro Boomin, TM88, Wheezy, Kanye West, Travis Scott',
            'artist_info': (
                'Playboi Carti es un rapero y compositor estadounidense conocido por su estilo experimental '
                'y su influencia en la escena del trap contemporáneo.'
            ),
            'image': 'images/albumes/playboi_carti_music.jpg',
            'audio': 'audio/music.mp3', # Asume que tienes este audio
            'song_list': [
                'Pop Out', 'Crush (feat. Travis Scott)', 'K Pop', 'Evil J0rdan', 'Mojo Jojo', 'Philly', 'Radar',
                'Rather Lie', 'Fine Shit', 'Backd00r', 'Toxic', 'Munyun', 'Crank', 'Charge Dem Hoes a Fee',
                'Good Credit', 'I Seeeeee You Baby Boi', 'Wake Up F1lthy', 'Jumpin', 'Trim', 'Cocaine Nose',
                'We Need All Da Vibes', 'Olympian', 'Opm Babi', 'Twin Trim', 'Like Weezy', 'Dis 1 Got It',
                'Walk', 'HBA', 'Overly', 'South Atlanta Baby'
            ],
            'comments': [
                {'username': 'trapLord', 'comment': 'El sonido vanguardista de Carti sigue evolucionando, este álbum es otro viaje.'},
                {'username': 'opiumGang', 'comment': 'La producción es de otro nivel, Carti siempre innovando.'}
            ]
        },
        'elvis_crespo_suavemente': {
            'key': 'elvis_crespo_suavemente',
            'title': 'Suavemente',
            'artist': 'Elvis Crespo',
            'price': 50000,
            'genre': 'Merengue',
            'release_date': '1998',
            'label': 'Sony Discos',
            'producers': 'Elvis Crespo, Roberto Cora',
            'artist_info': 'Elvis Crespo es un cantante puertorriqueño-estadounidense de merengue, conocido por su éxito mundial "Suavemente".',
            'image': 'images/albumes/elvis_crespo_suavemente.jpg',
            'audio': 'audio/suavemente.mp3',
            'song_list': ['Suavemente', 'Tu Sonrisa', 'Luna Llena', 'Nuestra Canción', 'Pintame', 'Me Arrepiento', 'Te Vas', 'Para Darte Mi Vida', 'Lloré, Lloré', 'Por el Caminito'],
            'comments': [{'username': 'merenguero', 'comment': '¡Un clásico del merengue que nunca falla en una fiesta!'}]
        },
        'eminem_the_eminem_show': {
            'key': 'eminem_the_eminem_show',
            'title': 'The Eminem Show',
            'artist': 'Eminem',
            'price': 95000,
            'genre': 'Hip Hop',
            'release_date': '26 de mayo de 2002',
            'label': 'Shady, Aftermath, Interscope',
            'producers': 'Dr. Dre, Eminem, Jeff Bass',
            'artist_info': 'Eminem es un rapero, compositor y productor discográfico estadounidense, considerado uno de los artistas de hip hop más influyentes y exitosos.',
            'image': 'images/albumes/eminem_the_eminem_show.jpg',
            'audio': 'audio/the_eminem_show.mp3',
            'song_list': ['Curtains Up (Skit)', 'White America', 'Business', 'Cleanin\' Out My Closet', 'Square Dance', 'The Kiss (Skit)', 'Soldier', 'Say Goodbye Hollywood', 'Drips', 'Without Me', 'Paul Rosenberg (Skit)', 'Sing for the Moment', 'Superman', 'Hailie\'s Song', 'Steve Berman (Skit)', 'When the Music Stops', '\'Till I Collapse', 'My Dad\'s Gone Crazy', 'Curtains Close (Skit)'],
            'comments': [{'username': 'slimShadyFan', 'comment': 'Uno de los mejores álbumes de Eminem, letras crudas y producción increíble.'}]
        },
        'nirvana_in_utero': {
            'key': 'nirvana_in_utero',
            'title': 'In Utero',
            'artist': 'Nirvana',
            'price': 120000,
            'genre': 'Grunge, Rock Alternativo',
            'release_date': '13 de septiembre de 1993',
            'label': 'DGC Records',
            'producers': 'Steve Albini',
            'artist_info': 'Nirvana fue una banda de rock estadounidense formada en Aberdeen, Washington, en 1987. Liderada por Kurt Cobain, se convirtió en un ícono del movimiento grunge.',
            'image': 'images/albumes/nirvana_in_utero.jpg',
            'audio': 'audio/in_utero.mp3',
            'song_list': ['Serve the Servants', 'Scentless Apprentice', 'Heart-Shaped Box', 'Rape Me', 'Frances Farmer Will Have Her Revenge on Seattle', 'Dumb', 'Very Ape', 'Milk It', 'Pennyroyal Tea', 'Radio Friendly Unit Shifter', 'Tourette\'s', 'All Apologies'],
            'comments': [{'username': 'grungeForever', 'comment': 'Un álbum crudo y poderoso, la esencia de Nirvana.'}]
        },
        'aespa_whiplash': {
            'key': 'aespa_whiplash',
            'title': 'Whiplash',
            'artist': 'Aespa',
            'price': 130000,
            'genre': 'K-pop, Hyperpop',
            'release_date': '2024',
            'label': 'SM Entertainment',
            'producers': 'Productores de Aespa',
            'artist_info': 'Aespa es un grupo femenino surcoreano formado por SM Entertainment, conocido por su concepto de metaverso y su música innovadora.',
            'image': 'images/albumes/aespa_whiplash.jpg', 
            'audio': 'audio/whiplash.mp3',
            'song_list': ['Whiplash', 'Just Another Girl', 'Flowers','Pink Hoodie', 'Kill it', 'Flights, Not Feelings'],
            'comments': [{'username': 'MYaespa', 'comment': '¡Aespa siempre sorprendiendo con su sonido único!'}]},
        'daddy_yankee_barrio': { 
            'key': 'daddy_yankee_barrio',
            'title': 'Barrio Fino (Deluxe Version)', 
            'artist': 'Daddy Yankee',
            'price': 150000,
            'genre': 'Reggaetón',
            'release_date': '13 de julio de 2004',
            'label': 'El Cartel Records, VI Music',
            'producers': 'Luny Tunes, DJ Nelson, Monserrate & DJ Urba, Nely "El Arma Secreta", Naldo, Echo, Diesel',
            'artist_info': 'Daddy Yankee es un cantante, rapero, compositor y productor discográfico puertorriqueño, apodado el "Rey del Reguetón". "Barrio Fino" es uno de sus álbumes más icónicos.',
            'image': 'images/albumes/daddy_yankee_barrio.jpg',
            'audio': 'audio/barrio_fino.mp3',
            'song_list': ['Intro', 'King Daddy', 'Gasolina', 'Lo Que Pasó, Pasó', 'No Me Dejes Solo (feat. Wisin & Yandel)', 'Salud y Vida', 'Corazones', 'Tu Príncipe (feat. Zion & Lennox)', 'Cuéntame', 'Santifica Tus Escapularios', 'Sabor A Melao (feat. Andy Montañez)', 'El Muro', 'Dale Caliente', 'El Empuje', '¿Qué Vas A Hacer? (feat. May-Be)', 'Intermedio "Gavilan"', 'ElCangri.com', 'Golpe De Estado (feat. Tommy Viera)', '2 Mujeres', 'Saber Su Nombre', 'Outro'],
            'comments': [{'username': 'reggaetoneroFull', 'comment': '¡El álbum que definió el reggaetón! Puros clásicos.'}]
        },
        'the_beatles_abbey_road': {
            'key': 'the_beatles_abbey_road',
            'title': 'Abbey Road',
            'artist': 'The Beatles',
            'price': 135000,
            'genre': 'Rock',
            'release_date': '26 de septiembre de 1969',
            'label': 'Apple Records',
            'producers': 'George Martin',
            'artist_info': 'The Beatles, una de las bandas más influyentes de todos los tiempos, conocidos por su innovación musical y su impacto cultural.',
            'image': 'images/albumes/the_beatles_abbey.jpg',
            'audio': 'audio/abbey_road.mp3',
            'song_list': ['Come Together', 'Something', 'Maxwell\'s Silver Hammer', 'Oh! Darling', 'Octopus\'s Garden', 'I Want You (She\'s So Heavy)', 'Here Comes the Sun', 'Because', 'You Never Give Me Your Money', 'Sun King', 'Mean Mr. Mustard', 'Polythene Pam', 'She Came In Through the Bathroom Window', 'Golden Slumbers', 'Carry That Weight', 'The End', 'Her Majesty'],
            'comments': [{'username': 'classicRockFan', 'comment': 'Una obra maestra atemporal, la despedida perfecta.'}]
        },
        'bts_love_yourself': {
            'key': 'bts_love_yourself',
            'title': 'Love Yourself: Answer',
            'artist': 'BTS',
            'price': 105000,
            'genre': 'K-pop, Pop',
            'release_date': '24 de agosto de 2018',
            'label': 'Big Hit Entertainment',
            'producers': 'Pdogg, Slow Rabbit, Supreme Boi, y otros',
            'artist_info': 'BTS es un grupo surcoreano que ha alcanzado fama mundial, conocido por su música significativa y sus poderosas actuaciones.',
            'image': 'images/albumes/bts_love.jpg',
            'audio': 'audio/love_yourself.mp3',
            'song_list': ['Euphoria', 'Trivia 起: Just Dance', 'Serendipity (Full Length Edition)', 'DNA', 'Dimple', 'Trivia 承: Love', 'Her', 'Singularity', 'FAKE LOVE', 'The Truth Untold (feat. Steve Aoki)', 'Trivia 轉: Seesaw', 'Tear', 'Epiphany', 'I\'m Fine', 'IDOL', 'Answer: Love Myself', 'Magic Shop', 'Best of Me', 'Airplane Pt.2', 'Go Go', 'Anpanman', 'MIC Drop', 'DNA (Pedal 2 LA Mix)', 'FAKE LOVE (Rocking Vibe Mix)', 'MIC Drop (Steve Aoki Remix) (Full Length Edition)'],
            'comments': [{'username': 'ARMYforever', 'comment': 'Un álbum lleno de mensajes hermosos y música increíble.'}]
        },
        'frank_sinatra_the_world': {
            'key': 'frank_sinatra_the_world',
            'title': 'The World We Knew',
            'artist': 'Frank Sinatra',
            'price': 140000,
            'genre': 'Traditional Pop, Jazz',
            'release_date': 'Septiembre de 1967',
            'label': 'Reprise Records',
            'producers': 'Jimmy Bowen, Ernie Freeman',
            'artist_info': 'Frank Sinatra, apodado "La Voz", fue uno de los cantantes más populares e influyentes del siglo XX, conocido por su estilo impecable y su carisma.',
            'image': 'images/albumes/frank_sinatra_the_world.jpg',
            'audio': 'audio/the_world_we_knew.mp3',
            'song_list': ['The World We Knew (Over and Over)', 'Somethin\' Stupid (con Nancy Sinatra)', 'This Is My Love', 'Born Free', 'Don\'t Sleep in the Subway', 'This Town', 'This Is My Song', 'You Are There', 'Drinking Again', 'Some Enchanted Evening'],
            'comments': [{'username': 'croonerFan', 'comment': 'La voz de Sinatra es simplemente mágica. Un álbum encantador.'}]
        }
    }

    # Si no existe la clave, usar una 'base' o un álbum vacío
    album_data = albums_info.get(album_key, {
        'key': 'unknown', # Añadir una clave por defecto
        'title': 'Álbum Desconocido',
        'artist': '',
        'price': 0,
        'genre': '',
        'release_date': '',
        'label': '',
        'producers': '',
        'artist_info': '',
        'image': 'images/default.jpg', # Considera tener una imagen por defecto
        'audio': '',
        'song_list': [],
        'comments': []
    })

    context = {
        'album_data': album_data
    }
    return render(request, 'paginas/publico/pub_vinilo.html', context)

def password_reset_request(request):
    if request.user.is_authenticated:
        return redirect('com_inicio')

    if request.method == 'POST':
        form = PasswordResetRequestForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            user = User.objects.get(email__iexact=email, is_active=True)

            from .models import PasswordResetCode # Import here to avoid circular dependency
            # Eliminar códigos antiguos para este usuario
            PasswordResetCode.objects.filter(user=user).delete()
            # Crear un nuevo código
            reset_code = PasswordResetCode.objects.create(user=user)

            current_site = get_current_site(request)
            # Contexto común para ambas plantillas
            email_context = {
                'user': user,
                'code': reset_code.code,
                'expiration_minutes': 10, # El modelo ya lo establece, pero lo pasamos para el mensaje
                'domain': current_site.domain,
                'site_name': current_site.name,
                'protocol': 'https' if request.is_secure() else 'http',
            }
            
            # Renderizar el asunto del correo
            mail_subject = render_to_string('registration/password_reset_subject.txt', email_context).strip()
            # Renderizar la versión HTML del correo
            html_message = render_to_string('registration/password_reset_email.html', email_context)
            # Renderizar la versión de texto plano del correo
            text_message = render_to_string('registration/password_reset_email.txt', email_context)

            # Enviar el correo multipart
            email_message = EmailMultiAlternatives(mail_subject, text_message, f"Vinyles <{os.environ.get('EMAIL_HOST_USER')}>", [email])
            email_message.attach_alternative(html_message, "text/html")
            email_message.send()

            # Almacenar el ID del usuario en la sesión para el siguiente paso
            request.session['reset_user_id'] = user.id

            messages.success(request, 'Te hemos enviado un correo con un código de verificación.')
            return redirect('password_reset_done')
        else:
            messages.error(request, "Por favor, corrige los errores en el formulario.")
    else:
        form = PasswordResetRequestForm()

    return render(request, 'paginas/publico/pub_solicitar_reseteo.html', {'form': form})


def password_reset_confirm_code(request):
    user_id = request.session.get('reset_user_id')
    if not user_id:
        messages.error(request, "La sesión de restablecimiento ha expirado o no es válida. Por favor, inténtalo de nuevo.")
        return redirect('password_reset') # Redirige al inicio del flujo de reseteo

    try:
        user = User.objects.get(pk=user_id)
    except User.DoesNotExist:
        messages.error(request, "Usuario no encontrado. Por favor, solicita un nuevo restablecimiento de contraseña.")
        return redirect('password_reset')

    if request.method == 'POST':
        form = PasswordResetConfirmForm(user, request.POST)
        if form.is_valid():
            form.save() # Guarda la nueva contraseña y elimina el código
            del request.session['reset_user_id'] # Limpia la sesión
            messages.success(request, 'Tu contraseña ha sido restablecida exitosamente. Ahora puedes iniciar sesión.')
            return redirect('password_reset_complete') # Redirige a la página de éxito
        else:
            messages.error(request, "Por favor, corrige los errores señalados.")
    else:
        form = PasswordResetConfirmForm(user)

    return render(request, 'paginas/publico/pub_restablecer_contrasena_codigo.html', {'form': form, 'validlink': True})

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
    # Las claves aquí deben coincidir con las usadas en los parámetros ?album=
    albums_info_base = {
        'michael_jackson_bad': {'title': 'Bad', 'artist': 'Michael Jackson', 'price': 105000, 'image': 'images/albumes/michael_jackson_bad.jpg'},
        'metallica_master': {'title': 'Master of Puppets', 'artist': 'Metallica', 'price': 105000, 'image': 'images/albumes/metallica_master.jpg'},
        'joe_arroyo_la_verdad': {'title': 'La Verdad', 'artist': 'Joe Arroyo', 'price': 80000,  'image': 'images/albumes/joe_arroyo_la_verdad.jpg'},
        'michael_jackson_thriller': {'title': 'Thriller', 'artist': 'Michael Jackson','price':110000,'image':'images/albumes/michael_jackson_thriller.jpg'},
        'the_beatles_sgt_pepper': {'title': "Sgt. Pepper's Lonely Hearts Club Band", 'artist': 'The Beatles','price':95000,'image':'images/albumes/the_beatles_sgt_pepper.jpg'},
        'guns_n_roses_appetite': {'title':'Appetite for Destruction','artist':"Guns N' Roses",'price':120000,'image':'images/albumes/guns_n_roses_appetite.jpg'},
        'playboi_carti_music': {'title':'Music','artist':'Playboi Carti','price':90000,'image':'images/albumes/playboi_carti_music.jpg'},
        'elvis_crespo_suavemente': {'title': 'Suavemente', 'artist': 'Elvis Crespo', 'price': 50000, 'image': 'images/albumes/elvis_crespo_suavemente.jpg'},
        'eminem_the_eminem_show': {'title': 'The Eminem Show', 'artist': 'Eminem', 'price': 95000, 'image': 'images/albumes/eminem_the_eminem_show.jpg'},
        'nirvana_in_utero': {'title': 'In Utero', 'artist': 'Nirvana', 'price': 120000, 'image': 'images/albumes/nirvana_in_utero.jpg'},
        'aespa_whiplash': {'title': 'Whiplash', 'artist': 'Aespa', 'price': 130000, 'image': 'images/albumes/aespa_whiplash.jpg'},
        'daddy_yankee_barrio': {'title': 'Barrio Fino (Deluxe Version)', 'artist': 'Daddy Yankee', 'price': 150000, 'image': 'images/albumes/daddy_yankee_barrio.jpg'},
        'the_beatles_abbey_road': {'title': 'Abbey Road', 'artist': 'The Beatles', 'price': 135000, 'image': 'images/albumes/the_beatles_abbey.jpg'},
        'bts_love_yourself': {'title': 'Love Yourself: Answer', 'artist': 'BTS', 'price': 105000, 'image': 'images/albumes/bts_love.jpg'},
        'frank_sinatra_the_world': {'title': 'The World We Knew', 'artist': 'Frank Sinatra', 'price': 140000, 'image': 'images/albumes/frank_sinatra_the_world.jpg'},
    }

    # Crear una copia para añadir los mapeos de retrocompatibilidad
    albums_info = albums_info_base.copy()
    albums_info.update({
        'bad': albums_info_base.get('michael_jackson_bad'),
        'master': albums_info_base.get('metallica_master'),
        'joe': albums_info_base.get('joe_arroyo_la_verdad'),
        'thriller': albums_info_base.get('michael_jackson_thriller'),
        'lonely': albums_info_base.get('the_beatles_sgt_pepper'),
        'destruction': albums_info_base.get('guns_n_roses_appetite'),
        'music': albums_info_base.get('playboi_carti_music'),
        'suavemente': albums_info_base.get('elvis_crespo_suavemente'),
        'eminem_show': albums_info_base.get('eminem_the_eminem_show'),
        'nirvana_in_utero': albums_info_base.get('nirvana_in_utero'),
        # Si tenías un mapeo para 'daddy_yankee_prestige' antes, asegúrate que ahora apunte a 'daddy_yankee_barrio' si es necesario, o elimínalo si 'daddy_yankee_prestige' ya no se usa.
    })

    # 2) Carga (o inicializa) tu carrito
    cart = request.session.get('cart', [])

    # 2a) Si llega ?remove=<índice>, lo eliminamos
    remove_index_str = request.GET.get('remove')
    if remove_index_str is not None:
        try:
            idx = int(remove_index_str)
            if 0 <= idx < len(cart):
                cart.pop(idx)
                request.session['cart'] = cart
                messages.success(request, "Álbum eliminado del carrito.")
            else:
                messages.error(request, "Índice de eliminación inválido.")
        except ValueError:
            messages.error(request, "Error al procesar la eliminación.")
        return redirect('com_carrito') # Redirigir siempre después de una acción POST/GET que modifica datos

    # 3) Si llega ?album=<clave>, añádelo
    album_key_to_add = request.GET.get('album')
    if album_key_to_add: # Solo procesar si 'album' está en GET
        album_data_to_add = albums_info.get(album_key_to_add)
        if album_data_to_add:
            cart.append(album_data_to_add)
            request.session['cart'] = cart
            messages.success(request, f"'{album_data_to_add['title']}' añadido al carrito.")

            # 2a) Si viene &checkout=true, enviar a checkout directo
            if request.GET.get('checkout') == 'true': # Corregido 'com_checkout' a 'checkout'
                return redirect('com_checkout')

            # 2b) sino, volver a la vista de carrito (o a la página anterior si es más conveniente)
            # Para evitar añadir el mismo ítem múltiples veces si el usuario refresca la URL con ?album=...
            # es mejor redirigir a la URL limpia del carrito.
            return redirect('com_carrito')

    # 4) Si no hubo 'album' en GET para añadir, o después de una acción de eliminación, renderiza normalmente
    total = sum(item['price'] for item in cart)
    return render(request, 'paginas/comprador/com_carrito.html', {
        'cart_items': cart,
        'total': total
    })
  
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

    # Inicializar formularios para la solicitud GET y para el contexto si el POST falla
    user_form = UserUpdateForm(instance=user)
    cliente_form = ClienteUpdateForm(instance=cliente_instance)
    # Siempre inicializa password_form para el contexto, incluso si no hay intento de cambio.
    # Se vinculará con datos POST solo si hay un intento.
    password_form = PasswordChangeForm(user=user)

    if request.method == 'POST':
        user_form = UserUpdateForm(request.POST, instance=user)
        # Incluir request.FILES para el campo de imagen (foto_perfil)
        cliente_form = ClienteUpdateForm(request.POST, request.FILES, instance=cliente_instance)

        # Determinar si hubo un intento de cambiar la contraseña
        # Es un intento si alguno de los campos de contraseña tiene algún valor
        intent_to_change_password = bool(
            request.POST.get('old_password') or \
            request.POST.get('new_password1') or \
            request.POST.get('new_password2')
        )

        if intent_to_change_password:
            # Vincular password_form con los datos del POST solo si hay intención
            password_form = PasswordChangeForm(user=user, data=request.POST)

        # Construir lista de formularios a validar
        forms_to_validate = [user_form, cliente_form]
        if intent_to_change_password:
            forms_to_validate.append(password_form)

        all_forms_are_valid = all(f.is_valid() for f in forms_to_validate)

        if all_forms_are_valid:
            user_form.save()
            
            # Antes de guardar cliente_form, verificamos si se debe eliminar la foto.
            # Accedemos a cliente_form.instance, que es la instancia que el formulario
            # está a punto de guardar.
            if cliente_form.cleaned_data.get('_delete_profile_photo'):
                # Si la bandera es True, establecemos el campo foto_perfil de la instancia del formulario a None.
                # El método save() personalizado del modelo Cliente se encargará de borrar el archivo físico.
                cliente_form.instance.foto_perfil = None

            cliente_form.save() # Guarda el cliente_form (incluyendo la posible nueva foto o ninguna)

            if intent_to_change_password: # password_form ya fue validado y es válido
                # Solo guardar el formulario de contraseña si fue válido Y se intentó cambiar
                password_form.save()
                update_session_auth_hash(request, password_form.user)
                messages.success(request, '¡Tu perfil y contraseña han sido actualizados exitosamente!')
            else: # No hubo intento de cambiar contraseña, y user_form/cliente_form fueron válidos
                messages.success(request, '¡Tu perfil ha sido actualizado exitosamente!')

            return redirect('com_perfil')
        else:
            # Si algún formulario no es válido, los errores se mostrarán.
            # password_form (vinculado si hubo intento) se pasará al contexto con sus errores.
            messages.error(request, 'Por favor, corrige los errores señalados en el formulario.')
    # Para GET request, los formularios ya están inicializados arriba (user_form, cliente_form no vinculados, password_form no vinculado)

    context = {
        'user_form': user_form,
        'cliente_form': cliente_form,
        'password_form': password_form,
        'titulo_pagina': 'Editar Mi Perfil',
        'cliente_instance': cliente_instance
    }
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
@login_required # Solo requiere que el usuario esté autenticado
def ven_bad(request):
    return render(request, 'paginas/vendedor/vinilos/ven_bad.html')

@login_required # Solo requiere que el usuario esté autenticado
def ven_crear(request):
    artista_form_modal = ArtistaForm()
    productor_form_modal = ProductorForm()
    genero_form_modal = GeneroForm()
    cancion_form_modal = CancionForm()
    canciones = Cancion.objects.all()

    if request.method == 'POST':
        producto_form = ProductoForm(request.POST, request.FILES)

        if producto_form.is_valid():
            producto = producto_form.save(commit=False)

            if request.user.is_authenticated:
                producto.vendedor = request.user  # Ajusta si tienes modelo VendedorProfile

            producto.save()
            producto_form.save_m2m()  # Guarda relaciones ManyToMany

            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({
                    'success': True,
                    'redirect_url': reverse('ven_producto')
                })
            else:
                messages.success(request, f"Producto '{producto.nombre}' creado exitosamente.")
                return redirect('ven_producto')

        else:
            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                form_html = render_to_string(
                    'vendedor/ven_crear_formulario.html',
                    {
                        'producto_form': producto_form,
                        'canciones': canciones,
                    },
                    request=request
                )
                return JsonResponse({'success': False, 'form_html': form_html})
            else:
                messages.error(request, "Por favor, corrige los errores en el formulario del producto.")

    else:
        producto_form = ProductoForm()

    context = {
        'producto_form': producto_form,
        'artista_form_modal': artista_form_modal,
        'productor_form_modal': productor_form_modal,
        'genero_form_modal': genero_form_modal,
        'cancion_form_modal': cancion_form_modal,
        'canciones': canciones,
        'titulo_pagina': 'Crear Nuevo Contenido Musical',
    }
    return render(request, 'paginas/vendedor/ven_crear.html', context)

@login_required # Solo requiere que el usuario esté autenticado
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
@login_required # Solo requiere que el usuario esté autenticado
def ven_perfil_editar(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)
    
    # Inicializar formularios para la solicitud GET y para el contexto si el POST falla
    user_form = UserUpdateForm(instance=user)
    cliente_form = ClienteUpdateForm(instance=cliente_instance)
    password_form = PasswordChangeForm(user=user) # No vinculado inicialmente

    if request.method == 'POST':
        user_form = UserUpdateForm(request.POST, instance=user)
        cliente_form = ClienteUpdateForm(request.POST, request.FILES, instance=cliente_instance)
        
        intent_to_change_password = bool(
            request.POST.get('old_password') or \
            request.POST.get('new_password1') or \
            request.POST.get('new_password2')
        )

        forms_to_validate = [user_form, cliente_form]
        if intent_to_change_password:
            password_form = PasswordChangeForm(user=user, data=request.POST) # Vincular si hay intento
            forms_to_validate.append(password_form)
        
        all_forms_are_valid = all(f.is_valid() for f in forms_to_validate)

        if all_forms_are_valid:
            user_form.save()
            
            # Antes de guardar cliente_form, verificamos si se debe eliminar la foto.
            if cliente_form.cleaned_data.get('_delete_profile_photo'):
                # Si la bandera es True, establecemos el campo foto_perfil de la instancia del formulario a None.
                cliente_form.instance.foto_perfil = None
                
            cliente_form.save()
            
            # Este bloque if/else para los mensajes y el guardado de contraseña
            # debe estar DENTRO del if all_forms_are_valid:
            if intent_to_change_password:
                password_form.save() # Ya está validado
                update_session_auth_hash(request, password_form.user)
                messages.success(request, '¡Tu perfil y contraseña han sido actualizados exitosamente!')
            else: # Solo perfil actualizado, sin intento de cambiar contraseña
                messages.success(request, '¡Tu perfil ha sido actualizado exitosamente!')
            return redirect('ven_perfil') # La redirección ocurre solo si todo fue válido y guardado
        # El siguiente else corresponde al if all_forms_are_valid:

        else: # Si algún formulario no es válido
            messages.error(request, 'Por favor corrige los errores señalados en el formulario.')
    
    # Para GET request, los formularios ya están inicializados arriba

    context = {
        'user_form': user_form,
        'cliente_form': cliente_form,
        'password_form': password_form, # Pasará la instancia correcta (vinculada con errores o no vinculada)
        'titulo_pagina': 'Editar Perfil de Vendedor', # Ajustado el título
        'cliente_instance': cliente_instance
    }
    return render(request, 'paginas/vendedor/ven_perfil_editar.html', context)

@login_required # Solo requiere que el usuario esté autenticado
def ven_producto(request):
    return render(request, 'paginas/vendedor/ven_producto.html')

@login_required # Solo requiere que el usuario esté autenticado
def ven_nosotros(request):
    return render(request, 'paginas/vendedor/ven_nosotros.html')

@login_required # Solo requiere que el usuario esté autenticado
def ven_terminos(request):
    return render(request, 'paginas/vendedor/ven_terminos.html')


# VISTAS DE LA CARPETA "ADMINISTRADOR"
@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_administrador(request):
    now_local = timezone.localtime()
    today_start = now_local.replace(hour=0, minute=0, second=0, microsecond=0)
    today_end = today_start + timedelta(days=1)

    usuarios_hoy = User.objects.filter(
        date_joined__gte=today_start,
        date_joined__lt=today_end
    ).count()

    return render(request, 'paginas/Administrador/admin_administrador.html', {
        'usuarios_hoy': usuarios_hoy
    })

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
    usuarios_bloqueados = User.objects.filter(cliente__isnull=False, is_active=False)
    return render(request, 'paginas/administrador/admin_bloq_users.html', {
        'usuarios': usuarios_bloqueados
    })

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_generos(request):
  return render(request, 'paginas/administrador/admin_generos.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_gestion_users(request):
    usuarios = User.objects.filter(cliente__isnull=False, is_active=True)  # Solo clientes activos
    return render(request, 'paginas/administrador/admin_gestion_users.html', {'usuarios': usuarios})

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_ver_perfil_usuario(request, user_id):
    usuario = get_object_or_404(User, id=user_id)
    cliente = getattr(usuario, 'cliente', None)
    return render(request, 'paginas/administrador/admin_ver_perfil_usuario.html', {
        'usuario': usuario,
        'cliente': cliente,
    })

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_user_edit(request, user_id):
    usuario = get_object_or_404(User, pk=user_id, cliente__isnull=False)
    cliente = usuario.cliente

    if request.method == 'POST':
        user_form = UserEditForm(request.POST, instance=usuario)
        cliente_form = ClienteEditForm(request.POST, request.FILES, instance=cliente)

        if user_form.is_valid() and cliente_form.is_valid():
            user_form.save()
            cliente_form.save()
            messages.success(request, "Perfil actualizado con éxito ✅")
            return redirect('admin_ver_perfil_usuario', user_id=usuario.id)
    else:
        user_form = UserEditForm(instance=usuario)
        cliente_form = ClienteEditForm(instance=cliente)

    return render(request, 'paginas/administrador/admin_user_edit.html', {
        'user_form': user_form,
        'cliente_form': cliente_form,
        'usuario': usuario
    })


@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_eliminar_usuario(request, usuario_id):
    if request.method == 'POST':
        usuario = get_object_or_404(User, id=usuario_id)
        nombre = f"{usuario.first_name} {usuario.last_name}"
        usuario.delete()
        messages.success(request, f"El usuario {nombre} fue eliminado exitosamente.")
        return redirect('admin_gestion_users')  # Cambia esto por la vista real donde muestras los usuarios
    else:
        messages.error(request, "Acceso no permitido.")
        return redirect('admin_gestion_users')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_bloquear_usuario(request, usuario_id):
    if request.method == 'POST':
        user = get_object_or_404(User, id=usuario_id)
        user.is_active = not user.is_active  # invierte estado
        user.save()

        estado = "desbloqueado" if user.is_active else "bloqueado"
        # Usamos `get_full_name() or user.username` para tener un fallback si el nombre no está completo.
        messages.success(request, f"El usuario {user.get_full_name() or user.username} ha sido {estado} correctamente.")
        # CORRECCIÓN: El argumento en la URL se llama 'user_id', no 'usuario_id'.
        return redirect('admin_ver_perfil_usuario', user_id=usuario_id)
    
    messages.error(request, "Acción no permitida.")
    # CORRECCIÓN: También se debe corregir el argumento aquí.
    return redirect('admin_gestion_users', user_id=usuario_id)


@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_new_users(request):
    now_local = timezone.localtime()
    today_start = now_local.replace(hour=0, minute=0, second=0, microsecond=0)
    today_end = today_start + timedelta(days=1)
    usuarios = User.objects.filter(
        date_joined__gte=today_start,
        date_joined__lt=today_end
    ).select_related('cliente')
    return render(request, 'paginas/Administrador/admin_new_users.html', {
        'usuarios': usuarios
    })

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
  return render(request, 'paginas/administrador/admin_mas_vendidos.html')


# VISTAS DE VINILOS, SUBCARPETA DE ADMINISTRADOR
@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def bts(request):
  return render(request, 'paginas/administrador/ventas/bts.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def carti_music(request):
    return render(request, 'paginas/administrador/ventas/carti_music.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def eminem_show(request):
  return render(request, 'paginas/administrador/ventas/eminem_show.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def exitos_joe(request):
    return render(request, 'paginas/administrador/ventas/exitos_joe.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def gnr_appetite(request):
    return render(request, 'paginas/administrador/ventas/gnr_appetite.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def master(request):
    return render(request, 'paginas/administrador/ventas/master.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def mj_bad(request):
  return render(request, 'paginas/administrador/ventas/mj_bad.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def mj_thriller(request):
    return render(request, 'paginas/administrador/ventas/mj_thriller.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def nirvana(request):
  return render(request, 'paginas/administrador/ventas/nirvana.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def the_beatles(request):
  return render(request, 'paginas/administrador/ventas/the_beatles.html')


# VISTAS DE LOS USUARIOS
@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def laura_g(request):
  return render(request, 'paginas/administrador/usuarios/laura_g.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def carlos_r(request):
  return render(request, 'paginas/administrador/usuarios/carlos_r.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def camila_q(request):
  return render(request, 'paginas/administrador/usuarios/camila_q.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def john_m(request):
  return render(request, 'paginas/administrador/usuarios/john_m.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def alex_r(request):
  return render(request, 'paginas/administrador/usuarios/alex_r.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def andrea_villalobos(request):
  return render(request, 'paginas/administrador/usuarios/andrea_villalobos.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def benjamin_castro(request):
  return render(request, 'paginas/administrador/usuarios/benjamin_castro.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def cristian_dominguez(request):
  return render(request, 'paginas/administrador/usuarios/cristian_dominguez.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def angela_torres(request):
  return render(request, 'paginas/administrador/usuarios/angela_torres.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def elisa_naranjo(request):
  return render(request, 'paginas/administrador/usuarios/elisa_naranjo.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def emilio_torres(request):
  return render(request, 'paginas/administrador/usuarios/emilio_torres.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def andrea_villalobos_2(request):
  return render(request, 'paginas/administrador/usuarios/andrea_villalobos_2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def benjamin_castro_2(request):
  return render(request, 'paginas/administrador/usuarios/benjamin_castro_2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def cristian_dominguez_2(request):
  return render(request, 'paginas/administrador/usuarios/cristian_dominguez_2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def angela_torres_2(request):
  return render(request, 'paginas/administrador/usuarios/angela_torres_2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def elisa_naranjo_2(request):
  return render(request, 'paginas/administrador/usuarios/elisa_naranjo_2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def emilio_torres_2(request):
  return render(request, 'paginas/administrador/usuarios/emilio_torres_2.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def sofia_ramirez(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/sofia_ramirez.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def esperanza_barrera(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/esperanza_barrera.html')

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def fernando_molina(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/fernando_molina.html')


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