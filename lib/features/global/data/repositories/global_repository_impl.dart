import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/errors/exceptions.dart';
import 'package:mybeshop/core/errors/failures.dart';
import 'package:mybeshop/features/global/data/datasources/global_local_data_source.dart';
import 'package:mybeshop/features/global/data/datasources/global_remote_data_source.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/global/domain/repositories/global_repository.dart';

class GlobalRepositoryImpl implements GlobalRepository {
  final GlobalRemoteDataSource globalRemoteDataSource;
  final GlobalLocalDataSource globalLocalDataSource;

  GlobalRepositoryImpl(
      {required this.globalRemoteDataSource,
      required this.globalLocalDataSource});

  @override
  Future<Either<Failure, StoreInfo>> getStoreInfo() async {
    try {
      final response = await globalRemoteDataSource.getStoreInfo();
      return Right(response);
    } on MyBeeException catch (e) {
      return Left(ServerFailure(message: e.message, exception: e));
    }
  }

  @override
  Future<String> getStoreUUID() async {
    return globalLocalDataSource.getSavedStoreUUID();
  }
}
