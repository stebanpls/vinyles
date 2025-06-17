from django.shortcuts import render, redirect
from django.urls import reverse
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth import update_session_auth_hash
from django.template.loader import render_to_string
from .models import Crud, Cliente, Genero, Producto, Artista, Productor, Cancion
from .forms import (
    CrudForm, UserRegistrationForm, UserUpdateForm, ClienteUpdateForm, LoginForm,
    ProductoForm, CancionForm, ArtistaForm, GeneroForm, ProductorForm
)
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.contrib.auth.models import User
from django.contrib import messages

# Vistas para los modales de creación
def artista_form_modal(request):
    if request.method == "POST":
        form = ArtistaForm(request.POST, request.FILES)
        if form.is_valid():
            artista = form.save()
            return JsonResponse({
                'success': True,
                'id': artista.id,
                'nombre': str(artista)
            })
        else:
            form_html = render_to_string('modales/modal_artista.html', {'form': form}, request=request)
            return JsonResponse({'success': False, 'form_html': form_html})
    else:
        form = ArtistaForm()
    return render(request, 'modales/modal_artista.html', {'form': form})

def modal_genero(request):
    if request.method == "POST":
        form = GeneroForm(request.POST)
        if form.is_valid():
            genero = form.save()
            return JsonResponse({
                'success': True,
                'id': genero.id,
                'nombre': str(genero)
            })
        else:
            form_html = render_to_string('modales/modal_genero.html', {'form': form}, request=request)
            return JsonResponse({'success': False, 'form_html': form_html})
    else:
        form = GeneroForm()
    return render(request, 'modales/modal_genero.html', {'form': form})

def modal_productor(request):
    if request.method == "POST":
        form = ProductorForm(request.POST)
        if form.is_valid():
            productor = form.save()
            return JsonResponse({
                'success': True,
                'id': productor.id,
                'nombre': str(productor)
            })
        else:
            form_html = render_to_string('modales/modal_productor.html', {'form': form}, request=request)
            return JsonResponse({'success': False, 'form_html': form_html})
    else:
        form = ProductorForm()
    return render(request, 'modales/modal_productor.html', {'form': form})

def modal_cancion(request):
    if request.method == "POST":
        form = CancionForm(request.POST)
        if form.is_valid():
            cancion = form.save()
            return JsonResponse({'success': True, 'id': cancion.id, 'nombre': str(cancion)})
        else:
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
    album_name_get = request.GET.get('album_name')
    artist_get = request.GET.get('artist')
    price_get = request.GET.get('price')
    image_get = request.GET.get('image')
    next_url = request.GET.get('next') or request.POST.get('next')

    if request.user.is_authenticated:
        if request.user.is_staff or request.user.is_superuser:
            return redirect(next_url or 'admin_administrador')
        else:
            return redirect(next_url or 'com_inicio')

    form = LoginForm() 

    if request.method == 'POST':
        form = LoginForm(request.POST) 
        album_name_get = request.POST.get('album_name', album_name_get)
        artist_get = request.POST.get('artist', artist_get)
        price_get = request.POST.get('price', price_get)
        image_get = request.POST.get('image', image_get)
        
        if form.is_valid():
            identifier = form.cleaned_data['login_identifier']
            password = form.cleaned_data['password']
            specific_auth_error_occurred = False
            user = authenticate(request, username=identifier, password=password)

            if user is None:
                try:
                    user_by_email = User.objects.get(email__iexact=identifier)
                    user = authenticate(request, username=user_by_email.username, password=password)
                except User.DoesNotExist:
                    pass
                except User.MultipleObjectsReturned:
                    messages.error(request, "Múltiples cuentas están asociadas con este correo electrónico. Por favor, contacte a soporte.")
                    specific_auth_error_occurred = True
            
            if user is not None:
                auth_login(request, user)
                messages.success(request, f"¡Bienvenido de nuevo, {user.username}!")
                if next_url:
                    return redirect(next_url)
                default_redirect_url_name = 'admin_administrador' if user.is_staff or user.is_superuser else 'com_inicio'
                return redirect(default_redirect_url_name)
            else:
                if not specific_auth_error_occurred:
                    messages.error(request, "El nombre de usuario/email o la contraseña son incorrectos. Por favor, inténtalo de nuevo.")
    
    context = {
        'form': form,
        'album_name_get': album_name_get,
        'artist_get': artist_get,
        'price_get': price_get,
        'image_get': image_get,
        'next_url': next_url,
    }
    return render(request, 'paginas/publico/pub_login.html', context)

