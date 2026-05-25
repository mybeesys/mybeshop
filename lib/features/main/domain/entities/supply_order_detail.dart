import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/supplier.dart';
import 'package:mybeshop/features/main/domain/entities/supply_order_item.dart';

class SupplyOrderDetail extends Equatable {
  final int id;
  final String no;
  final String date;
  final Supplier supplier;
  final List<SupplyOrderItem> items;

  const SupplyOrderDetail({
    required this.id,
    required this.no,
    required this.date,
    required this.supplier,
    required this.items,
  });

  @override
  List<Object?> get props => [id, no, date, supplier, items];
}
