import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer.dart';
import 'package:mybeshop/features/main/domain/repositories/main_repository.dart';

class GetPriceOfferUseCase {
  final MainRepository _repository;

  const GetPriceOfferUseCase(this._repository);
  Future<Either<Failure, PriceOffer>> call({no, filters}) async {
    return await _repository.getPriceOffer(no: no, filters: filters);
  }
}
