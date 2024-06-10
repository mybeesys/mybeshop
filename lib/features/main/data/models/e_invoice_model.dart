import 'package:mybeshop/features/global/data/models/store_info_model.dart';
import 'package:mybeshop/features/main/data/models/invoice_model.dart';
import 'package:mybeshop/features/main/domain/entities/e_invoice.dart';

class EInvoiceModel extends EInvoice {
  const EInvoiceModel({
    required super.storeInfo,
    required super.termsAndConditions,
    required super.invoice,
  });
  factory EInvoiceModel.fromJson(Map<String, dynamic> json) {
    return EInvoiceModel(
        storeInfo: json["store"] != null
            ? StoreInfoModel.fromJson(json["store"])
            : null,
        termsAndConditions: json["termsAndConditions"],
        invoice: InvoiceModel.fromJson(json["invoice"]));
  }
}
