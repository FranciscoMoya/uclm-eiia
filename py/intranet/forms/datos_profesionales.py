from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, SelectMultipleField, BooleanField, SubmitField, HiddenField
from crud.data_layer import get_db

class DatosProfesionalesForm(FlaskForm):
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
    submit = SubmitField('Actualizar')

    sn = HiddenField()
    givenName = HiddenField()

    columns = ("telefono","despacho","quinquenios","sexenios","sexenio_vivo")

    def store(self, uid):
        ret = self.to_dict()
        get_db().profesores.store(ret)
        return ret

    def to_dict(self):
        return { k: getattr(self, k).data for k in self.columns }
