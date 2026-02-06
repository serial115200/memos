/* Live reload: connect to current host so it works with --host 0.0.0.0 (e.g. http://172.16.8.194:8000) */
(function () {
  var ws = new WebSocket('ws://' + window.location.host + '/websocket-reload');
  ws.onmessage = function () { window.location.reload(); };
  ws.onerror = function () {}; /* no server: static build, ignore */
})();
