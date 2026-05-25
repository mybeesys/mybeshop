import 'package:dartz/dartz.dart';
import 'package:mybeshop/core/utils/services/local_storage_service/local_storage_service.dart';

abstract class MainLocalDataSource {
  bool isFirstTime();
  Future<Unit> onboardingViewed();
}

class MainLocalDataSourceImpl implements MainLocalDataSource {
  final LocalStorageService localStorageService;

  MainLocalDataSourceImpl(this.localStorageService);

  @override
  Future<Unit> onboardingViewed() async {
    await localStorageService.setBool("first_time", true);
    return unit;
  }

  @override
  bool isFirstTime() {
    bool? response = localStorageService.getBool("first_time");
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }
}
