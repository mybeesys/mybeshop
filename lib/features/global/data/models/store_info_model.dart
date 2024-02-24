import 'package:mybeshop/features/global/domain/entities/store_info.dart';

class StoreInfoModel extends StoreInfo {
  const StoreInfoModel({
    required super.name,
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
  });

  factory StoreInfoModel.fromJson(Map<String, dynamic> json) {
    return StoreInfoModel(
        name: json["name"],
        logo: json["logo"],
        heroTitle: json["heroTitle"],
        bio: json["bio"],
        cover: json["cover"],
        trn: json["trn"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        workingHours: json["workingHours"],
        social: Map.from(json["social"]));
  }
}
