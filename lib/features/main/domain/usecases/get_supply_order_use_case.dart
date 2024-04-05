import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/supply_order.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class GetSupplyOrderUseCase {
  final MainRepository _repository;

  const GetSupplyOrderUseCase(this._repository);
  Future<Either<Failure, SupplyOrder>> call({no, filters}) async {
    return await _repository.getSupplyOrder(no: no, filters: filters);
  }
}
