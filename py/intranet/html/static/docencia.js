const docencia = document.getElementById('docencia');
const uid = document.getElementById('chooserid');
const actualizar = document.getElementById('actualizar');
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
            console.log(resp, profe);
            for (var i = 0; i < resp.length; ++i) {
                const p = resp[i];
                uid.options.add(new Option(p.sn + ', ' + p.givenName, p.userid));
                if (p.userid == profe.userid)
                    uid.options[i].selected = true;
            }
            getData('/v2/docencia.por_area/por_areaid/' + profe.areaid, function (resp, profe){
                for (var i = 0; i < resp.length; ++i) {
                    const p = resp[i];
                    docencia.options.add(new Option(
                        Math.floor(p.semestre/2 + 0.5) + 'º. ' 
                            + p.titulo + '. ' + p.asignatura, 
                        p.asigid));
                }
                getAsignaturasProfe(profe.userid);
            }, profe);
        }, profe);
    });
}

function getAsignaturasProfe(userid) {
    getData('/v2/docencia.por_profesor/por_userid/' + userid, function (asignaturas, profe){
        for (var i = 0; i < docencia.options.length; ++i) {
            const p = docencia.options[i];
            p.selected = valueInArray(p.value, asignaturas, function(x) {return x.asigid;});
        }
        sortSelect(docencia); // fixes Edge rendering issue
        pending(false);
    });
}

function sortSelect(sel) {
    var arr = new Array();
    Array.prototype.forEach.call(sel.options, function(op) {
        arr.push([op.text, op.value, op.selected]);
    });
    arr.sort(function (a,b){
        return a[0].localeCompare(b[0]);
    });
    while (sel.options.length > 0) {
        sel.options[0] = null;
    }
    arr.forEach(function(e) {
        sel.options.add(new Option(e[0], e[1], false, e[2]));
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

function postUI() {
    const userid = uid.options[uid.selectedIndex].value;
    if (!userid) return;
    pending(true);
    var req = new XMLHttpRequest();
    req.onload  = function() { 
        Array.prototype.forEach.call(docencia.selectedOptions, function(asig) {
            var req = new XMLHttpRequest();
            req.open('POST', '/v2/docencia.profesores_asignaturas/por_userid/', true);
            req.setRequestHeader("Content-Type", "application/json");
            req.send(JSON.stringify({ 'userid': userid, 'asigid': parseInt(asig.value) }));
        });        
        pending(false);
    };
    req.open('DELETE', '/v2/docencia.profesores_asignaturas/por_userid/' + userid, true);
    req.send();
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
