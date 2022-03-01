import 'dart:convert';

abstract class BaseServiceModel {
  fromJson(String str) => fromMap(json.decode(str));
  fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap();
  String toJson() => json.encode(toMap());
}
