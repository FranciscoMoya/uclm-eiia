import json, requests
from build_cursos import get_cursos


def get_areas(term):
    cursos = get_cursos(term)
    areas = { c['subject']: remove_number(c['asignatura']) for c in cursos }
    return [ {'aid':k, 'area':v}  for k,v in areas.items() ]

def remove_number(s):
    if s.endswith(' I'): return s[:-2]
    if s.endswith(' II'): return s[:-3]
    return s


if __name__ == '__main__':
    for a in get_areas(2):
        print(a['aid'], a['area'])
