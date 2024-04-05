import 'package:mybeshop/features/main/domain/entities/supplier.dart';

class SupplierModel extends Supplier {
  const SupplierModel({
    required super.id,
    required super.name,
    required super.phone,
    super.address,
    super.company,
    super.email,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
    required super.canDelete,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        company: json["company"],
        email: json["email"],
        notes: json["notes"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        canDelete: json["canDelete"]);
  }
}
