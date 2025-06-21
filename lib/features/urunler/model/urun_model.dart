class UrunModel {
  final int id;
  final String phoneCode;
  final String link;
  final String eImg;
  final String prices;
  final double firstPrice;
  final double lastPrice;
  final String siteMarka;
  final bool isBilidirimBasarisiz;
  final bool isGosterildi;
  final bool isDeleted;
  final DateTime updateDate;
  final String name;

  UrunModel({
    required this.id,
    required this.phoneCode,
    required this.link,
    required this.eImg,
    required this.prices,
    required this.firstPrice,
    required this.lastPrice,
    required this.siteMarka,
    required this.isBilidirimBasarisiz,
    required this.isGosterildi,
    required this.isDeleted,
    required this.updateDate,
    required this.name,
  });

  factory UrunModel.fromJson(Map<String, dynamic> json) => UrunModel(
    id: json["id"],
    phoneCode: json["phoneCode"],
    link: json["link"],
    eImg: json["eImg"],
    prices: json["prices"],
    firstPrice: json["firstPrice"]?.toDouble(),
    lastPrice: json["lastPrice"]?.toDouble(),
    siteMarka: json["siteMarka"],
    isBilidirimBasarisiz: json["isBilidirimBasarisiz"],
    isGosterildi: json["isGosterildi"],
    isDeleted: json["isDeleted"],
    updateDate: DateTime.parse(json["updateDate"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phoneCode": phoneCode,
    "link": link,
    "eImg": eImg,
    "prices": prices,
    "firstPrice": firstPrice,
    "lastPrice": lastPrice,
    "siteMarka": siteMarka,
    "isBilidirimBasarisiz": isBilidirimBasarisiz,
    "isGosterildi": isGosterildi,
    "isDeleted": isDeleted,
    "updateDate": updateDate.toIso8601String(),
    "name": name,
  };
}
