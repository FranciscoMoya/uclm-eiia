import csv

def labels(h0,h1):
    ''' Asume h0 y h1 enteros de 0 a 23 que representan hora de inicio y final
        Devuelve secuencia de cadenas horarias cada media hora '''
    for h in range(h0,h1):
        for m in (0,30):
            yield '{:d}:{:02d}'.format(h,m)

# desde 8:30 a 21:00 en intervalos de media hora
horas = tuple(labels(8,21))[1:]
nombres_dia = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes']
dias = dict(zip('LMXJV', nombres_dia))

def tutorias(t):
    ''' Asume t una lista de campos del CSV del formulario correspondientes a medias horas de tutoría.
        Devuelve una cadena compacta del tipo 'Lunes: 8:30 a 11:30\nMartes: 9:30 a 11:30'.
    '''
    tr = list(tutorias_tramos(t))
    diastr = tuple((d,horas_dia(d,tr)) for d in 'LMXJV')
    return '\n'.join('{}: {}'.format(dias[d],h) for d,h in diastr if h != '')

def horas_dia(dia, tramos):
    return ' y '.join('{} a {}'.format(h0,h1) for d,h0,h1 in tramos if d == dia)


def tutorias_tramos(t):
    ''' Asume t una lista de campos del CSV del formulario correspondientes a medias horas de tutoría.
        Devuelve secuencia de tramos compactados, del tipo [('L', '8:30', '11:30'), ('L', '8:30', '11:30')]
    '''
    for d in 'LMXJV':
        yield from tutorias_dia(d, t)

def tutorias_dia(d, t):
    ''' Asume d una letra de 'LMXJV' y t una lista de campos del CSV del formulario, correspondeintes a medias
        horas de tutoría.
        Devuelve la secuencia de tramos compactados del día d.  Por ejemplo ('L', '8:30', '11:30')
    '''
    medias = [d in v for v in t]
    ant = [False] + medias
    sig = medias[1:] + [False]
    comienzo = [l for l,i,j in zip(horas, medias, ant) if i and not j] 
    final = [l for l,i,j in zip(horas, medias, ant) if not i and j]
    return zip([d]*100, comienzo, final)


def update(profes, f):
    data = iter(csv.reader(f))
    next(data) # skip header
    for row in data:
        timestamp, nombre = row[:2]
        t, despacho = row[2:-1], row[-1]
        sn, givenName = tuple(nombre.split(', '))
        profe = [p for p in profes if p['sn'] == sn and p['givenName'] == givenName]
        if not profe:
            print("Key not found", sn, givenName)
            continue
        profe = profe[0]
        profe['tutorias'] = tutorias(t)
        if despacho: 
            profe['office'] = office_normalize(despacho)


def office_normalize(despacho):
    if despacho.startswith('1') or despacho.startswith('0'):
        return 'Sabatini ' + despacho
    return despacho

if __name__ == '__main__':
    update([])
