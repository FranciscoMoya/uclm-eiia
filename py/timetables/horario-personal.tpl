\documentclass[a4paper]{article}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[top=5mm, bottom=5mm, left=5mm, right=5mm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage{PTSansNarrow,tikz}
\renewcommand*\familydefault{\sfdefault}
\usepackage[spanish]{babel}

\usetikzlibrary{positioning,shapes,shapes.multipart}

%Options for timetable contents
\def\firsthour{8}
\def\lasthour{21}
\def\daynames{lunes, martes, miércoles, jueves, viernes}

%Options for timetable drawing
\def\daywidth{3.8cm}   %approx \textwidth / 6
\def\hourheight{2cm} %approx \textheight / (\lasthour - \firsthour + 1)

\title{Horario personal de {{prof}}}
\author{}

\begin{document}

{% for id,sn,fn in profesores %}
{%- set sid = id.replace('.','_') -%}
\input{Primer_semestre_{{ sid }}.tex}
\input{Segundo_semestre_{{ sid }}.tex}
{% endfor %}

\end{document}