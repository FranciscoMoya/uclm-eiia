from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, SelectMultipleField, BooleanField, SubmitField

class DatosPersonalesForm(FlaskForm):
    despacho = StringField('Despacho')
    telefono = StringField('Teléfono')
    area = StringField('Área de conocimiento')
    acreditacion = SelectMultipleField('Acreditación',
                                       choices = [
                                           ('ad', 'Ayudante Doctor'),
                                           ('cd', 'Contratado Doctor'),
                                           ('tu', 'Titular de Universidad'),
                                           ('cu', 'Catedrático de Universidad')
                                       ])
    quinquenios = IntegerField('Número de quinquenios')
    sexenios = IntegerField('Número de sexenios')
    sexenio_vivo = BooleanField('Sexenio vivo')
    submit = SubmitField('Actualizar')
