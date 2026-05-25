import 'package:mybeshop/features/main/domain/entities/area.dart';

class AreaModel extends Area {
  const AreaModel(
      {required super.id, required super.name, required super.cityId});
  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
        id: json["id"],
        name: json["name"],
        cityId: int.parse(json["cityId"].toString()));
  }
}
