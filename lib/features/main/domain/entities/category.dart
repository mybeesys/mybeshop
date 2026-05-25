// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final int productsCount;
  List<Product> products;

  Category(
      {required this.id,
      required this.name,
      required this.productsCount,
      required this.products});

  @override
  List<Object?> get props => [id, name, productsCount, products];
}
