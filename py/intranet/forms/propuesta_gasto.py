from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, HiddenField, FloatField, TextAreaField
from crud.data_layer import get_db

class PropuestaGastoForm(FlaskForm):
    userid = HiddenField('Usuario')
    descripcion = StringField('Descripción')
    justificacion = TextAreaField('Justificación')
    importe = FloatField('Importe')
    submit = SubmitField('Actualizar')

    columns = ('userid', 'importe', 'descripcion', 'justificacion')

    def store(self, uid):
        ret = self.to_dict()
        get_db().dset('propuestas_gastos', ret)
        return ret

    def to_dict(self):
        return { k: getattr(self, k).data for k in self.columns }