def pub_log_out(request):
    messages.info(request, "Has cerrado sesión exitosamente. ¡Hasta luego!")
    return render(request, 'paginas/publico/pub_log_out.html')

def pub_nosotros(request):
  return render(request, 'paginas/publico/pub_nosotros.html')

def pub_registro(request):
    if request.user.is_authenticated:
        messages.info(request, 'Ya has iniciado sesión. Si deseas registrar una nueva cuenta, por favor cierra tu sesión actual primero.')
        if hasattr(request.user, 'is_staff') and request.user.is_staff:
            return redirect('admin_administrador')
        else:
            return redirect('com_inicio')

    if request.method == 'POST':
        user_form = UserRegistrationForm(request.POST)
        if user_form.is_valid():
            new_user = user_form.save(commit=False)
            new_user.set_password(user_form.cleaned_data['password'])
            new_user.save()
            messages.success(request, '¡Registro exitoso! Ahora puedes iniciar sesión.')
            return redirect('pub_login')
        else:
            messages.error(request, 'Por favor corrige los errores presentados en el formulario.')
    else:
        user_form = UserRegistrationForm()
    return render(request, 'paginas/publico/pub_registro.html', {'user_form': user_form})

def pub_reembolsos(request):
  return render(request, 'paginas/publico/pub_reembolsos.html')

# Esta vista renderiza la plantilla que también usa PasswordResetConfirmView.
# Se mantiene porque tienes una URL directa a ella en gestion/urls.py.
def pub_restablecer_contrasena(request):
  return render(request, 'paginas/publico/pub_restablecer_contrasena.html')

def pub_soporte(request):
  return render(request, 'paginas/publico/pub_soporte.html')

def pub_terminos(request):
  return render(request, 'paginas/publico/pub_terminos.html')

