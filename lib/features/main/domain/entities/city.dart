import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final String name;
  final int stateId;

  const City({required this.id, required this.name, required this.stateId});
  @override
  List<Object?> get props => [id, name, stateId];
}
