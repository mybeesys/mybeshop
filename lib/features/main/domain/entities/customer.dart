import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final int id;
  final String name;

  const Customer({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
