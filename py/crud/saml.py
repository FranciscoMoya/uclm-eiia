from flask_saml2.utils import certificate_from_file, private_key_from_file

APP_SECRET_KEY='not a secret'

SP_ISSUER='eii-to-sp'
SP_CERTIFICATE = certificate_from_file('cert/sp-certificate.pem')
SP_PRIVATE_KEY = private_key_from_file('cert/sp-private-key.pem')

import platform
host = 'localhost'if platform.system() == 'Windows' else 'intranet.eii-to.uclm.es'

# Fake IdP

IDP_CERTIFICATE=certificate_from_file('cert/idp-certificate.pem')
IDP_PRIVATE_KEY = private_key_from_file('cert/idp-private-key.pem')
IDP_METADATA_URL=f'http://{host}/idp/saml/metadata.xml'
IDP_SSO_URL=f'http://{host}/idp/saml/login/'
IDP_SLO_URL=f'http://{host}/idp/saml/logout/'
IDP_ACS_URL=f'http://{host}/eii/saml/acs/eii-to/'