def pub_vinilo(request):
    album_key = request.GET.get('album', '')
    albums_info = {
        'michael_jackson_bad': {'key': 'michael_jackson_bad', 'title': 'Bad', 'artist': 'Michael Jackson', 'price': 105000, 'genre': 'Pop', 'release_date': '31 de agosto de 1987', 'label': 'Epic Records', 'producers': 'Michael Jackson, Quincy Jones', 'artist_info': ('Michael Jackson fue un cantante, compositor y bailarín estadounidense apodado el "Rey del Pop". Es considerado uno de los artistas más importantes e influyentes del siglo XX.'), 'image': 'images/albumes/michael_jackson_bad.jpg', 'audio': 'audio/bad.mp3', 'song_list': ['Bad', 'The Way You Make Me Feel', 'Speed Demon', 'Liberian Girl', 'Just Good Friends (con Stevie Wonder)', 'Another Part of Me', 'Man in the Mirror', 'I Just Can\'t Stop Loving You (con Siedah Garrett)', 'Dirty Diana', 'Smooth Criminal', 'Leave Me Alone'], 'comments': [{'username': 'musicLover', 'comment': 'Un álbum icónico con ritmos pegadizos y la energía inigualable de Michael!'}, {'username': 'popFanatic', 'comment': 'Cada canción es un hit, la producción es impecable.'}]},
        'metallica_master': {'key': 'metallica_master', 'title': 'Master of Puppets', 'artist': 'Metallica', 'price': 105000, 'genre': 'Thrash Metal', 'release_date': '3 de marzo de 1986', 'label': 'Elektra Records', 'producers': 'Flemming Rasmussen, Metallica', 'artist_info': ('Metallica es una banda estadounidense de heavy metal formada en 1981. Es una de las bandas más influyentes y exitosas en la historia del metal.'), 'image': 'images/albumes/metallica_master.jpg', 'audio': 'audio/master.mp3', 'song_list': ['Battery', 'Master of Puppets', 'The Thing That Should Not Be', 'Welcome Home (Sanitarium)', 'Disposable Heroes', 'Leper Messiah', 'Orion', 'Damage, Inc.'], 'comments': [{'username': 'metalHead', 'comment': 'Una obra maestra del thrash metal, cada riff es легендарный!'}, {'username': 'guitarHero', 'comment': 'La composición y la ejecución instrumental son de otro nivel.'}]},
        'joe_arroyo_la_verdad': {'key': 'joe_arroyo_la_verdad', 'title': 'La Verdad de Joe Arroyo: el Original', 'artist': 'Joe Arroyo', 'price': 80000, 'genre': 'Salsa, Cumbia', 'release_date': 'Recopilación de varios lanzamientos', 'label': 'Discos Fuentes', 'producers': 'Varios productores a lo largo de su carrera', 'artist_info': ('Álvaro José Arroyo González, conocido como Joe Arroyo, fue un cantautor colombiano, considerado uno de los más grandes exponentes de la música caribeña en su país.'), 'image': 'images/albumes/joe_arroyo_la_verdad.jpg', 'audio': 'audio/joe.mp3', 'song_list': ['Rebelión', 'La Noche', 'Tania', 'El Centurión de la Noche', 'Yamulemau', 'Te Quiero Más', 'En Barranquilla Me Quedo', 'Mary', 'Sobreviviré', 'A Mi Pueblo'], 'comments': [{'username': 'salsaQueen', 'comment': '¡Un verdadero legado de la salsa colombiana, imposible no bailar!'}, {'username': 'caribeSoul', 'comment': 'La voz y el sabor de Joe Arroyo son únicos e inigualables.'}]},
        'michael_jackson_thriller': {'key': 'michael_jackson_thriller', 'title': 'Thriller', 'artist': 'Michael Jackson', 'price': 110000, 'genre': 'Pop', 'release_date': '30 de noviembre de 1982', 'label': 'Epic Records', 'producers': 'Quincy Jones', 'artist_info': ('Michael Jackson, el "Rey del Pop", revolucionó la música y la cultura popular con su voz, sus bailes y su visión artística innovadora.'), 'image': 'images/albumes/michael_jackson_thriller.jpg', 'audio': 'audio/thriller.mp3', 'song_list': ['Wanna Be Startin\' Somethin\'', 'Baby Be Mine', 'The Girl Is Mine (con Paul McCartney)', 'Thriller', 'Beat It', 'Billie Jean', 'Human Nature', 'P.Y.T. (Pretty Young Thing)', 'The Lady in My Life'], 'comments': [{'username': 'classicPop', 'comment': 'El álbum más vendido de todos los tiempos por una razón, ¡cada canción es perfecta!'}, {'username': 'moonwalker', 'comment': 'Thriller no solo es música, es un evento cultural.'}]},
        'the_beatles_sgt_pepper': {'key': 'the_beatles_sgt_pepper', 'title': 'Sgt. Pepper\'s Lonely Hearts Club Band', 'artist': 'The Beatles', 'price': 95000, 'genre': 'Rock Psicodélico, Pop', 'release_date': '1 de junio de 1967', 'label': 'Parlophone', 'producers': 'George Martin', 'artist_info': ('The Beatles fue una banda británica de rock formada en Liverpool. Considerada la banda más influyente en la historia de la música popular.'), 'image': 'images/albumes/the_beatles_sgt_pepper.jpg', 'audio': 'audio/lonely.mp3', 'song_list': ['Sgt. Pepper\'s Lonely Hearts Club Band', 'With a Little Help from My Friends', 'Lucy in the Sky with Diamonds', 'Getting Better', 'Fixing a Hole', 'She\'s Leaving Home', 'Being for the Benefit of Mr. Kite!', 'Within You Without You', 'When I\'m Sixty-Four', 'Lovely Rita', 'Good Morning Good Morning', 'Sgt. Pepper\'s Lonely Hearts Club Band (Reprise)', 'A Day in the Life'], 'comments': [{'username': 'beatlemania', 'comment': 'Un álbum revolucionario que expandió los límites de la música pop y rock.'}, {'username': 'sixtiesSound', 'comment': 'La creatividad y la experimentación en este álbum son asombrosas.'}]},
        'guns_n_roses_appetite': {'key': 'guns_n_roses_appetite', 'title': 'Appetite for Destruction', 'artist': 'Guns N\' Roses', 'price': 120000, 'genre': 'Hard Rock', 'release_date': '21 de julio de 1987', 'label': 'Geffen Records', 'producers': 'Mike Clink', 'artist_info': ('Guns N\' Roses es una banda estadounidense de hard rock formada en Los Ángeles. Con su sonido crudo y enérgico, se convirtieron en un fenómeno a finales de los 80.'), 'image': 'images/albumes/guns_n_roses_appetite.jpg', 'audio': 'audio/destruction.mp3', 'song_list': ['Welcome to the Jungle', 'It\'s So Easy', 'Nightrain', 'Out ta Get Me', 'Mr. Brownstone', 'Paradise City', 'My Michelle', 'Think About You', 'Sweet Child o\' Mine', 'You\'re Crazy', 'Anything Goes', 'Rocket Queen'], 'comments': [{'username': 'rockNRoll', 'comment': 'Un álbum debut explosivo que revitalizó el hard rock para una nueva generación.'}, {'username': 'axlRoseFan', 'comment': 'La voz de Axl y los riffs de Slash son simplemente legendarios.'}]},
        'playboi_carti_music': {'key': 'playboi_carti_music', 'title': 'Music', 'artist': 'Playboi Carti', 'price': 90000, 'genre': 'Hip Hop, Trap', 'release_date': '14 de marzo de 2025', 'label': 'Opium, Interscope Records', 'producers': 'Ojivolta, Cardo, F1lthy, Bnyx, Maaly Raw, Metro Boomin, TM88, Wheezy, Kanye West, Travis Scott', 'artist_info': ('Playboi Carti es un rapero y compositor estadounidense conocido por su estilo experimental y su influencia en la escena del trap contemporáneo.'), 'image': 'images/albumes/playboi_carti_music.jpg', 'audio': 'audio/music.mp3', 'song_list': ['Pop Out', 'Crush (feat. Travis Scott)', 'K Pop', 'Evil J0rdan', 'Mojo Jojo', 'Philly', 'Radar', 'Rather Lie', 'Fine Shit', 'Backd00r', 'Toxic', 'Munyun', 'Crank', 'Charge Dem Hoes a Fee', 'Good Credit', 'I Seeeeee You Baby Boi', 'Wake Up F1lthy', 'Jumpin', 'Trim', 'Cocaine Nose', 'We Need All Da Vibes', 'Olympian', 'Opm Babi', 'Twin Trim', 'Like Weezy', 'Dis 1 Got It', 'Walk', 'HBA', 'Overly', 'South Atlanta Baby'], 'comments': [{'username': 'trapLord', 'comment': 'El sonido vanguardista de Carti sigue evolucionando, este álbum es otro viaje.'}, {'username': 'opiumGang', 'comment': 'La producción es de otro nivel, Carti siempre innovando.'}]},
        'elvis_crespo_suavemente': {'key': 'elvis_crespo_suavemente', 'title': 'Suavemente', 'artist': 'Elvis Crespo', 'price': 50000, 'genre': 'Merengue', 'release_date': '1998', 'label': 'Sony Discos', 'producers': 'Elvis Crespo, Roberto Cora', 'artist_info': 'Elvis Crespo es un cantante puertorriqueño-estadounidense de merengue, conocido por su éxito mundial "Suavemente".', 'image': 'images/albumes/elvis_crespo_suavemente.jpg', 'audio': 'audio/suavemente.mp3', 'song_list': ['Suavemente', 'Tu Sonrisa', 'Luna Llena', 'Nuestra Canción', 'Pintame', 'Me Arrepiento', 'Te Vas', 'Para Darte Mi Vida', 'Lloré, Lloré', 'Por el Caminito'], 'comments': [{'username': 'merenguero', 'comment': '¡Un clásico del merengue que nunca falla en una fiesta!'}]},
        'eminem_the_eminem_show': {'key': 'eminem_the_eminem_show', 'title': 'The Eminem Show', 'artist': 'Eminem', 'price': 95000, 'genre': 'Hip Hop', 'release_date': '26 de mayo de 2002', 'label': 'Shady, Aftermath, Interscope', 'producers': 'Dr. Dre, Eminem, Jeff Bass', 'artist_info': 'Eminem es un rapero, compositor y productor discográfico estadounidense, considerado uno de los artistas de hip hop más influyentes y exitosos.', 'image': 'images/albumes/eminem_the_eminem_show.jpg', 'audio': 'audio/the_eminem_show.mp3', 'song_list': ['Curtains Up (Skit)', 'White America', 'Business', 'Cleanin\' Out My Closet', 'Square Dance', 'The Kiss (Skit)', 'Soldier', 'Say Goodbye Hollywood', 'Drips', 'Without Me', 'Paul Rosenberg (Skit)', 'Sing for the Moment', 'Superman', 'Hailie\'s Song', 'Steve Berman (Skit)', 'When the Music Stops', '\'Till I Collapse', 'My Dad\'s Gone Crazy', 'Curtains Close (Skit)'], 'comments': [{'username': 'slimShadyFan', 'comment': 'Uno de los mejores álbumes de Eminem, letras crudas y producción increíble.'}]},
        'nirvana_in_utero': {'key': 'nirvana_in_utero', 'title': 'In Utero', 'artist': 'Nirvana', 'price': 120000, 'genre': 'Grunge, Rock Alternativo', 'release_date': '13 de septiembre de 1993', 'label': 'DGC Records', 'producers': 'Steve Albini', 'artist_info': 'Nirvana fue una banda de rock estadounidense formada en Aberdeen, Washington, en 1987. Liderada por Kurt Cobain, se convirtió en un ícono del movimiento grunge.', 'image': 'images/albumes/nirvana_in_utero.jpg', 'audio': 'audio/in_utero.mp3', 'song_list': ['Serve the Servants', 'Scentless Apprentice', 'Heart-Shaped Box', 'Rape Me', 'Frances Farmer Will Have Her Revenge on Seattle', 'Dumb', 'Very Ape', 'Milk It', 'Pennyroyal Tea', 'Radio Friendly Unit Shifter', 'Tourette\'s', 'All Apologies'], 'comments': [{'username': 'grungeForever', 'comment': 'Un álbum crudo y poderoso, la esencia de Nirvana.'}]},
        'aespa_whiplash': {'key': 'aespa_whiplash', 'title': 'Whiplash', 'artist': 'Aespa', 'price': 130000, 'genre': 'K-pop, Hyperpop', 'release_date': '2024', 'label': 'SM Entertainment', 'producers': 'Productores de Aespa', 'artist_info': 'Aespa es un grupo femenino surcoreano formado por SM Entertainment, conocido por su concepto de metaverso y su música innovadora.', 'image': 'images/albumes/aespa_whiplash.jpg', 'audio': 'audio/whiplash.mp3', 'song_list': ['Whiplash', 'Just Another Girl', 'Flowers','Pink Hoodie', 'Kill it', 'Flights, Not Feelings'], 'comments': [{'username': 'MYaespa', 'comment': '¡Aespa siempre sorprendiendo con su sonido único!'}]},
        'daddy_yankee_barrio': {'key': 'daddy_yankee_barrio', 'title': 'Barrio Fino (Deluxe Version)', 'artist': 'Daddy Yankee', 'price': 150000, 'genre': 'Reggaetón', 'release_date': '13 de julio de 2004', 'label': 'El Cartel Records, VI Music', 'producers': 'Luny Tunes, DJ Nelson, Monserrate & DJ Urba, Nely "El Arma Secreta", Naldo, Echo, Diesel', 'artist_info': 'Daddy Yankee es un cantante, rapero, compositor y productor discográfico puertorriqueño, apodado el "Rey del Reguetón". "Barrio Fino" es uno de sus álbumes más icónicos.', 'image': 'images/albumes/daddy_yankee_barrio.jpg', 'audio': 'audio/barrio_fino.mp3', 'song_list': ['Intro', 'King Daddy', 'Gasolina', 'Lo Que Pasó, Pasó', 'No Me Dejes Solo (feat. Wisin & Yandel)', 'Salud y Vida', 'Corazones', 'Tu Príncipe (feat. Zion & Lennox)', 'Cuéntame', 'Santifica Tus Escapularios', 'Sabor A Melao (feat. Andy Montañez)', 'El Muro', 'Dale Caliente', 'El Empuje', '¿Qué Vas A Hacer? (feat. May-Be)', 'Intermedio "Gavilan"', 'ElCangri.com', 'Golpe De Estado (feat. Tommy Viera)', '2 Mujeres', 'Saber Su Nombre', 'Outro'], 'comments': [{'username': 'reggaetoneroFull', 'comment': '¡El álbum que definió el reggaetón! Puros clásicos.'}]},
        'the_beatles_abbey_road': {'key': 'the_beatles_abbey_road', 'title': 'Abbey Road', 'artist': 'The Beatles', 'price': 135000, 'genre': 'Rock', 'release_date': '26 de septiembre de 1969', 'label': 'Apple Records', 'producers': 'George Martin', 'artist_info': 'The Beatles, una de las bandas más influyentes de todos los tiempos, conocidos por su innovación musical y su impacto cultural.', 'image': 'images/albumes/the_beatles_abbey.jpg', 'audio': 'audio/abbey_road.mp3', 'song_list': ['Come Together', 'Something', 'Maxwell\'s Silver Hammer', 'Oh! Darling', 'Octopus\'s Garden', 'I Want You (She\'s So Heavy)', 'Here Comes the Sun', 'Because', 'You Never Give Me Your Money', 'Sun King', 'Mean Mr. Mustard', 'Polythene Pam', 'She Came In Through the Bathroom Window', 'Golden Slumbers', 'Carry That Weight', 'The End', 'Her Majesty'], 'comments': [{'username': 'classicRockFan', 'comment': 'Una obra maestra atemporal, la despedida perfecta.'}]},
        'bts_love_yourself': {'key': 'bts_love_yourself', 'title': 'Love Yourself: Answer', 'artist': 'BTS', 'price': 105000, 'genre': 'K-pop, Pop', 'release_date': '24 de agosto de 2018', 'label': 'Big Hit Entertainment', 'producers': 'Pdogg, Slow Rabbit, Supreme Boi, y otros', 'artist_info': 'BTS es un grupo surcoreano que ha alcanzado fama mundial, conocido por su música significativa y sus poderosas actuaciones.', 'image': 'images/albumes/bts_love.jpg', 'audio': 'audio/love_yourself.mp3', 'song_list': ['Euphoria', 'Trivia 起: Just Dance', 'Serendipity (Full Length Edition)', 'DNA', 'Dimple', 'Trivia 承: Love', 'Her', 'Singularity', 'FAKE LOVE', 'The Truth Untold (feat. Steve Aoki)', 'Trivia 轉: Seesaw', 'Tear', 'Epiphany', 'I\'m Fine', 'IDOL', 'Answer: Love Myself', 'Magic Shop', 'Best of Me', 'Airplane Pt.2', 'Go Go', 'Anpanman', 'MIC Drop', 'DNA (Pedal 2 LA Mix)', 'FAKE LOVE (Rocking Vibe Mix)', 'MIC Drop (Steve Aoki Remix) (Full Length Edition)'], 'comments': [{'username': 'ARMYforever', 'comment': 'Un álbum lleno de mensajes hermosos y música increíble. ¡BTS los mejores!'}]},
        'frank_sinatra_the_world': {'key': 'frank_sinatra_the_world', 'title': 'The World We Knew', 'artist': 'Frank Sinatra', 'price': 140000, 'genre': 'Traditional Pop, Jazz', 'release_date': 'Septiembre de 1967', 'label': 'Reprise Records', 'producers': 'Jimmy Bowen, Ernie Freeman', 'artist_info': 'Frank Sinatra, apodado "La Voz", fue uno de los cantantes más populares e influyentes del siglo XX, conocido por su estilo impecable y su carisma.', 'image': 'images/albumes/frank_sinatra_the_world.jpg', 'audio': 'audio/the_world_we_knew.mp3', 'song_list': ['The World We Knew (Over and Over)', 'Somethin\' Stupid (con Nancy Sinatra)', 'This Is My Love', 'Born Free', 'Don\'t Sleep in the Subway', 'This Town', 'This Is My Song', 'You Are There', 'Drinking Again', 'Some Enchanted Evening'], 'comments': [{'username': 'croonerFan', 'comment': 'La voz de Sinatra es simplemente mágica. Un álbum encantador.'}]}
    }
    album_data = albums_info.get(album_key, {
        'key': 'unknown', 'title': 'Álbum Desconocido', 'artist': '', 'price': 0, 'genre': '', 'release_date': '', 'label': '', 'producers': '', 'artist_info': '', 'image': 'images/default.jpg', 'audio': '', 'song_list': [], 'comments': []
    })
    context = {'album_data': album_data}
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
    })
    cart = request.session.get('cart', [])
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
        return redirect('com_carrito')
    album_key_to_add = request.GET.get('album')
    if album_key_to_add:
        album_data_to_add = albums_info.get(album_key_to_add)
        if album_data_to_add:
            cart.append(album_data_to_add)
            request.session['cart'] = cart
            messages.success(request, f"'{album_data_to_add['title']}' añadido al carrito.")
            if request.GET.get('checkout') == 'true':
                return redirect('com_checkout')
            return redirect('com_carrito')
    total = sum(item['price'] for item in cart)
    return render(request, 'paginas/comprador/com_carrito.html', {'cart_items': cart, 'total': total})
  
