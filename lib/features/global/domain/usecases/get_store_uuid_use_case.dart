import 'package:mybeshop/features/global/domain/repositories/global_repository.dart';

class GetStoreUUIDUseCase {
  final GlobalRepository _repository;

  const GetStoreUUIDUseCase(this._repository);

  Future<String> call() async {
    return await _repository.getStoreUUID();
  }
}
