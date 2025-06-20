from django import forms
from .models import Crud, Cliente, Genero, Artista, Productor, Producto, Cancion # Importa los modelos
from .widgets import MinimalFileInput # Importar el widget personalizado
from django.contrib.auth.models import User # Importa el modelo User estándar de Django
from django.contrib.auth.forms import PasswordResetForm as DjangoPasswordResetForm # Renombrar para evitar conflicto
from django_recaptcha.fields import ReCaptchaField
from django_recaptcha.widgets import ReCaptchaV2Checkbox # Importar el widget para personalizarlo
from datetime import timedelta # Para el formulario de Cancion

# Create your views here.
class CrudForm(forms.ModelForm):
    class Meta:
        model = Crud # Especifica el modelo que se va a usar en el formulario
        fields = '__all__'

class UserRegistrationForm(forms.ModelForm):
    password = forms.CharField(label='Contraseña', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Repetir Contraseña', widget=forms.PasswordInput)
    email = forms.EmailField(label='Correo Electrónico', required=True)
    captcha = ReCaptchaField(
        label='Verificación', # Puedes cambiar la etiqueta si lo deseas
        widget=ReCaptchaV2Checkbox(
            # attrs={'data-hl': 'es'} # Mantenemos esto por si acaso, pero priorizaremos api_params
            api_params={'hl': 'es-419'}, # Añadimos el idioma como parámetro de la API
            attrs={
                'data-theme': 'dark', # Solicitar el tema oscuro para el widget
            }
        ),
        error_messages={
            'required': 'Por favor, completa la verificación reCAPTCHA.',
            'captcha_invalid': 'Verificación reCAPTCHA inválida. Por favor, inténtalo de nuevo.'
        }
    )

class CustomPasswordResetForm(DjangoPasswordResetForm): # Hereda del PasswordResetForm de Django
    email = forms.EmailField(
        label="Correo Electrónico",
        max_length=254,
        widget=forms.EmailInput(attrs={'autocomplete': 'email', 'class': 'form-control', 'placeholder': 'abc@mail.com', 'required': 'required'})
    )
    captcha = ReCaptchaField(
        label='Verificación',
        widget=ReCaptchaV2Checkbox(
            api_params={'hl': 'es-419'}, # Idioma para el widget
            attrs={
                'data-theme': 'dark', # Tema oscuro
            }
        ),
        error_messages={
            'required': 'Por favor, completa la verificación reCAPTCHA.',
            'captcha_invalid': 'Verificación reCAPTCHA inválida. Por favor, inténtalo de nuevo.'
        }
    )
    # No se necesita la clase Meta aquí, ya que PasswordResetForm no es un ModelForm
    # y los campos se definen directamente o se heredan.
    # El campo 'username' no es utilizado por el flujo estándar de reseteo de contraseña de Django.

    # El método clean_password2 no es aplicable a PasswordResetForm,
    # pertenece a formularios donde se establece/cambia una contraseña (ej. SetPasswordForm, UserCreationForm).
    # PasswordResetForm solo recopila el email. La confirmación de la nueva contraseña
    # ocurre en PasswordResetConfirmView con su respectivo formulario.

    def clean_password2(self):
        cd = self.cleaned_data
        if cd.get('password') and cd.get('password2') and cd['password'] != cd['password2']:
            raise forms.ValidationError("Las contraseñas no coinciden.")
        return cd.get('password2')

    # No es necesario un método save() personalizado aquí si la vista maneja set_password().

#FORMULARIO PARA CREAR ARTISTA 
class ArtistaForm(forms.ModelForm):
    class Meta:
        model = Artista
        fields = ['nombre', 'informacion', 'foto'] # 'biografia' cambiado a 'informacion'
        labels = {
            'nombre': 'Nombre del Artista',
            'informacion': 'Información del Artista', # Etiqueta actualizada
            'foto': 'Foto del Artista',
        }
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Ej: Michael Jackson'}),
            'informacion': forms.Textarea(attrs={ # 'biografia' cambiado a 'informacion'
                'rows': 4,
                'placeholder': 'Cuenta algo sobre el artista...',
                'class': 'form-control'
            }),
            'foto': MinimalFileInput(attrs={ # Usamos MinimalFileInput si es apropiado, o ClearableFileInput
                'class': 'form-control-file mb-2', # Ajustar clases según tu CSS
                'accept': 'image/*'
            }),
        }

    def clean_nombre(self):
        nombre = self.cleaned_data.get('nombre')
        if not nombre or not nombre.strip():
            raise forms.ValidationError("El nombre del artista es obligatorio.")
        return nombre

    # La validación para 'informacion' y 'foto' puede ser opcional si en el modelo
    # los campos permiten blank=True, null=True.
    # Si son obligatorios en el modelo, el ModelForm ya lo valida.
    # Estas validaciones personalizadas son útiles para mensajes de error específicos.
    def clean_informacion(self):
        informacion = self.cleaned_data.get('informacion')
        if not informacion or not informacion.strip(): # Solo si es obligatorio
            raise forms.ValidationError("La información del artista es obligatoria.")
        return informacion

    def clean_foto(self):
        foto = self.cleaned_data.get('foto')
        if not foto: # Solo si es obligatorio
            raise forms.ValidationError("La foto del artista es obligatoria.")
        return foto

