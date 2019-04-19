from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .data_layer import get_db
from .session import auth_profesor

class DespachosList(Resource):
    def get(self):
        ret = get_db().aget('despachos')
        data = get_db().aget('datos_profesionales')
        for k in data:
            despacho = data[k][2]
            if despacho:
                ret[k] = despacho
        return ret

class Despacho(Resource):
    method_decorators = [auth_profesor] 

    def get(self, userid):
        ret = get_db().tget('datos_profesionales', userid) 
        if ret is not None and ret[2]:
            return ret[2]
        ret = get_db().tget('despachos', userid)
        if ret is not None:
            return ret
        return ({"message": f"Datos Profesionales de {userid} no encontrados"}, 404)
