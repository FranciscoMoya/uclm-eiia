SERVICE_ENDPOINT = "/v1/datos_profesionales/";

function pending(v) {
    const img = document.querySelector("#pending");
    img.style.display = (v ? "block": "none");
    const b = document.querySelector('#actualizar');
    b.disabled = false;
}

// AD Data
PROFESOR_ENDPOINT = "/v1/profesor/";
function getADDataForUser(userid) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 300) {
            showError(req.responseText);
            return;
        }
        var resp = JSON.parse(req.responseText);
        for (var key in resp) {
            fillValue(key, resp[key]);
        }
    };
    req.open('GET', PROFESOR_ENDPOINT + userid, true);
    req.send();
}

function getDatosProfesionalesForUser(userid) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 300) {
            showError(req.responseText);
            return;
        }
        var resp = JSON.parse(req.responseText);
        fillValues(resp);
        const tel = document.getElementById('telefono');
        const telAD = document.getElementById('telephoneNumber');
        if (!tel.value)
            tel.value = telAD.value;
        // displayName es inconsistente
        const nombre = document.getElementById('nombre');
        const givenName = document.getElementById('givenName');
        const sn = document.getElementById('sn');
        nombre.value = givenName.value + ' ' + sn.value;    
    };
    req.open('GET', SERVICE_ENDPOINT + userid, true);
    req.send();
}


function setDatosProfesionalesForUser(userid, form) {
    pending(true);
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 300) {
            showError(req.responseText);
        }
        pending(false);
    };
    req.open('PUT', SERVICE_ENDPOINT + userid, true);
    req.setRequestHeader("Content-Type", "application/json");
    req.send(serializeUserData(form));
}

function fillValues(data) {
    for (var key in data) {
        fillValue(key, data[key]);
    }
}

function fillValue(name, val) {
    const input = document.querySelector('#' + name);
    if (!input) return;
    if (input.tagName == 'INPUT') {
        if (input.type == 'checkbox') {
           input.checked = val != 0;
        }
        else {
            input.value = val;
        }
    }
    else if (input.tagName == 'SELECT') {
        for (var i = 0; i < input.length; ++i) {
            input.options[i].selected = valueInArray(input.options[i].value, val);
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
    var err = document.querySelector("#errors");
    if (err)
        err.innerHTML = obj ? obj.message : msg;
}

function serializeUserData(form) {
    const columns = ["area","telefono","despacho","quinquenios","sexenios","sexenio_vivo","acreditacion"];
    var ret = {};
    for (var i=0; i<columns.length; ++i) {
        key = columns[i];
        ret[key] = getValue(form, key);
    }
    ret.quinquenios = parseInt(ret.quinquenios);
    ret.sexenios = parseInt(ret.sexenios);
    console.log('formData', JSON.stringify(ret));
    return JSON.stringify(ret);
}

function getValue(form, name) {
    const input = document.querySelector('#' + name);
    if (!input) return;
    if (input.tagName == 'INPUT') {
        if (input.type == 'checkbox') {
           return input.checked ? 1 : 0;
        }
        else {
            return input.value;
        }
    }
    else if (input.tagName == 'SELECT') {
        var ret = [];
        for (var i = 0; i < input.length; ++i) {
            if (input.options[i].selected)
                ret.push(input.options[i].value);
        }
        return ret;
    }
}
