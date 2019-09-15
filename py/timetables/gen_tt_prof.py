import requests, json
from pprint import pprint

api='https://intranet.eii-to.uclm.es/UniTime/api/'
url = api + 'instructor-schedule'

params = {
    'token':  '-1borxv3rp8jdymfsfriup3if4wzi7x1wfh5lr0ec8kshcpqn82',
    'id':     'francisco.moya',
    'term':   'Primer semestre2019UCLM',
}

curricula = {
    'I. Eléctrica': set((
        'ALG 101',
        'CAL 101',
        'FIS 101',
        'INF 101',
        'QUI 101',
        'AM 201',
        'CM 201',
        'GE 201',
        'MF 201',
        'TE 201',
        'EP 301',
        'IEBT 301',
        'LE 301',
        'ME 301',
        'RA 301',
        'AEB 401',
        'DPI 401',
        'PCIE 401',
        'PI 401',
        'SEC 401',
        'SEE 401',
        'CAL 104',
        'EG 101',
        'EST 101',
        'FIS 101',
        'TMA 101',
        'EL 201',
        'SFOI 201',
        'TC 201',
        'TME 201',
        'TT 201',
        'CD 301',
        'CE 301',
        'CME 301',
        'ER 301',
        'IEAT 301',
        'IA 401',
        'OCI 401',
        'PRL 401',
        'SEO 401',
        'SES 401',
    )),
    'I. Electrónica': set((
        'ALG 102',
        'CAL 102',
        'FIS 102',
        'INF 102',
        'QUI 102',
        'AM 202',
        'CM 202',
        'GE 202',
        'MF 202',
        'TE 202',
        'EA 301',
        'ED 301',
        'II 301',
        'RA 302',
        'RI 301',
        'FT 401',
        'IEA 401',
        'MSP 401',
        'PI 401',
        'SSE 401',
        'CAL 105',
        'EG 102',
        'EST 102',
        'FIS 102',
        'TMA 102',
        'AR 201',
        'SFOI 202',
        'TEL 201',
        'TME 202',
        'TT 202',
        'AI 301',
        'CD 302',
        'ED 302',
        'EP 302',
        'IE 301',
        'IEL 401',
        'MIC 401',
        'OPT 401',
        'PRL 401',
    )),
    'I. Aeroespacial': set((
        'ALG 103',
        'CAL 103',
        'FIS 103',
        'FIS 104',
        'QUI 103',
        'TA 101',
        'CM 203',
        'INF 201',
        'MM 201',
        'RM 201',
        'TTTC 201',
        'CAL 106',
        'EG 103',
        'EST 103',
        'FIS 104',
        'TMA 103',
        'EAU 201',
        'ELE 201',
        'GE 203',
        'MF 203',
        'MSD 201',
    ))
}

class Evento(object):
    def __init__(self, e, c, m):
        try:
            course = c['course'][0]
            self.asig = course['courseTitle']
            self.aula = m['building'] + '.' + m['roomNumber']
            self.sstart = m['startTime']
            self.send = m['endTime']
            self.dow = dowFromDay(m['dayOfWeek'])
            self.curr = course2curr(course['subjectArea'] + ' ' + course['courseNumber'])

            self.uids = set(i['externalId'] for i in e['instructors'])
            self.name = abrevia(self.asig)
            self.start = str2hora(self.sstart)
            self.end = str2hora(self.send)
            self.duration = lambda: None
            setattr(self.duration, 'seconds', (self.end - self.start) * 3600)
            self.location = ('Laboratorio ' if self.aula.startswith('19') else 'Aula ' )+ self.aula
            self.description = self.curr + '\\\\' \
                + hora2str(self.start) + ' -- ' + hora2str(self.end)
            self.dates = abrevDate(m['firstDate']) + '\\\\' + abrevDate(m['lastDate'])
        except:
            pprint(c)

    def __str__(self):
        dia = 'LMXJV'[self.dow]
        return f'{self.asig}\n {self.aula}\n {dia} {self.start}-{self.end}\n'

    def __repr__(self):
        return self.__str__()

def course2curr(c):
    for curr in curricula:
        if c in curricula[curr]:
            return curr
    return ''

def dowFromDay(d):
    return {
        'Monday': 0,
        'Tuesday': 1,
        'Wednesday': 2,
        'Thursday': 3,
        'Friday': 4,
    }[d]

def abrevDate(d):
    return '/'.join(reversed(d[5:].split('-')))

def get_events(params):
    r = requests.get(url, params)
    e = json.loads(r.text)
    inst = e['instructors'][0]
    params['prof'] = inst['firstName'] + ' ' + inst['lastName']

    events = []
    for c in e['classes']:
        for m in c['meetings']:
            events.append(Evento(e,c,m))
    return events

def str2hora(s):
    hh,mm = (int(e) for e in s.split(':'))
    return hh + mm/60

def slot2hora(slot):
    return slot / 12.

def hora2str(h):
    hh, mm = int(h), int(h%1 * 60)
    return f'{hh}:{mm:02d}'

def abreviaProf(prof):
    return '\\\\'.join(abreviaP(prof.split(';'))).replace('\\\\...',', \\ldots')

def abreviaP(L):
    for p in L[:2]:
        yield abreviaNombre(p)
    if len(L) > 2:
        yield '...'

def abreviaNombre(fn):
    if fn == '':
        return ''
    ap,n = fn.split(', ')
    np = n.split(' ')
    for p in ('Del', 'De', 'La'):
        if p in np:
            np.remove(p)
    an = ' '.join(p[0]+'.' for p in np)
    return f'{ap}, {an}'

import arrow
from jinja2 import Environment, FileSystemLoader
from collections import Counter

def gen_calendar(all_events, params):
    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template('horario-personal-semestre.tpl')

    days = [dict() for i in range(5)] 
    for event in all_events:
        day = event.dow
        if day >= 5: #weekend
            continue
        days[day][event.start] = event

    #pprint(days)

    names = Counter(event.name for day in days for event in day.values() )
    names = [x[0] for x in names.most_common()]
    colors = ['red', 'green', 'blue', 'yellow', 'orange', 'brown', 'purple', 'gray']

    term , name = params['term'][:-8], params['id'].replace('.','_')
    fname = f'{term}_{name}.tex'.replace(' ','_')
    from itertools import cycle
    with open(fname, "wt", encoding='utf-8') as f:
        print('Output to', fname)
        f.write(template.render(
            days=days, 
            names=zip(names, cycle(colors)),
            semestre = term,
            prof = params['prof']
        ))


def abrevia(asig):
    return asig.replace('INSTALACIONES ELÉCTRICAS DE', 
        'INST. E. DE').replace('SISTEMAS DE FABRICACIÓN Y ORGANIZACIÓN INDUSTRIAL',
        'S. DE FABRICACIÓN Y ORGANIZACIÓN IND.')


def gen_calendar_all():
    url = 'https://intranet.eii-to.uclm.es/v2/profesores/por_userid/'
    r = requests.get(url)

    profesores = [(p['userid'],p['sn'],p['givenName']) for p in json.loads(r.text)]
    for id,sn,givenName in profesores:
        params['id'] = id
        params['prof'] = f'{givenName} {sn}'
        for term in ('Primer semestre', 'Segundo semestre'):
            params['term'] = term + '2019UCLM'
            try:
                ev = get_events(params)
            except:
                ev = []
            gen_calendar(ev, params)

    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template('horario-personal.tpl')
    with open('horario-personal.tex', "wt", encoding='utf-8') as f:
        f.write(template.render(profesores = profesores))

gen_calendar_all()
