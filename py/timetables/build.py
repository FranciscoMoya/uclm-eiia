from jinja2 import Environment, FileSystemLoader, select_autoescape
import argparse, json, requests, datetime

from build_cursos import get_cursos
from build_staff import get_staff
from build_areas import get_areas
from build_preferences import get_preferences

parser = argparse.ArgumentParser(description='Generate XML data for UniTime')
parser.add_argument('--sec', help='Sección XML a generar (e.g. offerings)')
args = parser.parse_args()


env = Environment(
    loader=FileSystemLoader('templates'),
    autoescape=select_autoescape(['html', 'xml'])
)

env.globals.update(zip=zip)

sections = {
    'aareas': {
        'jinja_template': 'aareas.tmpl.xml',
        'data': lambda: None
    },
    'aclasif': {
        'jinja_template': 'aclasif.tmpl.xml',
        'data': lambda: None
    },
    'majors': {
        'jinja_template': 'majors.tmpl.xml',
        'data': lambda: None
    },
    'rooms': {
        'jinja_template': 'rooms.tmpl.xml',
        'data': lambda: None
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
}

def apply_template(name):
    print('Generando', name)
    sec = sections[name]
    template = env.get_template(sec['jinja_template'])
    date = datetime.date.today().isoformat()
    with open(f'{name}-{date}.xml', 'w') as f:
        f.write(template.render(data = sec['data']()))

if args.sec != 'all':
    apply_template(args.sec)
else:
    for s in sections.keys():
        apply_template(s)

