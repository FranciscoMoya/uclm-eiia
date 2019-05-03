from flask_restful import Api, Resource, reqparse, abort
from .session import auth_profesor
from .data_layer import DataLayerContext, Profesores
from .ad import DirectorioActivo

parser = reqparse.RequestParser(bundle_errors=True, trim=True)
parser.add_argument('userid')
parser.add_argument('password')
parser.add_argument('name')
parser.add_argument('campus', default='Toledo')

class Directorio(Resource):
    method_decorators = [auth_profesor] 

    def post(self):
        args = parser.parse_args()
        self.userid = args['userid']
        self.password = args['password']
        name, campus = args['name'], args['campus']
        if name:
            return self.append_profesor(name, campus)
        return self.update_profesores()

    def append_profesor(self, name, campus):
        with DirectorioActivo(self.userid, self.password) as da:
            profes = [ entry_to_dict(p) for p in da.profesor(name=name,ou=campus) ]
        return self.update_database(profes)

    def update_profesores(self):
        with DirectorioActivo(self.userid, self.password) as da:
            profes = [ entry_to_dict(p) for p in da.profesores('ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO') ]
        return self.update_database(profes)

    def update_database(self, profes):
        nuevos = []
        with DataLayerContext() as db:
            profesores = Profesores(db)
            for p in profes:
                normalizeProfesor(p,db)
                prev = profesores.get(p['userid'])
                if len(prev) > 0:
                    profesores.update(p)
                else:
                    p['areaid'] = 1
                    profesores.store(p)
                    nuevos.append(p)
        return nuevos


ad_keys = ('sn','givenName','department','mail','title','telephoneNumber','displayName')
db_keys = ('sn','givenName','departamento','email','categoria','telefono')

def entry_to_dict(p):
    ret = { b: str(p[a] if p[a] else '') for a,b in zip(ad_keys,db_keys) }
    return ret

def normalizeProfesor(p, db):

    def indexof(value, table, column):
        cursor = db.execute(f'SELECT * from {table} WHERE {column} = ?', (value,))
        if len(cursor.fetchall()) == 0:
            db.execute(f'REPLACE INTO {table}({column}) VALUES (?)', 
                        (value,))
        cursor = db.execute(f'SELECT * from {table} WHERE {column} = ?', 
                        (value,))
        return next(cursor)[0]

    p['catid'] = indexof(p['categoria'], 'categorias', 'categoria')
    p['deptid'] = indexof(p['departamento'], 'departamentos', 'departamento')
    p['userid'] = p['email'].split('@')[0].lower()
    del p['categoria']
    del p['departamento']
    if not p['telefono']: del p['telefono']
