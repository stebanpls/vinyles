from django import forms
from .models import Crud, Cliente, Genero # Importa los modelos Crud, Cliente y Genero
from .widgets import MinimalFileInput # Importar el widget personalizado
from django.contrib.auth.models import User # Importa el modelo User estándar de Django

# Create your views here.
class CrudForm(forms.ModelForm):
    class Meta:
        model = Crud # Especifica el modelo que se va a usar en el formulario
        fields = '__all__'

class UserRegistrationForm(forms.ModelForm):
    password = forms.CharField(label='Contraseña', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Repetir Contraseña', widget=forms.PasswordInput)

    class Meta:
        model = User # Usaremos el modelo User que Django ya provee
        fields = ('username', 'first_name', 'email') # Campos que pediremos del modelo User.
        # Puedes añadir 'last_name' si lo deseas.

    def clean_password2(self):
        # Este método se llama automáticamente durante la validación del formulario
        cd = self.cleaned_data # Diccionario con los datos limpios del formulario
        # Verifica que ambos campos de contraseña existan y que sean iguales
        if cd.get('password') and cd.get('password2') and cd['password'] != cd['password2']:
            raise forms.ValidationError('Las contraseñas no coinciden.')
        return cd.get('password2') # Devuelve la contraseña confirmada (o None si no estaba presente)

class UserUpdateForm(forms.ModelForm):
    email = forms.EmailField(required=True)

    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email']

    def __init__(self, *args, **kwargs):
        super(UserUpdateForm, self).__init__(*args, **kwargs)
        self.fields['first_name'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Nombres'})
        self.fields['last_name'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Apellidos'})
        self.fields['email'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Correo Electrónico'})

class ClienteUpdateForm(forms.ModelForm):
    # Ya no necesitamos el checkbox visible 'eliminar_foto_perfil'
    generos_favoritos = forms.ModelMultipleChoiceField(
        queryset=Genero.objects.all(),
        widget=forms.CheckboxSelectMultiple,
        required=False,
        label="Géneros Favoritos"
    )
    # Campo oculto para marcar la intención de eliminar la foto
    _delete_profile_photo = forms.BooleanField(required=False, widget=forms.HiddenInput())

    foto_perfil = forms.ImageField(
        required=False,
        widget=MinimalFileInput(), # Usamos nuestro widget personalizado
        error_messages={
            'invalid_image': "La imagen seleccionada no es válida o está corrupta. Por favor, intente con un archivo de imagen diferente (JPG o PNG)."
        }
    )

    class Meta:
        model = Cliente
        fields = ['numero_documento', 'celular', 'direccion_residencia', 'foto_perfil', '_delete_profile_photo', 'generos_favoritos']

    def __init__(self, *args, **kwargs):
        super(ClienteUpdateForm, self).__init__(*args, **kwargs)
        self.fields['numero_documento'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Número de Documento'})
        self.fields['celular'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Celular'})
        self.fields['direccion_residencia'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Dirección de Residencia'})
        self.fields['foto_perfil'].widget.attrs.update({'class': 'form-control-file mb-2'})
        # self.fields['foto_perfil'].required = False # Ya se define en la declaración del campo arriba
        # El campo _delete_profile_photo es un HiddenInput, su posición no afecta la UI visible.