@login_required
def com_checkout(request):
    cart = request.session.get('cart', [])
    if not cart:
        return redirect('com_carrito')
    total = sum(item['price'] for item in cart)
    return render(request, 'paginas/comprador/com_checkout.html', {'cart_items': cart, 'total': total})
    
@login_required
def com_nosotros(request):
  return render(request, 'paginas/comprador/com_nosotros.html')

@login_required
def com_perfil(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)
    context = {
        'cliente_instance': cliente_instance,
        'user': user,
        'titulo_pagina': 'Mi Perfil'
    }
    return render(request, 'paginas/comprador/com_perfil.html', context)

@login_required
def com_perfil_editar(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)

    # Inicializar formularios para la solicitud GET y para el contexto si el POST falla
    user_form = UserUpdateForm(instance=user)
    cliente_form = ClienteUpdateForm(instance=cliente_instance)
    password_form = PasswordChangeForm(user=user) 

    if request.method == 'POST':
        user_form = UserUpdateForm(request.POST, instance=user)
        cliente_form = ClienteUpdateForm(request.POST, request.FILES, instance=cliente_instance)

        intent_to_change_password = bool(
            request.POST.get('old_password') or \
            request.POST.get('new_password1') or \
            request.POST.get('new_password2')
        )

        if intent_to_change_password:
            password_form = PasswordChangeForm(user=user, data=request.POST)
        
        forms_to_validate = [user_form, cliente_form]
        if intent_to_change_password:
            forms_to_validate.append(password_form)
        
        all_forms_are_valid = all(f.is_valid() for f in forms_to_validate)

        if all_forms_are_valid:
            user_form.save()
            
            if cliente_form.cleaned_data.get('_delete_profile_photo'):
                if cliente_instance.foto_perfil:
                    cliente_instance.foto_perfil.delete(save=False)
                    cliente_instance.foto_perfil = None
            cliente_form.save()

            if intent_to_change_password:
                password_form.save()
                update_session_auth_hash(request, password_form.user)
                messages.success(request, '¡Tu perfil y contraseña han sido actualizados exitosamente!')
            else:
                messages.success(request, '¡Tu perfil ha sido actualizado exitosamente!')
            return redirect('com_perfil')
        else:
            messages.error(request, 'Por favor, corrige los errores señalados en el formulario.')
    
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

