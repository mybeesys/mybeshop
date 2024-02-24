import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class GetProductsUseCase {
  final MainRepository _mainRepository;

  const GetProductsUseCase(this._mainRepository);
  Future<Either<Failure, List<Product>>> call({dynamic filters}) async {
    return await _mainRepository.getProducts(filters: filters);
  }
}
