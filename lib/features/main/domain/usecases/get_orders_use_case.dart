import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/order.dart' as order;
import '../repositories/main_repository.dart';

class GetOrdersUseCase {
  final MainRepository _mainRepository;

  const GetOrdersUseCase(this._mainRepository);

  Future<Either<Failure, List<order.Order>>> call({filters}) async {
    return await _mainRepository.getOrders(filters: filters);
  }
}
