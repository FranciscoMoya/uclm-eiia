from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, SelectMultipleField, BooleanField, SubmitField, HiddenField
from crud.data_layer import get_db

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

    # AD fields
    telephoneNumber = HiddenField()
    sn = HiddenField()
    givenName = HiddenField()
    displayName = HiddenField()

    columns = ("area","telefono","despacho","quinquenios","sexenios","sexenio_vivo","acreditacion")

    def store(self, uid):
        get_db().mset('datos_profesionales', uid, self.to_list())

    def to_dict(self):
        return { k: getattr(self, k).data for k in self.columns }

    def to_list(self):
        return [ getattr(self, k).data for k in self.columns ]
