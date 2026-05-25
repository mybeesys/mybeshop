import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class GetVariantProductUseCase {
  final MainRepository _mainRepository;

  const GetVariantProductUseCase(this._mainRepository);
  Future<Either<Failure, Product>> call({data}) async {
    return await _mainRepository.getVariantProduct(data: data);
  }
}
