# Intranet de la EII-TO

La intranet es el recurso informático que usaremos cuando no tengamos otra opción.  Si podemos, intentaremos que todo lo que se hace en la intranet se termine haciendo en servidores gestionados por la Universidad u otros servicios externos.

## Servicios básicos

`/form/profesores`  Datos personales de profesores. Capacidad de editar despacho, sexenios, quinquenios y acreditación.

`/app/docencia.html`  Datos de docencia.  Los jefes de área pueden definir la docencia de los profesores de su área.

`/app/tutorias.html`  Horario de tutoría del profesor.

`/app/desiderata.html`  Desiderata de horarios del profesor.

## Servicios de administración

Estos servicios solo están disponibles para el administrador.

`/form/admin_profesores`  Permita editar datos personales de cualquier profesor.

`/app/admin_desiderata.html`  Permite editar las desiderata de horarios de cualquier profesor.

`/app/directorio.html` Permite añadir profesores del directorio activo, o actualizar los que ya hay.

## API REST

Internamente toda la interacción se produce mediante una API REST sencilla.  Cada recurso tiene la siguiente semántica:

* `GET` Obtiene los valores del recurso o colección de recursos.
* `POST` Crea un nuevo elemento en la colección.
* `PUT` Actualiza parcial o totalmente un elemento de la colección.
* `DELETE` Elimina un elemento de la colección.

Los recursos disponibles son los siguientes:

* `/v2/<tabla>/schema`  Estructura de la tabla (o vista) `<tabla>`.  Solo admite `GET`.

* `/v2/<tabla>/por_<columna>/` Datos de la tabla `<tabla>` ordenados por la columna `<columna>`. Admite `GET`, `POST` y `PUT`.

* `/v2/<tabla>/por_<columna>/<valor>` Registros de la tabla `<tabla>` que tiene el valor `<valor>` en la columna `<columna>`. Admite `GET` y `DELETE`.

* `v2/justificantes/<usuario>` Justificantes para el usuario `<usuario>`. Admite `GET`, `POST` y `DELETE`. El archivo debe tener la clave `justificante` y estar codificado como `multipart/form-data`.  Devuelve la lista completa de archivos para el usuario.

* `v2/directorio/update_profesores/` Actualiza los datos básicos de profesores del directorio activo. Solo responde a `POST` con argumentos JSON `userid`, `password` (del usuario que hace la consulta al directorio activo) y opcionalmente `name` y `campus`.  Si no hay campo `name` se actualizan todos los profesores de la Escuela.


| Tabla | Descripción |
|---|-----|
|`profesores`| Tabla de profesores con datos básicos |
|`profesores.expandidos`| Vista expandida con muchos datos de los profesores |
|`profesores.desiderata`| Desiderata de los profesores |
|`profesores.tutorias`| Tutorías de los profesores|
|`profesores.areas`| Áreas de los profesores |
|`profesores.superareas`| Agrupación de áreas que comparten docencia|
|`profesores.categorias`| Categorías profesionales de profesores (del directorio activo) |
|`profesores.departamentos`| Departamentos de los profesores (del directorio activo) |
|`docencia.titulos`| Titulaciones impartidas |
|`docencia.asignaturas`| Asignaturas impartidas |
|`docencia.profesores_asignaturas`| Asignación de profesores a asignaturas |
|`docencia.areas_asignaturas`| Asignación de áreas a asignaturas |
|`docencia.por_profesor`| Vista de la docencia de cada profesor |
|`docencia.por_area`| Vista de la docencia de cada área |
|`docencia.por_superarea`| Vista de la docencia de cada superárea |


## Páginas estáticas

`/static/tutorias.html` muestra los datos y tutorías de los profesores.  Internamente hace consultas al API JavaScript.
