import requests, json

r = requests.get('https://intranet.eii-to.uclm.es/v2/profesores.expandidos/por_sn/')
assert r.status_code <= 300
profes = json.loads(r.text)




position = {
    'CATEDRATICO/A DE UNIVERSIDAD': 1,
    'PROFESOR/A TITULAR DE UNIVERSIDAD': 2,
    'PROFESOR CONTRATADO DOCTOR': 8,
    'P. CONTRATADO DOCTOR': 8,
    'PROFESOR CONTRATADO DOCTOR INTERINO': 5,
    'T.E.U. ECONOMIA FINANCIERA Y CONTABILIDAD': 3,
    'T.E.U. FISICA APLICADA': 3,
    'T.E.U. EXPRESION GRAFICA EN LA INGENIERIA': 3,
    'PROFESOR TITULAR DE ESCUELA UNIVERSITARIA': 3,
    'PROFESOR/A CATEDRATICO ESCUELA UNIVERSITARIA': 2883584,
    'PROFESOR/A AYUDANTE DOCTOR': 6,
    'PROFESOR AYUDANTE DOCTOR': 6,
    'P. ASOCIADO/A': 2883585,
    'PROFESOR COLABORADOR': 7,
    'INVESTIGADOR EN FORMACION 4º AÑO': -1,
}

def instructors():
    id = 2949121
    dept = 231383
    for p in profes:
        userid, sn, givenName, email = p['userid'], p['sn'], p['givenName'], p['email']
        pal = (givenName + ' ' + sn).replace('-',' ').split(' ')
        extid = ''.join(p[0] for p in pal if p not in ('DE', 'DEL'))
        extid = extid.replace('Á','A').replace('É','E').replace('Í','I').replace('Ó','O').replace('Ú','U')
        #extid = 'NULL'
        #print (p)
        p['id'] = id
        pos = position[p['categoria']]
        if pos < 0:
            continue
        yield f'''({id},'{extid}','{userid}','{sn}','{givenName}',NULL,{pos},NULL,{dept},0,NULL,'{email}',NULL,NULL,NULL,NULL)'''
        id += 1


print(f'''

LOCK TABLES `departmental_instructor` WRITE;
/*!40000 ALTER TABLE `departmental_instructor` DISABLE KEYS */;
INSERT INTO `departmental_instructor` VALUES {','.join(instructors())};
/*!40000 ALTER TABLE `departmental_instructor` ENABLE KEYS */;
UNLOCK TABLES;


''')

