import requests, json
from pprint import pprint

api='https://intranet.eii-to.uclm.es/UniTime/api/'
url = api + 'events'

class Evento(object):
    def __init__(self, asig, prof, aula, start, end, dow):
        self.asig = asig
        self.prof = prof
        self.aula = aula
        self.sstart = start
        self.send = end
        self.dow = dow

        self.name = abrevia(asig)
        self.start = slot2hora(self.sstart)
        self.end = slot2hora(self.send)
        self.duration = lambda: None
        setattr(self.duration, 'seconds', (end - start) * 5 * 60)
        self.location = ('Laboratorio ' if aula.startswith('19') else 'Aula ' )+ aula
        self.description = abreviaProf(self.prof) + '\\\\' \
            + hora2str(self.start) + ' -- ' + hora2str(self.end)

    def __str__(self):
        dia = 'LMXJV'[self.dow]
        return f'{self.asig}\n {self.prof}\n {self.aula}\n {dia} {self.start}-{self.end}\n'

    def __repr__(self):
        return self.__str__()

def get_events(params):
    r = requests.get(url, params)
    events_json = json.loads(r.text)

    events = []
    for e in events_json:
        assert 'courseTitles' in e
        assert 'meetings' in e
        slots = tuple((m['startSlot'],m['endSlot']) for m in e['meetings'])
        dow = tuple(m['dayOfWeek'] for m in e['meetings'])
        loc = tuple(m['location']['displayName'] for m in e['meetings'])
        for s,d,l in zip(slots, dow, loc):
            events.append(Evento(
                asig = e['courseTitles'][0],
                prof = '; '.join(p['formattedName'] for p in e['instructors']) if 'instructors' in e else '',
                aula = l,
                start = s[0],
                end = s[1],
                dow = d
            ))
            #if events[-1].prof.find('Bevia') > 0:
            #    pprint(e)
    return events

def slot2hora(slot):
    return slot / 12.

def hora2str(h):
    hh, mm = int(h), int(h%1 * 60)
    return f'{hh}:{mm:02d}'

def abreviaProf(prof):
    return '\\\\'.join(abreviaP(prof.split(';'))).replace('\\\\...',', \ldots')

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

def gen_calendar(curr, curso, params):
    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template('cal.tpl')

    days = [dict() for i in range(5)] 
    for event in get_events(params):
        day = event.dow
        if day >= 5: #weekend
            continue
        days[day][event.start] = event

    #pprint(days)

    names = Counter(event.name for day in days for event in day.values() )
    names = [x[0] for x in names.most_common()]
    colors = ['red', 'green', 'blue', 'yellow', 'orange', 'brown', 'purple', 'gray']

    term , name = params['term'][:-8], params['name']
    fname = f'{term}_{name}.tex'.replace(' ','_')
    from itertools import cycle
    with open(fname, "wt", encoding='utf-8') as f:
        print('Output to', fname)
        f.write(template.render(
            days=days, 
            names=zip(names, cycle(colors)),
            curso = curso, curr = curr,
            semestre = term
        ))


def abrevia(asig):
    return asig.replace('INSTALACIONES ELÉCTRICAS DE', 
        'INST. E. DE').replace('SISTEMAS DE FABRICACIÓN Y ORGANIZACIÓN INDUSTRIAL',
        'S. DE FABRICACIÓN Y ORGANIZACIÓN IND.')

params = {
    'token':  '-1borxv3rp8jdymfsfriup3if4wzi7x1wfh5lr0ec8kshcpqn82',
    'type':   'CURRICULUM',
    'e:type': 'Class',
    'term':   'Primer semestre2019UCLM',
    'name':   'IE 02'
}

def gen_calendar_all():
    for term in ('Primer semestre', 'Segundo semestre'):
        params['term'] = term + '2019UCLM'
        for curr, currname in zip(('IE','IEIA', 'IA'),
                                ('Ingeniería Eléctrica', 
                                'Ingeniería Electrónica Industrial y Automática',
                                'Ingeniería Aeroespacial')):
            for curso in (1,2,3,4):
                if curr == 'IA' and curso > 2: continue
                params['name'] = f'{curr} {curso:02d}'
                gen_calendar(currname, curso, params)

gen_calendar_all()
#gen_calendar('Ingeniería Eléctrica', 2, params)
