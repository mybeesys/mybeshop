import 'package:get/get.dart';
import 'package:mybeshop/features/main/data/models/category_model.dart';
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
    await getProducts();
    final response = await _getCategoriesUseCase();
    response.fold((failure) {
      categoriesLoading(false);
      update();
    }, (success) {
      categories = success;
      categoriesLoading(false);
      categories.insert(
          0,
          CategoryModel(
              id: 495739457,
              name: "all".tr,
              productsCount: products.length,
              products: products));
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

  Future<void> getProducts() async {
    productsLoading(true);
    update();
    var response;
    if (selectedCategory != null) {
      response = await _getProductsUseCase(
          filters: {"categories_ids[]": "${selectedCategory?.id}"});
    } else {
      response = await _getProductsUseCase();
    }
    response.fold((failure) {
      productsLoading(false);
      update();
    }, (success) {
      products = success;
      productsLoading(false);
      update();
    });
  }

  void setProductInCart(id) {
    for (var c in categories) {
      c.products.firstWhereOrNull((element) => element.id == id)?.inCart =
          false;
      update();
    }
  }

  @override
  void onInit() {
    getCategories();
    // getProducts();
    super.onInit();
  }
}
