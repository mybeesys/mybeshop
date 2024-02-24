import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class GetCategoriesUseCase {
  final MainRepository _mainRepository;

  const GetCategoriesUseCase(this._mainRepository);

  Future<Either<Failure, List<Category>>> call({filters}) async {
    return await _mainRepository.getCategories(filters: filters);
  }
}
