import json, requests

def get_cursos(term):
    all_courses = set()
    def course_repeated(aid):
        if aid in all_courses:
            return True
        all_courses.add(aid)
        return False

    r = requests.get('https://intranet.eii-to.uclm.es/v2/docencia.por_superarea/por_semestre/')
    assert r.status_code <= 300
    cursos = [ c for c in json.loads(r.text) if course_in_term(c,term) and not course_repeated(c['asigid']) ]
    fill_subject_area(cursos)
    fill_course_nr(cursos)
    fill_instructors(cursos)
    return cursos

def course_in_term(c, term):
    if c['semestre'] & 1 == term & 1:
        return True
    # Aunque no sea del semestre puede que sea anual
    return c['ects'] == 12


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

def fill_instructors(cursos):
    r = requests.get('https://intranet.eii-to.uclm.es/v2/docencia.por_profesor/por_asigid/')
    assert r.status_code <= 300
    assigned = json.loads(r.text)
    teo, lab = {}, {}
    for a in assigned:
        aid = a['asigid']
        teo[aid], lab[aid] = [], []
    for a in assigned:
        aid = a['asigid']
        if a['teoria']:
            teo[aid].append(a['userid'])
        if a['laboratorio']:
            lab[aid].append(a['userid'])
    for c in cursos:
        aid = c['asigid']
        c['teoria'] = teo[aid] if aid in teo else []
        c['laboratorio'] = lab[aid] if aid in lab else []
