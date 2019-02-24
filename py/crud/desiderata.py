from flask_restful import Api, Resource, reqparse, abort
from .data_layer import get_db
from .session import auth_profesor

class DesiderataList(Resource):
    def get(self):
        return get_db().aget('desiderata')

class Desideratum(Resource):
    method_decorators = [auth_profesor] 

    def get(self, userid):
        return get_db().tget('desiderata', userid) \
            or ("Desideratum no encontrado", 404)

    def post(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("desideratum", type=list, location='json')
        args = parser.parse_args()

        db = get_db()
        if db.tget('desiderata', userid):
            return "User {} already has desideratum".format(userid), 400

        db.insert(userid, args['desideratum'])
        return {
            'userid': userid,
            'desideratum': args['desideratum']
        }, 201

    def put(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("desideratum", type=list, location='json')
        args = parser.parse_args()
        
        get_db().tset('desiderata', userid, args['desideratum'])
        return  {
            'userid': userid,
            'desideratum': args['desideratum']
        }, 201

    def delete(self, userid):
        get_db().tdel('desiderata', userid)
        return "{} is deleted.".format(userid), 200

