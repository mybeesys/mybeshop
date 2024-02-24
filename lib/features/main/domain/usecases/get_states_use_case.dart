import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';
import 'package:mybeshop/features/main/domain/entities/state.dart' as state;

class GetStatesUseCase {
  final MainRepository _mainRepository;

  const GetStatesUseCase(this._mainRepository);

  Future<Either<Failure, List<state.State>>> call() async {
    return await _mainRepository.getStates();
  }
}
