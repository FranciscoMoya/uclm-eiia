# Scripts de apoyo a la UCLM - EII Toledo

Lo siento, hay muchas cosas que hacer y no tengo tiempo de que estas aplicaciones sean fáciles de usar para personas no iniciadas en la informática.  Si estás interesado en alguno y tienes problemas para hacerlos funcionar, avísame.

## Instalación

* Instala [Python](http://python.org).  Al instalar, no olvides marcar la casilla para añadir `python` al `PATH`.

* Instala los paquetes necesarios de Python.  En un terminal de órdenes (PowerShell o `cmd.exe`)

```
pip install selenium
pip install requests
pip install openpyxl
```

* Descarga las aplicaciones de este proyecto GitHub [UCLM-EII](http://github.com/FranciscoMoya/uclm-eii). Usa el botón *Clone or download* y selecciona *Download ZIP*.  Descomprime el ZIP en cualquier carpeta.  Por ejemplo, vamos a suponer que lo descomprimes en la carpeta de *Documentos*.

* En la carpeta donde lo has descomprimido verás otra carpeta `py`.  Crea con `wordpad.exe` un archivo de texto en esa carpeta que se llame `cv_cfg.py` con el siguiente contenido.  Fíjate en que tanto el usuario como la contraseña deben estar entre comillas.  Si usas la comilla simple en tu contraseña usa dobles comillas en este archivo.  Si eso también te da problemas habla conmigo.

```
USERNAME = 'Tu usuario de la UCLM'
PASSWORD = 'Tu contraseña de la UCLM'
```

* Ejecuta un terminal de órdenes. Basta presionar la tecla de Windows y teclear el nombre. Hay dos ampliamente usados.  El moderno es `powershell.exe`, el cásico es `cmd.exe`.  Para lo que vamos a hacer da igual.

* Cambia la carpeta de trabajo a la carpeta `py` donde guardaste el archivo de contraseñas con una orden similar a `cd Documents\uclm-eii\py`. Modifica la ruta según la carpeta donde descomprimiste el ZIP. 

* Ten paciencia.  Uso un framework de prueba de aplicaciones web que no es precisamente rápido.  Las aplicaciones terminarán funcionando

## Tutorías

Esta aplicación ya es obsoleta.  Su funcionalidad se ha sustituido por la página dinámica
`intranet/html/static/tutorias.html` que se construye con los datos extraídos de la Intranet.

## Actas

La aplicación `actas.py` permite actualizar las actas de una asignatura con las calificaciones de Campus Virtual.  Un pequeño resumen de las opciones disponibles puede obtenerse ejecutando:

```
python actas.py --help
```

Lo siguiente es un ejemplo de ejecución para leer las calificaciones de la asignatura INFORMÁTICA, rellenar las actas, y subirlas a la aplicación de actas:

```
python actas.py --fetch INFORMÁTICA --cv informatica-18-19.xlsx --actas A.xlsx B.xlsx C.xlsx --out-prefix inf-18-19- --upload
```

Esta invocación realiza las siguientes operaciones:

* Descarga las calificaciones de la asignatura `INFORMÁTICA` del [Campus Virtual](https://campusvirtual.uclm.es) y las guarda en el archivo `informatica-18-19.xlsx`.
* Descarga las actas de la asignatura `INFORMÁTICA` de [actascalificacion.uclm.es](https://actascalificacion.uclm.es) en los archivos `A.xlsx`, `B.xlsx` y `C.xlsx`. Normalmente estas actas solo tendrán los nombres de los alumnos.
* Rellena de forma automática todas las actas y guarda el resultado en los archivos `inf-18-19-A.xlsx`, `inf-18-19-B.xlsx` y `inf-18-19-C.xlsx`.
* Sube las actas rellenas a [actascalificacion.uclm.es](https://actascalificacion.uclm.es).

Si necesitas cambiar alguna calificación, puedes hacerlo en los archivos resultado (p.ej. `inf-18-19-A.xlsx`) y posteriormente subir las actas con la orden siguiente:

```
python actas.py --noout --actas A.xlsx B.xlsx C.xlsx --out-prefix inf-18-19- --upload INFORMÁTICA
```

Es muy importante utilizar el mismo nombre de la asignatura que aparece en Campus Virtual.  Si tienes algún problema habla conmigo.

### Más opciones

El script permite otras opciones, como considerar *no presentado* al alumno que no se presenta a alguna actividad, escalar las calificaciones, si en el Campus Virtual se usa una escala diferente a 10, o redondear hacia arriba las calificaciones de más de un 4.0.  Por ejemplo, la invocación real en INFORMÁTICA sería:

```
python actas.py --fetch INFORMÁTICA --cv informatica-18-19.xlsx --actas A.xlsx B.xlsx C.xlsx --out-prefix inf-18-19- --upload --ceil --scale 10 --require "Examen ordinario"
```

## Disclaimer

En este corto periodo de tiempo en el que estoy intentando modernizar los procesos de la Escuela ya he tenido que aguantar a uno que entra insultándome en el despacho y que, encima, suelta sin ruborizarse una idiotez sin la más leve intención de que resulte útil (ni para él ni para la Escuela).  Yo sigo convencido de que la inmensa mayoría del PDI de la Escuela son excelentes personas y por eso sigo empeñado en evitar que dilapiden su tiempo con procesos mecánicos.

Pero aprovecho la ocasión para avisar. **No tengo paciencia con este tipo de comportamientos infantiles**, tengo bastante con un niño de cinco años.  De todas formas si has llegado hasta aquí no debes asustarte, todo el que quiera mejorar la Escuela, sus procesos, o sus resultados tendrá toda mi atención.
