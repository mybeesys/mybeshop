import 'package:equatable/equatable.dart';

class Supplier extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String? address;
  final String? company;
  final String? email;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final bool canDelete;

  const Supplier({
    required this.id,
    required this.name,
    required this.phone,
    this.address,
    this.company,
    this.email,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.canDelete,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        address,
        company,
        email,
        notes,
        createdAt,
        updatedAt,
        canDelete
      ];
}
