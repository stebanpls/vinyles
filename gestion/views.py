from django.shortcuts import render, redirect
# Se importa el reverse para redireccionar a la vista de crud.
from django.urls import reverse
from django.http import HttpResponse
# Se importa los atributos de Crud 
from .models import Crud # Importar el modelo Crud (el cual está en mayúsculas) para poder usarlo en las vistas.
from .forms import CrudForm # Importar el formulario CrudForm para poder usarlo en las vistas.


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
    # Si es POST, se procesa la "autenticación" y se redirige al carrito
    if request.method == 'POST':
        # Recoger datos del formulario, incluidos los campos ocultos con información del álbum
        album_name = request.POST.get('album_name', '')
        artist = request.POST.get('artist', '')
        price = request.POST.get('price', '')
        image = request.POST.get('image', '')
        
        # Simulación: asumimos que la autenticación es correcta.
        # Construimos la URL para redirigir a la vista del carrito.
        carrito_url = reverse('carrito')  # Asegúrate de que en urls.py la vista del carrito tenga nombre 'carrito'
        # Creamos la query string con los datos del álbum
        query_string = f'?album_name={album_name}&artist={artist}&price={price}&image={image}'
        return redirect(carrito_url + query_string)
    
    # Para peticiones GET se muestra el formulario de login
    return render(request, 'paginas/publico/pub_login.html')
  
def pub_login_administrador(request):
  return render(request, 'paginas/publico/pub_login_administrador.html')

def pub_logOut(request):
  return render(request, 'paginas/publico/pub_logOut.html')

def pub_nosotros(request):
  return render(request, 'paginas/publico/pub_nosotros.html') # Se crea un renderizado de este archivo HTML.

def pub_reembolsos(request):
  return render(request, 'paginas/publico/pub_reembolsos.html')

def pub_registro(request):
  return render(request, 'paginas/publico/pub_registro.html')

def pub_restablecer_contrasena(request):
  return render(request, 'paginas/publico/pub_restablecer_contrasena.html')

def pub_restablecer_contrasena_admin(request):
  return render(request, 'paginas/publico/pub_restablecer_contrasena_admin.html')

def pub_soporte(request):
  return render(request, 'paginas/publico/pub_soporte.html')

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
        'song_list': [],
        'comments': []
    })

    context = {
        'album_data': album_data
    }
    return render(request, 'paginas/publico/pub_vinilo.html', context)


# VISTAS DE LA CARPETA "COMPRADOR"
def com_inicio(request):
  return render(request, 'paginas/comprador/com_inicio.html')

def com_albumes(request):
  return render(request, 'paginas/comprador/com_albumes.html')

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
    # views.py
    
def com_nosotros(request):
  return render(request, 'paginas/comprador/com_nosotros.html')

def com_perfil(request):
  return render(request, 'paginas/comprador/com_perfil.html')

def com_progreso_envio(request):
    return render(request, 'paginas/comprador/com_progreso_envio.html')
  
def com_reembolsos(request):
  return render(request, 'paginas/publico/pub_reembolsos.html')

def com_soporte(request):
  return render(request, 'paginas/comprador/com_soporte.html')

def com_terminos(request):
  return render(request, 'paginas/comprador/com_terminos.html')


# VISTAS DE LA CARPETA "VENDEDOR"
def ven_bad(request):
  return render(request, 'paginas/vendedor/vinilos/ven_bad.html')

def ven_crear(request):
  return render(request, 'paginas/vendedor/ven_crear.html')

def ven_notificaciones(request):
  return render(request, 'paginas/vendedor/ven_notificaciones.html')

def ven_perfil(request):
  return render(request, 'paginas/vendedor/ven_perfil.html')

def ven_producto(request):
  return render(request, 'paginas/vendedor/ven_producto.html')

def ven_sobre_nosotros(request):
  return render(request, 'paginas/vendedor/ven_sobre_nosotros.html')


# VISTAS DE LA CARPETA "ADMINISTRADOR"
def admin_administrador(request):
  return render(request, 'paginas/Administrador/admin_administrador.html')

def admin_notificaciones(request):
  return render(request, 'paginas/administrador/admin_notificaciones.html')

def admin_pedido(request):
  return render(request, 'paginas/administrador/admin_pedido.html')

def admin_producto(request):
  return render(request, 'paginas/administrador/admin_producto.html')

def admin_reembolsos(request):
  return render(request, 'paginas/administrador/admin_reembolsos.html')

