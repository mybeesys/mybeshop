import 'package:equatable/equatable.dart';

class StoreInfo extends Equatable {
  final String name;
  final String slug;
  final String heroTitle;
  final String bio;
  final String? logo;
  final String? cover;
  final String? trn;
  final String? address;
  final String phone;
  final String email;
  final String workingHours;
  final Map<String, String> social;
  final bool ordersTrackingEnabled;

  const StoreInfo({
    required this.name,
    required this.slug,
    required this.heroTitle,
    required this.bio,
    this.logo,
    this.cover,
    this.trn,
    this.address,
    required this.phone,
    required this.email,
    required this.workingHours,
    required this.social,
    required this.ordersTrackingEnabled,
  });

  @override
  List<Object?> get props => [
        name,
        slug,
        heroTitle,
        bio,
        logo,
        cover,
        trn,
        address,
        phone,
        email,
        workingHours,
        social,
        ordersTrackingEnabled,
      ];
}
