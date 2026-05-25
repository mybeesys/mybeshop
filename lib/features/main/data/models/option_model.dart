import 'package:mybeshop/features/main/domain/entities/option.dart';

class OptionModel extends Option {
  const OptionModel(
      {required super.id,
      required super.name,
      required super.variantOptionName});
  factory OptionModel.fromJson(Map<String, dynamic> json, {opName}) {
    return OptionModel(
      id: json["id"],
      name: json["name"],
      variantOptionName: opName,
    );
  }
}
