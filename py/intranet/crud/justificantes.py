from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .session import auth_profesor
import os, werkzeug
from flask import request
from datetime import datetime

class Justificantes(Resource):
    method_decorators = [auth_profesor] 

    def get(self, userid):
        try:
            dirname = f'html/static/justificantes/{userid}/'
            files = os.listdir(dirname)
            return {
                'userid': userid,
                'justificantes': [ (f, str(datetime.fromtimestamp(os.path.getmtime(dirname + f)))) 
                                    for f in files ]
            }
        except:
            return {
                'userid': userid,
                'justificantes': []
            }

    def post(self, userid):
        f = request.files['justificante']
        print('POST', f)
        if f:
            filename = werkzeug.secure_filename(f.filename)
            dirname = f'html/static/justificantes/{userid}'
            os.makedirs(dirname, exist_ok = True)
            filepath = filename_fix_existing(f'{dirname}/{filename}')
            f.save(filepath)
        return self.get(userid), 201

    def delete(self, userid):
        parser = reqparse.RequestParser()
        parser.add_argument("justificante")
        args = parser.parse_args()
        filename = args['justificante']
        filepath = f"html/static/justificantes/{userid}/{filename}"
        print('delete', filepath)
        if os.path.exists(filepath):
            os.remove(filepath)
            return self.get(userid), 200
        return {"message": f"Unable to delete {userid}/{filename}."}, 405

# Taken from https://github.com/steveeJ/python-wget/blob/master/wget.py#L72
def filename_fix_existing(filename):
    """Expands name portion of filename with numeric ' (x)' suffix to
    return filename that doesn't exist already.
    """
    if not os.path.exists(filename): return filename
    dirname = os.path.dirname(filename)
    filename = os.path.basename(filename)
    name, ext = filename.rsplit('.', 1)
    names = [x for x in os.listdir(dirname) if x.startswith(name)]
    names = [x.rsplit('.', 1)[0] for x in names]
    suffixes = [x.replace(name, '') for x in names]
    # filter suffixes that match ' (x)' pattern
    suffixes = [x[2:-1] for x in suffixes
                   if x.startswith(' (') and x.endswith(')')]
    indexes  = [int(x) for x in suffixes
                   if set(x) <= set('0123456789')]
    idx = 1
    if indexes:
        idx += sorted(indexes)[-1]
    return f'{dirname}/{name} ({idx}).{ext}'