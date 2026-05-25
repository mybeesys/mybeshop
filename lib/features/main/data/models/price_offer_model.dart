import 'package:mybeshop/features/global/data/models/store_info_model.dart';
import 'package:mybeshop/features/main/data/models/price_offer_detail_model.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer.dart';

class PriceOfferModel extends PriceOffer {
  const PriceOfferModel({
    required super.store,
    required super.termsAndConditions,
    required super.priceOfferDetail,
  });

  factory PriceOfferModel.fromJson(Map<String, dynamic> json) {
    return PriceOfferModel(
      store: StoreInfoModel.fromJson(json["store"]),
      termsAndConditions: json["termsAndConditions"],
      priceOfferDetail: PriceOfferDetailModel.fromJson(
        json["priceOffer"],
      ),
    );
  }
}
