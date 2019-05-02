SERVICE_ENDPOINT = "/v2/profesores.tutorias/por_userid/";
var args = getUrlVars();
var dirty = true;

function pending(v) {
    dirty = v;
    const img = document.querySelector("#pending");
    img.style.display = (dirty ? "block": "none");
}


function getTutoriaForCurrentUser() {
    var userid = args['userid'];
    return getTutoriaForUser(userid);
}

function getTutoriaForUser(userid) {
    var req = new XMLHttpRequest();
    req.onload  = function() {
        if (req.status >= 400) return;
        var resp = JSON.parse(req.responseText)[0];
        const input = document.querySelector("#tutoria");
        input.onkeyup = function(){ pending(true); };
        input.value = resp.tutoria;
        pending(false);
    };
    req.open('GET', SERVICE_ENDPOINT + userid, true);
    try { req.send(); }
    catch(ex) { pending(false); }
}

function updateTutoriaForUser(userid) {
    return function() {
        if (dirty) setTutoriaForUser(userid);
    }
}

function setTutoriaForUser(userid) {
    var req = new XMLHttpRequest();
    req.open('PUT', SERVICE_ENDPOINT, true);
    req.setRequestHeader("Content-Type", "application/json");
    req.onload  = function() { 
        if (req.status >= 300)
            showError(req.responseText);
        pending(false); 
    };
    const input = document.querySelector("#tutoria");
    req.send(JSON.stringify({ "userid": userid, "tutoria": input.value }));
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

function showError(msg) {
    obj = JSON.parse(msg);
    var err = document.querySelector("#errors");
    if (err)
        err.innerHTML = obj ? obj.message : msg;
}
