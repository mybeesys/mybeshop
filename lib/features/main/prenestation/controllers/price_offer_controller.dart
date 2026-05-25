import 'package:get/get.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer.dart';
import 'package:mybeshop/features/main/domain/usecases/get_price_offer_use_case.dart';

class PriceOfferController extends GetxController {
  final String priceOfferNo;
  final GetPriceOfferUseCase _getPriceOfferUseCase;
  PriceOfferController(this._getPriceOfferUseCase, this.priceOfferNo);

  RxBool priceOfferLoading = false.obs;
  PriceOffer? priceOffer;

  Future<void> getPriceOffer() async {
    priceOfferLoading(true);
    update();
    final response = await _getPriceOfferUseCase(no: priceOfferNo);
    response.fold((failure) {
      priceOfferLoading(false);
      update();
    }, (success) {
      priceOffer = success;
      priceOfferLoading(false);
      update();
    });
  }

  @override
  void onInit() {
    getPriceOffer();
    super.onInit();
  }
}
