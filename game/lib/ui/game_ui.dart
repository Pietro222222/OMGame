import 'dart:io';

import 'package:dart_console2/dart_console2.dart';
import 'package:game/ui/console.dart';
import 'package:game/ui/listener/listener.dart';
import 'package:game/ui/player.dart';

class Game {
  Game();

  void clearPlayer(Player player) {
    console.cursorPosition = Coordinate(player.position.y, player.position.x);
    console.resetColorAttributes();
    stdout.write(' ');
  }

  void drawPlayer(Player player) {
    console.cursorPosition = Coordinate(player.position.y, player.position.x);
    console.setForegroundColor(ConsoleColor.values[player.colorIndex]);
    stdout.write('@');
    console.resetColorAttributes();
  }

  void drawPlayers() {
    players.players.forEach((key, value) {
      drawPlayer(value);
    });
  }

  void clearPlayers() {
    players.players.forEach((key, value) {
      clearPlayer(value);
    });
  }

  void playerMoved(Player player, Coord loc) {
    console.cursorPosition = Coordinate(player.position.y, player.position.x);
    clearPlayers();
    player.position.x = loc.x;
    player.position.y = loc.y;
    drawPlayers();
  }

  void initGame() {
    console.clearScreen();
    console.hideCursor();
    console.rawMode = true;
    drawPlayers();
  }

  void exitGame() {
    console.rawMode = false;
    console.showCursor();
  }

  void listen(int key) {
    if (key == 27) {
      exitGame();
      exit(0);
    }
    if (keys.containsKey(key)) {
      keys[key]!.function();
    }
  }
}

Game game = Game();
