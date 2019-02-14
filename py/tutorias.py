from ad import DirectorioActivo
from cv_cfg import USERNAME, PASSWORD
import tuto_gform as gform
import json, argparse, jinja2

def entry_to_dict(p):
    keys = ('sn','givenName','department','mail','title','telephoneNumber', 'displayName')
    return { k: str(p[k] if p[k] else '') for k in keys }

def merge_into(A, B):
    for p in B:
        q = [i for i in A if i['mail'] == p['mail']]
        if not q:
            A.append(p)
            continue
        assert len(q) == 1
        merge_profe(q[0], p)

def merge_profe(A,B):
    for k in B:
        A[k] = B[k]

            

if __name__ == '__main__':
    try: os.chdir(os.path.dirname(__file__))
    except: pass
    parser = argparse.ArgumentParser(description='Utiliza los datos de Active Directory y Formulario Google para automatizar la publicación de tutorías.')
    parser.add_argument('--json', nargs='?', type=argparse.FileType('r+'), const='data.json', default=None,
                        help='guarda los datos de profesores en archivo JSON')
    parser.add_argument('--gform', nargs='?', type=argparse.FileType('r', encoding='utf-8'), const='Solicitud cambio de horario de tutorías.csv', default=None,
                        help='recoge los datos de profesores de formulario Google')
    parser.add_argument('--html', nargs='?', type=argparse.FileType('w', encoding='utf-8'), const='data.html', default=None,
                        help='renderiza los datos en archivo HTML')
    parser.add_argument('--js', nargs='?', type=argparse.FileType('w', encoding='utf-8'), const='data.js', default=None,
                        help='renderiza los datos en archivo JavaScript')
    parser.add_argument('--tmpl', nargs='?', type=argparse.FileType('r', encoding='utf-8'), const='profes.jinja2.html', default='profes.jinja2.html',
                        help='plantilla Jinja2 empleada para renderizar los datos')
    args = parser.parse_args()
    
    profes = []
    with DirectorioActivo(USERNAME, PASSWORD) as da:
        profes = [ entry_to_dict(p) for p in da.profesores('ESCUELA DE INGENIERÍA INDUSTRIAL TOLEDO') ]
    profes.sort(key=lambda p: (p['sn'],p['givenName']))

    for p in profes:
        p['tutorias'] = 'No han sido especificadas por el profesor'

    if args.json:
        profes_prev = json.load(args.json)
        merge_into(profes, profes_prev)

    if args.gform:
        gform.update(profes, args.gform)

    if args.html:
        template = jinja2.Template(args.tmpl.read())
        args.html.write(template.render(profes=profes))

    if args.js:
        args.js.write('profes={};'.format(json.dumps(profes)))

    if args.json:
        args.json.seek(0)
        args.json.write(json.dumps(profes))
        args.json.truncate()

