from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .data_layer import get_db
from .session import auth_profesor

class TutoriasList(Resource):
    def get(self):
        return get_db().aget('tutorias')

def tutorias_parser():
    parser = reqparse.RequestParser(bundle_errors=True, trim=True)
    parser.add_argument('tutoria', required=True, default='')
    return parser

class Tutoria(Resource):
    method_decorators = [auth_profesor] 
    _parser = tutorias_parser()

    def get(self, userid):
        ret = get_db().tget('tutorias', userid)
        if ret is None:
            return ({"message":"Tutoria no encontrada"}, 404)
        return ret

    def post(self, userid):
        db = get_db()
        if db.tget('tutorias', userid):
            return {"message":f"User {userid} already has tutoria"}, 400

        ret, code = self.put(userid)
        return ret, 201 if code < 300 else code

    def put(self, userid):
        args = self._parser.parse_args()
        
        get_db().tset('tutorias', userid, args['tutoria'])
        return  {
            'userid': userid,
            'tutoria': args['tutoria']
        }, 202

    def delete(self, userid):
        get_db().tdel('tutorias', userid)
        return {"message":f"{userid} is deleted."}, 200

