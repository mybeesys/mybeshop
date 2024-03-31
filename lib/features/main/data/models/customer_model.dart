import 'package:mybeshop/features/main/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({required super.id, required super.name});
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(id: json["id"], name: json["name"]);
  }
}
