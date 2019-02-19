import sqlite3
from flask import g

DATABASE = 'eii.db'
NUM_HORAS = 12

def cross(A,B):
    return ((a,b) for a in A for b in B)


class DataLayer(object):
    def __init__(self):
        self.db = sqlite3.connect(DATABASE)
        self.db.row_factory = sqlite3.Row
        self.autoCreateTables()

    def close(self):
        self.db.close()

    def autoCreateTables(self):
        c = self.db.cursor()
        dias = 'LMXJV'
        horas = range(NUM_HORAS)
        pref_columns = ','.join('[{}{}] TINYINT DEFAULT 0 NOT NULL'.format(*t) for t in cross(dias,horas))
        c.execute('''CREATE TABLE IF NOT EXISTS "desiderata" (
            [userid] TEXT PRIMARY KEY NOT NULL, {})'''.format(pref_columns))
        c.close()
        self.db.commit()

    def insert(self, userid, *args):
        c = self.db.cursor()
        pref_columns = ''.join(',{}'.format(i) for i in args)
        print('userid={}\ndesideratum={}\n'.format(userid,pref_columns))
        c.execute("REPLACE INTO desiderata VALUES ('{}'{})".format(userid, pref_columns))
        c.close()
        self.db.commit()

    def lookup(self, userid):
        c = self.db.cursor()
        c.execute("SELECT * FROM desiderata WHERE userid = '{}'".format(userid))
        ret = c.fetchone()
        c.close()
        return ret

    def delete(self, userid):
        c = self.db.cursor()
        c.execute("DELETE FROM desiderata WHERE userid = '{}'".format(userid))
        c.commit()
        c.close()


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