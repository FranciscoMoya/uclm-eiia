import platform
from .data_layer import es_profesor, es_jefe_area
from flask import g, url_for, abort, redirect
from flask_restful import reqparse
from functools import wraps

if platform.system() == 'Windows':
    class FakeAuthData(object):
        def __init__(self):
            self.attributes = {
                'uid': 'alberto.rico',
                'sn':  'MOYA FERNÁNDEZ',
                'givenName': 'FRANCISCO',
                'eduPersonAffiliation': 'faculty'
            }
            
    class EIIServiceProvider(object):
        def get_logout_return_url(self):
            return url_for('index', _external=True)

        def is_user_logged_in(self):
            return True

        def get_auth_data_in_session(self):
            return FakeAuthData()

    def SAML2_SETUP(app):
        app.secret_key = 'not a secret'

else:
    from flask_saml2.sp import ServiceProvider, create_blueprint
    from flask_saml2.utils import certificate_from_file, private_key_from_file

    class EIIServiceProvider(ServiceProvider):
        def get_logout_return_url(self):
            return url_for('index', _external=True)

    SP_CERTIFICATE = certificate_from_file('cert/sp-certificate.pem')
    SP_PRIVATE_KEY = private_key_from_file('/home/UCLM/francisco.moya/key.pem')
    IDP_CERTIFICATE=certificate_from_file('cert/idp-certificate.pem')

    sp_host = 'intranet.eii-to.uclm.es'
    idp_host = 'adas.uclm.es'

    def SAML2_SETUP(app):
        sp = get_sp()

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
                    'entity_id': f'https://{idp_host}/metadata/index.php/saml2',
                    'sso_url': f'https://{idp_host}/SAML2/SSOService.php',
                    'slo_url': f'https://{idp_host}/SAML2/SLOService.php',
                    'certificate': IDP_CERTIFICATE,
                },
            },
        ]
        app.register_blueprint(create_blueprint(sp), url_prefix='/saml/')


def auth_profesor(func, unrestricted=('get',)):
    @wraps(func)
    def wrapper(*args, **kwargs):
        #print(func.__name__, args, kwargs)
        def tiene_permiso(uid):
            if uid == 'francisco.moya':
                return True
            if not es_profesor(uid):
                return False
            if es_jefe_area(uid):
                return True
            if es_propio_usuario(uid):
                return True
            print('auth_profesor: not authorized', uid, args, kwargs)
            return False

        def es_propio_usuario(uid):
            # Si está en formdata
            try:
                func.__self__.db() # Required to build parser
                reqargs = func.__self__.parser.parse_args()
                if 'userid' in reqargs and reqargs['userid'] == uid:
                    return True
            except:
                pass
            # Si está en la URL directamente
            if 'userid' in kwargs and kwargs['userid'] == uid:
                return True
            # Si está en la URL como filtro
            if 'column' in kwargs and kwargs['column'] == 'userid' and \
                'value' in kwargs and kwargs['value']  == uid:
                return True
            return False

        if func.__name__ not in unrestricted:
            sp = get_sp()
            if not sp.is_user_logged_in():
                return redirect('/')
            auth = sp.get_auth_data_in_session()
            aa = auth.attributes
            if not tiene_permiso(aa['uid']):
                return abort(401)                   
        return func(*args, **kwargs)
    return wrapper

# SAML Session singleton
sp_ = None
def get_sp():
    global sp_
    if sp_ is None:
        sp_ = EIIServiceProvider()
    return sp_
