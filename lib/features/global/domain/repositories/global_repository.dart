import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';

abstract class GlobalRepository {
  Future<Either<Failure, StoreInfo>> getStoreInfo();
  Future<String> getStoreUUID();
}
