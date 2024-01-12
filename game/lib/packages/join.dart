import 'package:json_annotation/json_annotation.dart';

part "join.g.dart";

@JsonSerializable()
class JoinedPackage {
  int colorIndex;

  JoinedPackage(this.colorIndex);

  Map toJson() => _$JoinedPackageToJson(this);
  factory JoinedPackage.fromJson(Map<String, dynamic> json) =>
      _$JoinedPackageFromJson(json);
}
