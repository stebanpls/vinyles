from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse


class SimpleTest(TestCase):
    def test_example(self):
        """A very simple test to make sure the test runner works."""
        self.assertEqual(1 + 1, 2)


class PaginaInicioTest(TestCase):
    def setUp(self):
        self.password = "password"  # nosec
        self.user = User.objects.create_user(username="testuser", password=self.password)

    def test_vista_inicio_existe_y_usa_plantilla_correcta(self):
        """Prueba que la página de inicio pública existe y usa la plantilla correcta."""
        # Usamos reverse() para obtener la URL a partir del nombre definido en urls.py
        response = self.client.get(reverse("pub_inicio"))
        self.assertEqual(response.status_code, 200)  # 200 significa "OK"
        self.assertTemplateUsed(response, "paginas/_base_inicio.html")

    def test_vista_inicio_autenticado_usa_plantilla_correcta(self):
        """Prueba que la página de inicio del comprador existe y usa la plantilla correcta."""
        self.client.login(username="testuser", password=self.password)
        response = self.client.get(reverse("com_inicio"))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, "paginas/_base_inicio.html")


class PaginaAlbumesTest(TestCase):
    def setUp(self):
        self.password = "password"  # nosec
        self.user = User.objects.create_user(username="testuser", password=self.password)

    def test_vista_albumes_publica_existe_y_usa_plantilla_correcta(self):
        """Prueba que la página de álbumes pública existe y usa la plantilla correcta."""
        response = self.client.get(reverse("pub_albumes"))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, "paginas/_base_albumes.html")

    def test_vista_albumes_autenticado_usa_plantilla_correcta(self):
        """Prueba que la página de álbumes del comprador existe y usa la plantilla correcta."""
        self.client.login(username="testuser", password=self.password)
        response = self.client.get(reverse("com_albumes"))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, "paginas/_base_albumes.html")
