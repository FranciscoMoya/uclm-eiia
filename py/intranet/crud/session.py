import platform
if platform.system() == 'Windows':
    from functools import wraps

    def auth_profesor(func, unrestricted=('get',)):
        @wraps(func)
        def wrapper(*args, **kwargs):
            return func(*args, **kwargs)
        return wrapper


    class FakeUserData(object):
        def __init__(self):
            self.uid = 'francisco.moya'
            self.sn = 'MOYA FERNÁNDEZ'
            self.givenName = 'FRANCISCO'
            self.eduPersonAffiliation = 'faculty'

    class FakeAuthData(object):
        def __init__(self):
            self.attributes = FakeUserData()

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
    from flask import g, url_for, abort, redirect
    from functools import wraps
    from flask_saml2.utils import certificate_from_file, private_key_from_file


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
                    #print('Error auth', auth)
                    return abort(401)
            return func(*args, **kwargs)
        return wrapper


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

# SAML Session singleton
sp_ = None
def get_sp():
    global sp_
    if sp_ is None:
        sp_ = EIIServiceProvider()
    return sp_
