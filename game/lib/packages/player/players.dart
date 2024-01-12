import 'package:game/ui/player.dart';
import 'package:json_annotation/json_annotation.dart';

part 'players.g.dart';

@JsonSerializable()
class PlayerPackage {
  int colorIndex;
  Coord position;
  String name;

  PlayerPackage(this.colorIndex, this.position, this.name);

  Map toJson() => _$PlayerPackageToJson(this);
  factory PlayerPackage.fromJson(Map<String, dynamic> json) =>
      _$PlayerPackageFromJson(json);
}

@JsonSerializable()
class PlayersPackage {
  late List<PlayerPackage> players;

  PlayersPackage(this.players);

  PlayersPackage.fromPlayers(Players playersInfo) {
    players = playersInfo.players
        .map((key, value) {
          return MapEntry(
              key, PlayerPackage(value.colorIndex, value.position, key));
        })
        .values
        .toList();
  }

  Map toJson() => _$PlayersPackageToJson(this);
  factory PlayersPackage.fromJson(Map<String, dynamic> json) =>
      _$PlayersPackageFromJson(json);
}
