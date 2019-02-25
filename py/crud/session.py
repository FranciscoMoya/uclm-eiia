from flask_saml2.sp import ServiceProvider, create_blueprint
from flask import g, url_for, abort, redirect
from functools import wraps
from .saml import *


def auth_profesor(func, unrestricted=('get',)):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print(func.__name__, args, kwargs)
        if False and func.__name__ not in unrestricted:
            sp = get_sp()
            if not sp.is_user_logged_in():
                return redirect('/')
            auth = sp.get_auth_data_in_session()
            if kwargs['userid'] != auth.nameid:
                print('auth', auth)
                return abort(401)
        return func(*args, **kwargs)
    return wrapper


class EIIServiceProvider(ServiceProvider):
    def get_logout_return_url(self):
        return url_for('index', _external=True)

# SAML Session singleton
def get_sp():
    sp = getattr(g, '_service_provider', None)
    if sp is None:
        sp = g._service_provider = EIIServiceProvider()
    return sp

'''
SAML2_SETUP no puede llamar a get_sp() sin un contexto de aplicación,
pero lo que pone en el contexto de aplicación no llega al index.

Debe generarse otro contexto de aplicación. No influye desde el punto
de vista funcional pero merece la pena revisarlo.
'''


def SAML2_SETUP(app):
    with app.app_context():
        sp = get_sp()

    app.secret_key = APP_SECRET_KEY

    app.config['SAML2_SP'] = {
        'issuer':      SP_ISSUER,
        'certificate': SP_CERTIFICATE,
        'private_key': SP_PRIVATE_KEY,
    }

    app.config['SAML2_IDENTITY_PROVIDERS'] = {
        'uclm-test-idp': {
            'CLASS': 'flask_saml2.sp.idphandler.IdPHandler',
            'OPTIONS': {
                'display_name': 'My Identity Provider',
                'sso_url':     IDP_SSO_URL,
                'slo_url':     IDP_SLO_URL,
                'certificate': IDP_CERTIFICATE,
            },
        },
    }

    app.register_blueprint(create_blueprint(sp), url_prefix='/saml/')