@login_required
def ven_bad(request):
  return render(request, 'paginas/vendedor/vinilos/ven_bad.html')

@login_required
def ven_crear(request):
    if request.method == 'POST':
        producto_form = ProductoForm(request.POST, request.FILES)
        artista_form_modal = ArtistaForm()
        productor_form_modal = ProductorForm()
        genero_form_modal = GeneroForm()
        cancion_form_modal = CancionForm()

        if producto_form.is_valid():
            producto = producto_form.save(commit=False)
            producto.save()
            producto_form.save_m2m()
            messages.success(request, f"Producto '{producto.nombre}' creado exitosamente.")
            return redirect('ven_crear')
        else:
            messages.error(request, "Por favor, corrige los errores en el formulario del producto.")
    else:
        producto_form = ProductoForm()
        artista_form_modal = ArtistaForm()
        productor_form_modal = ProductorForm()
        genero_form_modal = GeneroForm()
        cancion_form_modal = CancionForm()

    context = {
        'producto_form': producto_form,
        'artista_form_modal': artista_form_modal,
        'productor_form_modal': productor_form_modal,
        'genero_form_modal': genero_form_modal,
        'cancion_form_modal': cancion_form_modal,
        'titulo_pagina': 'Crear Nuevo Contenido Musical',
    }
    return render(request, 'paginas/vendedor/ven_crear.html', context)

