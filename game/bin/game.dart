import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_console2/dart_console2.dart';
import 'package:game/game.dart';
import 'package:game/packages/handler/handler.dart';
import 'package:game/packages/join.dart';
import 'package:game/packages/package.dart';
import 'package:game/ui/game_ui.dart';

Future<void> main(List<String> arguments) async {
  await gameSocket.connect(arguments);
  var socket = gameSocket.socket;

  var json = jsonEncode(Package(
      'Joined',
      '${socket.address.address}:${socket.port}',
      Package.getInformationFrom(
          JoinedPackage(Random().nextInt(ConsoleColor.values.length - 1)))));

  socket.write(json);

  Game game = Game();
  game.initGame();

  socket.listen(
    (Uint8List data) async {
      final message = String.fromCharCodes(data);
      var packages = message.split('\n');
      packages.sublist(0, packages.length - 1).forEach((rawPackage) {
        if (rawPackage.length <= 1) {
          return;
        }
        Package package = Package.fromJson(jsonDecode(rawPackage));
        packageHandler(package, socket);
      });
    },
    onError: (error) {
      print(error);
      socket.close();
    },

    // handle the client closing the connection
    onDone: () {
      print('Server disconnected');
      game.exitGame();
      socket.close();
      exit(1);
    },
  );

  ReceivePort receivePort = ReceivePort();

  // Spawn a new isolate
  await Isolate.spawn(isolateFunction, receivePort.sendPort);

  // Listen for messages from the isolate
  receivePort.listen((message) {
    game.listen(message);
  });
}

void isolateFunction(SendPort sendport) {
  while (true) {
    sendport.send(stdin.readByteSync());
  }
}
