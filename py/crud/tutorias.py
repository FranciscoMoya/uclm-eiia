from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .data_layer import get_db


class Tutoria(Resource):
    # method_decorators = [auth_profesor] 

    def get(self, userid):
        return get_db().tget('tutorias', userid) \
            or ("tutoria no encontrada", 404)

    def post(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("tutoria")
        args = parser.parse_args()

        db = get_db()
        if db.tget('tutorias', userid):
            return "User {} already has tutoria".format(userid), 400

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
        return "{} is deleted.".format(userid), 200

