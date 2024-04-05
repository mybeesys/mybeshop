import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer_detail.dart';

class PriceOffer extends Equatable {
  final StoreInfo store;
  final String termsAndConditions;
  final PriceOfferDetail priceOfferDetail;

  const PriceOffer(
      {required this.store,
      required this.termsAndConditions,
      required this.priceOfferDetail});

  @override
  List<Object?> get props => [store, termsAndConditions, priceOfferDetail];
}
