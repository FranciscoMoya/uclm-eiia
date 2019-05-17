const docencia = document.getElementById('docencia');
const uid = document.getElementById('chooserid');
const actualizar = document.getElementById('actualizar');
const all_profes = {};

uid.onchange = function() {
    getAsignaturasProfe(uid.options[uid.selectedIndex].value);
};

function pending(v) {
    const img = document.getElementById('pending');
    img.style.display = (v ? "block": "none");
    actualizar.disabled = v;
}

function getData(url, func, data) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 300) {
            showError(req.responseText);
            return;
        }
        var resp = JSON.parse(req.responseText);
        func(resp, data);
    };
    req.open('GET', url, true);
    req.send();
}

function getProfesor(userid) {
    pending(true);
    getData('/v2/profesores.expandidos/por_userid/' + userid, function (profes) {
        if (profes.length < 1) {
            showError('Profesor ' + userid + ' no encontrado.');
            return;
        }
        var profe = profes[0];
        fillValues(profe);
        actualizar.style.display = (profe.head ? 'block': 'none');
        docencia.disabled = !profe.head;
        getData('/v2/profesores.expandidos/por_sareaid/' + profe.sareaid, function (resp,profe) {
            for (var i = 0; i < resp.length; ++i) {
                const p = resp[i];
                all_profes[p.userid] = p;    
                uid.options.add(new Option(p.sn + ', ' + p.givenName, p.userid));
                if (p.userid == profe.userid)
                    uid.options[i].selected = true;
            }
            getAsignaturasSuperArea(profe);
        }, profe);
    });
}

function getAsignaturasSuperArea(profe) {
    getData('/v2/docencia.por_superarea/por_sareaid/' + profe.sareaid, function (resp, profe){
        docencia.innerHTML = 
        '<table class="table">\
            <thead>\
                <tr class="headings">\
                    <th scope="col">Curso</th>\
                    <th scope="col">Título</th>\
                    <th scope="col">Asignatura</th>\
                    <th scope="col">Teoría</th>\
                    <th scope="col">Lab.</th>\
                </tr>\
            </thead>\
            <tbody id="docenciaRows"></tbody>\
        </table>';
        resp.sort(function (a,b){
            if (a.semestre < b.semestre) return -1;
            if (a.semestre > b.semestre) return 1;
            const t = a.titulo.localeCompare(b.titulo);
            if (t) return t;
            return a.asignatura.localeCompare(b.asignatura);
        });
        const rows = document.getElementById('docenciaRows');
        for (var i = 0; i < resp.length; ++i) {
            createRowAsignatura(rows, resp[i]);
        }
        getAsignaturasProfe(profe.userid);
    }, profe);
}

function createRowAsignatura(rows, p) {
    const tr = document.createElement('tr');
    tr.setAttribute('class', 'area' + p.areaid);
    tr.setAttribute('id', asig_id('A', p.areaid, p.asigid));
    rows.appendChild(tr);

    const curso = document.createElement('td');
    curso.innerHTML = Math.floor(p.semestre/2 + 0.5) + 'º';
    tr.appendChild(curso);

    const titulo = document.createElement('td');
    titulo.innerHTML = p.titulo;
    tr.appendChild(titulo);

    const asig = document.createElement('td');
    asig.innerHTML = p.asignatura;
    tr.appendChild(asig);

    const teo = checkbox(asig_id('T', p.areaid, p.asigid));
    tr.appendChild(teo);

    const lab = checkbox(asig_id('L', p.areaid, p.asigid));
    tr.appendChild(lab);
}

function checkbox(id) {
    const td = document.createElement('td');
    td.setAttribute('align', 'center');
    td.innerHTML = '<input class="form-check-input" type="checkbox" id="' 
        + id + '"' 
        + (isaAreaHead()? '>':' disabled>');
    return td;
}

function asig_id(prefix, areaid, asigid) {
    return prefix + '_' + areaid + '_' + asigid
}

function asigid_from_id(id) {
    const r = id.split('_');
    if (r.length > 2) {
        return parseInt(r[2]);
    }
    return -1;
}

function getAsignaturasProfe(userid) {
    const profe = all_profes[userid];
    if (!profe) alert(JSON.stringify(profe));
    getData('/v2/docencia.por_profesor/por_userid/' + userid, function (asignaturas) {
        const trh = document.querySelectorAll('tr:not(.headings):not(.area' + profe.areaid + ')');
        for (var i=0; i<trh.length; ++i) {
            trh[i].style.display = 'none';
        }
        const tr = document.querySelectorAll('tr.area' + profe.areaid );
        for (var i=0; i<tr.length; ++i) {
            tr[i].style.display = null;
        }
        const cb = document.querySelectorAll('input[type="checkbox"]');
        for (var i=0; i<cb.length; ++i) {
            cb[i].checked = false;
        }
        asignaturas.forEach(function (a) {
            const teo = document.getElementById(asig_id('T', profe.areaid, a.asigid));
            teo.checked = (a.teoria != 0);    
            const lab = document.getElementById(asig_id('L', profe.areaid, a.asigid));
            lab.checked = (a.laboratorio != 0);    
        });
        pending(false);
    });
}

function fillValues(data) {
    for (var key in data) {
        fillValue(key, data[key]);
    }
}

function fillValue(name, val) {
    const input = document.getElementById(name);
    if (!input) return;
    if (input.tagName == 'INPUT') {
        if (input.type == 'checkbox') {
        input.checked = val != 0;
        }
        else {
            input.value = val;
        }
    }
    else if (input.tagName == 'SELECT' && input.multiple) {
        Array.prototype.forEach.call(input.options, function(op) {
            op.selected = valueInArray(op.value, val);
        });
    }
    else if (input.tagName == 'SELECT') {
        for (var i = 0; i < input.length; ++i) {
            if (input.options[i].value == val)
                input.selectedIndex = i;
        }
    }
    else  {
        input.innerHTML = val;
    }
}

function isaAreaHead() {
    const userid = uid.options[uid.selectedIndex].value;
    const profe = all_profes[userid];
    return profe.head;
}

function postUI() {
    const userid = uid.options[uid.selectedIndex].value;
    const profe = all_profes[userid];
    if (!userid) return;
    pending(true);
    const rows = document.querySelectorAll('#docenciaRows>tr[class="area' + profe.areaid + '"]')
    Array.prototype.forEach.call(rows, function(row) {
        const v = row.querySelectorAll('input');
        const asigid = asigid_from_id(v[0].id);
        const teoria = v[0].checked;
        const laboratorio = v[1].checked;
        var req = new XMLHttpRequest();
        req.open('POST', '/v2/docencia.profesores_asignaturas/por_userid/', true);
        req.setRequestHeader("Content-Type", "application/json");
        req.send(JSON.stringify({ 
            'userid': userid, 
            'asigid': asigid,
            'teoria': teoria,
            'laboratorio': laboratorio
        }));
    });        
    pending(false);
}

function valueInArray(v, arr, accessor) {
    if (!arr)
        return false;
    if (!accessor)
        accessor = function(x){return x;}
    for (var vv = 0; vv < arr.length; ++vv)
        if (v == accessor(arr[vv]))
            return true;
    return false;
}
