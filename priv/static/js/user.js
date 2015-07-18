$(document).ready(function() {

  var messages = $("#messages");
  var messanger = $("#messanger");
  var input = $("#message-input");
  var username = $("#username");
  var startchat = $('#startchat');
  var waiting = $('#waiting');
  var clientname = $('#clientname');
  var intro = $('#intro');

  var socket = new Phoenix.Socket("ws://localhost:4000/ws");
  socket.connect();

  var chan = socket.chan("rooms:lobby", {});

  startchat.click(function() {
    join_lobby();
  });


  function join_lobby() {
    wait_for_agent();

    var params = get_params();
    var lobby = socket.chan("rooms:lobby", params);
    lobby.join();

    lobby.on("chat_created", function(chat) {
      join_chat(chat);
    });
  }

  function join_chat(chat) {

    var chan = socket.chan("chat:" + chat.id, get_params());
    chan.join();
    console.log(chan.state);

    chan.on("agent_entered", function(msg) {
      show_messanger();
      console.log(chan);
    });

    chan.on("new_msg", function(msg) {
      add_message(msg);
    });

    input.keydown(function(e) {
      if (e.keyCode == 13) {
        chan.push("new_msg", {
          user: clientname.val(),
          body: input.val()
        });
        input.val("");
      }
    });
  }

  function wait_for_agent() {
    waiting.css("display", "block");
    intro.css("display", "none");
  }

  function show_messanger() {
    waiting.css("display", "none");
    messanger.css("display", "block");
  }

  function add_message(msg) {
    messages.append('<div class="alert alert-info">' + msg["user"] + ': ' + msg["body"] + '</div></div>');
    scrollTo(0, document.body.scrollHeight);
  }

  function get_info() {
    var resp;
    $.get("http://ipinfo.io", function(response) {
      resp = response;
    }, "jsonp");
    return resp;
  }

  function myIP() {
    if (window.XMLHttpRequest) xmlhttp = new XMLHttpRequest();
    else xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

    xmlhttp.open("GET", "http://api.hostip.info/get_html.php", false);
    xmlhttp.send();

    hostipInfo = xmlhttp.responseText.split("\n");

    for (i = 0; hostipInfo.length >= i; i++) {
      ipAddress = hostipInfo[i].split(":");
      if (ipAddress[0] == "IP") return ipAddress[1];
    }

    return false;
  }

  function get_params() {
    var ip = myIP();
    var params = {
      "type": "client",
      "name": clientname.val(),
      "ip": ip 
    };
    return params;
  }

});
