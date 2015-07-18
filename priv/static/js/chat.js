$( document ).ready(function() {
  var messages  = $("#messages");
  var input     = $("#message-input");
  
  var socket = new Phoenix.Socket("/ws");
  socket.connect();

  var params = {"type": "agent", "agent": "5"};
  var chan = socket.chan("rooms:lobby", params);
  chan.join(); 
  
  chan.on("new:msg", function(msg) {
    $messages.append(i"<p><a href='#'>["+msg.user+"]</a>&nbsp; "+msg.body+"</p>");
  });

});
