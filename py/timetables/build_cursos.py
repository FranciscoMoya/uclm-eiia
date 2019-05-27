import json, requests

def get_cursos():
    r = requests.get('https://intranet.eii-to.uclm.es/v2/docencia.por_superarea/por_semestre/')
    assert r.status_code <= 300
    cursos = json.loads(r.text)
    fill_subject_area(cursos)
    fill_course_nr(cursos)
    return cursos

subject_area = {
    1: 'INF',
    2: 'CMIM',
    3: 'ECO',
    4: 'EST',
    5: 'GRA',
    6: 'FIS',
    7: 'IE',
    8: 'ISA',
    9: 'MAT',
    10: 'MMT',
    11: 'QUI',
    12: 'QUI',
    13: 'QUI',
    14: 'TE',
    15: 'INF',
    16: 'MEC',
    17: 'MEC',
    18: 'MEC',
    19: 'QUI'
}

def fill_subject_area(cursos):
    for c in cursos:
        c['subject'] = subject_area[c['sareaid']]

def fill_course_nr(cursos):
    number = { subject_area[id]:[1,1,1,1] for id in subject_area }

    def next_nr(year, subject):
        n = number[subject][year]
        number[subject][year] = n + 1
        return n + 100 + 100*year

    for c in cursos:
        year = (c['semestre'] - 1) // 2
        c['nr'] = next_nr(year, c['subject'])
