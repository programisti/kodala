$( document ).ready(function() {
    
  var $desk = $("#desk tbody");
  
  var socket = new Phoenix.Socket("/ws");
  socket.connect();

  var params = {"type": "agent", "name": "5"};
  var lobby = socket.chan("rooms:lobby", params);
  lobby.join(); 
  
  lobby.on("user_entered", function(msg) {
    userEntered(msg);
  });

  lobby.on("chat_taken", function(msg) {
    console.log("chat_taken ")
    chatTaken(msg);
  });

  lobby.on("chat_ended", function(id) {
    $('#room' + id).remove();
  });

  function chatTaken(msg){
    var id = msg.chat.id;
    var status = msg.chat.status;  
    $('#'+id).find('a').attr('disabled','disabled')
    $('#'+id).find("td").eq(2).html(status);
  }

  function userEntered(msg){
    var client = msg.client_name;
    var status = msg.status;
    var id = msg.id;

    var table = document.getElementById('desk');
    var row = table.insertRow(-1);
    row.setAttribute("id", id);

    var id_cell = row.insertCell(0);
    var client_cell = row.insertCell(1);
    var status_cell = row.insertCell(2);
    var start_cell = row.insertCell(3);

    id_cell.innerHTML = id; 
    client_cell.innerHTML = client;
    status_cell.innerHTML = status;
    start_cell.innerHTML = "<a class='btn btn-primary btn-xs' target='_blank' href='/chat/"+ id +"'>Start</a>";

  }
});
