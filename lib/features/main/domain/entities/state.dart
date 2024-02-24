import 'package:equatable/equatable.dart';

class State extends Equatable {
  final int id;
  final String name;
  final int countryId;

  const State({required this.id, required this.name, required this.countryId});
  @override
  List<Object?> get props => [id, name, countryId];
}
