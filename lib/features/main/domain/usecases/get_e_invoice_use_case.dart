import 'package:dartz/dartz.dart';
import 'package:mybeshop/features/main/domain/entities/e_invoice.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/main_repository.dart';

class GetEInvoiceUseCase {
  final MainRepository _mainRepository;

  const GetEInvoiceUseCase(this._mainRepository);

  Future<Either<Failure, EInvoice>> call({filters}) async {
    return await _mainRepository.getEInvoice(filters: filters);
  }
}