@login_required
def ven_notificaciones(request):
  return render(request, 'paginas/vendedor/ven_notificaciones.html')

@login_required
def ven_perfil(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)
    context = {
        'cliente_instance': cliente_instance,
        'user': user,
        'titulo_pagina': 'Mi Perfil de Vendedor'
    }
    return render(request, 'paginas/vendedor/ven_perfil.html', context)

@login_required
def ven_perfil_editar(request):
    user = request.user
    cliente_instance, created = Cliente.objects.get_or_create(user=user)

    # Inicializar formularios para la solicitud GET y para el contexto si el POST falla
    user_form = UserUpdateForm(instance=user)
    cliente_form = ClienteUpdateForm(instance=cliente_instance)
    password_form = PasswordChangeForm(user=user)

    if request.method == 'POST':
        user_form = UserUpdateForm(request.POST, instance=user)
        cliente_form = ClienteUpdateForm(request.POST, request.FILES, instance=cliente_instance)
        
        intent_to_change_password = bool(
            request.POST.get('old_password') or \
            request.POST.get('new_password1') or \
            request.POST.get('new_password2')
        )

        if intent_to_change_password:
            password_form = PasswordChangeForm(user=user, data=request.POST)
        
        forms_to_validate = [user_form, cliente_form]
        if intent_to_change_password:
            forms_to_validate.append(password_form)
        
        all_forms_are_valid = all(f.is_valid() for f in forms_to_validate)

        if all_forms_are_valid:
            user_form.save()
            
            if cliente_form.cleaned_data.get('_delete_profile_photo'):
                if cliente_instance.foto_perfil:
                    cliente_instance.foto_perfil.delete(save=False)
                cliente_instance.foto_perfil = None
            cliente_form.save()

            if intent_to_change_password:
                password_form.save()
                update_session_auth_hash(request, password_form.user)
                messages.success(request, '¡Tu perfil y contraseña han sido actualizados exitosamente!')
            else: # Solo perfil actualizado, sin intento de cambiar contraseña
                messages.success(request, '¡Tu perfil ha sido actualizado exitosamente!')
            
            return redirect('ven_perfil')
        else:
            messages.error(request, 'Por favor, corrige los errores señalados en el formulario.')
    
    context = {
        'user_form': user_form,
        'cliente_form': cliente_form,
        'password_form': password_form,
        'titulo_pagina': 'Mi Perfil de Vendedor',
        'cliente_instance': cliente_instance
    }
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

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
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
  return render(request, 'paginas/administrador/admin_generos.html')

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

@login_required
@user_passes_test(lambda u: u.is_staff, login_url='pub_login')
def admin_mas_vendidos(request):
  return render(request, 'paginas/administrador/admin_mas_vendidos.html')

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