SERVICE_ENDPOINT = "/v1/desiderata/";
var args = getUrlVars();
var dirty = true;

function pending(v) {
    dirty = v;
    const img = document.querySelector("#pending");
    img.style.display = (dirty ? "block": "none");
}

function getDesiderataForCurrentUser() {
    var userid = args['userid'];
    return getDesiderataForUser(userid);
}

function getDesiderataForUser(userid) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        const table = document.querySelector(".timetable");
        var resp = (req.status < 300 ? JSON.parse(req.responseText) : getDefaultDesiderata(document.querySelector(".headings")));
        appendTimetable(table, resp);
        pending(false);
    };
    req.open('GET', SERVICE_ENDPOINT + userid, true);
    req.send();
}

function updateDesiderataForCurrentUser() {
    var userid = args['userid'];
    return updateDesiderataForUser(userid)();
}

function updateDesiderataForUser(userid) {
    return function() {
        if (dirty) setDesiderataForUser(userid);
    }
}

function setDesiderataForUser(userid) {
    var req = new XMLHttpRequest();
    req.open('PUT', SERVICE_ENDPOINT + userid, true);
    req.setRequestHeader("Content-Type", "application/json");
    req.onload  = function() {
        if (req.status < 300)
            pending(false);
        else
            showError(req.responseText);
        dirty = false; // prevent retries if not authorized
    };
    const table = document.querySelector(".timetable");
    const data = getDataFromTable(table);
    const payload = JSON.stringify(data);
    req.send(payload);
}

function getDefaultDesiderata(table) {
    var tr = table.querySelector('tr');
    var td = tr.querySelectorAll('th')
    return ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes'].map(function(d){ 
        return [d].concat(Array.apply(null, new Array(td.length - 1)).map(Number.prototype.valueOf, 0));
    });
}

function appendTimetable(table, tt) {
    var needEvidence = false;
    for (var dia=0; dia<tt.length; ++dia) {
        var row = table.insertRow(-1);
        var th = document.createElement('TH');
        th.scope = "row";
        th.innerHTML = tt[dia][0];
        row.appendChild(th);
        for (var i=1; i<tt[dia].length; ++i) {
            var cell = row.insertCell(-1);
            needEvidence |= (tt[dia][i] == 3 || tt[dia][i] == -3);
            cell.className = value2class(tt[dia][i]);
            cell.onclick = fillWithSelectedColor(cell);
        }
    }
    showEvidence(needEvidence);
}

function fillWithSelectedColor(cell) {
    return function() {
        selected = document.querySelector('input[type=radio]:checked').classList[1];
        cell.className = selected;
        pending(true);
    }
}

function getDataFromTable(table) {
    var tt = [];
    var tr = table.querySelectorAll('tr');
    var needEvidence = false;
    for (var dia=0; dia<tr.length; ++dia) {
        var values = [];
        values[0] = tr[dia].querySelector('th').textContent;
        var td = tr[dia].querySelectorAll('td');
        for (var i=0; i < td.length; ++i) {
            const v = class2value(td[i].className);
            values[i+1] = v;
            needEvidence |= (v == 3 || v == -3);
        }
        tt[dia] = values;
    }
    showEvidence(needEvidence);
    return {
        desideratum: tt
    }
}

function value2class(v) {
    return v==0? 'zr': v>0? 'p' + v.toString() : 'm' + (-v).toString();
}

function class2value(v) {
    return v[0]=='z'? 0: v[0]=='p'? parseInt(v.substr(1)) : - parseInt(v.substr(1));
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

function showEvidence(needEvidence) {
    document.getElementById('evidenceUI').style.display = (needEvidence? 'block': 'none');
}

function showError(msg) {
    obj = JSON.parse(msg);
    var err = document.querySelector("#errors");
    if (err)
        err.innerHTML = obj.message;
}

function fillJustificantes(uid, data) {
    const tab = document.querySelector("#justificantesTab");
    tab.innerHTML = '';
    const just = data.justificantes;
    for (i in just) {
      const f = just[i];
      var tr = document.createElement('TR');
      tr.innerHTML = '<td><i class="fa fa-file mr-1"></i>' +
        '<a href="/static/justificantes/' + uid + '/' + f[0]  + '">' + f[0] + 
        '</a></td><td>' + f[1] + '</td><td>' + 
        '<i class="fa fa-trash text-dark" onclick="deleteJustificanteForUser(\'' + 
        uid + '\', \'' + f[0] + '\')"></i></td>';
      tab.appendChild(tr);
    }
  }

function getJustificantesForUser(userid) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        var data = (req.status < 300 ? JSON.parse(req.responseText) : { 'justificantes': [] });
        fillJustificantes(userid, data);
    };
    req.open('GET', '/v1/justificantes/' + userid, true);
    req.send();
}

function postJustificantesForUser(userid, form) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status < 300)
            fillJustificantes(userid, JSON.parse(req.responseText));
    };
    var formData = new FormData(form);
    req.open('POST', '/v1/justificantes/' + userid, true);
    req.send(formData);
    return false;
}

function deleteJustificanteForUser(userid, filename) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status < 300)
            fillJustificantes(userid, JSON.parse(req.responseText));
    };
    var formData = new FormData();
    formData.append("justificante", filename);
    req.open('DELETE', '/v1/justificantes/' + userid, true);
    req.send(formData);
}
