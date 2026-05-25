import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/option.dart';

class VariantOption extends Equatable {
  final int libraryId;
  final String libraryName;
  final List<Option> options;

  const VariantOption({
    required this.libraryId,
    required this.libraryName,
    required this.options,
  });

  @override
  List<Object?> get props => [
        libraryId,
        libraryName,
        options,
      ];
}
