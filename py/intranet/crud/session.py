from flask_saml2.sp import ServiceProvider, create_blueprint
from flask import g, url_for, abort, redirect
from functools import wraps
from .saml import *


def auth_profesor(func, unrestricted=('get',)):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print(func.__name__, args, kwargs)
        if func.__name__ not in unrestricted:
            sp = get_sp()
            if not sp.is_user_logged_in():
                return redirect('/')
            auth = sp.get_auth_data_in_session()
            attr = auth.attributes
            if kwargs['userid'] != attr['uid'] or 'faculty' != attr['eduPersonAffiliation']:
                print('auth', auth)
                return abort(401)
        return func(*args, **kwargs)
    return wrapper


class EIIServiceProvider(ServiceProvider):
    def get_logout_return_url(self):
        return url_for('index', _external=True)

# SAML Session singleton
sp_ = None
def get_sp():
    global sp_
    if sp_ is None:
        sp_ = EIIServiceProvider()
    return sp_

def SAML2_SETUP(app):
    sp = get_sp()

    app.secret_key = APP_SECRET_KEY

    app.config['SERVER_NAME'] = SERVER_NAME
    app.config['SAML2_SP'] = {
        'issuer':      SP_ISSUER,
        'certificate': SP_CERTIFICATE,
        'private_key': SP_PRIVATE_KEY,
    }

    app.config['SAML2_IDENTITY_PROVIDERS'] = [
        {
            'CLASS': 'flask_saml2.sp.idphandler.IdPHandler',
            'OPTIONS': {
                'display_name': 'My Identity Provider',
                'entity_id': IDP_METADATA_URL,
                'sso_url': IDP_SSO_URL,
                'slo_url': IDP_SLO_URL,
                'certificate': IDP_CERTIFICATE,
            },
        },
    ]

    app.register_blueprint(create_blueprint(sp), url_prefix='/saml/')

