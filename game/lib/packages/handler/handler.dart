import 'dart:convert';
import 'dart:io';

import 'package:game/game.dart';
import 'package:game/packages/join.dart';
import 'package:game/packages/package.dart';
import 'package:game/packages/player/player_moved.dart';
import 'package:game/packages/player/player_position.dart';
import 'package:game/packages/player/players.dart';
import 'package:game/ui/game_ui.dart';
import 'package:game/ui/player.dart';
import 'package:game/utils/extensions/package.dart';
import 'package:game/utils/extensions/socket.dart';

void packageHandler(Package package, Socket socket) {
  switch (package.packageName) {
    case "Joined":
      JoinedPackage pkg =
          JoinedPackage.fromJson(jsonDecode(package.packageInformation));

      players.handlePackage(pkg, package.packageSender);

      if (package.packageSender != socket.getName()) {
        var playersInfo = PlayersPackage.fromPlayers(players);
        var package =
            Package("Players", socket.getName(), jsonEncode(playersInfo));
        package.send(socket);
      }
    case "Players":
      PlayersPackage pkg =
          PlayersPackage.fromJson(jsonDecode(package.packageInformation));
      for (var playerPackage in pkg.players) {
        players.players.putIfAbsent(playerPackage.name,
            () => Player(playerPackage.colorIndex, playerPackage.position));
      }
    case "PlayerMove":
      var name = gameSocket.socket.getName();

      PlayerMovePackage pkg =
          PlayerMovePackage.fromJson(jsonDecode(package.packageInformation));
      var player = players.players[package.packageSender];
      if (player != null) {
        game.playerMoved(player, pkg.coord);
      }
      Package(
              "PlayerPosition",
              name,
              jsonEncode(
                  PlayerPositionPackage(players.players[name]!.position)))
          .send(gameSocket.socket);

    case "PlayerPosition":
      // if (package.packageSender == gameSocket.socket.getName()) {
      //   return;
      // }
      PlayerPositionPackage pkg = PlayerPositionPackage.fromJson(
          jsonDecode(package.packageInformation));

      if (players.players[package.packageSender] != null) {
        var player = players.players[package.packageSender]!;
        game.clearPlayer(player);
        player.position = pkg.coord;
        game.drawPlayer(player);
      }
  }
}
