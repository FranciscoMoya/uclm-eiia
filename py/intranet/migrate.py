from crud.data_layer import DataLayer
from crud.data_layer_old import DataLayer as DataLayerOld
import json

a = DataLayerOld()
b = DataLayer(path="eii-ng-2.db")

def transform(ta,tb,filtro=lambda x:x):
    with a.db as c:
        with b.db as d:
            for row in c.execute(f'SELECT * FROM {ta}'):
                row = filtro(row)
                fmt = ','.join('?'*len(row))
                d.execute(f'INSERT INTO {tb} VALUES ({fmt})', row)


transform('departamentos', 'departamentos')
transform('categorias', 'categorias')
transform('superareas', 'superareas')
transform('areas', 'areas')
transform('profesores', 'profesores')
transform('desiderata', 'desiderata')
transform('tutorias', 'tutorias')
transform('propuestas_gastos', 'propuestas_gastos')
transform('gastos', 'gastos')
transform('titulos', 'titulos')
transform('asignaturas', 'asignaturas', lambda x: tuple(x) + (50,))
transform('profesores_asignaturas', 'profesores_asignaturas')
transform('areas_asignaturas', 'areas_asignaturas')

with b.db as d:
    d.execute('''INSERT INTO time_patterns VALUES
    (1,"1x50"),
    (2,"2x50"),
    (3,"3x50"),
    (21,"1x100"),
    (22,"2x100"),
    (31,"1x150"),
    (32,"2x150");
    ''')
    d.execute('''INSERT INTO date_patterns VALUES
    (1,"Semestre completo"),
    (2,"Semanas pares"),
    (3,"Semanas impares");
    ''')
    with a.db as c:
        for row in c.execute(f'SELECT * FROM asignaturas'):
            d.execute(f'INSERT INTO preferencias VALUES (?,?,?,?)', (row[0], 0,  3, 1))
            d.execute(f'INSERT INTO preferencias VALUES (?,?,?,?)', (row[0], 1, 21, 3))
            d.execute(f'INSERT INTO preferencias VALUES (?,?,?,?)', (row[0], 1, 21, 2))
