from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .data_layer import get_db, NUM_HORAS


def auth_profesor(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if not getattr(func, 'authenticated', True):
            return func(*args, **kwargs)
        # Asegurar que es profesor
        abort(401)
    return wrapper


class Desideratum(Resource):
    # method_decorators = [auth_profesor] 

    def get(self, userid):
        ret = get_db().lookup(userid)
        if ret:
            return dbrecord_to_json(ret)
        return "Desideratum no encontrado", 404

    def post(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("desideratum", type=list, location='json')
        args = parser.parse_args()

        db = get_db()
        if db.lookup(userid):
            return "User {} already has desideratum".format(userid), 400

        desideratum = {
            "userid": userid,
            "desideratum": args["desideratum"]
        }
        db.insert(*json_to_dbrecord(desideratum))
        return desideratum, 201

    def put(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("desideratum", type=list, location='json')
        args = parser.parse_args()
        
        desideratum = {
            "userid": userid,
            "desideratum": args["desideratum"]
        }
        get_db().insert(*json_to_dbrecord(desideratum))
        return desideratum, 201

    def delete(self, userid):
        get_db().delete(userid)
        return "{} is deleted.".format(userid), 200


# DataLayer adaptation

def dbrecord_to_json(r):
    desideratum = {
        "userid": r[0],
        "desideratum": dbrecord_to_desideratum(r[1:])
    }
    return desideratum

def dbrecord_to_desideratum(r):
    por_dias = [r[i:i+NUM_HORAS] for i in range(0,len(r),NUM_HORAS)]
    dias = ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes')
    return [ (d,)+l for d,l in zip(dias, por_dias) ]

def json_to_dbrecord(d):
    return [d['userid']] + json_to_desideratum(d['desideratum'])

def json_to_desideratum(por_dias):
    dias = ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes')
    def get_des(dia, l):
        assert dia == l[0], 'JSON data must carry week days in order'
        return l[1:]
    return sum((get_des(d,l) for d,l in zip(dias, por_dias)), [])
