from django.test import TestCase
from django.urls import reverse


class SimpleTest(TestCase):
    def test_example(self):
        """A very simple test to make sure the test runner works."""
        self.assertEqual(1 + 1, 2)


class PaginaInicioTest(TestCase):
    def test_vista_inicio_existe_y_usa_plantilla_correcta(self):
        """Prueba que la página de inicio pública existe y usa la plantilla correcta."""
        # Usamos reverse() para obtener la URL a partir del nombre definido en urls.py
        response = self.client.get(reverse("pub_inicio"))
        self.assertEqual(response.status_code, 200)  # 200 significa "OK"
        self.assertTemplateUsed(response, "paginas/publico/pub_inicio.html")
