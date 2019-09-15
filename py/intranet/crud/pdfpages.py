from flask_restful import Api, Resource, reqparse, abort
from functools import wraps
from .session import auth_profesor
import os, werkzeug
from flask import request, Response
from datetime import datetime
from .data_layer import get_db
import PyPDF2, io

fpath = 'html/Horario_personal_2019_2020.pdf'

class PdfPages(Resource):
    method_decorators = [auth_profesor]

    def get(self, userid):
        prof = dict((p['userid'],i) for i,p in enumerate(get_db().profesores.list()))
        pag = 2*prof[userid]
        # sacar las dos páginas a partir de indice*2 de fpath
        with open(fpath, 'rb') as f:
            fin = PyPDF2.PdfFileReader(f)
            fout = PyPDF2.PdfFileWriter()
            fout.addPage(fin.getPage(pag))
            fout.addPage(fin.getPage(pag+1))
            data = io.BytesIO()
            fout.write(data)
            resp = Response(data.getvalue())
            resp.headers['Content-Disposition'] = "inline; filename=horario-personal.pdf"
            resp.mimetype = 'application/pdf'
            return resp
    