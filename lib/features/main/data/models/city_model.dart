import 'package:mybeshop/features/main/domain/entities/city.dart';

class CityModel extends City {
  const CityModel(
      {required super.id, required super.name, required super.stateId});
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        id: json["id"],
        name: json["name"],
        stateId: int.parse(json["stateId"].toString()));
  }
}
