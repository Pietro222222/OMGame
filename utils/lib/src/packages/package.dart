import 'package:json_annotation/json_annotation.dart';

abstract class PackageInfo {
  Map toJson();
  factory PackageInfo.fromJson(Map<String, dynamic> json);
}

@JsonSerializable()
class Package {
  String packageName;
  String packageSender;

  PackageInfo packageInformation;

  Package(this.packageName, this.packageSender, this.packageInformation);

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
