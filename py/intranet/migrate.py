from crud.data_layer import DataLayer
from crud.data_layer_old import DataLayer as DataLayerOld
from crud.profesores import ProfesoresList

a = DataLayerOld()
b = DataLayer()
profesores = { p['userid']:p for p in ProfesoresList().get() }

def indexof(value, table, column):
    cursor = d.execute(f'SELECT * from {table} WHERE {column} = ?', (value,))
    if len(cursor.fetchall()) == 0:
        d.execute(f'REPLACE INTO {table}({column}) VALUES (?)', 
                    (value,))
    cursor = d.execute(f'SELECT * from {table} WHERE {column} = ?', 
                    (value,))
    return next(cursor)[0]

def transform(ta,tb,filtro=lambda x:x):
    with a.db as c:
        with b.db as d:
            for row in c.execute(f'SELECT * FROM {ta}'):
                row = filtro(row)
                fmt = ','.join('?'*len(row))
                d.execute(f'INSERT INTO {tb} VALUES ({fmt})', row)


transform('areas', 'areas', lambda x: x[:-1] + (0.0,))

with a.db as c:
    with b.db as d:
        for row in c.execute('SELECT * FROM datos_profesionales'):
            profe = dict(zip(('userid', 'area', 'telefono', 'despacho', 'quinquenios', 'sexenios', 'sexenio_vivo', 'acreditacion'), row))
            p = profesores[profe['userid']]
            for i,j in zip(('title','givenName','sn','mail'),
                            ('categoria', 'givenName', 'sn','email')):
                profe[j] = p[i]
            
            profe['deptid'] = indexof(p['department'],'departamentos','departamento')
            profe['areaid'] = indexof(profe['area'],'areas','area')
            profe['catid'] = indexof(profe['categoria'],'categorias','categoria')
            for s in profe['acreditacion']:
                profe[s] = 1

            del profe['acreditacion']
            del profe['area']
            del profe['categoria']
            b.profesores.store(profe)

transform('desiderata', 'desiderata')
transform('tutorias', 'tutorias')

