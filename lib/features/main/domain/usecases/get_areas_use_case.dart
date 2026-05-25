import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class GetAreasUseCase {
  final MainRepository _mainRepository;

  const GetAreasUseCase(this._mainRepository);

  Future<Either<Failure, List<Area>>> call({filters}) async {
    return await _mainRepository.getAreas(filters: filters);
  }
}
