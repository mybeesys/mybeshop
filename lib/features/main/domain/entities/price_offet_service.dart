import 'package:equatable/equatable.dart';

class PriceOfferService extends Equatable {
  final int id;
  final String name;
  final String description;
  final String price;
  final String tax;
  final String subTotal;

  const PriceOfferService(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.tax,
      required this.subTotal});

  @override
  List<Object?> get props => [id, name, description, price, tax, subTotal];
}
