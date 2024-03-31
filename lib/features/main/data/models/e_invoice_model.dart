import 'package:mybeshop/features/main/data/models/invoice_model.dart';
import 'package:mybeshop/features/main/domain/entities/e_invoice.dart';

class EInvoiceModel extends EInvoice {
  const EInvoiceModel({
    required super.termsAndConditions,
    required super.invoice,
  });
  factory EInvoiceModel.fromJson(Map<String, dynamic> json) {
    return EInvoiceModel(
        termsAndConditions: json["termsAndConditions"],
        invoice: InvoiceModel.fromJson(json["invoice"]));
  }
}
