from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .data_layer import get_db
from .session import auth_profesor


class Despacho(Resource):
    method_decorators = [auth_profesor] 

    def get(self, userid):
        return get_db().tget('despachos', userid) \
            or ("despacho no encontrado", 404)

    def post(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("despacho")
        args = parser.parse_args()

        db = get_db()
        if db.tget('despachos', userid):
            return "User {} already has despacho".format(userid), 400

        db.insert(userid, args['despacho'])
        return {
            'userid': userid,
            'despacho': args['despacho']
        }, 201

    def put(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("despacho")
        args = parser.parse_args()
        
        get_db().tset('despachos', userid, args['despacho'])
        return  {
            'userid': userid,
            'despacho': args['despacho']
        }, 201

    def delete(self, userid):
        get_db().tdel('despachos', userid)
        return "{} is deleted.".format(userid), 200

