# Intranet de la EII-TO

## Servicios básicos

`/app/tutorias.html`

`/app/despacho.html`

`/app/desiderata.html`

## API REST

`v1/profesores/` Lista de datos del Active Directory para profesores de la EII (JSON).  Esta lista se extrae de un archivo estático generado mediante `v1/buscar_profesores/<userid:string>:<password:string>`.  Cuidado al generar esta lista, estás enviando la contraseña a pelo.  Procura hacerlo solo en local.

`v1/tutorias/`  Lista de las tutorías (JSON)

`v1/despachos/`  Lista de las despachos (JSON)

`v1/desiderata/` Lista de las desiderata de horarios (JSON)

## Páginas estáticas

`/static/tutorias.html` muestra los datos y tutorías de los profesores.  Internamente hace consultas al API JavaScript.
