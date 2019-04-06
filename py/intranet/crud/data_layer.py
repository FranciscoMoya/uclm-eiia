import sqlite3, json
from flask import g

DATABASE = 'eii.db'

class DataLayer(object):
    def __init__(self, path = DATABASE):
        self.db = sqlite3.connect(path, detect_types = sqlite3.PARSE_DECLTYPES)
        self.db.row_factory = sqlite3.Row
        self.autoCreateTables()

    def close(self):
        self.db.close()

    def autoCreateTables(self):
        with self.db as c:
            c.execute('''
                CREATE TABLE IF NOT EXISTS "desiderata" (
                    [userid] TEXT PRIMARY KEY NOT NULL, 
                    [desideratum] JSON
                )''')
            c.execute('''
                CREATE TABLE IF NOT EXISTS "tutorias" (
                    [userid] TEXT PRIMARY KEY NOT NULL, 
                    [tutoria] TEXT
                )''')
            c.execute('''
                CREATE TABLE IF NOT EXISTS "datos_profesionales" (
                    [userid] TEXT PRIMARY KEY NOT NULL, 
                    [area] TEXT,
                    [telefono] TEXT,
                    [despacho] TEXT,
                    [quinquenios] INTEGER,
                    [sexenios] INTEGER,
                    [sexenio_vivo] BOOLEAN,
                    [acreditacion] JSON
                )''')

    def tset(self, table, userid, value):
        _check(table)
        with self.db as c:
            c.execute(f"REPLACE INTO {table} VALUES (?, ?)", (userid, value))

    def mset(self, table, userid, value):
        _check(table)
        row = (userid, *value)
        fmt = ','.join('?'*len(row))
        with self.db as c:
            c.execute(f"REPLACE INTO {table} VALUES ({fmt})", row)

    def tget(self, table, userid):
        _check(table)
        with self.db as c:
            for row in c.execute(f"SELECT * FROM {table} WHERE userid = ?", (userid,)):
                return _get_value(row)
        return None

    def aget(self, table):
        _check(table)
        with self.db as c:
            return { row[0]: _get_value(row) for row in c.execute(f"SELECT * FROM {table}") }

    def tdel(self, table, userid):
        _check(table)
        with self.db as c:
            c.execute(f"DELETE FROM {table} WHERE userid = ?", (userid,))

    def tlist(self, table):
        _check(table)
        with self.db as c:
            return [ tuple(row) for row in c.execute(f"SELECT * FROM {table}") ]

def _check(table):
    assert table in ('desiderata', 'tutorias', 'despachos', 'datos_profesionales')

def _get_value(row):
    if len(row) == 2:
        return row[1]
    return row[1:]


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