import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class ApplyCouponUseCase {
  final MainRepository _mainRepository;

  const ApplyCouponUseCase(this._mainRepository);

  Future<Either<Failure, ShoppingCart>> call({data}) async {
    return await _mainRepository.applyCoupon(data: data);
  }
}
