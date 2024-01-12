import 'dart:io';

class GameSocket {
  late Socket socket;
  GameSocket();

  Future<void> connect() async {
    socket = await Socket.connect("127.0.0.1", 8080);
  }
}

GameSocket gameSocket = GameSocket();
