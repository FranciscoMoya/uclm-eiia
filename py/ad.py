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
        return [e for e in self.conn.entries if 'PERSONAL' not in str(e['title'])]

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


def display_data(data, out):
    for e in data:
        display_entry(e, out)

def display_entry(e, out):
    print(e['displayName'], file=out)
    for key in e.entry_attributes:
        print("   {}: {}".format(key, e[str(key)]), file=out)
    print(file=out)

def display_summary(data, out):
    dep = set(str(e['department']) for e in data)
    cat = set(str(e['title']) for e in data )
    por_dep  = { d: len([p for p in data if p['department'] == d]) for d in dep }
    print('RESUMEN POR DEPARTAMENTO:', file=out)
    display_counters(por_dep, out)
    por_cat  = { d: len([p for p in data if p['title'] == d]) for d in cat }
    print('\nRESUMEN POR CATEGORÍA:', file=out)
    display_counters(por_cat, out)

def display_counters(d, out):
    for k in d:
        print('  {}: {}'.format(k, d[k]), file=out)

#conn.search('cn=francisco.moya,ou=Toledo,ou=PDI,dc=uclm,dc=es', '(objectclass=person)', attributes='*')
#conn.search('cn=Grupo.PDI.TO.EII,ou=PDI,dc=uclm,dc=es', '(objectclass=*)', attributes='member')
#conn.search('ou=Toledo,ou=PDI,dc=uclm,dc=es', '(objectClass=person)', attributes='displayName')
if __name__ == '__main__':
    import argparse, sys

    parser = argparse.ArgumentParser(description='Consulta el directorio activo.')
    parser.add_argument('--school', nargs='?', const='ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO', default=None,
                        help='Extrae datos de todos el PDI de un centro')
    parser.add_argument('--name', action='store', 
                        help='Extrae datos de un profesor por nombre')
    parser.add_argument('--nif', action='store', 
                        help='Extrae datos de un profesor por DNI')
    parser.add_argument('--attr', nargs='*', default='*',
                        help='Atributos a consultar')
    parser.add_argument('--summary', action='store_true',
                        help='Muestra resumen')
    parser.add_argument('--out', action='store', type=argparse.FileType('w', encoding='utf-8'), default=sys.stdout,
                        help='Archivo de salida')
    args = parser.parse_args()

    with DirectorioActivo(USERNAME, PASSWORD) as da:
        if args.nif or args.name:
            display_data(da.profesor(name=args.name, nif=args.nif, attr=args.attr), args.out)

        if args.school:
            prof = da.profesores(args.school, args.attr)
            display_data(prof, args.out)
            if args.summary:
                display_summary(prof, args.out)

        #print(da.correos_profesores('ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO'))
        #print(len(da.alumnos_displayNames('E.U. INGENIERIA TECNICA INDUSTRIAL')))
        #print(da.conn.search('ou=E.U. INGENIERIA TECNICA INDUSTRIAL,ou=Toledo,ou=Alumnos,dc=uclm,dc=es', '(objectclass=person)', attributes=['sn', 'givenName', 'displayName']))
        #print(da.conn.entries)
