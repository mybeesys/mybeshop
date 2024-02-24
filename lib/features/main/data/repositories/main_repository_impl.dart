import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/exceptions.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/data/datasources/main_local_data_source.dart';
import 'package:mybeshop/features/main/data/datasources/main_remote_data_source.dart';
import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';
import 'package:mybeshop/features/main/domain/entities/state.dart' as state;
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainLocalDataSource mainLocalDataSource;
  final MainRemoteDataSource mainRemoteDataSource;

  MainRepositoryImpl(
      {required this.mainLocalDataSource, required this.mainRemoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getCategories({filters}) async {
    try {
      final response =
          await mainRemoteDataSource.getCategories(filters: filters);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts({filters}) async {
    try {
      final response = await mainRemoteDataSource.getProducts(filters: filters);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getVariantProduct({data}) async {
    try {
      final response = await mainRemoteDataSource.getVariantProduct(data: data);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(
          ServerFailure(message: e.message, exception: e, code: e.code));
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> addToCart({data}) async {
    try {
      final response = await mainRemoteDataSource.addToCart(data: data);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(
          ServerFailure(message: e.message, exception: e, code: e.code));
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> getShoppingCart() async {
    try {
      final response = await mainRemoteDataSource.getShoppingCart();
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> clearShoppingCart() async {
    try {
      final response = await mainRemoteDataSource.clearShoppingCart();
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> deleteItemFromCart({data}) async {
    try {
      final response =
          await mainRemoteDataSource.deleteItemFromCart(data: data);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(
          ServerFailure(message: e.message, exception: e, code: e.code));
    }
  }

  @override
  Future<Either<Failure, ShoppingCart>> updateCart({data}) async {
    try {
      final response = await mainRemoteDataSource.updateCart(data: data);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(
          ServerFailure(message: e.message, exception: e, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<state.State>>> getStates() async {
    try {
      final response = await mainRemoteDataSource.getStates();
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getCities({filters}) async {
    try {
      final response = await mainRemoteDataSource.getCities(filters: filters);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Area>>> getAreas({filters}) async {
    try {
      final response = await mainRemoteDataSource.getAreas(filters: filters);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> checkout({data}) async {
    try {
      final response = await mainRemoteDataSource.checkout(data: data);
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(
          ServerFailure(message: e.message, exception: e, code: e.code));
    }
  }
}
