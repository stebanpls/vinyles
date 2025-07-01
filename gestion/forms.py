from datetime import timedelta  # Para el formulario de Cancion

from django import forms
from django.contrib.auth.forms import SetPasswordForm, UserCreationForm, UsernameField
from django.contrib.auth.forms import UserCreationForm as DjangoUserCreationForm
from django.contrib.auth.models import User  # Importa el modelo User estándar de Django
from django.utils.translation import gettext_lazy as _
from django_recaptcha.fields import ReCaptchaField, ReCaptchaV2Checkbox

from .models import (  # Importa los modelos actualizados
    Artista,
    Cancion,
    Cliente,
    Crud,
    Genero,
    Productor,
    Publicacion,
)
from .widgets import MinimalFileInput  # Importar el widget personalizado


class CrudForm(forms.ModelForm):
    class Meta:
        model = Crud  # Especifica el modelo que se va a usar en el formulario
        fields = "__all__"


class UserRegistrationForm(DjangoUserCreationForm):  # Heredar de UserCreationForm
    email = forms.EmailField(
        label="Correo Electrónico",
        required=True,
        help_text="Requerido. Se usará para la recuperación de la cuenta.",
    )
    first_name = forms.CharField(label="Nombres", max_length=150, required=False)
    last_name = forms.CharField(label="Apellidos", max_length=150, required=False)
    captcha = ReCaptchaField(
        label="Verificación",  # Puedes cambiar la etiqueta si lo deseas
        widget=ReCaptchaV2Checkbox(
            # attrs={'data-hl': 'es'} # Mantenemos esto por si acaso, pero priorizaremos api_params
            api_params={"hl": "es-419"},  # Añadimos el idioma como parámetro de la API
            attrs={
                "data-theme": "dark",  # Solicitar el tema oscuro para el widget
            },
        ),
        error_messages={
            "required": "Por favor, completa la verificación reCAPTCHA.",
            "captcha_invalid": "Verificación reCAPTCHA inválida. Por favor, inténtalo de nuevo.",
        },
    )

    class Meta(DjangoUserCreationForm.Meta):
        model = User
        fields = ("username", "email", "first_name", "last_name")
        field_classes = {"username": UsernameField}
        widgets = {
            "username": forms.TextInput(attrs={"placeholder": "Elige un nombre de usuario único"}),
        }

    def clean_email(self):
        email = self.cleaned_data.get("email")
        if email and User.objects.filter(email__iexact=email).exists():
            raise forms.ValidationError(
                "Ya existe un usuario registrado con este correo electrónico."
            )
        return email


class PasswordResetRequestForm(forms.Form):
    email = forms.EmailField(
        label="Correo Electrónico",
        max_length=254,
        widget=forms.EmailInput(
            attrs={"autocomplete": "email", "class": "form-control", "placeholder": "abc@mail.com"}
        ),
    )
    captcha = ReCaptchaField(
        label="Verificación",
        widget=ReCaptchaV2Checkbox(api_params={"hl": "es-419"}, attrs={"data-theme": "dark"}),
        error_messages={
            "required": "Por favor, completa la verificación reCAPTCHA.",
            "captcha_invalid": "Verificación reCAPTCHA inválida. Por favor, inténtalo de nuevo.",
        },
    )

    def clean_email(self):
        email = self.cleaned_data.get("email")
        if not User.objects.filter(email__iexact=email, is_active=True).exists():
            raise forms.ValidationError("No existe una cuenta activa con este correo electrónico.")
        return email


class PasswordResetConfirmForm(SetPasswordForm):
    code = forms.CharField(
        label=_("Código de Verificación"),
        max_length=6,
        min_length=6,
        widget=forms.TextInput(
            attrs={"class": "form-control", "placeholder": "Código de 6 dígitos"}
        ),
    )

    def clean_code(self):
        from .models import PasswordResetCode

        code = self.cleaned_data.get("code")
        try:
            reset_code_obj = PasswordResetCode.objects.get(user=self.user, code=code)
            if not reset_code_obj.is_valid():
                raise forms.ValidationError(
                    _("El código de verificación ha expirado. Por favor, solicita uno nuevo.")
                )
        except PasswordResetCode.DoesNotExist as e:
            raise forms.ValidationError(_("El código de verificación es incorrecto.")) from e
        return code

    def save(self, commit=True):
        from .models import PasswordResetCode

        user = super().save(commit=commit)
        if commit:
            PasswordResetCode.objects.filter(user=self.user).delete()
        return user


