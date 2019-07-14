from flask_restful import Api, Resource, reqparse, abort
from .data_layer import get_db
from .session import auth_profesor


class DBResourceBase(Resource):
    method_decorators = [auth_profesor]

    def db(self):
        data = getattr(self, 'data', None)
        if data: return data
        self.data = get_db()
        for a in self.table.split('.'):
            self.data = getattr(self.data, a)
        parser = reqparse.RequestParser(bundle_errors=True, trim=True)
        for arg, _, typ in self.data.columns:
            parser.add_argument(arg, type=typ)
        self.parser = parser
        return self.data

class DBSchemaClass(DBResourceBase):
    '''Schema resource for a DB backed resource'''
    
    def get(self):
        try:
            return [ {'column': c[0], 'type': c[2].__name__} for c in self.db().columns ]
        except Exception as ex:
            return {"message": f"Unable to get {self.table} schema.\n{ex}"}, 400


class DBResourceClass(DBResourceBase):
    '''A DB backed resource'''
    
    def get(self, column, value):
        try:
            return self.db().get(value, column)
        except Exception as ex:
            return {"message": f"Unable to get {self.table} where {column} = {value}.\n{ex}"}, 400

    def delete(self, column, value):
        try:
            self.db().delete(value, column)
            return {"message": f"Deleted {self.table} where {column} = {value}."}, 200
        except Exception as ex:
            return {"message": f"Unable to delete {self.table} where {column} = {value}.\n{ex}"}, 400


class DBResourceContainerClass(DBResourceBase):
    '''A DB backed resource container (table)'''

    def get(self, column = None):
        try:
            return self.db().list(order_by = column)
        except Exception as ex:
            return {"message": f"Unable to get {self.table} ordered by column {column}.\n{ex}"}, 400

    def post(self, column = None):
        try:
            db = self.db()
            args = self.parser.parse_args()
            db.store(args, replace = True)
            return {"message": f"Added/replaced {self.table} record."}, 201
        except Exception as ex:
            return {"message": f"Unable to post {self.table} column {column}.\n{ex}"}, 400

    def put(self, column = None):
        try:
            db = self.db()
            args = self.parser.parse_args()
            db.update(args)
            return {"message": f"Updated {self.table} record {args}."}, 202
        except Exception as ex:
            return {"message": f"Unable to put {self.table} by column {column}.\n{ex}"}, 400


def DBSchema(tablename):
    return type('DBS_' + tablename.replace('.','_'), (DBSchemaClass,), {'table': tablename})

def DBResource(tablename):
    return type('DBR_' + tablename.replace('.','_'), (DBResourceClass,), {'table': tablename})

def DBResourceContainer(tablename):
    return type('DBC_' + tablename.replace('.','_'), (DBResourceContainerClass,), {'table': tablename})