#PARA EL FORMULARIO DE PRODUCTO 
class ProductoForm(forms.ModelForm):
    class Meta:
        model = Producto
        fields = [
            'nombre', # 'titulo' cambiado a 'nombre'
            'artistas', # Mapeado desde 'artista_existente'
            'lanzamiento', # 'fecha_lanzamiento' cambiado a 'lanzamiento'
            'precio',
            'stock',
            'descripcion',
            'discografica', # 'sello_discografico' cambiado a 'discografica'
            'imagen_portada',
            'genero_principal',
        ]
        labels = {
            'nombre': 'Nombre del Producto/Álbum',
            'artistas': 'Artista(s) Principal(es)',
            'lanzamiento': 'Fecha de Lanzamiento',
            'discografica': 'Compañía Discográfica',
        }
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Ej: Thriller'}),
            'artistas': forms.SelectMultiple(attrs={'class': 'form-control select-artista'}), # Para ManyToManyField
            'lanzamiento': forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
            'genero_principal': forms.SelectMultiple(attrs={'class': 'form-control select-genero'}),
            'precio': forms.NumberInput(attrs={'class': 'form-control', 'min': '0', 'step': '0.01', 'placeholder': 'Ej: 100000'}),
            'stock': forms.NumberInput(attrs={'class': 'form-control', 'min': '0', 'step': '1', 'placeholder': 'Ej: 10'}),
            'descripcion': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'discografica': forms.TextInput(attrs={'class': 'form-control'}),
            'imagen_portada': MinimalFileInput(attrs={'class': 'form-control-file mb-2', 'accept': 'image/*'}),
        }

    def clean_precio(self):
        precio = self.cleaned_data.get('precio')
        if precio is not None and precio < 0:
            raise forms.ValidationError("El precio no puede ser negativo.")
        return precio

    def clean_stock(self):
        stock = self.cleaned_data.get('stock')
        if stock is not None and stock < 0:
            raise forms.ValidationError("El stock no puede ser negativo.")
        return stock

    def clean(self):
        cleaned_data = super().clean()
        artistas = cleaned_data.get('artistas')
        generos = cleaned_data.get('genero_principal')

        if not artistas:
            self.add_error('artistas', "Debes seleccionar al menos un artista.")
    
        if not generos or generos.count() == 0:
            self.add_error('genero_principal', "Debes seleccionar al menos un género.")

        return cleaned_data

