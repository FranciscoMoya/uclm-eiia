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

    def profesores(self, escuela, attr=['sn','givenName','department','mail','title','telephoneNumber', 'displayName']):
        self.conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', 
                    '(&(objectClass=person)(physicalDeliveryOfficeName={}))'.format(escuela), 
                    attributes=attr)
        return self.conn.entries

    def profesor(self, name=None, nif=None, attr='*'):
        filter=''
        if nif: filter += '(UCLMnif={})'.format(nif)
        if name: filter += '(displayName=*{}*)'.format(name)
        self.conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', 
                         '(&(objectclass=person){})'.format(filter), 
                         attributes = attr)
        return self.conn.entries

    def correos_profesores(self, escuela):
        self.conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', 
                    '(&(objectClass=person)(physicalDeliveryOfficeName={}))'.format(escuela), 
                    attributes=['department','mail'])
        return self.conn.entries

    def alumnos_displayNames(self, escuela, attr=['sn', 'givenName', 'displayName']):
        self.conn.search('ou={},ou=Toledo,ou=Alumnos,dc=uclm,dc=es'.format(escuela), 
                         '(objectclass=person)', 
                         attributes=attr)
        return { (str(p['sn']), str(p['givenName'])): str(p['displayName'])  for p in self.conn.entries }


def display_data(data):
    for e in data:
        display_entry(e)

def display_entry(e):
    print(e['displayName'])
    for key in e.entry_attributes:
        print("   {}: {}".format(key, e[str(key)]))
    print()

#conn.search('cn=francisco.moya,ou=Toledo,ou=PDI,dc=uclm,dc=es', '(objectclass=person)', attributes='*')
#conn.search('cn=Grupo.PDI.TO.EII,ou=PDI,dc=uclm,dc=es', '(objectclass=*)', attributes='member')
#conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', '(objectClass=person)', attributes='displayName')
if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Consulta el directorio activo.')
    parser.add_argument('--centro', nargs='?', const='ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO', default=None,
                        help='Extrae datos de todos el PDI de un centro')
    parser.add_argument('--name', action='store', 
                        help='Extrae datos de un profesor por nombre')
    parser.add_argument('--nif', action='store', 
                        help='Extrae datos de un profesor por DNI')
    parser.add_argument('--attr', nargs='*', default='*',
                        help='Atributos a consultar')
    args = parser.parse_args()

    with DirectorioActivo(USERNAME, PASSWORD) as da:
        if args.nif or args.name:
            display_data(da.profesor(name=args.name, nif=args.nif, attr=args.attr))

        if args.centro:
            display_data(da.profesores(args.centro, args.attr))

        #print(da.correos_profesores('ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO'))
        #print(len(da.alumnos_displayNames('E.U. INGENIERIA TECNICA INDUSTRIAL')))
        #print(da.conn.search('ou=E.U. INGENIERIA TECNICA INDUSTRIAL,ou=Toledo,ou=Alumnos,dc=uclm,dc=es', '(objectclass=person)', attributes=['sn', 'givenName', 'displayName']))
        #print(da.conn.entries)
