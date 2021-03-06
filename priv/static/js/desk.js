$(document).ready(function() {
  var params = {"type": "agent", "name": "5" };
  var topics = ["lobby", "elixir"];

  var socket = new Phoenix.Socket("/ws");
  socket.connect();

  for (i = 0; i < topics.length; i++) { 
    joinRoom(socket, topics[i], params);
  }

  function joinRoom(socket, roomId, params) {
    var chan = socket.chan("rooms:" + roomId, params);
    chan.join();

    chan.on("chat_ended", function(id) {
      $('#' + id).remove();
    });

    chan.on("user_entered", function(msg) {
      userEntered(roomId, msg);
    });

    chan.on("chat_taken", function(msg) {
      chatTaken(msg);
    });

    chan.on("chat_ended", function(chat) {
      alert(1);
      chatEnded(chat);
    });
  }

  function chatEnded(chat){
    $('#' + chat.id).remove();
  }

  function chatTaken(msg) {
    var id = msg.chat.id;
    var status = msg.chat.status;
    $('#' + id).find('a').attr('disabled', 'disabled')
    $('#' + id).find("td").eq(2).html(status);
  }

  function userEntered(topic, msg) {
    var client = msg.client_name;
    var status = msg.status;
    var id = msg.id;

    var table = document.getElementById(topic);
    var row = table.insertRow(-1);
    row.setAttribute("id", id);

    var id_cell = row.insertCell(0);
    var client_cell = row.insertCell(1);
    var status_cell = row.insertCell(2);
    var start_cell = row.insertCell(3);

    id_cell.innerHTML = id;
    client_cell.innerHTML = client;
    status_cell.innerHTML = status;
    start_cell.innerHTML = "<a class='btn btn-primary btn-xs' target='_blank' href='/chat/" + id + "'>Start</a>";

  }
});
