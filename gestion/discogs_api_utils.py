import logging
import os

import discogs_client
import requests
from django.conf import settings
from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
from django.utils.functional import LazyObject

logger = logging.getLogger(__name__)


class DiscogsAPI:
    def __init__(self):
        user_token = settings.DISCOGS_TOKEN

        if not user_token:
            raise ValueError("DISCOGS_USER_TOKEN debe estar configurado en tus settings o variables de entorno.")

        # Para búsquedas públicas, solo se necesita el user_token.
        self.user_agent = "VinylesStoreApp/1.0"
        self.client = discogs_client.Client(self.user_agent, user_token=user_token)

    def search_releases(self, query, type="release", per_page=10):
        """
        Busca lanzamientos (releases) en Discogs.
        :param query: La cadena de búsqueda (ej. "Nirvana Nevermind").
        :param type: Tipo de búsqueda (ej. 'release', 'master', 'artist', 'label').
        :param per_page: Número de resultados por página.
        :return: Una lista de objetos de Discogs o None si hay un error.
        """
        try:
            # discogs-client devuelve un iterador, lo convertimos a lista
            results = list(self.client.search(query, type=type, per_page=per_page))
            return results
        except discogs_client.exceptions.HTTPError as e:
            logger.warning(f"Error HTTP de Discogs al buscar: {e}")
            return None
        except Exception as e:
            logger.error(f"Error al buscar en Discogs: {e}")
            return None

    def get_release_details(self, release_id):
        """
        Obtiene los detalles completos de un lanzamiento por su ID de Discogs.
        :param release_id: El ID numérico del lanzamiento en Discogs.
        :return: Un objeto de lanzamiento de Discogs o None.
        """
        try:
            release = self.client.release(release_id)
            return release
        except discogs_client.exceptions.HTTPError as e:
            logger.warning(f"Error HTTP de Discogs al obtener detalles del lanzamiento {release_id}: {e}")
            return None
        except Exception as e:
            logger.error(f"Error al obtener detalles del lanzamiento {release_id}: {e}")
            return None

    def download_image(self, image_url, filename_prefix="discogs_image"):
        """
        Descarga una imagen de una URL y la guarda en el sistema de archivos de Django.
        :param image_url: URL de la imagen a descargar.
        :param filename_prefix: Prefijo para el nombre del archivo guardado.
        :return: La ruta relativa del archivo guardado en MEDIA_ROOT o None si falla.
        """
        if not image_url:
            return None

        try:
            headers = {"User-Agent": self.user_agent}
            response = requests.get(image_url, stream=True, headers=headers, timeout=(10, 15))
            response.raise_for_status()  # Lanza una excepción para errores HTTP

            # Obtener la extensión del archivo de la URL
            ext = os.path.splitext(image_url.split("?")[0])[-1]
            if not ext:
                ext = ".jpg"  # Fallback si no hay extensión

            filename = f"{filename_prefix}_{os.urandom(8).hex()}{ext}"
            path = default_storage.save(os.path.join("productos_portadas", filename), ContentFile(response.content))
            return path
        except requests.exceptions.RequestException as e:
            logger.error(f"Error al descargar la imagen de Discogs {image_url}: {e}")
            return None


class LazyDiscogsAPI(LazyObject):
    def _setup(self):
        """
        Este método se llama la primera vez que se accede al objeto `discogs_api`.
        """
        self._wrapped = DiscogsAPI()


discogs_api = LazyDiscogsAPI()
