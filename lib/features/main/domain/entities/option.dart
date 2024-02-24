import 'package:equatable/equatable.dart';

class Option extends Equatable {
  final int id;
  final String name;
  final String variantOptionName;

  const Option({
    required this.id,
    required this.name,
    required this.variantOptionName,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        variantOptionName,
      ];
}
