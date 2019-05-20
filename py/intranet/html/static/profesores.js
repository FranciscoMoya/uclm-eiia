function pending(v) {
    const img = document.querySelector("#pending");
    img.style.display = (v ? "block": "none");
    const b = document.querySelector('#actualizar');
    b.disabled = false;
}

function getProfesor(userid) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 300) {
            showError(req.responseText);
            return;
        }
        var resp = JSON.parse(req.responseText);
        if (resp.length < 1) {
            showError('Profesor ' + userid + ' no encontrado.');
            return;
        }
        fillValues(resp[0]);
    };
    req.open('GET', '/v2/profesores.expandidos/por_userid/' + userid, true);
    req.send();
}


function setProfesor(userid, form) {
    pending(true);
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 300) {
            showError(req.responseText);
        }
        pending(false);
    };
    req.open('POST', "/v2/profesores/por_userid/", true);
    req.setRequestHeader("Content-Type", "application/json");
    var profe = getUserData(form);
    profe.userid = userid;
    req.send(JSON.stringify(profe));
}

function fillValues(data) {
    data.acreditacion = [];
    ["cu","tu","cd","ad"].forEach(function(i){
        if (data[i]) data.acreditacion.push(i);
    });
    for (var key in data) {
        fillValue(key, data[key]);
    }
    const nombre = document.getElementById('nombre');
    const givenName = document.getElementById('givenName');
    const sn = document.getElementById('sn');
    nombre.value = givenName.value + ' ' + sn.value; 
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
        for (var i = 0; i < input.length; ++i) {
            input.options[i].selected = valueInArray(input.options[i].value, val);
        }
    }
    else if (input.tagName == 'SELECT') {
        for (var i = 0; i < input.length; ++i) {
            if (input.options[i].value == val)
                input.selectedIndex = i;
        }
    }
}

function valueInArray(v, arr) {
    if (!arr)
        return false;
    for (var vv = 0; vv < arr.length; ++vv)
        if (v == arr[vv])
            return true;
    return false;
}

function showError(msg) {
    obj = JSON.parse(msg);
    var err = document.getElementById("errors");
    if (err)
        err.innerHTML = obj ? obj.message : msg;
}

function getUserData(form) {
    const columns = ["userid","deptid","areaid","catid","telefono","despacho","quinquenios","sexenios","sexenio_vivo","acreditacion","head"];
    var ret = {};
    for (var i=0; i<columns.length; ++i) {
        key = columns[i];
        ret[key] = getValue(form, key);
    }
    ret.quinquenios = parseInt(ret.quinquenios);
    ret.sexenios = parseInt(ret.sexenios);
    ['cu','tu','cd','ad'].forEach(function(i){
        ret[i] = valueInArray(i, ret.acreditacion);
    });
    delete ret['acreditacion'];
    return ret;
}

function getValue(form, name) {
    const input = document.getElementById(name);
    if (!input) return;
    if (input.tagName == 'INPUT') {
        if (input.type == 'checkbox') {
           return input.checked ? true : false;
        }
        else {
            return input.value;
        }
    }
    else if (input.tagName == 'SELECT' && input.multiple) {
        var ret = [];
        for (var i = 0; i < input.length; ++i) {
            if (input.options[i].selected)
                ret.push(input.options[i].value);
        }
        return ret;
    }
    else if (input.tagName == 'SELECT') {
        for (var i = 0; i < input.length; ++i) {
            return input.options[input.selectedIndex].value;
        }
        return null;
    }
}
