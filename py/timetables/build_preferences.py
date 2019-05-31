import json, requests
from build_staff import get_staff
from build_cursos import get_cursos

def get_preferences(term):
    profes = get_staff(term)
    fill_desiderata(profes)
    cursos = get_cursos(term)
    return {
        'profes': profes,
        'cursos': cursos,
    }


level = {
    -3: 'P',
    -2: '2',
    -1: '1',
     0: '0',
     1: '-1',
     2: '-2',
     3: 'R',
}

def fill_desiderata(profes):
    r = requests.get('https://intranet.eii-to.uclm.es/v2/profesores.desiderata/por_userid/')
    assert r.status_code <= 300
    desiderata = { d['userid']:d['desideratum'] for d in json.loads(r.text) }
    for p in profes:
        uid = p['userid']
        p['desideratum'] = desiderata[uid] if uid in desiderata else []
        p['level'] = lambda l : level[l]
