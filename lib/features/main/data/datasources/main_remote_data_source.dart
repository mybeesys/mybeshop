import 'package:mybeshop/features/main/data/models/area_model.dart';
import 'package:mybeshop/features/main/data/models/category_model.dart';
import 'package:mybeshop/features/main/data/models/city_model.dart';
import 'package:mybeshop/features/main/data/models/product_model.dart';
import 'package:mybeshop/features/main/data/models/state_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../models/shopping_cart_model.dart';

abstract class MainRemoteDataSource {
  Future<List<CategoryModel>> getCategories({filters});
  Future<List<ProductModel>> getProducts({filters});
  Future<ProductModel> getVariantProduct({data});
  // Cart
  Future<ShoppingCartModel> addToCart({data});
  Future<ShoppingCartModel> updateCart({data});
  Future<ShoppingCartModel> deleteItemFromCart({data});
  Future<ShoppingCartModel> getShoppingCart();
  Future<ShoppingCartModel> clearShoppingCart();
  // Locations
  Future<List<StateModel>> getStates();
  Future<List<CityModel>> getCities({filters});
  Future<List<AreaModel>> getAreas({filters});
  Future<String> checkout({data});
}

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  final ApiConsumer apiConsumer;

  MainRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<List<CategoryModel>> getCategories({filters}) async {
    final response =
        await apiConsumer.get("v1/store/categories", queryParameters: filters);
    List<CategoryModel> categoriesList = List.from(response["data"])
        .map((category) => CategoryModel.fromJson(category))
        .toList();
    return categoriesList;
  }

  @override
  Future<List<ProductModel>> getProducts({filters}) async {
    final response =
        await apiConsumer.get("v1/store/products", queryParameters: filters);
    List<ProductModel> productsList = List.from(response["data"])
        .map((product) => ProductModel.fromJson(product))
        .toList();
    return productsList;
  }

  @override
  Future<ShoppingCartModel> addToCart({data}) async {
    final response = await apiConsumer.post(
      "v1/store/cart/add",
      body: data,
    );
    ShoppingCartModel shoppingCartModel =
        ShoppingCartModel.fromJson(response["data"]);
    return shoppingCartModel;
  }

  @override
  Future<ProductModel> getVariantProduct({data}) async {
    final response = await apiConsumer.post(
      "v1/store/get-variant-info",
      body: data,
    );
    ProductModel productModel = ProductModel.fromJson(response["data"]);
    return productModel;
  }

  @override
  Future<ShoppingCartModel> getShoppingCart() async {
    final response = await apiConsumer.get(
      "v1/store/cart",
    );
    ShoppingCartModel shoppingCartModel =
        ShoppingCartModel.fromJson(response["data"]);
    return shoppingCartModel;
  }

  @override
  Future<ShoppingCartModel> clearShoppingCart() async {
    final response = await apiConsumer.get(
      "v1/store/cart/clear",
    );
    ShoppingCartModel shoppingCartModel =
        ShoppingCartModel.fromJson(response["data"]);
    return shoppingCartModel;
  }

  @override
  Future<ShoppingCartModel> deleteItemFromCart({data}) async {
    final response = await apiConsumer.post(
      "v1/store/cart/delete",
      body: data,
    );
    ShoppingCartModel shoppingCartModel =
        ShoppingCartModel.fromJson(response["data"]);
    return shoppingCartModel;
  }

  @override
  Future<ShoppingCartModel> updateCart({data}) async {
    final response = await apiConsumer.post(
      "v1/store/cart/update",
      body: data,
    );
    ShoppingCartModel shoppingCartModel =
        ShoppingCartModel.fromJson(response["data"]);
    return shoppingCartModel;
  }

  @override
  Future<List<StateModel>> getStates() async {
    final response = await apiConsumer.get("v1/store/location/states");
    List<StateModel> statesList = List.from(response["data"])
        .map((state) => StateModel.fromJson(state))
        .toList();
    return statesList;
  }

  @override
  Future<List<CityModel>> getCities({filters}) async {
    final response = await apiConsumer.get("v1/store/location/cities",
        queryParameters: filters);
    List<CityModel> citiesList = List.from(response["data"])
        .map((city) => CityModel.fromJson(city))
        .toList();
    return citiesList;
  }

  @override
  Future<List<AreaModel>> getAreas({filters}) async {
    final response = await apiConsumer.get("v1/store/location/areas",
        queryParameters: filters);
    List<AreaModel> areasList = List.from(response["data"])
        .map((area) => AreaModel.fromJson(area))
        .toList();
    return areasList;
  }

  @override
  Future<String> checkout({data}) async {
    final response = await apiConsumer.post(
      "v1/store/store/checkout",
      body: data,
    );

    return response["message"];
  }
}
