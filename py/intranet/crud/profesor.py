from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .session import auth_profesor
import json

JSON_DB = 'profesores.json'
ad_keys = ('sn','givenName','department','mail','title','telephoneNumber', 'displayName')

def entry_to_dict(p):
    return { k: str(p[k] if p[k] else '') for k in ad_keys }

class ProfesoresList(Resource):
    def get(self):
        with open(JSON_DB) as js:
            return json.load(js)

class ProfesoresQuery(Resource):
    method_decorators = [auth_profesor] 

    def get(self, userid, password):
        from ad import DirectorioActivo

        with DirectorioActivo(userid, password) as da:
            profes = [ entry_to_dict(p) for p in da.profesores('ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO') ]
            profes.sort(key=lambda p: (p['sn'],p['givenName']))
            with open(JSON_DB, 'w') as js:
                js.write(json.dumps(profes))
    
            return profes

class Profesor(Resource):

    def get(self, userid):
        with open(JSON_DB) as js:
            profe = [p for p in json.load(js) if p['mail'].split('@')[0] == userid]
            return profe[0] if len(profe) > 0 else ({"message": f"User {userid} not found"}, 400)
