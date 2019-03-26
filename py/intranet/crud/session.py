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
                print('Error auth', auth)
                #return abort(401)
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

    # for testing
    #sp_host = '161.67.1.33:9000'
    #idp_host = 'eii-to.uclm.es:8000'

    app.secret_key = APP_SECRET_KEY

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
                'entity_id': f'https://{idp_host}/metadata/index.php/saml2',
                'sso_url': f'https://{idp_host}/SAML2/SSOService.php',
                'slo_url': f'https://{idp_host}/SAML2/SLOService.php',
                'certificate': IDP_CERTIFICATE,
            },
        },
    ]

    app.register_blueprint(create_blueprint(sp), url_prefix='/saml/')

