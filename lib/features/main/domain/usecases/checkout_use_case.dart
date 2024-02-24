import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class CheckoutUseCase {
  final MainRepository _mainRepository;

  const CheckoutUseCase(this._mainRepository);

  Future<Either<Failure, String>> call({data}) async {
    return await _mainRepository.checkout(data: data);
  }
}
