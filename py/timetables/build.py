from jinja2 import Environment, FileSystemLoader, select_autoescape
import argparse, json, requests, datetime

from build_cursos import get_cursos
from build_staff import get_staff
from build_areas import get_areas
from build_preferences import get_preferences
from build_curricula import get_curricula

parser = argparse.ArgumentParser(description='Generate XML data for UniTime')
parser.add_argument('--sec', default='all', help='Sección XML a generar (e.g. offerings)')
parser.add_argument('--term', default=1, type=int, help='Semestre a generar (1 o 2)')
args = parser.parse_args()


env = Environment(
    loader=FileSystemLoader('templates'),
    autoescape=select_autoescape(['html', 'xml'])
)

env.globals.update(zip=zip,enumerate=enumerate)

sections = {
    'aareas': {
        'jinja_template': 'aareas.tmpl.xml',
        'data': lambda x: None
    },
    'aclasif': {
        'jinja_template': 'aclasif.tmpl.xml',
        'data': lambda x: None
    },
    'majors': {
        'jinja_template': 'majors.tmpl.xml',
        'data': lambda x: None
    },
    'rooms': {
        'jinja_template': 'rooms.tmpl.xml',
        'data': lambda x: None
    },
    'areas': {
        'jinja_template': 'areas.tmpl.xml',
        'data': get_areas
    },
    'offerings': {
        'jinja_template': 'offerings.tmpl.xml',
        'data': get_cursos
    },
    'staff': {
        'jinja_template': 'staff.tmpl.xml',
        'data': get_staff
    },
    'preferences': {
        'jinja_template': 'preferences.tmpl.xml',
        'data': get_preferences
    },
    'curricula': {
        'jinja_template': 'curricula.tmpl.xml',
        'data': get_curricula
    },
}

tname = {
    1: 'Primer semestre',
    2: 'Segundo semestre'
}

def apply_template(name):
    print('Generando', name)
    sec = sections[name]
    template = env.get_template(sec['jinja_template'])
    date = datetime.date.today().isoformat()
    with open(f'{args.term}-{name}-{date}.xml', 'w', encoding='utf-8') as f:
        f.write(template.render(data = sec['data'](args.term), term = tname[args.term]))

if args.sec != 'all':
    apply_template(args.sec)
else:
    for s in sections.keys():
        apply_template(s)

