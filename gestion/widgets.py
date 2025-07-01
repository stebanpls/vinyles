from django.forms.widgets import ClearableFileInput


class MinimalFileInput(ClearableFileInput):
    # Sobrescribimos la plantilla para que solo renderice el input de archivo.
    # No queremos el enlace "Currently:", ni el checkbox "Clear",
    # ya que manejamos esa lógica con nuestro panel "Editar Foto".
    template_name = "gestion/widgets/minimal_file_input.html"

    # También podemos limpiar algunos textos que no usaremos, aunque
    # con la plantilla personalizada esto no es estrictamente necesario.
    initial_text = ""
    input_text = ""
    clear_checkbox_label = ""
