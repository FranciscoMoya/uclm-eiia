from flask_saml2.utils import certificate_from_file, private_key_from_file

APP_SECRET_KEY='not a secret'

SP_ISSUER='Test SP'
SP_CERTIFICATE = certificate_from_file('cert/sp-certificate.pem')
SP_PRIVATE_KEY = private_key_from_file('cert/sp-private-key.pem')

host='localhost'
host='bestia.uclm.es'


# Fake IdP

IDP_CERTIFICATE=certificate_from_file('cert/idp-certificate.pem')
IDP_PRIVATE_KEY = private_key_from_file('cert/idp-private-key.pem')
IDP_SSO_URL=f'http://{host}:8000/saml/login/'
IDP_SLO_URL=f'http://{host}:8000/saml/logout/'
IDP_ACS_URL=f'http://{host}:5000/saml/acs/uclm-test-idp/'