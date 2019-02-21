import sqlite3, json
from flask import g

DATABASE = 'eii.db'

class DataLayer(object):
    def __init__(self):
        self.db = sqlite3.connect(DATABASE, detect_types = sqlite3.PARSE_DECLTYPES)
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
                CREATE TABLE IF NOT EXISTS "despachos" (
                    [userid] TEXT PRIMARY KEY NOT NULL, 
                    [despacho] TEXT
                )''')

    def tset(self, table, userid, value):
        _check(table)
        with self.db as c:
            c.execute("REPLACE INTO {} VALUES (?, ?)".format(table), (userid, value))

    def tget(self, table, userid):
        _check(table)
        with self.db as c:
            for row in c.execute("SELECT * FROM {} WHERE userid = ?".format(table), (userid,)):
                return row[1]
        return None

    def tdel(self, table, userid):
        _check(table)
        with self.db as c:
            c.execute("DELETE FROM {} WHERE userid = ?".format(table), (userid,))

    def list(self, table):
        _check(table)
        with self.db as c:
            return [ tuple(row) for row in c.execute("SELECT * FROM {}".format(table)) ]

def _check(table):
    assert table in ('desiderata', 'tutorias', 'despachos')

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