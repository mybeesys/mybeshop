import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/utils/helper/app_dialogs.dart';
import 'package:mybeshop/core/utils/helper/app_loaders_helper.dart';
import 'package:mybeshop/core/utils/helper/validator.dart';
import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';
import 'package:mybeshop/features/main/domain/usecases/apply_coupon_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/checkout_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_areas_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_cities_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_states_use_case.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/checkout_view.dart';
import 'package:mybeshop/features/main/domain/entities/state.dart' as state;

class CheckoutController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // List Of Steps
  ShoppingCart? shoppingCart;
  bool checkoutCompleted = false;

  List<Widget> steps = const [
    PersonalInformationStepWidget(),
    PaymentMethodsStepWidget(),
    TrackOrderStepWidget(),
  ];

  static CheckoutController get to => Get.find();

  CheckoutController(this._getStatesUseCase, this._getCitiesUseCase,
      this._getAreasUseCase, this._applyCouponUseCase, this._checkoutUseCase);

  void onStepChanged(next) async {
    if (next) {
      if (tabController.index == 1) {
        await checkout();
      }
      if (tabController.index == 0) {
        if (checkoutForm.currentState!.validate()) {
          tabController.index++;
          tabController.animateTo(tabController.index);
        }
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
  final ApplyCouponUseCase _applyCouponUseCase;
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

  GlobalKey<FormState> checkoutForm = GlobalKey<FormState>();
  final TextEditingController nameInput = TextEditingController();
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController deliveryAddressInput = TextEditingController();
  Map<String, dynamic> errors = {};

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
      selectedState = states.first;
      getCities();
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
      selectedCity = cities.first;
      getAreas();
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
      selectedArea = areas.first;
      areasLoading(false);
      update();
    });
  }

  final GlobalKey<FormState> couponFormKey = GlobalKey<FormState>();
  final TextEditingController couponInput = TextEditingController();

  void applyCoupon() async {
    if (couponFormKey.currentState!.validate()) {
      AppLoaders.showLoading();
      final response =
          await _applyCouponUseCase(data: {"coupon": couponInput.text});
      response.fold((failure) {
        AppLoaders.hideLoading();
        Get.dialog(AppDialogs.customDialog(
            title: "error".tr,
            message: failure.message,
            isLottie: true,
            icon: "error.json",
            onPressed: () {
              Get.back();
            }));
      }, (success) {
        shoppingCart = success;
        AppLoaders.hideLoading();
        update();
        if (shoppingCart!.coupon.valid) {
          Get.dialog(AppDialogs.customDialog(
              title: "success".tr,
              message: "coupon_applied_successfully".tr,
              isLottie: true,
              icon: "success.json",
              onPressed: () {
                Get.back();
              }));
        } else {
          Get.dialog(AppDialogs.customDialog(
              title: "error".tr,
              message: "coupon_not_valid".tr,
              isLottie: true,
              icon: "error.json",
              onPressed: () {
                Get.back();
              }));
        }
      });
    }
  }

  Future<void> checkout({bool isMobile = false}) async {
    errors.clear();
    AppLoaders.showLoading();
    final response = await _checkoutUseCase(
      data: {
        "name": nameInput.text,
        "phone": phoneInput.text,
        "state_id": "${selectedState?.id}",
        "city_id": "${selectedCity?.id}",
        "area_id": "${selectedArea?.id}",
        "delivery_address": deliveryAddressInput.text,
        "payment_method": paymentMethod,
      },
    );

    response.fold((failure) {
      AppLoaders.hideLoading();
      errors = Validator.networkValidator(failure.exception);
      if (errors.isNotEmpty) {
        if (!isMobile) {
          tabController.index = 0;
          tabController.animateTo(tabController.index);
        }
        checkoutForm.currentState?.validate();
        update();
      } else {
        Get.dialog(AppDialogs.customDialog(
            title: "error".tr,
            message: failure.message,
            isLottie: true,
            icon: "error.json",
            onPressed: () {
              Get.back();
            }));
      }
    }, (success) {
      AppLoaders.hideLoading();
      checkoutCompleted = true;
      if (!isMobile) {
        tabController.index++;
        tabController.animateTo(tabController.index);
      }
      if (Get.isRegistered<MainController>()) {
        Get.find<MainController>().onInit();
      } else {
        Get.put(MainController(Get.find(), Get.find()));
      }
      if (Get.isRegistered<CartController>()) {
        CartController.to.onInit();
      } else {
        Get.put(CartController());
      }

      update();
      if (isMobile) {
        Get.offNamed(AppRoutes.checkoutCompleted);
      }
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
