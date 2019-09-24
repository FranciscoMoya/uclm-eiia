// Copyright (C) 2017 by Francisco Moya <francisco.moya@uclm.es>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// Usage:
//
// 1. Insert <script> tags in the task description:
//    <script src="https://www.promisejs.org/polyfills/promise-7.0.4.min.js"></script>
//    <script src="https://cdn.jsdelivr.net/gh/skulpt/skulpt-dist@0.11.0/skulpt.min.js"></script>
//    <script src="https://cdn.jsdelivr.net/gh/skulpt/skulpt-dist@0.11.0/skulpt-stdlib.js"></script>
//    <script src="https://cdn.jsdelivr.net/gh/FranciscoMoya/informatica-doc@master/_static/py-moodle.js"></script>
//
// 2. Define a container (pre, div) with id unittest containing the TestCase.
//    either class Test(TestCase) or class Test(TestCaseGui).
//
// 3. Optionally define a container (em, span, div) with id minpass
//    containing the minimum number of tests (asserts) required to
//    submit.

// Note: minpass has a different meaning when using TestCase (number
// of test_ methods successfully executed) or TestCaseGui (number of
// asserts successfully passed). This is an issue related to Skulpt
// unittest.gui

var code_separator = "\n# === === === # \n";

function installPythonFacade() {
    var editor = setupTextArea('id_onlinetext_editor');
    if (!editor)
	return;
    var format = document.getElementsByName('onlinetext_editor[format]');
    if (format)
        format[0].value = '2'; // text plain
    appendOutputArea(editor);
    replaceFormSubmission('mform1', editor);
}

function setupTextArea(id) {
    var editor = document.getElementById(id);
    if (!editor)
	return null;
    var newId = '_' + id;
    editor.setAttribute('id', newId); // prevent rich-text install
    editor.style.display = 'block';
    editor.style.fontFamily = 'monospace';
    editor.value = getUserCode(editor);
    return editor;
}

function appendOutputArea(editor) {
    var output = document.createElement('div');
    output.innerHTML= '<div id="status"></div><div id="canvas"></div>' 
	+ '<div id="test"><pre id="output"></pre></div>';
    editor.parentNode.insertBefore(output, editor.nextSibling);
}

function replaceFormSubmission(id, editor) {
    var form = document.getElementById(id);
    if (form.addEventListener)
	form.addEventListener("submit", testAndSubmitPythonProgram(editor, form), false);
    else if (form.attachEvent)
	form.attachEvent("onsubmit", testAndSubmitPythonProgram(editor, form));
}

function testAndSubmitPythonProgram (editor, form) {
    return function (e) {
	e.preventDefault();
	stdOut();
	statusOut();
	Sk.configure({
	    output: stdOut,
	    read: builtinRead,
        inputfunTakesPrompt: true,
        __future__: Sk.python3,
	});
	(Sk.TurtleGraphics || (Sk.TurtleGraphics = {})).target = 'canvas';
	Sk.canvas = 'canvas';
	Sk.divid = 'test';
	testPythonProgram(buildProg(editor)).then(
	    function success(summary) {
		updateSubmittedText(editor, summary);
		form.submit();
	    }, statusOut);
    };
}

function testPythonProgram(prog) {
    var testFail = 'Corrije los errores que se muestran abajo antes de enviar.'
    return new Promise(function (resolve, reject) {
	Sk.misceval.asyncToPromise(function () {
	    return Sk.importMainWithBody("<stdin>", false, prog, true);
	}).then(function (module) {
	    var test = module.tp$getattr('test__');
	    Sk.misceval.callsimAsync(null, test).then(
		function (r) {
		    var ret = Sk.ffi.remapToJs(r);
		    var results = document.getElementById('test_unit_results');
		    if (results)
			results.style.display = 'none';
		    if (ret[0] < minPassed()) reject(testFail);
		    else resolve(ret);
		},
		reject);
	}, reject);
    });
}

