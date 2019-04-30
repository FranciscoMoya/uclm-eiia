import sqlite3, json
from flask import g

class DataLayerContext(object):
    def __init__(self, path = 'eii-ng.db'):
        self.path = path

    def __enter__(self):
        db = sqlite3.connect(self.path, detect_types = sqlite3.PARSE_DECLTYPES)
        db.execute("PRAGMA foreign_keys = 1")
        self.db = db
        self.db.row_factory = sqlite3.Row
        return self.db

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.db.close()

class DataLayer(object):
    def __init__(self, path = 'eii-ng.db'):
        db = sqlite3.connect(path, detect_types = sqlite3.PARSE_DECLTYPES)
        db.execute("PRAGMA foreign_keys = 1")
        self.db = db
        self.db.row_factory = sqlite3.Row
        self.profesores = Profesores(db)
        self.docencia = Docencia(db)
        self.propuestas_gastos = PropuestasGastos(db)
        self.gastos = Gastos(db)

    def close(self):
        self.db.close()


class ReadOnlyView(object):
    def __init__(self, db):
        self.db = db

    def get(self, value, column = None):
        if not column:
            column = self.columns[0][0]
        columns = tuple(c[0] for c in self.columns)
        colnames = ','.join(columns)
        with self.db as c:
            return [ dict(zip(columns, row)) for row in c.execute(f'''
                SELECT {colnames} FROM {self.table} WHERE {column} = ?
                ''', (value,)) ]

    def list(self, order_by = None):
        order_clause = f'ORDER BY {order_by}' if order_by else '' 
        columns = tuple(c[0] for c in self.columns)
        colnames = ','.join(columns)
        with self.db as c:
            return [ dict(zip(columns, row)) for row in c.execute(f'''
                SELECT {colnames} FROM {self.table} {order_clause}''') ]


class ReadOnlyTable(ReadOnlyView):
    def __init__(self, db):
        super().__init__(db)
        coldefs = ',\n    '.join(f'{name} {typ}' for name,typ,_ in self.columns)
        with self.db as c:
            c.execute(f'CREATE TABLE IF NOT EXISTS {self.table} (\n    {coldefs}\n)')


class ReadWriteTable(ReadOnlyTable):
    def store(self, record, replace = True):
        method = 'REPLACE' if replace else 'INSERT'
        with self.db as c:
            columns = ','.join(record.keys())
            fmt = ','.join('?'*len(record))
            c.execute(f'{method} INTO {self.table} ({columns}) VALUES ({fmt})',
                    tuple(record.values()))

    def update(self, record):
        with self.db as c:
            key = self.columns[0][0]
            columns = tuple(col for col in record.keys() if col != key and col in record)
            fmt = ','.join(f'{col} = ?' for col in columns)
            val = tuple(record[col] for col in columns) + (record[key],)
            print('UPDATE', record)
            print('UPDATE', fmt, val)
            c.execute(f"UPDATE {self.table} SET {fmt} WHERE {key} = ?", val)

    def delete(self, value, column = None):
        if not column:
            column = self.columns[0][0]
        with self.db as c:
            c.execute(f'''
                DELETE FROM {self.table} WHERE {column} = ?
                ''', (value,))


class Profesores(ReadWriteTable):
    table = 'profesores'
    columns = (
        ('userid', 'TEXT PRIMARY KEY NOT NULL', str),
        ('sn', 'TEXT', str),
        ('givenName', 'TEXT', str),
        ('catid', 'INTEGER REFERENCES categorias(catid)', int),
        ('deptid', 'INTEGER REFERENCES departamentos(deptid)', int),
        ('areaid', 'INTEGER REFERENCES areas(areaid)', int),
        ('email', 'TEXT', str),
        ('telefono', 'TEXT', str),
        ('despacho', 'TEXT', str),
        ('quinquenios', 'INTEGER DEFAULT 0', int),
        ('sexenios', 'INTEGER DEFAULT 0', int),
        ('sexenio_vivo', 'BOOLEAN DEFAULT 0', bool),
        ('head', 'BOOLEAN DEFAULT 0', bool),
        ('ad', 'BOOLEAN DEFAULT 0', bool),
        ('cd', 'BOOLEAN DEFAULT 0', bool),
        ('tu', 'BOOLEAN DEFAULT 0', bool),
        ('cu', 'BOOLEAN DEFAULT 0', bool)
    )

    def __init__(self,db):
        super().__init__(db)
        self.tutorias = Tutorias(db)
        self.areas = Areas(db)
        self.departamentos = Departamentos(db)
        self.categorias = Categorias(db)
        self.desiderata = Desiderata(db)
        self.expandidos = ProfesoresExpandidos(db)


class Areas(ReadWriteTable):
    table = 'areas'
    columns = (
        ('areaid', 'INTEGER PRIMARY KEY NOT NULL', int),
        ('area', 'TEXT UNIQUE NOT NULL', str),
        ('areabudget', 'REAL DEFAULT 0.0', float)
    )


