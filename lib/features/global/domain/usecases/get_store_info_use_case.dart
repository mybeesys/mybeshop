import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/global/domain/repositories/global_repository.dart';

class GetStoreInfoUseCase {
  final GlobalRepository _globalRepository;

  GetStoreInfoUseCase(this._globalRepository);

  Future<Either<Failure, StoreInfo>> call() async {
    return await _globalRepository.getStoreInfo();
  }
}
