// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerPositionPackage _$PlayerPositionPackageFromJson(
        Map<String, dynamic> json) =>
    PlayerPositionPackage(
      Coord.fromJson(json['coord'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerPositionPackageToJson(
        PlayerPositionPackage instance) =>
    <String, dynamic>{
      'coord': instance.coord,
    };
