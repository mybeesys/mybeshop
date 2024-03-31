import 'package:mybeshop/features/main/domain/entities/invoice_item.dart';

class InvoiceItemModel extends InvoiceItem {
  const InvoiceItemModel({
    required super.id,
    required super.name,
    required super.qty,
    required super.tax,
    required super.discount,
    required super.price,
    required super.subTotal,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
        id: json["id"],
        name: json["name"],
        qty: int.parse(json["qty"].toString()),
        tax: json["tax"],
        discount: json["discount"],
        price: json["price"],
        subTotal: json["subTotal"]);
  }
}
