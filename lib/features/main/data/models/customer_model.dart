import 'package:mybeshop/features/main/data/models/area_model.dart';
import 'package:mybeshop/features/main/data/models/city_model.dart';
import 'package:mybeshop/features/main/data/models/state_model.dart';
import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/domain/entities/customer.dart';
import 'package:mybeshop/features/main/domain/entities/state.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required int id,
    required String no,
    required String phone,
    required String name,
    required String deliveryAddress,
    State? state,
    City? city,
    Area? area,
  }) : super(
          id: id,
          no: no,
          phone: phone,
          name: name,
          deliveryAddress: deliveryAddress,
          state: state,
          city: city,
          area: area,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] as int,
      no: json['no'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      state: json['state'] != null ? StateModel.fromJson(json['state']) : null,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      area: json['area'] != null ? AreaModel.fromJson(json['area']) : null,
    );
  }
}
