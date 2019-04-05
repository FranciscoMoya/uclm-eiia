
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

class EIIServiceProvider(ServiceProvider):
    def get_logout_return_url(self):
        return url_for('index', _external=True)

    def is_user_logged_in(self):
        return True

    def get_auth_data_in_session(self):
        return FakeAuthData()

# SAML Session singleton
sp_ = None
def get_sp():
    global sp_
    if sp_ is None:
        sp_ = EIIServiceProvider()
    return sp_


def SAML2_SETUP(app):
    pass

