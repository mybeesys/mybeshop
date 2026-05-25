import 'package:mybeshop/features/global/domain/entities/store_info.dart';

class StoreInfoModel extends StoreInfo {
  const StoreInfoModel({
    required super.name,
    required super.slug,
    required super.heroTitle,
    required super.bio,
    super.logo,
    super.cover,
    super.trn,
    super.address,
    required super.phone,
    required super.email,
    required super.workingHours,
    required super.social,
    required super.ordersTrackingEnabled,
  });

  factory StoreInfoModel.fromJson(Map<String, dynamic> json) {
    return StoreInfoModel(
      name: json["name"],
      slug: json["slug"],
      logo: json["logo"],
      heroTitle: json["heroTitle"],
      bio: json["bio"],
      cover: json["cover"],
      trn: json["trn"],
      address: json["address"],
      phone: json["phone"],
      email: json["email"],
      workingHours: json["workingHours"],
      social: Map.from(json["social"]),
      ordersTrackingEnabled: json["ordersTrackingEnabled"],
    );
  }
}
