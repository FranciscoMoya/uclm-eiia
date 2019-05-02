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
            print('argument', arg, typ)
        self.parser = parser
        return self.data

class DBResourceClass(DBResourceBase):
    '''A DB backed resource'''
    
    def get(self, column, value):
        try:
            return self.db().get(value, column)
        except:
            return {"message": f"Unable to get {self.table} where {column} = {value}."}, 400

    def delete(self, column, value):
        try:
            self.db().delete(value, column)
            return {"message": f"Deleted {self.table} where {column} = {value}."}, 200
        except:
            return {"message": f"Unable to delete {self.table} where {column} = {value}."}, 400


class DBResourceContainerClass(DBResourceBase):
    '''A DB backed resource container (table)'''

    def get(self, column = None):
        try:
            return self.db().list(order_by = column)
        except:
            return {"message": f"Unable to get {self.table} column {column}."}, 400

    def post(self, column = None):
        try:
            db = self.db()
            args = self.parser.parse_args()
            print('post', args)
            db.store(args, replace = True)
            return {"message": f"Added/replaced {self.table} record."}, 201
        except:
            return {"message": f"Unable to post {self.table} column {column}."}, 400

    def put(self, column = None):
        try:
            db = self.db()
            args = self.parser.parse_args()
            print('put', args)
            db.update(args)
            return {"message": f"Updated {self.table} record {args}."}, 202
        except:
            return {"message": f"Unable to put {self.table} by column {column}."}, 400

def DBResource(tablename):
    return type('DBR_' + tablename.replace('.','_'), (DBResourceClass,), {'table': tablename})

def DBResourceContainer(tablename):
    return type('DBC_' + tablename.replace('.','_'), (DBResourceContainerClass,), {'table': tablename})
