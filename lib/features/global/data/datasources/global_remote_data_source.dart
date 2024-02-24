import 'package:mybeshop/features/global/data/models/store_info_model.dart';

import '../../../../core/api/api_consumer.dart';

abstract class GlobalRemoteDataSource {
  Future<StoreInfoModel> getStoreInfo();
}

class GlobalRemoteDataSourceImpl implements GlobalRemoteDataSource {
  final ApiConsumer apiConsumer;

  GlobalRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<StoreInfoModel> getStoreInfo() async {
    final response = await apiConsumer.get(
      "v1/store/info",
    );
    StoreInfoModel storeInfoModel = StoreInfoModel.fromJson(response["data"]);
    return storeInfoModel;
  }
}
