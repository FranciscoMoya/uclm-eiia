import json, requests

def get_staff(term):
    r = requests.get('https://intranet.eii-to.uclm.es/v2/profesores.expandidos/por_sn/')
    assert r.status_code <= 300
    r.encoding = 'utf-8'
    profes = json.loads(r.text)
    fill_pos_type(profes)
    return profes


position = {
    'CATEDRATICO/A DE UNIVERSIDAD': 'CU',
    'PROFESOR/A TITULAR DE UNIVERSIDAD': 'TU',
    'PROFESOR CONTRATADO DOCTOR': 'CD',
    'P. CONTRATADO DOCTOR': 'CD',
    'PROFESOR CONTRATADO DOCTOR INTERINO': 'CDi',
    'T.E.U. ECONOMIA FINANCIERA Y CONTABILIDAD': 'TEU',
    'T.E.U. FISICA APLICADA': 'TEU',
    'T.E.U. EXPRESION GRAFICA EN LA INGENIERIA': 'TEU',
    'PROFESOR TITULAR DE ESCUELA UNIVERSITARIA': 'TEU',
    'PROFESOR/A CATEDRATICO ESCUELA UNIVERSITARIA': 'CEU',
    'PROFESOR/A AYUDANTE DOCTOR': 'AD',
    'PROFESOR AYUDANTE DOCTOR': 'AD',
    'P. ASOCIADO/A': 'ASOC',
    'PROFESOR COLABORADOR': 'COL',
    'INVESTIGADOR EN FORMACION 4º AÑO': 'INV',
}

def fill_pos_type(profes):
    for p in profes:
        p['pos_type'] = position[p['categoria']]
        p['extid'] = sigla(f"{p['givenName']} {p['sn']}")

def sigla(s):
    pal = s.replace('-',' ').split(' ')
    id = ''.join(p[0] for p in pal if p not in ('DE', 'DEL', 'EN', 'A', 'AL'))
    id = id.replace('Á','A').replace('É','E').replace('Í','I').replace('Ó','O').replace('Ú','U')
    return id