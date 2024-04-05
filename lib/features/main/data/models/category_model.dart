// ignore_for_file: must_be_immutable

import 'package:mybeshop/features/main/data/models/product_model.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel(
      {required super.id,
      required super.name,
      required super.productsCount,
      required super.products});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      productsCount: json["productsCount"],
      products: List.from(json["products"])
          .map((p) => ProductModel.fromJson(p))
          .toList(),
    );
  }
}
