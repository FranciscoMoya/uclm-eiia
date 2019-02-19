from flask import Flask
from flask_restful import Api, Resource, reqparse
import json
from crud.data_layer import close_db
from crud.desiderata import Desideratum

app = Flask(__name__)
api = Api(app)

@app.teardown_appcontext
def close_connection(exception):
    close_db()

api.add_resource(Desideratum, "/horario/desiderata/<string:userid>")
app.run(debug=True)
