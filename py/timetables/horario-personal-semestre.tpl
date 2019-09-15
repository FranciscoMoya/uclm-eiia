\section*{ Horario personal de {{prof}}, {{semestre}} }
{\centering
\begin{tikzpicture}[
    x=\daywidth, y=-\hourheight,
    block/.style={
        draw, text width=\daywidth, minimum height=\hourheight, inner sep=0pt, align=flush center
    },
    hour/.style ={block, fill=white, font=\small,
        rotate=90, 
        minimum height=1cm, minimum width=\hourheight, 
        anchor=south west, 
        xshift=-0.5*\hourheight, yshift=-0.5*\daywidth,
        text width=\hourheight},
    day/.style  ={block, fill=white, font=\normalsize,
        align=left, inner sep=5pt, text width=\daywidth-10pt,
        minimum height=0.4*\hourheight, yshift=-0.3*\hourheight},
    event details/.style={
        align=flush center,
        inner xsep=0pt, inner ysep=1pt,
        rectangle split, rectangle split parts=3,
        text width=0.95*\daywidth
    },
    name/.style ={font=\bfseries\small},
    dates/.style ={gray, font=\scriptsize, anchor=south east, align=right},
    desc/.style ={font=\scriptsize\itshape},
    loc/.style  ={font=\small},
    hours/.style={minimum height=#1*\hourheight}
]

{%- for name, color in names -%}
    \tikzset{ {{name}}/.style={block, fill={{color}}!20, draw={{color}}!50!black, thick} }
{% endfor %}

\draw[help lines, xshift=0.5*\daywidth, yshift=0.5*\hourheight]
    (0, \firsthour) grid [xstep=\daywidth, ystep=\hourheight] (5, \lasthour);

\pgfmathtruncatemacro\secondhour{\firsthour + 1}
\foreach \tend[remember=\tend as \start (initially \firsthour)] in {\secondhour, ..., \lasthour} {
    \node[hour] at (0, \start) {\start:00\\\tend:00};
}

\foreach \day[count=\daynum] in \daynames {
    \node[day] at (\daynum, \firsthour-1) {\day};
}

{%- for day in days -%}
    {%- set dayloop = loop -%}
    {%- for time, event in day.items() -%}
        {%- set duration = event.duration.seconds / 3600 -%}
        {%- set y = time  + (duration - 1) / 2 -%}
    
    \node[{{event.name}}, hours={{duration}}] at ( {{ dayloop.index }} , {{ y }} ) {};
    \node[event details] at ( {{ dayloop.index }} , {{ y }} ) {
        \nodepart[name]{one}   \strut {{ event.name }} 
        \nodepart[desc]{two}   \strut {{ event.description }}
        \nodepart[loc] {three} \strut {{ event.location }}
    };
    \node[dates] at ( {{ dayloop.index }}.5, {{y + duration/2}}) { {{ event.dates }} };

    {%- endfor %}
{% endfor %}

\end{tikzpicture}}
\clearpage
