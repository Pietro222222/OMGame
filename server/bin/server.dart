import 'dart:io';
import 'dart:typed_data';

List<Socket> clients = [];

Future<void> main(List<String> arguments) async {
  var socket = await ServerSocket.bind("127.0.0.1", 8080);
  socket.listen((event) {
    handleConnection(event);
  });
}

void broadCast(Object data) {
  for (var client in clients) {
    client.writeln(data);
  }
}

void handleConnection(Socket client) {
  var clientName = '${client.remoteAddress.address}:${client.remotePort}';
  print("Received connection $clientName");
  clients.add(client);

  client.listen(
    (Uint8List data) async {
      broadCast(String.fromCharCodes(data));
    },
    onError: (error) {
      print(error);
      clients.removeWhere((element) => element == client);
      client.close();
    },

    // handle the client closing the connection
    onDone: () {
      print('Client left');
      clients.removeWhere((element) => element == client);
      client.close();
    },
  );
}
