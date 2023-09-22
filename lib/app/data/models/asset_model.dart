class AssetModel {
  final String assetId;
  final String brand;
  final String code;
  final String cond;
  final String name;
  final String reg;
  final String room;
  final String type;
  final String year;
  final String image;

  AssetModel({
    required this.assetId,
    required this.brand,
    required this.code,
    required this.cond,
    required this.name,
    required this.reg,
    required this.room,
    required this.type,
    required this.year,
    required this.image,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        assetId: json["assetId"] ?? "",
        brand: json["brand"] ?? "",
        code: json["code"] ?? "",
        cond: json["cond"] ?? "",
        name: json["name"] ?? "",
        reg: json["reg"] ?? "",
        room: json["room"] ?? "",
        type: json["type"] ?? "",
        year: json["year"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "assetId": assetId,
        "brand": brand,
        "code": code,
        "cond": cond,
        "name": name,
        "reg": reg,
        "room": room,
        "type": type,
        "year": year,
        "image": image,
      };
}
