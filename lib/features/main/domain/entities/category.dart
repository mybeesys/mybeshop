import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final int productsCount;
  final List<Product> products;

  const Category(
      {required this.id,
      required this.name,
      required this.productsCount,
      required this.products});

  @override
  List<Object?> get props => [id, name, productsCount, products];
}
