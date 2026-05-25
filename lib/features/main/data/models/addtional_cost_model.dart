import 'package:mybeshop/features/main/domain/entities/additional_cost.dart';

class AdditionalCostModel extends AdditionalCost {
  const AdditionalCostModel({required super.statement, required super.cost});
  factory AdditionalCostModel.fromJson(Map<String, dynamic> json) {
    return AdditionalCostModel(
        statement: json["statement"], cost: json["cost"]);
  }
}
