from flask import Flask, url_for, send_from_directory, render_template, redirect
from flask_restful import Api, Resource, reqparse
from flask_cors import CORS
import json
from crud.data_layer import close_db
from crud.justificantes import Justificantes
from crud.directorio import Directorio
from crud.pdfpages import PdfPages
from crud.db_resource import DBResource, DBResourceContainer, DBSchema
from crud.session import get_sp, SAML2_SETUP
from forms.profesores import ProfesoresForm


app = Flask(__name__, static_url_path='')
CORS(app)
api = Api(app, prefix='/v2')
SAML2_SETUP(app)


@app.route('/')
def index():
    return redirect('/form/profesores')

@app.route('/app/<path:path>')
def app_path(path):
    sp = get_sp()
    auth = sp.get_auth_data_in_session() if sp.is_user_logged_in() else None        
    return render_template(path, auth = auth, logout_url = url_for('flask_saml2_sp.logout', _external=True))

all_forms = {
    'profesores': ProfesoresForm,
    'admin_profesores': ProfesoresForm
}

@app.route('/form/<path:path>', methods=['GET', 'POST'])
def form_path(path):
    sp = get_sp()
    auth = sp.get_auth_data_in_session() if sp.is_user_logged_in() else None
    form = all_forms[path]()
    if not auth:
        return redirect(url_for('flask_saml2_sp.login', _external=True))
    return render_template(path + ".html", 
                           auth = auth, 
                           form = form,
                           logout_url = url_for('flask_saml2_sp.logout', _external=True))

@app.teardown_appcontext
def close_connection(exception):
    close_db()

@app.route('/static/<path:path>')
def send_static(path):
    return send_from_directory('html/static', path)

for table in (
        'profesores', 
        'profesores.expandidos',
        'profesores.desiderata', 
        'profesores.tutorias', 
        'profesores.areas', 
        'profesores.superareas', 
        'profesores.categorias', 
        'profesores.departamentos', 
        'docencia.titulos', 
        'docencia.asignaturas',
        'docencia.profesores_asignaturas',
        'docencia.areas_asignaturas', 
        'docencia.por_profesor', 
        'docencia.por_area',
        'docencia.por_superarea',
        'docencia.pref',
        'docencia.pref.preferencias',
        'docencia.pref.preferencias.time_patterns',
        'docencia.pref.preferencias.date_patterns'):
    api.add_resource(DBSchema(table), f"/{table}/schema")
    api.add_resource(DBResourceContainer(table), f"/{table}/por_<string:column>/")
    api.add_resource(DBResource(table), f"/{table}/por_<string:column>/<string:value>")

api.add_resource(Justificantes, "/justificantes/<string:userid>")
api.add_resource(Directorio, "/directorio/update_profesores/")
api.add_resource(PdfPages, "/horario/<string:userid>")

# Impedir cache es una mala práctica. Parece que explorer no actualiza
# los resultados JSON.  Debería funcionar ahora que no borra lo cambiado
# pero para evitar problema se puede no cachear
@app.after_request
def after_request(response):
    response.cache_control.max_age = 0
    response.cache_control.public = True
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000, debug=True)
