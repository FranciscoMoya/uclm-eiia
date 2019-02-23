from flask_saml2.utils import certificate_from_file, private_key_from_file

APP_SECRET_KEY='not a secret'

SP_ISSUER='Test SP'
SP_CERTIFICATE = certificate_from_file('cert/sp-certificate.pem')
SP_PRIVATE_KEY = private_key_from_file('cert/sp-private-key.pem')

IDP_CERTIFICATE=certificate_from_file('cert/idp-certificate.pem')
IDP_SSO_URL='http://localhost:8000/saml/login/'
IDP_SLO_URL='http://localhost:8000/saml/logout/'
