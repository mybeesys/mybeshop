import 'package:equatable/equatable.dart';

class ProductExtra extends Equatable {
  final int id;
  final String name;
  final bool hasDiscount;
  final String originalPrice;
  final String price;
  final String originalPriceFormatted;
  final String priceFormatted;
  final bool inStock;

  const ProductExtra({
    required this.id,
    required this.name,
    required this.hasDiscount,
    required this.originalPrice,
    required this.price,
    required this.originalPriceFormatted,
    required this.priceFormatted,
    required this.inStock,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        hasDiscount,
        originalPrice,
        price,
        originalPriceFormatted,
        priceFormatted,
        inStock,
      ];
}
