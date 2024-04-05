import 'package:equatable/equatable.dart';

import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/domain/entities/state.dart';

class Customer extends Equatable {
  final int id;
  final String no;
  final String phone;
  final String name;
  final String? deliveryAddress;
  final State? state;
  final City? city;
  final Area? area;

  const Customer({
    required this.id,
    required this.no,
    required this.phone,
    required this.name,
    required this.deliveryAddress,
    this.state,
    this.city,
    this.area,
  });

  @override
  List<Object?> get props =>
      [id, no, phone, name, deliveryAddress, state, city, area];
}
