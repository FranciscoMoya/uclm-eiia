from flask_restful import Api, Resource, reqparse, abort
from .data_layer import get_db
from .session import auth_profesor

class DatosProfesionalesList(Resource):
    def get(self):
        return get_db().aget('datos_profesionales')

class DatosProfesionales(Resource):
    method_decorators = [auth_profesor]
    columns = ("area","telefono","despacho","quinquenios","sexenios","sexenio_vivo","acreditacion")

    def get(self, userid):
        ret = get_db().tget('datos_profesionales', userid) 
        if ret is None:
            return ({"message": f"Datos Profesionales de {userid} no encontrados"}, 404)
        return {k:v for k,v in zip(self.columns, ret)}

    def post(self, userid):
        parser = reqparse.RequestParser()
        for k in self.columns:
            parser.add_argument(k)
        args = parser.parse_args()

        db = get_db()
        if db.tget('datos_profesionales', userid):
            return {"message": f"User {userid} already have personal data"}, 400

        row = [args[k] if k in args else None for k in self.columns]
        db.mset('datos_profesionales', userid, row)
        ret = {k:v for k,v in zip(self.columns, row)}
        ret['userid'] = userid
        return ret, 201

    def put(self, userid):
        parser = reqparse.RequestParser()
        for k in self.columns:
            parser.add_argument(k)
        args = parser.parse_args()
        
        row = [args[k] if k in args else None for k in self.columns]
        get_db().mset('datos_profesionales', userid, row)
        ret = {k:v for k,v in zip(self.columns, row)}
        ret['userid'] = userid
        return ret, 201

    def delete(self, userid):
        get_db().tdel('datos_profesionales', userid)
        return {"message": f"Record for {userid} is deleted."}, 200

