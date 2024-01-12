// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerPackage _$PlayerPackageFromJson(Map<String, dynamic> json) =>
    PlayerPackage(
      json['colorIndex'] as int,
      Coord.fromJson(json['position'] as Map<String, dynamic>),
      json['name'] as String,
    );

Map<String, dynamic> _$PlayerPackageToJson(PlayerPackage instance) =>
    <String, dynamic>{
      'colorIndex': instance.colorIndex,
      'position': instance.position,
      'name': instance.name,
    };

PlayersPackage _$PlayersPackageFromJson(Map<String, dynamic> json) =>
    PlayersPackage(
      (json['players'] as List<dynamic>)
          .map((e) => PlayerPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayersPackageToJson(PlayersPackage instance) =>
    <String, dynamic>{
      'players': instance.players,
    };
