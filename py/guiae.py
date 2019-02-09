from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import sys, os, re, json, argparse
from cv_cfg import USERNAME, PASSWORD


class GuiaE(object):

    def __init__(self, user, passwd):
        self.user, self.passwd = user, passwd
        driver = webdriver.Chrome('g:/GitHub/challenges-private/eval/chromedriver.exe')
        self.driver = driver
        self.wait = WebDriverWait(driver, 10)
        driver.implicitly_wait(10)

    def __enter__(self):
        self.driver.__enter__()
        return self
    
    def __exit__(self, exc_type, exc_value, traceback):
        self.driver.__exit__(exc_type, exc_value, traceback)

    def authenticate(self):
        driver = self.driver
        driver.get('https://guiae.uclm.es/')
        driver.find_element_by_id('signin_username').send_keys(USERNAME)
        driver.find_element_by_id('signin_password').send_keys(PASSWORD)
        driver.find_element_by_xpath("//input[@type='submit' and @value='Entrar']").click()

    def asignaturas(self):
        driver = self.driver
        driver.get('https://guiae.uclm.es/selAsignatura/asignaturasCentro')
        asignaturasXpath = "//td[contains(@class,'PortletText1')]/strong"
        asignaturas = driver.find_elements_by_xpath(asignaturasXpath)
        ra = re.compile(r'(?P<curso>[1-9]+)º\s*(?P<id>[0-9]+)\s*-\s*(?P<givenName>.*)')
        return tuple(ra.match(a.text).groups() for a in asignaturas)

    def guias(self):
        driver = self.driver
        driver.get('https://guiae.uclm.es/selAsignatura/asignaturasCentro')
        guiasXpath = "//a[starts-with(@href,'/vistaPrevia/')]"
        guias = driver.find_elements_by_xpath(guiasXpath)
        return tuple(g.get_attribute('href') for g in guias)

    def profesores(self):
        driver = self.driver
        for url in self.guias():
            yield from self.profesores_guia(url)

    def profesores_guia(self, url):
        driver = self.driver
        driver.get(url)
        profesXpath = "//td[contains(@class,'tablaProfeHeader')]"
        dataXpath = "//table[contains(@class,'tablaProfe')]/tbody/tr[position()=4]"
        profes = driver.find_elements_by_xpath(profesXpath)
        data = driver.find_elements_by_xpath(dataXpath)
        rp = re.compile(r'Nombre del profesor:\s*(?P<nombre>.*)\s* - Grupo')
        for p,d in zip(profes, data):
            profe = dict(zip(('office', 'department', 'telephoneNumber', 'mail', 'tutorias'),
                             datos_profe(d)))
            profe['displayName'] = rp.match(p.text).group('nombre').strip()
            extraer_nombre_apellidos(profe)
            print('Found', profe)
            yield profe

    def profesores_unicos(self):
        profes = dict((p['displayName'],p) for p in self.profesores())
        return list(profes.values())
        

def datos_profe(elem):
    ''' Asume elem elemento tr del DOM con los datos del profesor.
        Devuelve tupla de cadenas, tiene en cuenta posibles inputs (caso del profesor que consulta).
    '''
    tds = elem.find_elements_by_xpath('.//td')
    try:
        despacho, telefono, email, tutoria = tuple(elem.find_element_by_name(i) for i in ('despacho_prof', 'telefono', 'email_prof', 'tutorias'))
        return despacho.value, tds[1].text, telefono.value, email.value, tutoria.text
    except EC.NoSuchElementException:
        return tuple(t.text for t in tds)

def camel_case_split(s):
    matches = re.finditer('.+?(?:(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|$)', s)
    return [m.group(0) for m in matches]