# FORMULARIO PARA CREAR ARTISTA
class ArtistaForm(forms.ModelForm):
    class Meta:
        model = Artista
        fields = ["nombre", "informacion", "foto"]  # 'biografia' cambiado a 'informacion'
        labels = {
            "nombre": "Nombre del Artista",
            "informacion": "Información del Artista",  # Etiqueta actualizada
            "foto": "Foto del Artista",
        }
        widgets = {
            "nombre": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ej: Michael Jackson"}
            ),
            "informacion": forms.Textarea(
                attrs={  # 'biografia' cambiado a 'informacion'
                    "rows": 4,
                    "placeholder": "Cuenta algo sobre el artista...",
                    "class": "form-control",
                }
            ),
            "foto": MinimalFileInput(
                attrs={  # Usamos MinimalFileInput si es apropiado, o ClearableFileInput
                    "class": "form-control-file mb-2",  # Ajustar clases según tu CSS
                    "accept": "image/*",
                }
            ),
        }

    def clean_nombre(self):
        nombre = self.cleaned_data.get("nombre")
        if not nombre or not nombre.strip():
            raise forms.ValidationError("El nombre del artista es obligatorio.")
        return nombre


# --- NUEVO: Formulario para crear una Publicacion (oferta) ---
class PublicacionForm(forms.ModelForm):
    class Meta:
        model = Publicacion
        fields = ["precio", "stock", "descripcion_condicion"]
        labels = {
            "precio": "Precio de tu copia",
            "stock": "Cantidad disponible",
            "descripcion_condicion": "Describe la condición de tu vinilo (portada, disco, etc.)",
        }
        widgets = {
            "precio": forms.NumberInput(
                attrs={"class": "form-control", "min": "0", "placeholder": "Ej: 120000"}
            ),
            "stock": forms.NumberInput(
                attrs={"class": "form-control", "min": "1", "placeholder": "Ej: 1"}
            ),
            "descripcion_condicion": forms.Textarea(
                attrs={
                    "class": "form-control",
                    "rows": 4,
                    "placeholder": "Ej: Portada en excelente estado, disco con ligeras marcas superficiales que no afectan el sonido.",
                }
            ),
        }

    def clean_precio(self):
        precio = self.cleaned_data.get("precio")
        if precio is not None and precio <= 0:
            raise forms.ValidationError("El precio debe ser un valor positivo.")
        return precio

    def clean_stock(self):
        stock = self.cleaned_data.get("stock")
        if stock is not None and stock < 1:
            raise forms.ValidationError("Debes tener al menos 1 en stock.")
        return stock


# ELIMINADO: ProductoForm ya no se usa para la creación por parte del vendedor.
# La información del Producto se obtendrá de Discogs.


