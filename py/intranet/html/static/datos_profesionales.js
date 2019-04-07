SERVICE_ENDPOINT = "/v1/datos_profesionales/";

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
        for (var key in resp) {
            fillValue(key, resp[key]);
        }
    };
    req.open('GET', SERVICE_ENDPOINT + userid, true);
    req.send();
}

function fillValue(name, val) {
    const input = document.querySelector('#' + name);
    if (!input) return;
    if (input.tagName == 'INPUT') {
        if (input.type == 'checkbox')
           input.checked = val != 0;
        else
            input.value = val;
    }
    else if (input.tagName == 'SELECT') {
        for (var i = 0; i < input.length; ++i) {
            input.options[i].selected = valueInArray(input.options[i].value, val);
        }
    }
}

function valueInArray(v, arr) {
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
