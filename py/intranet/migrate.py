from crud.data_layer import DataLayer
from crud.data_layer_old import DataLayer as DataLayerOld

a = DataLayer()
b = DataLayerOld()

with a.db as c:
    with b.db as d:
        pass
