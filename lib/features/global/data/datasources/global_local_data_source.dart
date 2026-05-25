import 'package:mybeshop/core/utils/services/local_storage_service/local_storage_service.dart';
import 'package:uuid/uuid.dart';

abstract class GlobalLocalDataSource {
  Future<String> saveStoreUUID();
  Future<String> getSavedStoreUUID();
}

class GlobalLocalDataSourceImpl implements GlobalLocalDataSource {
  final LocalStorageService _localStorageService;
  const GlobalLocalDataSourceImpl(this._localStorageService);
  @override
  Future<String> getSavedStoreUUID() async {
    var storeUUID = _localStorageService.getString("store_uuid");
    if (storeUUID != null) {
      return storeUUID;
    } else {
      return await saveStoreUUID();
    }
  }

  @override
  Future<String> saveStoreUUID() async {
    var uuid = const Uuid();
    String storeUUID = uuid.v1();
    await _localStorageService.setString("store_uuid", storeUUID);
    return storeUUID;
  }
}