# PARA EL FORMULARIO DE CANCION
class CancionForm(forms.ModelForm):
    minutos = forms.IntegerField(
        min_value=0,
        max_value=120,
        label="Minutos",
        required=False,
        widget=forms.NumberInput(attrs={"class": "form-control", "placeholder": "00"}),
    )
    segundos = forms.IntegerField(
        min_value=0,
        max_value=59,
        label="Segundos",
        required=False,
        widget=forms.NumberInput(attrs={"class": "form-control", "placeholder": "00"}),
    )

    class Meta:
        model = Cancion
        fields = ["nombre", "artistas", "productores", "generos"]
        widgets = {
            "nombre": forms.TextInput(attrs={"class": "form-control"}),
            "artistas": forms.SelectMultiple(attrs={"class": "form-control select-artista"}),
            "productores": forms.SelectMultiple(attrs={"class": "form-control select-productor"}),
            "generos": forms.SelectMultiple(attrs={"class": "form-control select-genero"}),
        }

    def clean(self):
        cleaned_data = super().clean()
        minutos = cleaned_data.get("minutos")
        segundos = cleaned_data.get("segundos")

        minutos = minutos if minutos is not None else 0
        segundos = segundos if segundos is not None else 0

        if minutos == 0 and segundos == 0:
            self.add_error(None, "La duración de la canción no puede ser 0 minutos y 0 segundos.")
        else:
            cleaned_data["duracion"] = timedelta(minutes=minutos, seconds=segundos)

        if not cleaned_data.get("artistas"):
            self.add_error("artistas", "Debes seleccionar al menos un artista.")

        if not cleaned_data.get("productores"):
            self.add_error("productores", "Debes seleccionar al menos un productor.")

        if not cleaned_data.get("generos"):
            self.add_error("generos", "Debes seleccionar al menos un género.")

        return cleaned_data

    def save(self, commit=True):
        instance = super().save(commit=False)
        if "duracion" in self.cleaned_data:
            instance.duracion = self.cleaned_data["duracion"]

        if commit:
            instance.save()
            self.save_m2m()
        return instance


# FORMULARIO PARA EL PRODCUTOR
class ProductorForm(forms.ModelForm):
    class Meta:
        model = Productor
        fields = ["nombre"]
        labels = {
            "nombre": "Nombre del Productor",
        }
        widgets = {
            "nombre": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ej: Quincy Jones"}
            ),
        }

    def clean_nombre(self):
        nombre = self.cleaned_data.get("nombre")
        if not nombre or not nombre.strip():
            raise forms.ValidationError("El nombre del productor es obligatorio.")
        return nombre


# FORMULARIO PARA EL GENERO
class GeneroForm(forms.ModelForm):
    class Meta:
        model = Genero
        fields = ["nombre", "foto"]
        labels = {
            "nombre": "Nombre del Género",
            "foto": "Foto del Género (Opcional)",
        }
        widgets = {
            "nombre": forms.TextInput(attrs={"class": "form-control", "placeholder": "Ej: Salsa"}),
            "foto": MinimalFileInput(
                attrs={"class": "form-control-file mb-2", "accept": "image/*"}
            ),
        }

    def clean_nombre(self):
        nombre = self.cleaned_data.get("nombre")
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
        fields = ["first_name", "last_name", "email"]

    def __init__(self, *args, **kwargs):
        super(UserUpdateForm, self).__init__(*args, **kwargs)
        self.fields["first_name"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Nombres",
        })
        self.fields["last_name"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Apellidos",
        })
        self.fields["email"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Correo Electrónico",
        })


class ClienteUpdateForm(forms.ModelForm):
    # Ya no necesitamos el checkbox visible 'eliminar_foto_perfil'
    generos_favoritos = forms.ModelMultipleChoiceField(
        queryset=Genero.objects.all(),
        widget=forms.CheckboxSelectMultiple,
        required=False,
        label="Géneros Favoritos",
    )
    # Campo oculto para marcar la intención de eliminar la foto
    _delete_profile_photo = forms.BooleanField(required=False, widget=forms.HiddenInput())

    foto_perfil = forms.ImageField(
        required=False,
        widget=MinimalFileInput(),  # Usamos nuestro widget personalizado
        error_messages={
            "invalid_image": "La imagen seleccionada no es válida o está corrupta. Por favor, intente con un archivo de imagen diferente (JPG o PNG)."
        },
    )

    class Meta:
        model = Cliente
        fields = [
            "numero_documento",
            "celular",
            "direccion_residencia",
            "foto_perfil",
            "_delete_profile_photo",
            "generos_favoritos",
        ]

    def __init__(self, *args, **kwargs):
        super(ClienteUpdateForm, self).__init__(*args, **kwargs)
        self.fields["numero_documento"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Número de Documento",
        })
        self.fields["celular"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Celular",
        })
        self.fields["direccion_residencia"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Dirección de Residencia",
        })
        self.fields["foto_perfil"].widget.attrs.update({"class": "form-control-file mb-2"})
        # self.fields['foto_perfil'].required = False # Ya se define en la declaración del campo arriba
        # El campo _delete_profile_photo es un HiddenInput, su posición no afecta la UI visible.


