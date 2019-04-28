from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, SelectMultipleField, BooleanField, SubmitField, HiddenField
from crud.data_layer import get_db

class ProfesoresForm(FlaskForm):
    despacho = StringField('Despacho')
    telefono = StringField('Teléfono')
    email = StringField('Correo-e')
    categoria = StringField('Categoría')
    departamento = StringField('Departamento')
    area = StringField('Área de conocimiento')
    acreditacion = SelectMultipleField('Acreditación',
                                       choices = [
                                           ('ad', 'Ayudante Doctor'),
                                           ('cd', 'Contratado Doctor'),
                                           ('tu', 'Titular de Universidad'),
                                           ('cu', 'Catedrático de Universidad')
                                       ])
    quinquenios = IntegerField('Quinquenios')
    sexenios = IntegerField('Sexenios')
    sexenio_vivo = BooleanField('Sexenio vivo')
    sn = HiddenField()
    givenName = HiddenField()
    submit = SubmitField('Actualizar')
