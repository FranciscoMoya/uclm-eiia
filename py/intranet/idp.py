#!/usr/bin/env python3
import logging, attr

from flask import Flask, abort, redirect, request, session, url_for
from flask.views import MethodView
from flask_saml2.utils import certificate_from_file, private_key_from_file
from flask_saml2.idp import create_blueprint, idp

logger = logging.getLogger(__name__)


@attr.s
class User:
    uid = attr.ib()
    eduPersonAffiliation = attr.ib()
    givenName = attr.ib()
    sn = attr.ib()
    email = attr.ib() # required by idp


class IdentityProvider(idp.IdentityProvider):
    def login_required(self):
        if not self.is_user_logged_in():
            next = url_for('login', next=request.url)

            abort(redirect(next))

    def is_user_logged_in(self):
        return 'user' in session and session['user'] in users

    def logout(self):
        del session['user']

    def get_current_user(self):
        return users[session['user']]


users = {user.uid: user for user in [
    User('francisco.moya', 'faculty', 'FRANCISCO', 'MOYA FERNÁNDEZ', 'francisco.moya'),
    User('fernando.castillo', 'faculty', 'FERNANDO JOSÉ', 'CASTILLO GARCÍA', 'fernando.castillo'),
    User('ismael.payo', 'faculty', 'ISMAEL', 'PAYO GUTIERREZ', 'ismael.payo'),
    User('gema.lominchar', 'staff', 'GEMA', 'LOMINCHAR DIAZ', 'gema.lominchar'),
]}


idp = IdentityProvider()


class Login(MethodView):
    def get(self):
        options = ''.join(f'<option value="{user.uid}">{user.sn}, {user.givenName} ({user.email})</option>'
                          for user in users.values())
        select = f'<div><label>Select a user: <select name="user">{options}</select></label></div>'

        next_url = request.args.get('next')
        next = f'<input type="hidden" name="next" value="{next_url}">'

        submit = '<div><input type="submit" value="Login"></div>'

        form = f'<form action="." method="post">{select}{next}{submit}</form>'
        header = '<title>Login</title><p>Please log in to continue.</p>'

        return header + form

    def post(self):
        user = request.form['user']
        next = request.form['next']

        session['user'] = user
        logging.info(f"Logged user {user} in")
        logging.info(f"Redirecting to {next}")

        return redirect(next)


app = Flask(__name__)
app.debug = True

app.secret_key = 'not a secret'

import platform
sp_host = 'localhost:9000' if platform.system() == 'Windows' else 'intranet.eii-to.uclm.es'
idp_host = 'localhost:8000' if platform.system() == 'Windows' else 'eii-to.uclm.es:8000'

app.config['SERVER_NAME'] = idp_host
app.config['SAML2_IDP'] = {
    'autosubmit': True,
    'certificate': certificate_from_file('cert/idp-certificate.pem'),
    'private_key': private_key_from_file('cert/idp-private-key.pem'),
}
app.config['SAML2_SERVICE_PROVIDERS'] = [
    {
        'CLASS': 'demo.AttributeSPHandler',
        'OPTIONS': {
            'display_name': 'Example Service Provider',
            'entity_id': f'http://{sp_host}/saml/metadata.xml',
            'acs_url': f'http://{sp_host}/saml/acs/',
            'certificate': certificate_from_file('cert/sp-certificate.pem'),
        },
    }
]

app.add_url_rule('/login/', view_func=Login.as_view('login'))
app.register_blueprint(create_blueprint(idp), url_prefix='/saml/')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
