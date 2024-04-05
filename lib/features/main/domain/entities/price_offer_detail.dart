import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/customer.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer_additional_cost.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer_product.dart';
import 'package:mybeshop/features/main/domain/entities/price_offet_service.dart';

class PriceOfferDetail extends Equatable {
  final int id;
  final String no;
  final String date;
  final String total;
  final String discount;
  final String totalAfterDiscount;
  final String tax;
  final String totalWithTax;
  final Customer customer;
  final List<PriceOfferProduct> products;
  final List<PriceOfferService> services;
  final List<PriceOfferAdditionalCost> additionalCosts;

  const PriceOfferDetail({
    required this.id,
    required this.no,
    required this.date,
    required this.total,
    required this.discount,
    required this.totalAfterDiscount,
    required this.tax,
    required this.totalWithTax,
    required this.customer,
    required this.products,
    required this.services,
    required this.additionalCosts,
  });

  @override
  List<Object?> get props => [
        id,
        no,
        date,
        total,
        discount,
        totalAfterDiscount,
        tax,
        totalWithTax,
        customer,
        products,
        services,
        additionalCosts,
      ];
}
