from django.forms.widgets import ClearableFileInput
from django.utils.translation import gettext_lazy as _

class MinimalFileInput(ClearableFileInput):
    # Sobrescribimos la plantilla para que solo renderice el input de archivo.
    # No queremos el enlace "Currently:", ni el checkbox "Clear",
    # ya que manejamos esa lógica con nuestro panel "Editar Foto".
    template_name = 'gestion/widgets/minimal_file_input.html'

    # También podemos limpiar algunos textos que no usaremos, aunque
    # con la plantilla personalizada esto no es estrictamente necesario.
    initial_text = ''
    input_text = ''
    clear_checkbox_label = ''

