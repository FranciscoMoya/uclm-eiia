from crud.data_layer import DataLayer
from crud.data_layer_old import DataLayer as DataLayerOld
from crud.profesores import ProfesoresList

a = DataLayerOld()
b = DataLayer()
profesores = { p['userid']:p for p in ProfesoresList().get() }

def indexof(value, table, column):
    cursor = d.execute(f'SELECT * from {table} WHERE {column} = ?', (value,))
    if len(cursor.fetchall()) == 0:
        d.execute(f'REPLACE INTO {table}({column}) VALUES (?)', 
                    (value,))
    cursor = d.execute(f'SELECT * from {table} WHERE {column} = ?', 
                    (value,))
    return next(cursor)[0]

def transform(ta,tb,filtro=lambda x:x):
    with a.db as c:
        with b.db as d:
            for row in c.execute(f'SELECT * FROM {ta}'):
                row = filtro(row)
                fmt = ','.join('?'*len(row))
                d.execute(f'INSERT INTO {tb} VALUES ({fmt})', row)


transform('areas', 'areas', lambda x: x[:-1] + (0.0,))

with a.db as c:
    with b.db as d:
        for row in c.execute('SELECT * FROM datos_profesionales'):
            profe = dict(zip(('userid', 'area', 'telefono', 'despacho', 'quinquenios', 'sexenios', 'sexenio_vivo', 'acreditacion'), row))
            p = profesores[profe['userid']]
            for i,j in zip(('title','givenName','sn','mail'),
                            ('categoria', 'givenName', 'sn','email')):
                profe[j] = p[i]
            
            profe['deptid'] = indexof(p['department'],'departamentos','departamento')
            profe['areaid'] = indexof(profe['area'],'areas','area')
            profe['catid'] = indexof(profe['categoria'],'categorias','categoria')
            for s in profe['acreditacion']:
                profe[s] = 1

            del profe['acreditacion']
            del profe['area']
            del profe['categoria']
            b.profesores.store(profe)

transform('desiderata', 'desiderata')
transform('tutorias', 'tutorias')

with b.db as d:
    for grado in (
        'Ingeniería Eléctrica',
        'Ingeniería en Electrónica Industrial y Automática',
        'Ingeniería Aeroespacial'):
        d.execute('INSERT INTO titulos(titulo,ects) VALUES (?,?)', (grado, 240))

