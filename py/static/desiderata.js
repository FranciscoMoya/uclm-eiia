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
        var resp = (req.status < 300 ? JSON.parse(req.responseText) : getDefaultDesiderata(table));
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
        dirty = false; // prevent retries if not authorized
    };
    const table = document.querySelector(".timetable");
    const payload = JSON.stringify(getDataFromTable(table));
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
    console.log(tt);
    for (var dia=0; dia<tt.length; ++dia) {
        var row = table.insertRow(-1);
        var th = document.createElement('TH');
        th.innerHTML = tt[dia][0];
        row.appendChild(th);
        for (var i=1; i<tt[dia].length; ++i) {
            var cell = row.insertCell(-1);
            cell.className = value2class(tt[dia][i]);
            cell.onclick = fillWithSelectedColor(cell);
        }
    }
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
    for (var dia=1; dia<tr.length; ++dia) {
        var values = [];
        values[0] = tr[dia].querySelector('th').textContent;
        var td = tr[dia].querySelectorAll('td');
        for (var i=0; i < td.length; ++i) {
            values[i+1] = class2value(td[i].className);
        }
        tt[dia-1] = values;
    }
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
