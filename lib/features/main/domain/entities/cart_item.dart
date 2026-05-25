import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';

class CartItem extends Equatable {
  final String uuid;
  final String id;
  final String storeSlug;
  final String? image;
  final String name;
  final String type;
  final int productId;
  final int? productVariantId;
  final int qty;
  final int maxQty;
  final String price;
  final String priceFormatted;
  final String createdAt;
  final List<ProductExtra> extras;

  const CartItem({
    required this.uuid,
    required this.id,
    required this.storeSlug,
    required this.image,
    required this.name,
    required this.type,
    required this.productId,
    required this.productVariantId,
    required this.qty,
    required this.maxQty,
    required this.price,
    required this.priceFormatted,
    required this.createdAt,
    required this.extras,
  });

  @override
  List<Object?> get props => [
        uuid,
        id,
        storeSlug,
        image,
        name,
        type,
        productId,
        productVariantId,
        qty,
        maxQty,
        price,
        priceFormatted,
        createdAt,
        extras,
      ];
}
