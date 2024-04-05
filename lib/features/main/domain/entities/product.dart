// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/domain/entities/variant_option.dart';

class Product extends Equatable {
  final int id;
  final String? type;
  final String? image;
  final String name;
  final String sku;
  final String? categoryId;
  final String? description;
  final int? calories;
  final String currency;
  final double? tax;
  final bool? hasDiscount;
  final int? discountPercent;
  final String? originalPrice;
  final String? price;
  final int? qty;
  final bool? inStock;
  final bool? outOfStock;
  bool? inCart;
  final List<String> images;

  final List<VariantOption> variantsOptions;
  final List<ProductExtra> extras;

  Product({
    required this.id,
    required this.type,
    required this.image,
    required this.name,
    required this.sku,
    required this.categoryId,
    this.description,
    this.calories,
    required this.currency,
    required this.tax,
    this.hasDiscount,
    this.discountPercent,
    this.originalPrice,
    this.price,
    this.qty,
    this.inStock,
    this.outOfStock,
    this.inCart,
    required this.images,
    required this.variantsOptions,
    required this.extras,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        image,
        name,
        sku,
        categoryId,
        description,
        calories,
        currency,
        tax,
        hasDiscount,
        discountPercent,
        originalPrice,
        price,
        qty,
        inStock,
        outOfStock,
        inCart,
        images,
        variantsOptions,
        extras,
      ];
}
