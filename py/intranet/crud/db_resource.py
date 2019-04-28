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

class DBResourceClass(DBResourceBase):
    '''A DB backed resource'''
    
    def get(self, column, value):
        return self.db().get(value, column)[0]

    def delete(self, column, value):
        self.db().delete(value, column)
        return {"message": f"Deleted {self.table} where {column} = {value}."}, 200


class DBResourceContainerClass(DBResourceBase):
    '''A DB backed resource container (table)'''

    def get(self, column = None):
        return self.db().list(order_by = column)

    def post(self, column = None):
        args = self.parser.parse_args()
        self.db().store(args, replace = False)
        return {"message": f"Added {self.table} record {args}."}, 201

    def put(self, column = None):
        args = self.parser.parse_args()
        self.db().update(args)
        return {"message": f"Updated {self.table} record {args}."}, 202

def DBResource(tablename):
    return type('DBR_' + tablename.replace('.','_'), (DBResourceClass,), {'table': tablename})

def DBResourceContainer(tablename):
    return type('DBC_' + tablename.replace('.','_'), (DBResourceContainerClass,), {'table': tablename})