def admin_usuario(request):
  return render(request, 'paginas/Administrador/admin_usuario.html')

def admin_verificacion(request):
  return render(request, 'paginas/Administrador/admin_verificacion.html')

def admin_adPro(request):
  return render(request, 'paginas/administrador/admin_adPro.html')

def admin_bloq_users(request):
  return render(request, 'paginas/administrador/admin_bloq_users.html')

def admin_generos(request):
  return render(request, 'paginas/admin_generos.html') # Se crea la rendererización de este archivo .HTML

def admin_gestion_users(request):
  return render(request, 'paginas/administrador/admin_gestion_users.html')

def admin_new_users(request):
  return render(request, 'paginas/Administrador/admin_new_users.html')

def admin_pedido_pendiente(request):
  return render(request, 'paginas/administrador/admin_pedido_pendiente.html')

def admin_pedido_realizado(request):
  return render(request, 'paginas/administrador/admin_pedido_realizado.html')

def admin_ventas(request):
  return render(request, 'paginas/Administrador/admin_ventas.html')

def admin_sobre_nosotros(request):
  return render(request, 'paginas/administrador/admin_sobre_nosotros.html')

def masVendidos(request):
  return render(request, 'paginas/masvendidos.html')


# VISTAS DE VINILOS, SUBCARPETA DE ADMINISTRADOR
def bts(request):
  return render(request, 'paginas/administrador/ventas/bts.html')

def cartiMusic(request):
    return render(request, 'paginas/administrador/ventas/cartiMusic.html')

def eminemShow(request):
  return render(request, 'paginas/administrador/ventas/eminemShow.html')

def exitosJoe(request):
    return render(request, 'paginas/administrador/ventas/exitosJoe.html')

def gnrAppetite(request):
    return render(request, 'paginas/administrador/ventas/gnrAppetite.html')

def master(request):
    return render(request, 'paginas/administrador/ventas/master.html')

def mjBad(request):
  return render(request, 'paginas/administrador/ventas/mjBad.html')

def mjThriller(request):
    return render(request, 'paginas/administrador/ventas/mjThriller.html')

def nirvana(request):
  return render(request, 'paginas/administrador/ventas/nirvana.html')

def theBeatles(request):
  return render(request, 'paginas/administrador/ventas/theBeatles.html')


# VISTAS DE LOS USUARIOS
def lauraG(request):
  return render(request, 'paginas/administrador/usuarios/lauraG.html')

def carlosR(request):
  return render(request, 'paginas/administrador/usuarios/carlosR.html')

def camilaQ(request):
  return render(request, 'paginas/administrador/usuarios/camilaQ.html')

def jhonM(request):
  return render(request, 'paginasadministrador//usuarios/jhonM.html')

def alexR(request):
  return render(request, 'paginas/administrador/usuarios/alexR.html')

def andreaVillalobos(request):
  return render(request, 'paginas/administrador/usuarios/andreaVillalobos.html')

def benjaminCastro(request):
  return render(request, 'paginas/administrador/usuarios/benjaminCastro.html')

def cristianDominguez(request):
  return render(request, 'paginas/administrador/usuarios/cristianDominguez.html')

def angelaTorres(request):
  return render(request, 'paginas/administrador/usuarios/angelaTorres.html')

def elisaNaranjo(request):
  return render(request, 'paginas/administrador/usuarios/elisaNaranjo.html')

def emilioTorres(request):
  return render(request, 'paginas/administrador/usuarios/emilioTorres.html')

def andreaVillalobos2(request):
  return render(request, 'paginas/administrador/usuarios/andreaVillalobos2.html')

def benjaminCastro2(request):
  return render(request, 'paginas/administrador/usuarios/benjaminCastro2.html')

def cristianDominguez2(request):
  return render(request, 'paginas/administrador/usuarios/cristianDominguez2.html')

def angelaTorres2(request):
  return render(request, 'paginas/administrador/usuarios/angelaTorres2.html')

def elisaNaranjo2(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/elisaNaranjo2.html')

def emilioTorres2(request):
  return render(request, 'paginas/administrador/usuarios/emilioTorres2.html')

def sofiaRamirez(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/sofiaRamirez.html')

def esperanzaBarrera(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/esperanzaBarrera.html')

def fernandoMolina(request):
  return render(request, 'paginas/administrador/usuarios/bloqueados/fernandoMolina.html')


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


# VISTAS DE LA CARPETA "PLANTILLAS"
def plantilla_publico(request):
  return render(request, 'plantillas/plantilla_publico.html')