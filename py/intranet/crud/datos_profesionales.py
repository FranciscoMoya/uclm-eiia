from flask_restful import Api, Resource, reqparse, abort
from .data_layer import get_db
from .session import auth_profesor

class DatosProfesionalesList(Resource):
    def get(self):
        return get_db().aget('datos_profesionales')

def datos_profesionales_parser():
    parser = reqparse.RequestParser(bundle_errors=True, trim=True)
    parser.add_argument('area', required=True, default='')
    parser.add_argument('telefono', required=True, default='')
    parser.add_argument('despacho', required=True, default='')
    parser.add_argument('quinquenios', type=int, required=True, default=0)
    parser.add_argument('sexenios', type=int, required=True, default=0)
    parser.add_argument('sexenio_vivo', type=int, required=True, default=0)
    parser.add_argument('acreditacion', action='append', required=True, default=[])
    return parser

class DatosProfesionales(Resource):
    method_decorators = [auth_profesor]
    _parser = datos_profesionales_parser()

    def get(self, userid):
        columns = [ arg.name for arg in self._parser.args ]
        defaults = [ arg.default for arg in self._parser.args ]
        ret = get_db().tget('datos_profesionales', userid)
        if ret:
            return {k:v for k,v in zip(columns, ret)}
        # Backwards compatibility
        despacho = get_db().tget('despachos', userid)
        if despacho is not None:
            ret = { k:v for k,v in zip(columns, defaults) }
            ret['despacho'] = despacho
            return ret
        return ({"message": f"Datos Profesionales de {userid} no encontrados"}, 404)

    def post(self, userid):
        db = get_db()
        if db.tget('datos_profesionales', userid):
            return {"message": f"User {userid} already have personal data"}, 400
        ret, code = self.put(userid)
        return ret, 201 if code < 300 else code

    def put(self, userid):
        args = self._parser.parse_args()
        columns = [ arg.name for arg in self._parser.args ]
        row = [ args[k] for k in columns ]
        get_db().mset('datos_profesionales', userid, row)
        ret = { k:v for k,v in zip(columns, row) }
        ret['userid'] = userid
        return ret, 202

    def delete(self, userid):
        get_db().tdel('datos_profesionales', userid)
        return {"message": f"Record for {userid} is deleted."}, 200

