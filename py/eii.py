from flask import Flask, url_for, send_from_directory
from flask_restful import Api, Resource, reqparse
from flask_cors import CORS
import json
from crud.data_layer import close_db
from crud.desiderata import Desideratum
from crud.despachos import Despacho
from crud.tutorias import Tutoria
from crud.session import get_sp, SAML2_SETUP

app = Flask(__name__, static_url_path='')
CORS(app)
# Enable SAML for authenticated sessions
SAML2_SETUP(app)
api = Api(app)

@app.teardown_appcontext
def close_connection(exception):
    close_db()

@app.route('/static/<path:path>')
def send_static(path):
    return send_from_directory('static', path)

@app.route('/')
def index():
    sp = get_sp()
    if sp.is_user_logged_in():
        auth_data = sp.get_auth_data_in_session()

        message = f'''
        <p>You are logged in as <strong>{auth_data.nameid}</strong>.
        The IdP sent back the following attributes:<p>
        '''

        attrs = '<dl>{}</dl>'.format(''.join(
            f'<dt>{attr}</dt><dd>{value}</dd>'
            for attr, value in auth_data.attributes.items()))

        logout_url = url_for('flask_saml2_sp.logout')
        logout = f'<form action="{logout_url}" method="POST"><input type="submit" value="Log out"></form>'

        return message + attrs + logout
    else:
        message = '<p>You are logged out.</p>'

        login_url = url_for('flask_saml2_sp.login')
        link = f'<p><a href="{login_url}">Log in to continue</a></p>'

        return message + link


api.add_resource(Desideratum, "/desiderata/<string:userid>")
api.add_resource(Despacho, "/despachos/<string:userid>")
api.add_resource(Tutoria, "/tutorias/<string:userid>")
app.run(debug=True)
