import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/main/domain/entities/order.dart';
import 'package:mybeshop/features/main/domain/usecases/get_orders_use_case.dart';

class TrackOrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GetOrdersUseCase _getOrdersUseCase;

  TrackOrdersController(this._getOrdersUseCase);

  RxBool ordersLoading = false.obs;
  List<Order> orders = [];

  Future<void> getOrders() async {
    ordersLoading(true);
    update();
    final response = await _getOrdersUseCase(filters: {
      "phone": searchInput.text,
    });

    response.fold((failure) {}, (success) {
      orders = success;
      ordersLoading(false);
      update();
    });
  }

  List<String> filters = [
    "all",
    "new",
    "packaging",
    "delivery-in-progress",
    "completed",
    "cancelled",
  ];
  final TextEditingController searchInput = TextEditingController();
  void onSearch(v) {
    getOrders();
  }

  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 6, vsync: this);
    super.onInit();
  }
}
