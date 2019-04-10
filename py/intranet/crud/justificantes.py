from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .session import auth_profesor
import os, datetime

class Justificantes(Resource):
    method_decorators = [auth_profesor] 

    def get(self, userid):
        try:
            dirname = f'html/static/justificantes/{userid}/'
            files = os.listdir(dirname)
            return [ (f, datetime.datetime.fromtimestamp(os.path.getmtime(dirname + f))) for f in files]
        except:
            return []

    def post(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("tutoria")
        args = parser.parse_args()

        db = get_db()
        if db.tget('Justificantes', userid):
            return {"message":f"User {userid} already has tutoria"}, 400

        db.insert(userid, args['tutoria'])
        return {
            'userid': userid,
            'tutoria': args['tutoria']
        }, 201

    def put(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("tutoria")
        args = parser.parse_args()
        
        get_db().tset('Justificantes', userid, args['tutoria'])
        return  {
            'userid': userid,
            'tutoria': args['tutoria']
        }, 201

    def delete(self, userid):
        get_db().tdel('Justificantes', userid)
        return {"message":f"{userid} is deleted."}, 200