ie = (
(
    (56308, 'TECNOLOGÍA DEL MEDIO AMBIENTE', 6, 'OB', 'S2'),
    (56300, 'ÁLGEBRA', 6, 'FB', 'S1'),
    (56301, 'CÁLCULO I', 6, 'FB', 'S1'),
    (56302, 'QUÍMICA', 6, 'FB', 'S1'),
    (56303, 'FÍSICA', 12, 'FB', 'AN'),
    (56304, 'INFORMÁTICA', 6, 'FB', 'S1'),
    (56306, 'CÁLCULO II', 6, 'FB', 'S2'),
    (56307, 'ESTADÍSTICA', 6, 'FB', 'S2'),
    (56400, 'EXPRESIÓN GRÁFICA', 6, 'FB', 'S2')
),
(
    (56312, 'TECNOLOGÍA ELÉCTRICA', 6, 'OB', 'S1'),
    (56313, 'CIENCIA DE LOS MATERIALES', 6, 'OB', 'S1'),
    (56317, 'MECÁNICA DE FLUIDOS', 6, 'OB', 'S1'),
    (56319, 'SISTEMAS DE FABRICACIÓN Y ORGANIZACIÓN INDUSTRIAL', 6, 'OB', 'S2'),
    (56321, 'TERMODINÁMICA TÉCNICA', 6, 'OB', 'S2'),
    (56402, 'ELECTRÓNICA', 6, 'OB', 'S2'),
    (56403, 'TEORÍA DE MECANISMOS Y ESTRUCTURAS', 6, 'OB', 'S2'),
    (56405, 'TEORÍA DE CIRCUITOS', 6, 'OB', 'S2'),
    (56311, 'AMPLIACIÓN DE MATEMÁTICAS', 6, 'FB', 'S1'),
    (56316, 'GESTIÓN EMPRESARIAL', 6, 'FB', 'S1')
),
(
    (56347, 'MÁQUINAS ELÉCTRICAS', 6, 'OB', 'S1'),
    (56406, 'REGULACIÓN AUTOMÁTICA', 6, 'OB', 'S1'),
    (56407, 'CONTROL DE MÁQUINAS ELÉCTRICAS', 6, 'OB', 'S2'),
    (56408, 'INSTALACIONES ELÉCTRICAS DE BAJA TENSIÓN', 6, 'OB', 'S1'),
    (56409, 'INSTALACIONES ELÉCTRICAS DE ALTA TENSIÓN', 6, 'OB', 'S2'),
    (56410, 'LÍNEAS ELÉCTRICAS', 6, 'OB', 'S1'),
    (56411, 'ELECTRÓNICA DE POTENCIA', 6, 'OB', 'S1'),
    (56411, 'ELECTRÓNICA DE POTENCIA', 6, 'OB', 'S2'),
    (56412, 'CONTROL DISCRETO', 6, 'OB', 'S2'),
    (56413, 'CENTRALES ELÉCTRICAS', 6, 'OB', 'S2'),
    (56414, 'ENERGÍAS RENOVABLES', 6, 'OB', 'S2')
),
(
    (56415, 'PROYECTOS EN LA INGENIERÍA', 6, 'OB', 'S1'),
    (56349, 'PRÁCTICAS EN EMPRESAS', 6, 'OP', 'S1'),
    (56349, 'PRÁCTICAS EN EMPRESAS', 6, 'OP', 'S2'),
    (56448, 'SISTEMAS ENERGÉTICOS CONVENCIONALES', 6, 'OP', 'S1'),
    (56449, 'SISTEMAS ENERGÉTICOS EMERGENTES', 6, 'OP', 'S1'),
    (56450, 'APROVECHAMIENTO ENERGÉTICO DE LA BIOMASA', 6, 'OP', 'S1'),
    (56451, 'SISTEMAS DE ENERGÍA EÓLICA', 6, 'OP', 'S2'),
    (56452, 'SISTEMAS DE ENERGÍA SOLAR', 6, 'OP', 'S2'),
    (56453, 'PREVENCIÓN DE RIESGOS LABORALES', 6, 'OP', 'S2'),
    (56454, 'PROYECTO Y CÁLCULO DE INSTALACIONES EN EDIFICIOS', 6, 'OP', 'S1'),
    (56455, 'DISEÑO DE PROYECTOS DE INSTALACIONES', 6, 'OP', 'S1'),
    (56456, 'OBRA CIVIL EN INSTALACIONES', 6, 'OP', 'S2'),
    (56457, 'INSTALACIONES DE ALUMBRADO', 6, 'OP', 'S2')
))

