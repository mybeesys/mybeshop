import 'package:equatable/equatable.dart';

class SupplyOrderItem extends Equatable {
  final int id;
  final String name;
  final int qty;

  const SupplyOrderItem(
      {required this.id, required this.name, required this.qty});

  @override
  List<Object?> get props => [id, name, qty];
}
