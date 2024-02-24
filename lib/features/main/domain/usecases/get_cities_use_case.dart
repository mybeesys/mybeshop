import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class GetCitiesUseCase {
  final MainRepository _mainRepository;

  const GetCitiesUseCase(this._mainRepository);

  Future<Either<Failure, List<City>>> call({filters}) async {
    return await _mainRepository.getCities(filters: filters);
  }
}