ieia = (
(
    (56308, 'TECNOLOGÍA DEL MEDIO AMBIENTE', 6, 'OB', 'S2'),
    (56300, 'ÁLGEBRA', 6, 'FB', 'S1'),
    (56301, 'CÁLCULO I', 6, 'FB', 'S1'),
    (56302, 'QUÍMICA', 6, 'FB', 'S1'),
    (56303, 'FÍSICA', 12, 'FB', 'AN'),
    (56304, 'INFORMÁTICA', 6, 'FB', 'S1'),
    (56306, 'CÁLCULO II', 6, 'FB', 'S2'),
    (56307, 'ESTADÍSTICA', 6, 'FB', 'S2'),
    (56400, 'EXPRESIÓN GRÁFICA', 6, 'FB', 'S2')
),
(
    (56312, 'TECNOLOGÍA ELÉCTRICA', 6, 'OB', 'S1'),
    (56313, 'CIENCIA DE LOS MATERIALES', 6, 'OB', 'S1'),
    (56317, 'MECÁNICA DE FLUIDOS', 6, 'OB', 'S1'),
    (56319, 'SISTEMAS DE FABRICACIÓN Y ORGANIZACIÓN INDUSTRIAL', 6, 'OB', 'S2'),
    (56321, 'TERMODINÁMICA TÉCNICA', 6, 'OB', 'S2'),
    (56403, 'TEORÍA DE MECANISMOS Y ESTRUCTURAS', 6, 'OB', 'S2'),
    (56500, 'TECNOLOGÍA ELECTRÓNICA', 6, 'OB', 'S2'),
    (56501, 'ANÁLISIS DE REDES', 6, 'OB', 'S2'),
    (56311, 'AMPLIACIÓN DE MATEMÁTICAS', 6, 'FB', 'S1'),
    (56316, 'GESTIÓN EMPRESARIAL', 6, 'FB', 'S1')
),
(
    (56406, 'REGULACIÓN AUTOMÁTICA', 6, 'OB', 'S1'),
    (56411, 'ELECTRÓNICA DE POTENCIA', 6, 'OB', 'S1'),
    (56411, 'ELECTRÓNICA DE POTENCIA', 6, 'OB', 'S2'),
    (56412, 'CONTROL DISCRETO', 6, 'OB', 'S2'),
    (56502, 'ELECTRÓNICA ANALÓGICA', 6, 'OB', 'S1'),
    (56503, 'INSTRUMENTACIÓN ELECTRÓNICA', 6, 'OB', 'S2'),
    (56504, 'ELECTRÓNICA DIGITAL I', 6, 'OB', 'S1'),
    (56505, 'ELECTRÓNICA DIGITAL II', 6, 'OB', 'S2'),
    (56506, 'ROBÓTICA INDUSTRIAL', 6, 'OB', 'S1'),
    (56507, 'INFORMÁTICA INDUSTRIAL', 6, 'OB', 'S1'),
    (56508, 'AUTOMATIZACIÓN INDUSTRIAL', 6, 'OB', 'S2')
),
(
    (56415, 'PROYECTOS EN LA INGENIERÍA', 6, 'OB', 'S1'),
    (56453, 'PREVENCIÓN DE RIESGOS LABORALES', 6, 'OP', 'S2'),
    (56523, 'FUNDAMENTOS DE TELECOMUNICACIONES', 6, 'OP', 'S1'),
    (56525, 'SIMULACIÓN DE SISTEMAS ELECTRÓNICOS', 6, 'OP', 'S1'),
    (56526, 'MODELADO DE SISTEMAS DE POTENCIA', 6, 'OP', 'S1'),
    (56527, 'MICROTECNOLOGÍA', 6, 'OP', 'S2'),
    (56528, 'OPTOELECTRÓNICA', 6, 'OP', 'S2'),
    (56529, 'INSTRUMENTACIÓN ELECTRÓNICA AVANZADA', 6, 'OP', 'S1'),
    (56530, 'INSTALACIONES ELÉCTRICAS', 6, 'OP', 'S2')
))

