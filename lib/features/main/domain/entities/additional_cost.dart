import 'package:equatable/equatable.dart';

class AdditionalCost extends Equatable {
  final String statement;
  final String cost;

  const AdditionalCost({required this.statement, required this.cost});

  @override
  List<Object?> get props => [statement, cost];
}
