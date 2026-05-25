import 'package:mybeshop/features/main/data/models/option_model.dart';
import 'package:mybeshop/features/main/domain/entities/variant_option.dart';

class VariantOptionModel extends VariantOption {
  const VariantOptionModel(
      {required super.libraryId,
      required super.libraryName,
      required super.options});

  factory VariantOptionModel.fromJson(Map<String, dynamic> json) {
    return VariantOptionModel(
      libraryId: json["libraryId"],
      libraryName: json["libraryName"],
      options: List.from(json["options"]).map((e) {
        return OptionModel.fromJson(e, opName: json["libraryName"]);
      }).toList(),
    );
  }
}