ia = (
(
    (00000, 'TECNOLOGÍA AEROESPACIAL', 6, 'OB', 'S1'),
    (00000, 'ÁLGEBRA', 6, 'FB', 'S1'),
    (00000, 'CÁLCULO I', 6, 'FB', 'S1'),
    (00000, 'QUÍMICA', 6, 'FB', 'S1'),
    (00000, 'FÍSICA I', 6, 'FB', 'S1'),
    (00000, 'FÍSICA II', 6, 'FB', 'S2'),
    (00000, 'CÁLCULO II', 6, 'FB', 'S2'),
    (00000, 'ESTADÍSTICA INFERENCIAL', 6, 'FB', 'S2'),
    (00000, 'EXPRESIÓN GRÁFICA', 6, 'FB', 'S2'),
    (00000, 'TECNOLOGÍA DEL MEDIO AMBIENTE', 6, 'FB', 'S2')
),
(
    (00000, 'METODOS MATEMÁTICOS', 6, 'OB', 'S1'),
    (00000, 'INFORMÁTICA', 6, 'FB', 'S1'),
    (00000, 'TERMODINÁMICA TÉCNICA Y TRANSFERENCIA DE CALOR', 6, 'OB', 'S1'),
    (00000, 'CIENCIA DE LOS MATERIALES', 6, 'OB', 'S1'),
    (00000, 'RESISTENCIA DE LOS MATERIALES', 6, 'OB', 'S1'),
    (00000, 'ELECTROTECNIA', 6, 'OB', 'S2'),
    (00000, 'MECÁNICA DEL SÓLIDO DEFORMABLE', 6, 'OB', 'S2'),
    (00000, 'MECÁNICA DE FLUIDOS', 6, 'OB', 'S2'),
    (00000, 'ELECTRÓNICA Y AUTOMÁTICA', 6, 'FB', 'S2'),
    (00000, 'GESTIÓN EMPRESARIAL', 6, 'FB', 'S2')
),
(
    (00000, 'INGENIERÍA Y TECNOLOGÍA DE MATERIALES', 6, 'OB', 'S1'),
    (00000, 'MÁQUINAS Y MECANISMOS', 6, 'OB', 'S1'),
    (00000, 'AEROPUERTOS Y TRANSPORTE AÉREO', 6, 'OB', 'S1'),
    (00000, 'AERODINÁMICA', 6, 'OB', 'S1'),
    (00000, 'ESTRUCTURAS AERONÁUTICAS', 6, 'OB', 'S1'),
    (00000, 'MATERIALES ESTRUCT AEROESPACIALES', 6, 'OB', 'S2'),
    (00000, 'PLANTAS DE POTENCIA Y FUNDAMENTOS DE PROPULSIÓN', 6, 'OB', 'S2'),
    (00000, 'MECÁNICA DE VUELO Y ORBITAL', 6, 'OB', 'S2'),
    (00000, 'EQUIPOS Y SISTEMAS EMBARCADOS', 6, 'OB', 'S2'),
    (00000, 'FABRICACIÓN Y MANTENIMIENTO AEROESPACIAL', 6, 'OB', 'S2')
),
(
    (00000, 'PROPULSIÓN AEROESPACIAL', 6, 'OB', 'S1'),
    (00000, 'VEHÍCULOS AEROESPACIALES', 6, 'OB', 'S1'),
    (00000, 'NAVEGACIÓN AÉREA', 6, 'OB', 'S1'),
    (00000, 'VIBRACIONES Y AEROELASTICIDAD', 6, 'OB', 'S1'),
    (00000, 'INGENIERÍA DE PRODUCCIÓN AERONÁUTICA', 6, 'OB', 'S1'),
    (00000, 'PROYECTOS DE INGENIERÍA AEROESPACIAL', 6, 'OB', 'S2'),
    (00000, 'EQUIPOS Y SISTEMAS CONFIABLES', 6, 'OB', 'S2'),
    (00000, 'PRÁCTICAS EXTERNAS', 6, 'PE', 'S2')
))

with b.db as d:
    for titid,plan in zip((1,2,3),(ie,ieia,ia)):
        for año,curso in enumerate(plan):
            for asig in curso:
                cod, asignatura, ects, caracter, sem = asig
                semestre = 1 if sem == 'S1' else 2 if sem == 'S2' else 1
                semestre += 2*año
                d.execute('INSERT INTO asignaturas(asignatura,titid,ects,semestre) VALUES (?,?,?,?)',
                        (asignatura,titid,ects,semestre))

