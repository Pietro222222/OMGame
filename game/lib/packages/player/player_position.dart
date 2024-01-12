import 'package:game/ui/player.dart';
import 'package:json_annotation/json_annotation.dart';

part "player_position.g.dart";

@JsonSerializable()
class PlayerPositionPackage {
  Coord coord;
  PlayerPositionPackage(this.coord);
  Map toJson() => _$PlayerPositionPackageToJson(this);
  factory PlayerPositionPackage.fromJson(Map<String, dynamic> json) =>
      _$PlayerPositionPackageFromJson(json);
}
