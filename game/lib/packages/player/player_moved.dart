import 'package:game/ui/player.dart';
import 'package:json_annotation/json_annotation.dart';

part "player_moved.g.dart";

@JsonSerializable()
class PlayerMovePackage {
  Coord coord;
  PlayerMovePackage(this.coord);

  Map toJson() => _$PlayerMovePackageToJson(this);
  factory PlayerMovePackage.fromJson(Map<String, dynamic> json) =>
      _$PlayerMovePackageFromJson(json);
}
