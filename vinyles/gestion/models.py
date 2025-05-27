from typing import Any
from django.db import models

# Create your models here.
class Crud(models.Model): # Es mejor nombrar la clase con mayúscula inicial, siguiendo las convenciones de Python
  id = models.AutoField(primary_key = True)
  nombre = models.CharField(max_length = 50, verbose_name = "Nombre")
  apellido = models.CharField(max_length = 50, verbose_name = "Apellido")
  foto = models.ImageField(upload_to = 'fotos/', verbose_name = "Foto", null = True)
  clase = models.TextField(max_length = 100, verbose_name = "Clase", null = True)
  direccion = models.CharField(max_length = 250, verbose_name = "Dirección", blank = True, null = True)
  fechaIngreso = models.DateField(verbose_name = "Fecha de Ingreso", blank = True, null = True)

  class Meta:
    verbose_name_plural = "Crud" # Aquí especificas el nombre plural

  def __str__(self):
    return f"ID = {self.id} y Nombres: {self.nombre} {self.apellido}" # Es usar f-string para formatear cadenas de texto
  
  def delete(self, using = None, keep_parents = False):
    if self.foto: # Buena práctica: verificar si la foto existe antes de intentar borrarla
      self.foto.storage.delete(self.foto.name)
      super().delete()