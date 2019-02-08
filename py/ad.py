from ldap3 import Server, Connection, ALL
from cv_cfg import USERNAME, PASSWORD

class DirectorioActivo(object):
    def __init__(self, user, passwd):
        self.server = Server('dcto03.uclm.es', get_info=ALL)
        self.conn = Connection(self.server, 'cn={},ou=Toledo,ou=PDI,dc=uclm,dc=es'.format(user), passwd, auto_bind=True)

    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_value, traceback):
        self.conn.unbind()

    def profesores(self, escuela):
        self.conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', 
                    '(&(objectClass=person)(physicalDeliveryOfficeName={}))'.format(escuela), 
                    attributes=['sn','givenName','department','mail','title','telephoneNumber', 'displayName'])
        return self.conn.entries

    def profesor(self, name):
        self.conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', 
                         '(&(objectclass=person)(sn={}))'.format(name), 
                         attributes='*')
        return self.conn.entries

    def correos_profesores(self, escuela):
        self.conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', 
                    '(&(objectClass=person)(physicalDeliveryOfficeName={}))'.format(escuela), 
                    attributes=['department','mail'])
        return self.conn.entries

#conn.search('cn=francisco.moya,ou=Toledo,ou=PDI,dc=uclm,dc=es', '(objectclass=person)', attributes='*')
#conn.search('cn=Grupo.PDI.TO.EII,ou=PDI,dc=uclm,dc=es', '(objectclass=*)', attributes='member')
#conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', '(objectClass=person)', attributes='displayName')
if __name__ == '__main__':
    with DirectorioActivo(USERNAME, PASSWORD) as da:
        #print(da.profesores('ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO'))
        print(da.profesor('AMA ESPINOSA'))
        #print(da.correos_profesores('ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO'))