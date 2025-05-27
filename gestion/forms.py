from django import forms
from .models import Crud # Importa el modelo Crud desde el archivo models.py

# Create your views here.
class CrudForm(forms.ModelForm):
  class Meta:
    model = Crud # Especifica el modelo que se va a usar en el formulario
    fields = '__all__'