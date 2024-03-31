import 'package:mybeshop/features/main/data/models/addtional_cost_model.dart';
import 'package:mybeshop/features/main/data/models/customer_model.dart';
import 'package:mybeshop/features/main/data/models/invoice_item_model.dart';
import 'package:mybeshop/features/main/domain/entities/invoice.dart';

class InvoiceModel extends Invoice {
  const InvoiceModel({
    required super.id,
    required super.no,
    required super.status,
    required super.paymentMethod,
    super.transactionRef,
    required super.date,
    required super.customer,
    required super.tax,
    required super.discount,
    required super.additionalCosts,
    required super.total,
    required super.totalAfterDiscount,
    required super.totalAfterTaxes,
    required super.totalWrittenAr,
    required super.totalWrittenEn,
    required super.items,
  });
  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
        id: json["id"],
        no: json["no"],
        status: json["status"],
        paymentMethod: json["paymentMethod"],
        transactionRef: json["transactionRef"],
        date: json["date"],
        customer: CustomerModel.fromJson(json["customer"]),
        tax: json["tax"],
        discount: json["discount"],
        additionalCosts: List.from(json["additionalCosts"])
            .map((additonal) => AdditionalCostModel.fromJson(additonal))
            .toList(),
        total: json["total"],
        totalAfterDiscount: json["TotalAfterDiscount"],
        totalAfterTaxes: json["TotalAfterTaxes"],
        totalWrittenAr: json["TotalWrittenAr"],
        totalWrittenEn: json["TotalWrittenEn"],
        items: List.from(json["items"])
            .map((item) => InvoiceItemModel.fromJson(item))
            .toList());
  }
}
