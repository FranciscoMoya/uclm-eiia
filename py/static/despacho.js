SERVICE_ENDPOINT = "/v1/despachos/";
var args = getUrlVars();
var dirty = true;

function pending(v) {
    dirty = v;
    const img = document.querySelector("#pending");
    img.style.display = (dirty ? "block": "none");
}


function getDespachoForCurrentUser() {
    var userid = args['userid'];
    return getDespachoForUser(userid);
}

function getDespachoForUser(userid) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 400) return;
        var resp = JSON.parse(req.responseText);
        const input = document.querySelector("#despacho");
        input.onchange = function(){pending(true);};
        input.value = resp;
        pending(false);
    };
    req.open('GET', SERVICE_ENDPOINT + userid, true);
    req.send();
}

function updateDespachoForCurrentUser() {
    var userid = args['userid'];
    return updateDespachoForUser(userid)();
}

function updateDespachoForUser(userid) {
    return function() {
        if (dirty) setDespachoForUser(userid);
    }
}

function setDespachoForUser(userid) {
    var req = new XMLHttpRequest();
    req.open('PUT', SERVICE_ENDPOINT + userid, true);
    req.setRequestHeader("Content-Type", "application/json");
    req.onload  = function() {
        pending(false);
    };
    const input = document.querySelector("#despacho");
    req.send(JSON.stringify({ "despacho": input.value }));
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}
