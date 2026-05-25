import 'package:mybeshop/features/main/domain/entities/state.dart';

class StateModel extends State {
  const StateModel(
      {required super.id, required super.name, required super.countryId});
  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        id: json["id"],
        name: json["name"],
        countryId: int.parse(json["countryId"].toString()));
  }
}
