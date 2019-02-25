#!/usr/bin/env python3
from flask import Flask, abort, redirect, request, session, url_for
from flask.views import MethodView
import attr

from flask_saml2.idp import create_blueprint, idp
from crud.saml import *

@attr.s
class User:
    username = attr.ib()
    email = attr.ib()

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


users = {user.username: user for user in [
    User('francisco.moya', 'francisco.moya'),
    User('alex', 'alex'),
    User('jordan', 'jordan'),
]}


idp = IdentityProvider()


class Login(MethodView):
    def get(self):
        options = ''.join(f'<option value="{user.username}">{user.email}</option>'
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
        print("Logged user", user, "in")
        print("Redirecting to", next)

        return redirect(next)


app = Flask(__name__)
app.debug = True
app.secret_key = 'not a secret'
app.config['SAML2_IDP'] = {
    'issuer': 'Test IdP',
    'autosubmit': True,
    'certificate': IDP_CERTIFICATE,
    'private_key': IDP_PRIVATE_KEY,
}
app.config['SAML2_SERVICE_PROVIDERS'] = {
    'my-test-sp': {
        'CLASS': 'flask_saml2.idp.sp.demo.AttributeSPHandler',
        'OPTIONS': {
            'acs_url': IDP_ACS_URL,
            'certificate': SP_CERTIFICATE,
        },
    },
}

app.add_url_rule('/login/', view_func=Login.as_view('login'))
app.register_blueprint(create_blueprint(idp), url_prefix='/saml/')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
