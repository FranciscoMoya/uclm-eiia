#!/usr/bin/env python3
from flask import Flask, url_for

from flask_saml2.sp import ServiceProvider, create_blueprint
from crud.saml import *


class ServiceProvider(ServiceProvider):
    def get_logout_return_url(self):
        return url_for('index', _external=True)


import platform
sp_host = 'localhost:9000' if platform.system() == 'Windows' else 'intranet.eii-to.uclm.es'
idp_host = 'localhost:8000' if platform.system() == 'Windows' else 'adas.uclm.es'

sp = ServiceProvider()

app = Flask(__name__)
app.debug = True
app.secret_key = 'not a secret'

app.config['SERVER_NAME'] = sp_host
app.config['SAML2_SP'] = {
    'issuer': 'Test SP',
    'certificate': SP_CERTIFICATE,
    'private_key': SP_PRIVATE_KEY,
}

app.config['SAML2_IDENTITY_PROVIDERS'] = [
    {
        'CLASS': 'flask_saml2.sp.idphandler.IdPHandler',
        'OPTIONS': {
            'display_name': 'My Identity Provider',
            'entity_id': f'http://{idp_host}/metadata/index.php/saml2',
            'sso_url': f'http://{idp_host}/SAML2/SSOService.php',
            'slo_url': f'http://{idp_host}/SAML2/SSOService.php',
            'certificate': IDP_CERTIFICATE,
        },
    },
]


@app.route('/')
def index():
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


app.register_blueprint(create_blueprint(sp), url_prefix='/saml/')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000)

