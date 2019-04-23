from crud.data_layer import DataLayer

'''
    Migración de base de datos para normalizar el área de conocimiento.

    Esta migración deberá producirse una vez que se tengan las áreas de 
    conocimiento en los formularios de datos profesionales.
'''

a = DataLayer()
b = DataLayer(path='eii.new.db')


def transform(table, mapfn = lambda r:r):
    with a.db as c:
        with b.db as d:
            for row in c.execute(f"SELECT * FROM {table}"):
                fmt = ','.join('?'*len(row))
                data = mapfn(row)
                d.execute(f"REPLACE INTO {table} VALUES ({fmt})", data)


def area_to_id(row):
    data = list(row)
    data[1] = area_id(data[1])
    return data


def area_id(area):
    with b.db as c:
        c.execute("REPLACE INTO areas (nombre, presupuesto) VALUES (?,?)", (area, 0.0))
        for row in c.execute(f"SELECT areaid FROM areas WHERE nombre = '{area}'"):
            return row[0]
    assert False, 'Not reached'


transform('desiderata')
transform('tutorias')
transform('propuestas_gastos')
transform('gastos')
transform('areas')
transform('datos_profesionales', area_to_id)
