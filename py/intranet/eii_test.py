from flask import Flask, url_for, send_from_directory, render_template, redirect
from flask_restful import Api, Resource, reqparse
from flask_cors import CORS
import json
from crud.data_layer import close_db
from crud.profesores import Profesor, ProfesoresList, ProfesoresQuery
from crud.justificantes import Justificantes
from crud.db_resource import DBResource, DBResourceContainer
from crud.session import get_sp, SAML2_SETUP
from forms.datos_profesionales import DatosProfesionalesForm
from forms.justificantes import JustificantesForm
from forms.propuesta_gasto import PropuestaGastoForm

app = Flask(__name__, static_url_path='')
CORS(app)
api = Api(app, prefix='/v1')
SAML2_SETUP(app)

@app.route('/')
def index():
    return redirect('/form/datos_profesionales')

@app.route('/app/<path:path>')
def app_path(path):
    sp = get_sp()
    auth = sp.get_auth_data_in_session() if sp.is_user_logged_in() else None        
    return render_template(path, auth = auth, logout_url = '/')


all_forms = {
    'datos_profesionales': DatosProfesionalesForm,
    'admin_datos': DatosProfesionalesForm,
    'propuesta_gasto': PropuestaGastoForm
}

@app.route('/form/<path:path>', methods=['GET', 'POST'])
def form_path(path):
    sp = get_sp()
    auth = sp.get_auth_data_in_session() if sp.is_user_logged_in() else None
    form = all_forms[path]()
    if not auth:
        return redirect('/')
    if form.validate_on_submit():
        form.store(auth.attributes['uid'])
    return render_template(path + ".html", 
                           auth = auth, 
                           form = form,
                           logout_url = '/')

@app.teardown_appcontext
def close_connection(exception):
    close_db()

@app.route('/static/<path:path>')
def send_static(path):
    return send_from_directory('html/static', path)

api.add_resource(ProfesoresQuery, "/buscar_profesores/<string:userid>:<string:password>")

for table in (
        'profesores', 
        'profesores.expandidos',
        'profesores.desiderata', 
        'profesores.tutorias', 
        'profesores.areas', 
        'docencia.titulos', 
        'docencia.asignaturas', 
        'docencia.por_profesor', 
        'docencia.por_area'):
    api.add_resource(DBResource(table), f"/{table}/por_<string:column>/<string:value>")
    api.add_resource(DBResourceContainer(table), f"/{table}/por_<string:column>/")

api.add_resource(Justificantes, "/justificantes/<string:userid>")


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000, debug=True)
