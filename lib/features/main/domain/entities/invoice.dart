import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/additional_cost.dart';
import 'package:mybeshop/features/main/domain/entities/customer.dart';
import 'package:mybeshop/features/main/domain/entities/invoice_item.dart';

class Invoice extends Equatable {
  final int id;
  final String no;
  final String status;
  final String paymentMethod;
  final String? transactionRef;
  final String date;
  final Customer customer;
  final String tax;
  final String discount;
  final List<AdditionalCost> additionalCosts;
  final String total;
  final String totalAfterDiscount;
  final String totalAfterTaxes;
  final String totalWrittenAr;
  final String totalWrittenEn;
  final List<InvoiceItem> items;

  const Invoice({
    required this.id,
    required this.no,
    required this.status,
    required this.paymentMethod,
    this.transactionRef,
    required this.date,
    required this.customer,
    required this.tax,
    required this.discount,
    required this.additionalCosts,
    required this.total,
    required this.totalAfterDiscount,
    required this.totalAfterTaxes,
    required this.totalWrittenAr,
    required this.totalWrittenEn,
    required this.items,
  });
  @override
  List<Object?> get props => [
        id,
        no,
        status,
        paymentMethod,
        transactionRef,
        date,
        customer,
        tax,
        discount,
        additionalCosts,
        total,
        totalAfterDiscount,
        totalAfterTaxes,
        totalWrittenAr,
        totalWrittenEn,
        items,
      ];
}
