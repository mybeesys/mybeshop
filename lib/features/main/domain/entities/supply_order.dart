import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/global/domain/entities/store_info.dart';
import 'package:mybeshop/features/main/domain/entities/supply_order_detail.dart';

class SupplyOrder extends Equatable {
  final StoreInfo store;
  final String termsAndConditions;
  final SupplyOrderDetail supplyOrderDetail;

  const SupplyOrder(
      {required this.store,
      required this.termsAndConditions,
      required this.supplyOrderDetail});
  @override
  List<Object?> get props => [store, termsAndConditions, supplyOrderDetail];
}
