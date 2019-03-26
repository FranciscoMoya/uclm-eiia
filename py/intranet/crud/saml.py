from flask_saml2.utils import certificate_from_file, private_key_from_file

APP_SECRET_KEY='not a secret'

SP_ISSUER='eii-to-sp'
SP_CERTIFICATE = certificate_from_file('cert/sp-certificate.pem')
SP_PRIVATE_KEY = private_key_from_file('/home/UCLM/francisco.moya/key.pem')

import platform
sp_host = 'localhost:9000' if platform.system() == 'Windows' else 'intranet.eii-to.uclm.es'
idp_host = 'localhost:8000' if platform.system() == 'Windows' else 'adas.uclm.es'

# Fake IdP
IDP_CERTIFICATE=certificate_from_file('cert/idp-certificate.pem')
