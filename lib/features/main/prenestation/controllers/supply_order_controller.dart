import 'package:get/get.dart';
import 'package:mybeshop/features/main/domain/entities/supply_order.dart';
import 'package:mybeshop/features/main/domain/usecases/get_supply_order_use_case.dart';

class SupplyOrderController extends GetxController {
  final String supplyOrderNo;
  final GetSupplyOrderUseCase _getSupplyOrderUseCase;
  SupplyOrderController(
    this._getSupplyOrderUseCase,
    this.supplyOrderNo,
  );

  RxBool supplyOrderLoading = false.obs;
  SupplyOrder? supplyOrder;

  Future<void> getSupplyOrder() async {
    supplyOrderLoading(true);
    update();
    final response = await _getSupplyOrderUseCase(no: supplyOrderNo);
    response.fold((failure) {
      supplyOrderLoading(false);
      update();
    }, (success) {
      supplyOrder = success;
      supplyOrderLoading(false);
      update();
    });
  }

  @override
  void onInit() {
    getSupplyOrder();
    super.onInit();
  }
}
