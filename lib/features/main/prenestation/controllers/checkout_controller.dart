import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';
import 'package:mybeshop/features/main/domain/usecases/checkout_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_areas_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_cities_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_states_use_case.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/checkout_view.dart';
import 'package:mybeshop/features/main/domain/entities/state.dart' as state;

class CheckoutController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // List Of Steps
  late final ShoppingCart? shoppingCart;
  List<Widget> steps = const [
    PersonalInformationStepWidget(),
    PaymentMethodsStepWidget(),
    TrackOrderStepWidget(),
  ];

  static CheckoutController get to => Get.find();

  CheckoutController(this._getStatesUseCase, this._getCitiesUseCase,
      this._getAreasUseCase, this._checkoutUseCase);

  void onStepChanged(next) {
    if (next) {
      if (tabController.index < 2) {
        tabController.index++;
        tabController.animateTo(tabController.index);
      }
    } else {
      if (tabController.index > 0) {
        tabController.index--;
        tabController.animateTo(tabController.index);
      }
    }
    update();
  }

  String paymentMethod = "cash_on_delivery";

  void onPaymentMethodChanged(name) {
    paymentMethod = name;
    update();
  }

  // Tabs
  late TabController tabController;
  onStepClicked(int index) {
    tabController.animateTo(index);
    update();
  }

  final GetStatesUseCase _getStatesUseCase;
  final GetCitiesUseCase _getCitiesUseCase;
  final GetAreasUseCase _getAreasUseCase;
  final CheckoutUseCase _checkoutUseCase;
  // Locations
  RxBool stateLoading = false.obs;
  List<state.State> states = [];

  RxBool citiesLoading = false.obs;
  List<City> cities = [];

  RxBool areasLoading = false.obs;
  List<Area> areas = [];

  state.State? selectedState;
  City? selectedCity;
  Area? selectedArea;

  void onStateSelected(state) {
    selectedState = state;
    getCities();
    update();
  }

  void onCitySelected(city) {
    selectedCity = city;
    getAreas();
    update();
  }

  void onAreaSelected(area) {
    selectedArea = area;
    update();
  }

  Future<void> getStates() async {
    stateLoading(true);
    update();

    final response = await _getStatesUseCase();
    response.fold((failure) {}, (success) {
      states = success;
      stateLoading(false);
      update();
    });
  }

  Future<void> getCities() async {
    citiesLoading(true);
    update();

    final response =
        await _getCitiesUseCase(filters: {"state_id": "${selectedState?.id}"});
    response.fold((failure) {}, (success) {
      cities = success;
      citiesLoading(false);
      update();
    });
  }

  Future<void> getAreas() async {
    areasLoading(true);
    update();

    final response =
        await _getAreasUseCase(filters: {"city_id": "${selectedCity?.id}"});
    response.fold((failure) {}, (success) {
      areas = success;
      areasLoading(false);
      update();
    });
  }

  final TextEditingController nameInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController deliveryAddressInput = TextEditingController();

  Future<void> checkout() async {
    final response = await _checkoutUseCase(data: {
      "name": nameInput.text,
      "phone": phoneInput.text,
      "state_id": "${selectedState?.id}",
      "city_id": "${selectedCity?.id}",
      "area_id": "${selectedArea?.id}",
      "delivery_address": deliveryAddressInput.text,
      "payment_method": paymentMethod,
    });
  }

  @override
  void onInit() {
    shoppingCart = CartController.to.shoppingCart;
    getStates();
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
}
