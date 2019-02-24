from cv_cfg import USERNAME, PASSWORD
import csv, argparse, jinja2, re

def save_descriptions(csvfile, dir, tmpl, itmpl):
    data = iter(csv.reader(csvfile))
    header = next(data)
    all_courses = []
    for row in data:
        course_data = dict(zip(header, row))
        canonicalize(course_data, dir)
        render_html(tmpl, course_data)
        all_courses.append(course_data)
    all_courses.sort(key=lambda e: e['Denominación'])
    por_grado = { g: [x for x in all_courses if g.upper() in x['Grado']] \
                        for g in ('Ingeniería Eléctrica', 'Ingeniería en Electrónica Industrial y Automática') }
    render_index_html(itmpl, por_grado, dir)

def render_html(tmpl, data):
    with open(data['filename'], 'w', encoding='utf-8') as f:
        print('Output to ', f.name)
        f.write(tmpl.render(asig=data))

def render_index_html(tmpl, data, dir):
    with open(dir + '/index.html', 'w', encoding='utf-8') as f:
        print('Output index to ', f.name)
        f.write(tmpl.render(opt=data))

def canonicalize(data, dir):
    for k in data:
        if any(k.startswith(l) for l in ('Contenidos', 'Competencias', 'Justificación')):
            continue
        data[k] = data[k].upper()
    data['doble'] = ';' in data['Grado']
    data['Denominación'] = data['Denominación'].upper()
    data['filename'] = get_filename(data, dir)
    data['Áreas de conocimiento proponentes'] = fix_area(data['Áreas de conocimiento proponentes'])
    
starts_with_area = re.compile(r'([ÁA]REA(\s*DE\s*)?)?(?P<area>.*)')
def fix_area(data):
    return '\n'.join(starts_with_area.match(a).group('area') for a in data.upper().split('\n'))

def get_filename(data, dir):
    return '{}/{}.html'.format(dir, data['Denominación'].replace(' ', '_'))

if __name__ == '__main__':
    try: os.chdir(os.path.dirname(__file__))
    except: pass
    parser = argparse.ArgumentParser(description='Extrae descripción de asignaturas de formulatio Google')
    parser.add_argument('--gform', nargs='?', type=argparse.FileType('r', encoding='utf-8'), default='Propuesta de asignatura optativa.csv', const=None,
                        help='recoge los datos de de formulario Google')
    parser.add_argument('--html', nargs='?', default='../optativas', const=None,
                        help='renderiza los datos en HTML en la carpeta indicada')
    parser.add_argument('--tmpl', nargs='?', type=argparse.FileType('r', encoding='utf-8'), const='templates/optativa.html', default='templates/optativa.html',
                        help='plantilla Jinja2 empleada para renderizar los datos')
    parser.add_argument('--index-tmpl', nargs='?', type=argparse.FileType('r', encoding='utf-8'), const='templates/optativa-index.html', default='templates/optativa-index.html',
                        help='plantilla Jinja2 empleada para renderizar los datos')
    args = parser.parse_args()

    if args.gform:
        print('Generando descripciones...')
        tmpl, itmpl = jinja2.Template(args.tmpl.read()), jinja2.Template(args.index_tmpl.read())
        save_descriptions(args.gform, args.html, tmpl, itmpl)
