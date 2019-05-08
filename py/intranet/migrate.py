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
transform('asignaturas', 'asignaturas')
transform('profesores_asignaturas', 'profesores_asignaturas', lambda x: tuple(x) + (True, True))
transform('areas_asignaturas', 'areas_asignaturas')
