import 'dart:io';

import 'package:dart_console2/dart_console2.dart';
import 'package:game/packages/join.dart';
import 'package:game/ui/console.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Coord {
  int x, y;
  Coord(this.x, this.y);

  Map toJson() => _$CoordToJson(this);
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

class Player {
  //ConsoleColors.values[index];
  int colorIndex;
  Coord position;

  Player(this.colorIndex, this.position);

  void draw() {
    console.cursorPosition = Coordinate(position.y, position.x);
    console.setForegroundColor(ConsoleColor.values[colorIndex]);
    stdout.write(' ');
    console.resetColorAttributes();
  }
}

class Players {
  Map<String, Player> players;

  Players(this.players);

  void handlePackage(JoinedPackage package, String sender) {
    players.putIfAbsent(sender, () => Player(package.colorIndex, Coord(0, 0)));
  }

  void drawPlayers() {
    players.forEach((_, value) => value.draw());
  }
}

Players players = Players({});
