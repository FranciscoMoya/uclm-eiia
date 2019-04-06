from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, SelectMultipleField, BooleanField, SubmitField

class DatosProfesionalesForm(FlaskForm):
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
    quinquenios = IntegerField('Quinquenios')
    sexenios = IntegerField('Sexenios')
    sexenio_vivo = BooleanField('Sexenio vivo')
    submit = SubmitField('Actualizar')

    columns = ("area","telefono","despacho","quinquenios","sexenios","sexenio_vivo","acreditacion")
        
    def to_dict(self):
        return { k: getattr(self, k).data for k in self.columns }

    def to_list(self):
        return [ getattr(self, k).data for k in self.columns ]
