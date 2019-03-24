from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .data_layer import get_db
from .session import auth_profesor

class TutoriasList(Resource):
    def get(self):
        return get_db().aget('tutorias')

class Tutoria(Resource):
    method_decorators = [auth_profesor] 

    def get(self, userid):
        return get_db().tget('tutorias', userid) \
            or ({"message":"Tutoria no encontrada"}, 404)

    def post(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("tutoria")
        args = parser.parse_args()

        db = get_db()
        if db.tget('tutorias', userid):
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
        
        get_db().tset('tutorias', userid, args['tutoria'])
        return  {
            'userid': userid,
            'tutoria': args['tutoria']
        }, 201

    def delete(self, userid):
        get_db().tdel('tutorias', userid)
        return {"message":f"{userid} is deleted."}, 200

