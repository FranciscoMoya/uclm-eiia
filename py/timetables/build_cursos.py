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
    fill_time_pref(cursos)
    return cursos

especiales_timePref = {
    'MECÁNICA DE FLUIDOS': '21',
    'TECNOLOGÍA ELÉCTRICA': '21',
    'INSTALACIONES ELÉCTRICAS DE BAJA TENSIÓN': '21',
}

def fill_time_pref(cursos):
    for c in cursos:
        a = c['asignatura']
        c['timePref'] = especiales_timePref[a] if a in especiales_timePref else '111'


def course_in_term(c, term):
    if c['semestre'] & 1 == term & 1:
        return True
    # Aunque no sea del semestre puede que sea anual
    return c['ects'] == 12

especiales = {
    'ELECTRÓNICA': 'EL',    
    'TECNOLOGÍA ELECTRÓNICA': 'TEL',
    'ESTADÍSTICA INFERENCIAL': 'EST',
}
def subject_area (s):
    if s in especiales:
        return especiales[s]
    s = s.upper().replace('-',' ').replace('Á','A').replace('É','E').replace('Í','I').replace('Ó','O').replace('Ú','U')
    pal = [p for p in s.split(' ') if len(p) > 3]
    if len(pal) > 1:
        return ''.join(p[0] for p in pal)
    return s[:3]


def fill_subject_area(cursos):
    for c in cursos:
        c['subject'] = subject_area(c['asignatura'])


def fill_course_nr(cursos):
    number = {}

    def next_nr(year, subject):
        if subject not in number:
            number[subject] = [1,1,1,1]
        n = number[subject][year]
        number[subject][year] = n + 1
        return n + 100 + 100*year

    for c in cursos:
        year = (c['semestre'] - 1) // 2
        c['nr'] = next_nr(year, c['subject'])
        c['uniqueid'] = c['asigid']

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


if __name__ == '__main__':
    for t in '123':
        print('-------------------------')
        r = requests.get('https://intranet.eii-to.uclm.es/v2/docencia.asignaturas/por_titid/' + t)
        assert r.status_code <= 300
        asig = json.loads(r.text)
        for a in asig:
            print(subject_area(a['asignatura']), a['asignatura'])