por_area = {
'Arquitectura y Tecnología de Computadores': (
    'INFORMÁTICA', 
    'INFORMÁTICA INDUSTRIAL', 
    'EQUIPOS Y SISTEMAS CONFIABLES'
),
'Ciencia de Materiales e Ingeniería Metalúrgica': (
    'CIENCIA DE LOS MATERIALES',
    'SISTEMAS DE FABRICACIÓN Y ORGANIZACIÓN INDUSTRIAL'
),
'Economía Financiera y Contabilidad': (
    'SISTEMAS DE FABRICACIÓN Y ORGANIZACIÓN INDUSTRIAL',
    'GESTIÓN EMPRESARIAL'
),
'Estadística e Investigación Operativa': (
    'ESTADÍSTICA',
    'ESTADÍSTICA INFERENCIAL'
),
'Expresión Gráfica en la Ingeniería': (
    'EXPRESIÓN GRÁFICA',
    'PROYECTOS EN LA INGENIERÍA',
    'PROYECTO Y CÁLCULO DE INSTALACIONES EN EDIFICIOS',
    'DISEÑO DE PROYECTOS DE INSTALACIONES'
),
'Física Aplicada': (
    'FÍSICA',
    'SISTEMAS DE ENERGÍA SOLAR',
    'FÍSICA I',
    'FÍSICA II'
),
'Ingeniería Eléctrica': (
    'TECNOLOGÍA ELÉCTRICA',
    'TEORÍA DE CIRCUITOS',
    'MÁQUINAS ELÉCTRICAS',
    'CONTROL DE MÁQUINAS ELÉCTRICAS',
    'INSTALACIONES ELÉCTRICAS DE BAJA TENSIÓN',
    'INSTALACIONES ELÉCTRICAS DE ALTA TENSIÓN',
    'LÍNEAS ELÉCTRICAS',
    'CENTRALES ELÉCTRICAS',
    'ENERGÍAS RENOVABLES',
    'OBRA CIVIL EN INSTALACIONES',
    'INSTALACIONES DE ALUMBRADO',
    'ANÁLISIS DE REDES',
    'INSTALACIONES ELÉCTRICAS',
    'ELECTROTECNIA'
),
'Ingeniería de Sistemas y Automática': (
    'REGULACIÓN AUTOMÁTICA',
    'CONTROL DISCRETO',
    'ROBÓTICA INDUSTRIAL',
    'AUTOMATIZACIÓN INDUSTRIAL',
    'ELECTRÓNICA Y AUTOMÁTICA'
),
'Matemática Aplicada': (
    'ÁLGEBRA', 
    'CÁLCULO I', 
    'CÁLCULO II', 
    'AMPLIACIÓN DE MATEMÁTICAS',
    'METODOS MATEMÁTICOS'
),
'Máquinas y Motores Térmicos': (
    'TERMODINÁMICA TÉCNICA',
    'SISTEMAS ENERGÉTICOS CONVENCIONALES',
    'SISTEMAS ENERGÉTICOS EMERGENTES',
    'APROVECHAMIENTO ENERGÉTICO DE LA BIOMASA',
    'SISTEMAS DE ENERGÍA EÓLICA',
    'PREVENCIÓN DE RIESGOS LABORALES',
    'TERMODINÁMICA TÉCNICA Y TRANSFERENCIA DE CALOR'
),
'Química': (
    'QUÍMICA', 
    'TECNOLOGÍA DEL MEDIO AMBIENTE'
),
'Química Analítica': (
    'QUÍMICA', 
    'TECNOLOGÍA DEL MEDIO AMBIENTE'
),
'Química Inorgánica': (
    'QUÍMICA', 
    'TECNOLOGÍA DEL MEDIO AMBIENTE'
),
'Tecnología Electrónica': (
    'ELECTRÓNICA', 
    'ELECTRÓNICA DE POTENCIA',
    'TECNOLOGÍA ELECTRÓNICA',
    'ELECTRÓNICA ANALÓGICA',
    'INSTRUMENTACIÓN ELECTRÓNICA',
    'ELECTRÓNICA DIGITAL I',
    'ELECTRÓNICA DIGITAL II',
    'FUNDAMENTOS DE TELECOMUNICACIONES',
    'SIMULACIÓN DE SISTEMAS ELECTRÓNICOS',
    'MODELADO DE SISTEMAS DE POTENCIA',
    'MICROTECNOLOGÍA',
    'OPTOELECTRÓNICA',
    'INSTRUMENTACIÓN ELECTRÓNICA AVANZADA'
),
'Ingeniería Mecánica': (
    'MECÁNICA DE FLUIDOS', 
    'TEORÍA DE MECANISMOS Y ESTRUCTURAS',
    'RESISTENCIA DE LOS MATERIALES',
    'MECÁNICA DEL SÓLIDO DEFORMABLE'
)}

with b.db as d:
    for area,asigs in por_area.items():
        for asignatura in asigs:
            d.execute('INSERT INTO areas_asignaturas SELECT areaid,asigid FROM areas CROSS JOIN asignaturas WHERE area = ? AND asignatura = ?',
                    (area,asignatura))
