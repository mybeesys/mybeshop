import 'package:equatable/equatable.dart';

class OrderExtra extends Equatable {
  final String name;
  final String price;

  const OrderExtra({required this.name, required this.price});

  @override
  List<Object?> get props => [name, price];
}
