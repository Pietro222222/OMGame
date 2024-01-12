import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {
  String packageName;
  String packageSender;

  String packageInformation;

  Package(this.packageName, this.packageSender, this.packageInformation);

  static String getInformationFrom(Object obj) {
    return json.encode(obj);
  }

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