class Departamentos(ReadWriteTable):
    table = 'departamentos'
    columns = (
        ('deptid', 'INTEGER PRIMARY KEY NOT NULL', int),
        ('departamento', 'TEXT UNIQUE NOT NULL', str)
    )


class Categorias(ReadWriteTable):
    table = 'categorias'
    columns = (
        ('catid', 'INTEGER PRIMARY KEY NOT NULL', int),
        ('categoria', 'TEXT UNIQUE NOT NULL', str)
    )


class Desiderata(ReadWriteTable):
    table = 'desiderata'
    columns = (
        ('userid', 'TEXT PRIMARY KEY NOT NULL', str),
        ('desideratum', 'JSON', str)
    )


class Tutorias(ReadWriteTable):
    table = 'tutorias'
    columns = (
        ('userid', 'TEXT PRIMARY KEY NOT NULL', str),
        ('tutoria', 'TEXT', str)
    )


class ProfesoresExpandidos(ReadOnlyView):
    table = 'profesores NATURAL JOIN areas NATURAL JOIN departamentos NATURAL JOIN categorias NATURAL join tutorias'
    columns = Profesores.columns + Areas.columns[1:] + Departamentos.columns[1:] + Categorias.columns[1:] + Tutorias.columns[1:]


class PropuestasGastos(ReadWriteTable):
    table = 'propuestas_gastos'
    columns = (
        ('pgid', 'INTEGER PRIMARY KEY NOT NULL', str), 
        ('userid', 'TEXT REFERENCES profesores(userid)', str), 
        ('timestamp', 'TEXT DEFAULT CURRENT_TIMESTAMP', str),
        ('importe', 'REAL NOT NULL', float),
        ('descripcion', 'TEXT NOT NULL', str),
        ('justificacion', 'TEXT', str)
    )


class Gastos(ReadWriteTable):
    table = 'gastos'
    columns = (
        ('pgid', 'INTEGER REFERENCES propuestas_gastos(pgid)', int),
        ('timestamp', 'TEXT DEFAULT CURRENT_TIMESTAMP', str),
        ('importe', 'REAL NOT NULL', float),
        ('justificacion', 'TEXT', str)
    )


class Docencia(object):
    def __init__(self,db):
        self.titulos = Titulos(db)
        self.asignaturas = Asignaturas(db)
        self.areas = Areas(db)
        self.profesores_asignaturas = ProfesoresAsignaturas(db)
        self.areas_asignaturas = AreasAsignaturas(db)
        self.por_profesor = DocenciaPorProfesor(db)
        self.por_area = DocenciaPorArea(db)


class Titulos(ReadWriteTable):
    table = 'titulos'
    columns = (
        ('titid', 'INTEGER PRIMARY KEY NOT NULL', int),
        ('titulo', 'TEXT UNIQUE NOT NULL', str),
        ('titects', 'INTEGER NOT NULL', int)
    )


class Asignaturas(ReadWriteTable):
    table = 'asignaturas'
    columns = (
        ('asigid', 'INTEGER PRIMARY KEY NOT NULL', int),
        ('asignatura', 'TEXT NOT NULL', str),
        ('titid', 'INTEGER REFERENCES titulos(titid)', int),
        ('semestre', 'INTEGER NOT NULL', int),
        ('ects', 'INTEGER NOT NULL', int)
    )


class DocenciaPorArea(ReadOnlyView):
    table = 'asignaturas NATURAL JOIN areas_asignaturas NATURAL JOIN titulos'
    columns = Asignaturas.columns \
        + (('areaid', 'TEXT REFERENCES areas(areaid)', int),) \
        + Titulos.columns[1:]

class DocenciaPorProfesor(ReadOnlyView):
    table = 'asignaturas NATURAL JOIN profesores_asignaturas'
    columns = Asignaturas.columns + \
            (('userid', 'TEXT REFERENCES profesores(userid)', str),)


class ProfesoresAsignaturas(ReadWriteTable):
    table = 'profesores_asignaturas'
    columns = (
        ('userid', 'TEXT REFERENCES profesores(userid)', str),
        ('asigid', 'INTEGER REFERENCES asignaturas(asigid)', int)
    )


class AreasAsignaturas(ReadWriteTable):
    table = 'areas_asignaturas'
    columns = (
        ('areaid', 'INTEGER REFERENCES areas(areaid)', int),
        ('asigid', 'INTEGER REFERENCES asignaturas(asigid)', int)
    )






# Custom JSON type
def adapt_json(data):
    return (json.dumps(data, sort_keys=True)).encode()

def convert_json(blob):
    return json.loads(blob.decode())

sqlite3.register_adapter(dict, adapt_json)
sqlite3.register_adapter(list, adapt_json)
sqlite3.register_adapter(tuple, adapt_json)
sqlite3.register_converter('JSON', convert_json)

# DataLayer singleton
def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = DataLayer()
    return db

def close_db():
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()