#PARA EL FORMULARIO DE CANCION
class CancionForm(forms.ModelForm):
    minutos = forms.IntegerField(
        min_value=0, max_value=120, label="Minutos", required=False,
        widget=forms.NumberInput(attrs={'class': 'form-control', 'placeholder': '00'})
    )
    segundos = forms.IntegerField(
        min_value=0, max_value=59, label="Segundos", required=False,
        widget=forms.NumberInput(attrs={'class': 'form-control', 'placeholder': '00'})
    )

    class Meta:
        model = Cancion
        fields = ['nombre', 'artistas', 'productores', 'generos']
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control'}),
            'artistas': forms.SelectMultiple(attrs={'class': 'form-control select-artista'}),
            'productores': forms.SelectMultiple(attrs={'class': 'form-control select-productor'}),
            'generos': forms.SelectMultiple(attrs={'class': 'form-control select-genero'}),
        }

    def clean(self):
        cleaned_data = super().clean()
        minutos = cleaned_data.get('minutos')
        segundos = cleaned_data.get('segundos')

        minutos = minutos if minutos is not None else 0
        segundos = segundos if segundos is not None else 0

        if minutos == 0 and segundos == 0:
            self.add_error(None, "La duración de la canción no puede ser 0 minutos y 0 segundos.")
        else:
            cleaned_data['duracion'] = timedelta(minutes=minutos, seconds=segundos)

        if not cleaned_data.get('artistas'):
            self.add_error('artistas', "Debes seleccionar al menos un artista.")

        if not cleaned_data.get('productores'):
            self.add_error('productores', "Debes seleccionar al menos un productor.")

        if not cleaned_data.get('generos'):
            self.add_error('generos', "Debes seleccionar al menos un género.")

        return cleaned_data

    def save(self, commit=True):
        instance = super().save(commit=False)
        if 'duracion' in self.cleaned_data:
            instance.duracion = self.cleaned_data['duracion']

        if commit:
            instance.save()
            self.save_m2m()
        return instance

#FORMULARIO PARA EL PRODCUTOR 
class ProductorForm(forms.ModelForm):
    class Meta:
        model = Productor
        fields = ['nombre']
        labels = {
            'nombre': 'Nombre del Productor',
        }
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Ej: Quincy Jones'}),
        }

    def clean_nombre(self):
        nombre = self.cleaned_data.get('nombre')
        if not nombre or not nombre.strip():
            raise forms.ValidationError("El nombre del productor es obligatorio.")
        return nombre

#FORMULARIO PARA EL GENERO
class GeneroForm(forms.ModelForm):
    class Meta:
        model = Genero
        fields = ['nombre']
        labels = {
            'nombre': 'Nombre del Género',
        }
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Ej: Salsa'}),
        }

    def clean_nombre(self):
        nombre = self.cleaned_data.get('nombre')
        if not nombre or not nombre.strip():
            raise forms.ValidationError("El nombre del género es obligatorio.")
        # Considerar validar si el género ya existe si el campo 'nombre' en el modelo es unique=True
        # if Genero.objects.filter(nombre__iexact=nombre).exists():
        #     raise forms.ValidationError("Este género ya existe.")
        return nombre

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

class LoginForm(forms.Form):
    login_identifier = forms.CharField(label="Nombre de usuario o Correo Electrónico")
    password = forms.CharField(label="Contraseña", widget=forms.PasswordInput)
    captcha = ReCaptchaField(
        label='Verificación',
        widget=ReCaptchaV2Checkbox(
            # attrs={'data-hl': 'es'}
            api_params={'hl': 'es-419'}, # Añadimos el idioma como parámetro de la API
            attrs={
                'data-theme': 'dark', # Solicitar el tema oscuro para el widget
            }
        ),
        error_messages={
            'required': 'Por favor, completa la verificación reCAPTCHA.',
            'captcha_invalid': 'Verificación reCAPTCHA inválida. Por favor, inténtalo de nuevo.'
        }
    )