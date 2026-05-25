import 'package:equatable/equatable.dart';

class PriceOfferAdditionalCost extends Equatable {
  final int id;
  final String name;
  final String description;
  final String cost;

  const PriceOfferAdditionalCost(
      {required this.id,
      required this.name,
      required this.description,
      required this.cost});

  @override
  List<Object?> get props => [id, name, description, cost];
}