class LoginForm(forms.Form):
    login_identifier = forms.CharField(label="Nombre de usuario o Correo Electrónico")
    password = forms.CharField(label="Contraseña", widget=forms.PasswordInput)
    captcha = ReCaptchaField(
        label="Verificación",
        widget=ReCaptchaV2Checkbox(
            # attrs={'data-hl': 'es'}
            api_params={"hl": "es-419"},  # Añadimos el idioma como parámetro de la API
            attrs={
                "data-theme": "dark",  # Solicitar el tema oscuro para el widget
            },
        ),
        error_messages={
            "required": "Por favor, completa la verificación reCAPTCHA.",
            "captcha_invalid": "Verificación reCAPTCHA inválida. Por favor, inténtalo de nuevo.",
        },
    )


class ClienteEditForm(forms.ModelForm):
    class Meta:
        model = Cliente
        fields = ["numero_documento", "celular", "direccion_residencia", "foto_perfil"]
        labels = {
            "numero_documento": "Número de documento",
            "celular": "Celular",
            "direccion_residencia": "Dirección de residencia",
            "foto_perfil": "Foto de perfil",
        }
        widgets = {
            "numero_documento": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ingresa el número de documento"}
            ),
            "celular": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ingresa el número de celular"}
            ),
            "direccion_residencia": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ingresa la dirección"}
            ),
            "foto_perfil": forms.ClearableFileInput(attrs={"class": "form-control"}),
        }


class UserEditForm(forms.ModelForm):
    is_staff = forms.BooleanField(
        label="¿Puede acceder al panel administrativo?",
        required=False,
        widget=forms.CheckboxInput(attrs={"class": "form-check-input"}),
    )

    class Meta:
        model = User
        fields = ["username", "email", "first_name", "last_name", "is_staff"]
        labels = {
            "username": "Nombre de usuario",
            "email": "Correo electrónico",
            "first_name": "Nombres",
            "last_name": "Apellidos",
            "is_staff": "¿Puede acceder al panel administrativo?",
        }
        widgets = {
            "username": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ingresa el nombre de usuario"}
            ),
            "email": forms.EmailInput(
                attrs={"class": "form-control", "placeholder": "Ingresa el correo"}
            ),
            "first_name": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ingresa los nombres"}
            ),
            "last_name": forms.TextInput(
                attrs={"class": "form-control", "placeholder": "Ingresa los apellidos"}
            ),
        }


class CrearUsuarioStaffForm(UserCreationForm):
    email = forms.EmailField(
        label="Correo Electrónico",
        required=True,
        widget=forms.EmailInput(attrs={"placeholder": "Correo del nuevo administrador"}),
    )
    first_name = forms.CharField(
        label="Nombres",
        max_length=150,
        required=True,
        widget=forms.TextInput(attrs={"placeholder": "Nombres del administrador"}),
    )
    last_name = forms.CharField(
        label="Apellidos",
        max_length=150,
        required=True,
        widget=forms.TextInput(attrs={"placeholder": "Apellidos del administrador"}),
    )

    class Meta(UserCreationForm.Meta):
        model = User
        fields = ("username", "email", "first_name", "last_name", "password1", "password2")
        field_classes = {"username": UsernameField}
        widgets = {
            "username": forms.TextInput(
                attrs={"placeholder": "Nombre de usuario del administrador"}
            ),
            "password1": forms.PasswordInput(attrs={"placeholder": "Contraseña de acceso"}),
            "password2": forms.PasswordInput(attrs={"placeholder": "Confirmar contraseña"}),
        }

    def clean_email(self):
        email = self.cleaned_data.get("email")
        if email and User.objects.filter(email__iexact=email).exists():
            raise forms.ValidationError("Este correo ya está registrado.")
        return email

    def save(self, commit=True):
        user = super().save(commit=False)
        user.is_staff = True
        user.is_superuser = False
        if commit:
            user.save()
        return user
