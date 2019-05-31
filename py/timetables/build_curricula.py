import json, requests
from build_cursos import get_cursos

def get_curricula(term):
    r = requests.get('https://intranet.eii-to.uclm.es/v2/docencia.titulos/por_titid/')
    assert r.status_code <= 300
    titulos = json.loads(r.text)
    return tuple(get_curriculum(t, term) for t in titulos)


def get_curriculum(t, term):
    t['extid'] = sigla(t['titulo'])
    t['años'] = tuple(get_curriculum_año(t, year, term) for year in (1,2,3,4))
    return t

asignaturas = []
def get_curriculum_año(t, year, term):
    global asignaturas
    if not asignaturas:
        asignaturas = get_cursos(term)

    tid = t['titid']
    semestre = 2*year + term - 2     # term es 1 o 2
    return tuple(c for c in asignaturas if c['titid'] == tid and c['semestre'] == semestre)


def sigla(s):
    pal = s.upper().replace('-',' ').split(' ')
    eid = ''.join(p[0] for p in pal if p not in ('Y', 'E', 'DE', 'DEL', 'EN', 'A', 'AL'))
    eid = eid.replace('Á','A').replace('É','E').replace('Í','I').replace('Ó','O').replace('Ú','U')
    return eid