import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/domain/entities/e_invoice.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';
import 'package:mybeshop/features/main/domain/entities/state.dart' as state;
import 'package:mybeshop/features/main/domain/entities/order.dart' as order;
import 'package:mybeshop/features/main/domain/entities/supply_order.dart';

abstract class MainRepository {
  Future<Either<Failure, List<Category>>> getCategories({filters});
  Future<Either<Failure, List<Product>>> getProducts({dynamic filters});
  Future<Either<Failure, Product>> getVariantProduct({data});
  // Cart
  Future<Either<Failure, ShoppingCart>> getShoppingCart();
  Future<Either<Failure, ShoppingCart>> addToCart({data});
  Future<Either<Failure, ShoppingCart>> updateCart({data});
  Future<Either<Failure, ShoppingCart>> deleteItemFromCart({data});
  Future<Either<Failure, ShoppingCart>> clearShoppingCart();
  // Locations
  Future<Either<Failure, List<state.State>>> getStates();
  Future<Either<Failure, List<City>>> getCities({filters});
  Future<Either<Failure, List<Area>>> getAreas({filters});
  Future<Either<Failure, String>> checkout({data});
  // TrackOrders
  Future<Either<Failure, List<order.Order>>> getOrders({filters});
  // Electronic Invoice
  Future<Either<Failure, EInvoice>> getEInvoice({filters});
  // Apply Coupon
  Future<Either<Failure, ShoppingCart>> applyCoupon({data});
  // PriceOffer
  Future<Either<Failure, PriceOffer>> getPriceOffer({no, filters});
  // Supply Order
  Future<Either<Failure, SupplyOrder>> getSupplyOrder({no, filters});
}
