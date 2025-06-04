from django import forms
from .models import Crud # Importa el modelo Crud desde el archivo models.py
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