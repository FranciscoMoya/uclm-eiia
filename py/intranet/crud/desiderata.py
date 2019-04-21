from flask_restful import Api, Resource, reqparse, abort
from .data_layer import get_db
from .session import auth_profesor

class DesiderataList(Resource):
    def get(self):
        return get_db().aget('desiderata')

def desiderata_parser():
    parser = reqparse.RequestParser(bundle_errors=True, trim=True)
    parser.add_argument('desideratum', type=list, location='json')
    return parser

class Desideratum(Resource):
    method_decorators = [auth_profesor]
    _parser = desiderata_parser()

    def get(self, userid):
        return get_db().tget('desiderata', userid) \
            or ({"message":"Desideratum no encontrado"}, 404)

    def post(self, userid):
        db = get_db()
        if db.tget('desiderata', userid):
            return {"message":f"User {userid} already has desideratum"}, 400

        ret, code = self.put(userid)
        return ret, 201 if code < 300 else code

    def put(self, userid):
        args = self._parser.parse_args()
        
        get_db().tset('desiderata', userid, args['desideratum'])
        return  {
            'userid': userid,
            'desideratum': args['desideratum']
        }, 201

    def delete(self, userid):
        get_db().tdel('desiderata', userid)
        return {"message":"Record for {userid} is deleted."}, 200
