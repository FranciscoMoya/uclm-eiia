from flask_saml2.utils import certificate_from_file, private_key_from_file

APP_SECRET_KEY='not a secret'

SP_ISSUER='eii-to-sp'
SP_CERTIFICATE = certificate_from_file('cert/sp-certificate.pem')
SP_PRIVATE_KEY = private_key_from_file('cert/sp-private-key.pem')

import platform
sp_host = 'localhost:9000' if platform.system() == 'Windows' else 'intranet.eii-to.uclm.es'
idp_host = 'localhost:8000' if platform.system() == 'Windows' else 'eii-to.uclm.es:8000'

SERVER_NAME = sp_host

# Fake IdP
IDP_CERTIFICATE=certificate_from_file('cert/idp-certificate.pem')
IDP_METADATA_URL=f'http://{idp_host}/saml/metadata.xml'
IDP_SSO_URL=f'http://{idp_host}/saml/login/'
IDP_SLO_URL=f'http://{idp_host}/saml/logout/'
