import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/invoice.dart';

class EInvoice extends Equatable {
  final String termsAndConditions;
  final Invoice invoice;

  const EInvoice({required this.termsAndConditions, required this.invoice});
  @override
  List<Object?> get props => [termsAndConditions, invoice];
}
