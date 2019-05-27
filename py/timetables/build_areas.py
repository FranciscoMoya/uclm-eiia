import json, requests
from build_cursos import fill_subject_area


def get_areas():
    r = requests.get('https://intranet.eii-to.uclm.es/v2/profesores.superareas/por_sarea/')
    assert r.status_code <= 300
    areas = json.loads(r.text)
    fill_subject_area(areas)
    return areas
