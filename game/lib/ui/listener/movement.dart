import 'dart:convert';
import 'dart:io';

import 'package:game/game.dart';
import 'package:game/packages/package.dart';
import 'package:game/packages/player/player_moved.dart';
import 'package:game/ui/listener/key_stroke.dart';
import 'package:game/ui/player.dart';
import 'package:game/utils/extensions/package.dart';
import 'package:game/utils/extensions/socket.dart';

class MoveDown extends KeyStroke {
  @override
  void function() {
    var player = players.players[gameSocket.socket.getName()]!;
    if (player.position.y < stdout.terminalLines) {
      var coord = Coord(player.position.x, player.position.y + 1);
      Package("PlayerMove", gameSocket.socket.getName(),
              jsonEncode(PlayerMovePackage(coord)))
          .send(gameSocket.socket);
    }
  }
}

class MoveUp extends KeyStroke {
  @override
  void function() {
    var player = players.players[gameSocket.socket.getName()]!;
    if (player.position.y > 0) {
      var coord = Coord(player.position.x, player.position.y - 1);
      Package("PlayerMove", gameSocket.socket.getName(),
              jsonEncode(PlayerMovePackage(coord)))
          .send(gameSocket.socket);
    }
  }
}

class MoveRight extends KeyStroke {
  @override
  void function() {
    var player = players.players[gameSocket.socket.getName()]!;
    if (player.position.x < stdout.terminalColumns) {
      var coord = Coord(player.position.x + 1, player.position.y);
      Package("PlayerMove", gameSocket.socket.getName(),
              jsonEncode(PlayerMovePackage(coord)))
          .send(gameSocket.socket);
    }
  }
}
class MoveLeft extends KeyStroke {
  @override
  void function() {
    var player = players.players[gameSocket.socket.getName()]!;
    if (player.position.x > 0) {
      var coord = Coord(player.position.x - 1, player.position.y);
      Package("PlayerMove", gameSocket.socket.getName(),
              jsonEncode(PlayerMovePackage(coord)))
          .send(gameSocket.socket);
    }
  }
}