def extraer_nombre_apellidos(profe):
    ''' Asume profe diccionario con claves displayName y email.
        Aplica heurísticos para descomponer el nombre completo en nombre y apellidos.
    '''
    completo = profe['displayName'].lower().replace('ñ','n')
    username = profe['email'].split('@')[0].split('.')
    if len(username) < 2:
        print('Wrong email {} <{}>'.format(profe['displayName'], profe['email']))
        return
    sn = camel_case_split(username[1])
    if sn[0] in ('de', 'del'):
        sn = sn[1:]
    apellido = sn[0].lower()
    i = completo.find(apellido)
    if i < 0 and apellido.startswith('de'):
        i = completo.find(apellido[2:])
    if i < 0 and apellido.startswith('del'):
        i = completo.find(apellido[3:])
    if i < 0:
        print('Wrong email/name {} <{}>'.format(profe['displayName'], profe['email']))
        return
    profe['givenName'] = profe['displayName'][:i].strip()
    profe['sn'] = profe['displayName'][i:].strip()

def splitN(L,n):
    it = iter(L)
    while True:
        t = tuple(x for _, x in zip(range(n), it))
        if t == tuple():
            break
        yield t

def html_dumps(profes, row_tmpl, profe_tmpl, ngroup):
    return ''.join(html_dumps_row(r, row_tmpl, profe_tmpl) for r in splitN(profes, ngroup))

def html_dumps_row(r, row_tmpl, profe_tmpl):
    return row_tmpl.format(''.join(html_dumps_profe(p, profe_tmpl) for p in r))

def html_dumps_profe(profe, tmpl):
    return tmpl.format(**profe)


if __name__ == '__main__':
    try: os.chdir(os.path.dirname(__file__))
    except: pass
    parser = argparse.ArgumentParser(description='Utiliza los datos de la Guía-E para automatizar la publicación de tutorías.')
    parser.add_argument('--fetch', nargs='?', type=argparse.FileType('w'), const='data.json', default=None,
                        help='recoge los datos de profesores de guiae')
    parser.add_argument('--json', nargs='?', type=argparse.FileType('r'), const='data.json', default=None,
                        help='recoge los datos de profesores de archivo JSON')
    parser.add_argument('--html', nargs='?', type=argparse.FileType('w', encoding='utf-8'), const='data.html', default=None,
                        help='renderiza los datos en archivo HTML')
    parser.add_argument('--js', nargs='?', type=argparse.FileType('w', encoding='utf-8'), const='data.js', default=None,
                        help='renderiza los datos en archivo JavaScript')
    parser.add_argument('--tmpl', nargs='?', type=argparse.FileType('r', encoding='utf-8'), const='data.tmpl.html', default='data.tmpl.html',
                        help='plantilla empleada para renderizar los datos')
    parser.add_argument('--row-tmpl', dest='rtmpl', nargs='?', type=argparse.FileType('r', encoding='utf-8'), const='row.tmpl.html', default='row.tmpl.html',
                        help='plantilla empleada para renderizar una fila')
    parser.add_argument('--profe-tmpl', dest='ptmpl', nargs='?', type=argparse.FileType('r', encoding='utf-8'), const='profe.tmpl.html', default='profe.tmpl.html',
                        help='plantilla empleada para renderizar un profesor')
    parser.add_argument('--group', nargs='?', type=int, const=1, default=3,
                        help='Agrupa las fichas de profesores en filas de GROUP elementos')
    args = parser.parse_args()
    
    profes = []
    if args.fetch:
        with GuiaE(USERNAME, PASSWORD) as guiae:
            guiae.authenticate()
            profes = guiae.profesores_unicos()
            args.fetch.write(json.dumps(profes))
    if args.html:
        profes = json.load(args.json)
        profes.sort(key=lambda p: (p['sn'],p['givenName']))
        args.html.write(
            args.tmpl.read().format(
                html_dumps(profes, 
                    args.rtmpl.read(), 
                    args.ptmpl.read(), 
                    args.group)))
    if args.js:
        profes = json.load(args.json)
        profes.sort(key=lambda p: (p['sn'],p['givenName']))
        args.js.write('profes={};'.format(json.dumps(profes)))
