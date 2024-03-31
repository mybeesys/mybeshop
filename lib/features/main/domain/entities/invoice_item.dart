import 'package:equatable/equatable.dart';

class InvoiceItem extends Equatable {
  final int id;
  final String name;
  final int qty;
  final String tax;
  final String discount;
  final String price;
  final String subTotal;

  const InvoiceItem({
    required this.id,
    required this.name,
    required this.qty,
    required this.tax,
    required this.discount,
    required this.price,
    required this.subTotal,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        qty,
        tax,
        discount,
        price,
        subTotal,
      ];
}
