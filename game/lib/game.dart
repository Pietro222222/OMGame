import 'dart:io';

class GameSocket {
  late Socket socket;
  GameSocket();

  Future<void> connect(List<String> arguments) async {
    var server = "127.0.0.1";
    var port = 8080;
    if (arguments.isNotEmpty) {
      server = arguments[0];
      if (arguments.length > 1) {
        port = int.parse(arguments[1]);
      }
    }
    try {
      socket = await Socket.connect(server, port);
    } catch (_) {
      print("invalid address");
      exit(1);
    }
  }
}

GameSocket gameSocket = GameSocket();
