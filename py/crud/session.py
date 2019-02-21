from flask_saml2.sp import ServiceProvider, create_blueprint
from flask import g, url_for
from .saml import *

class EIIServiceProvider(ServiceProvider):
    def get_logout_return_url(self):
        return url_for('index', _external=True)

# SAML Session singleton
def get_sp():
    sp = getattr(g, '_service_provider', None)
    if sp is None:
        sp = g._service_provider = EIIServiceProvider()
    return sp


# Imitating CORS
def SAML2_SETUP(app):
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
                'display_name': 'UCLM SSO',
                'sso_url':     IDP_SSO_URL,
                'slo_url':     IDP_SLO_URL,
                'certificate': IDP_CERTIFICATE,
            },
        },
    }

    app.register_blueprint(create_blueprint(get_sp()), url_prefix='/saml/')
