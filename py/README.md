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

* Descarga las aplicaciones de este proyecto GitHub [UCLM-EII](http://github.com/FranciscoMoya/uclm-eii). Usa el botón *Clone or download* y selecciona *Download ZIP*.  Descomprime el ZIP en cualquier carpeta.

## Tutorías

Desactivar el formulario de Google y descargar las respuestas como CSV.

Ejecutar el script así:

```
python tutorias.py --json --gform --html ../tutorias.html
```

De esta forma graba y usa `data.json` como almacén de datos disponibles hasta ahora.  Esto permite borrar las respuestas dadas hasta ahora en el formulario.

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
* Descarga las actas de la asignatura `INFORMÁTICA` de (actascalificacion.uclm.es](https://actascalificacion.uclm.es) en los archivos `A.xlsx`, `B.xlsx` y `C.xlsx`. Normalmente estas actas solo tendrán los nombres de los alumnos.
* Rellena de forma automática todas las actas y guarda el resultado en los archivos `inf-18-19-A.xlsx`, `inf-18-19-B.xlsx` y `inf-18-19-C.xlsx`.
* Sube las actas rellenas a [actascalificacion.uclm.es](https://actascalificacion.uclm.es).

Si necesitas cambiar alguna calificación, puedes hacerlo en los archivos resultado (p.ej. `inf-18-19-A.xlsx`) y posteriormente subir las actas con la orden siguiente:

```
python actas.py --actas A.xlsx B.xlsx C.xlsx --out-prefix inf-18-19- --upload INFORMÁTICA
```