function builtinRead(x) {
    if (Sk.builtinFiles === undefined || Sk.builtinFiles["files"][x] === undefined) {
	var div = document.getElementById(x);
	if (div) return div.textContent;
	throw "File not found: '" + x + "'";
    }
    return Sk.builtinFiles["files"][x];
}

function stdOut(text) {
    var output = document.getElementById('output');
    if (text)
	output.innerHTML += sanitize(text);
    else
	output.innerHTML = '';
}

function statusOut(text) {
    var status = document.getElementById('status');
    if (text)
	status.innerHTML += '<p>' + sanitize(text) + '</p>';
    else
	status.innerHTML = '';
}

function buildProg(editor) {
    var prog = getUserCode(editor) + unittest(document.getElementById('unittest'));
    return unsanitize(prog);
}

function unittest(elem) {
    if (!elem)
	return '\ndef test__():\n return [1,1]';
    return '\nfor n in ["Test","unittest","TestCase","TestCaseGui"]:' +
        '\n if n in globals():' +
        '\n  raise ImportError("No incluyas pruebas ({})".format(n))' +
        '\nfrom unittest import TestCase\n' + 
        elem.innerHTML +
        '\ndef test__():\n' +
        ' t=Test()\n t.main()\n' +
        ' return [t.numPassed, t.numFailed]'; 
}

function unsanitize(text) {
    return text
	.replace(new RegExp('&amp;', 'g'), '&')
	.replace(new RegExp('&lt;', 'g'), '<')
	.replace(new RegExp('&gt;', 'g'), '>');
}

function sanitize(text) {
    if (typeof text === 'string')
	return text
	    .replace(new RegExp('<', 'g'), '&lt;')
	    .replace(new RegExp('&', 'g'), '&amp;');
    return text;
}

function getUserCode(editor) {
    var sec = editor.value.split(code_separator);
    var prog =  sec.length > 1? sec[1]: sec[0]; 
    return unsanitize(prog);
}

function updateSubmittedText(editor, sum) {
    var prog = getUserCode(editor);
    var out = document.getElementById('output').innerHTML;
    var header = "#py3 " + sum[0].toString() + " passed / " + sum[1].toString() + " failed\n";
    var doc = header + code_separator + prog + code_separator + out;
    editor.value = doc;
}


function minPassed() {
    var f = document.getElementById('minpass');
    if (!f) return 0;
    return parseInt(f.innerHTML, 10);
}

// https://raw.githubusercontent.com/jfriend00/docReady/master/docready.js
(function(funcName, baseObj) {
    "use strict";
    funcName = funcName || "docReady";
    baseObj = baseObj || window;
    var readyList = [];
    var readyFired = false;
    var readyEventHandlersInstalled = false;
    
    function ready() {
        if (!readyFired) {
            readyFired = true;
            for (var i = 0; i < readyList.length; i++) {
                readyList[i].fn.call(window, readyList[i].ctx);
            }
            readyList = [];
        }
    }
    
    function readyStateChange() {
        if ( document.readyState === "complete" ) {
            ready();
        }
    }
    
    baseObj[funcName] = function(callback, context) {
        if (readyFired) {
            setTimeout(function() {callback(context);}, 1);
            return;
        } else {
            readyList.push({fn: callback, ctx: context});
        }
        if (document.readyState === "complete" || (!document.attachEvent && document.readyState === "interactive")) {
            setTimeout(ready, 1);
        } else if (!readyEventHandlersInstalled) {
            if (document.addEventListener) {
                document.addEventListener("DOMContentLoaded", ready, false);
                window.addEventListener("load", ready, false);
            } else {
                document.attachEvent("onreadystatechange", readyStateChange);
                window.attachEvent("onload", ready);
            }
            readyEventHandlersInstalled = true;
        }
    }
})("docReady", window);

docReady(installPythonFacade);

