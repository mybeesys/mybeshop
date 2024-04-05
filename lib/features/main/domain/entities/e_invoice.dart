import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/main/domain/entities/invoice.dart';

class EInvoice extends Equatable {
  final StoreInfo? storeInfo;
  final String termsAndConditions;
  final Invoice invoice;

  const EInvoice({
    required this.storeInfo,
    required this.termsAndConditions,
    required this.invoice,
  });
  @override
  List<Object?> get props => [termsAndConditions, invoice];
}
