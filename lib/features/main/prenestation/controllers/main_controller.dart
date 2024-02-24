import 'package:get/get.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/usecases/get_categories_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_products_use_case.dart';

class MainController extends GetxController {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  MainController(this._getCategoriesUseCase, this._getProductsUseCase);

  bool isGrid = false;

  void changeProductsLayout() {
    isGrid = !isGrid;
    update();
  }

  RxBool categoriesLoading = false.obs;
  List<Category> categories = [];

  void getCategories() async {
    categoriesLoading(true);
    update();
    final response = await _getCategoriesUseCase();
    response.fold((failure) {
      categoriesLoading(false);
      update();
    }, (success) {
      categories = success;
      categoriesLoading(false);
      selectedCategory = categories.first;

      update();
    });
  }

  RxBool productsLoading = false.obs;
  List<Product> products = [];

  Category? selectedCategory;

  void onCategorySelected(v) {
    selectedCategory = v;
    // getProducts();
    update();
  }

  // void getProducts() async {
  //   productsLoading(true);
  //   update();
  //   var response;
  //   if (selectedCategory != null) {
  //     response = await _getProductsUseCase(
  //         filters: {"categories_ids[]": "${selectedCategory?.id}"});
  //   } else {
  //     response = await _getProductsUseCase();
  //   }
  //   response.fold((failure) {
  //     productsLoading(false);
  //     update();
  //   }, (success) {
  //     products = success;
  //     productsLoading(false);
  //     update();
  //   });
  // }

  @override
  void onInit() {
    getCategories();
    // getProducts();
    super.onInit();
  }
}
