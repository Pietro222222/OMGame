import 'dart:io';
import 'dart:typed_data';

int packagesBroadcasted = 0;
List<Socket> clients = [];

Future<void> main(List<String> arguments) async {
  var server = "127.0.0.1";
  var port = 8080;
  if (arguments.isNotEmpty) {
    server = arguments[0];
    if (arguments.length > 1) {
      port = int.parse(arguments[1]);
    }
  }
  ServerSocket socket;
  try {
    socket = await ServerSocket.bind(server, port);
  } catch (_) {
    print("invalid address");
    exit(1);
  }
  socket.listen((event) {
    handleConnection(event);
  });
}

void broadCast(Object data) {
  for (var client in clients) {
    client.writeln(data);
    packagesBroadcasted++;
  }
}

void handleConnection(Socket client) {
  var clientName = '${client.remoteAddress.address}:${client.remotePort}';
  print("Received connection $clientName");
  clients.add(client);

  client.listen(
    (Uint8List data) async {
      broadCast(String.fromCharCodes(data));
      stdout.write("\rPackages Broadcasted: $packagesBroadcasted");
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
