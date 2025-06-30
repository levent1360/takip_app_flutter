class UrunModel {
  final int id;
  final String phoneCode;
  final String link;
  final String? eImg;
  final String? markaIcon;
  final String? prices;
  final double? firstPrice;
  final double? lastPrice;
  final String? siteMarka;
  final bool? isBilidirimBasarisiz;
  final bool? isGosterildi;
  final bool? isDeleted;
  final bool isIslendi;
  final bool isBildirimAcik;
  final DateTime updateDate;
  final String? name;

  UrunModel({
    required this.id,
    required this.phoneCode,
    required this.link,
    this.eImg,
    this.markaIcon,
    this.prices,
    this.firstPrice,
    this.lastPrice,
    this.siteMarka,
    this.isBilidirimBasarisiz,
    this.isGosterildi,
    this.isDeleted,
    required this.isIslendi,
    required this.isBildirimAcik,
    required this.updateDate,
    this.name,
  });

  factory UrunModel.fromJson(Map<String, dynamic> json) => UrunModel(
    id: json["id"],
    phoneCode: json["phoneCode"],
    link: json["link"],
    eImg: json["eImg"] as String?,
    markaIcon: json["markaIcon"] as String?,
    prices: json["prices"] as String?,
    firstPrice: json["firstPrice"]?.toDouble(),
    lastPrice: json["lastPrice"]?.toDouble(),
    siteMarka: json["siteMarka"] as String?,
    isBilidirimBasarisiz: json["isBilidirimBasarisiz"] as bool?,
    isGosterildi: json["isGosterildi"] as bool?,
    isDeleted: json["isDeleted"] as bool?,
    isIslendi: json["isIslendi"],
    isBildirimAcik: json["isBildirimAcik"],
    updateDate: DateTime.parse(json["updateDate"]),
    name: json["name"] as String?,
  );

  UrunModel copyWith({
    int? id,
    String? phoneCode,
    String? link,
    String? eImg,
    String? markaIcon,
    String? prices,
    double? firstPrice,
    double? lastPrice,
    String? siteMarka,
    bool? isBilidirimBasarisiz,
    bool? isGosterildi,
    bool? isDeleted,
    bool? isIslendi,
    bool? isBildirimAcik,
    DateTime? updateDate,
    String? name,
  }) {
    return UrunModel(
      id: id ?? this.id,
      phoneCode: phoneCode ?? this.phoneCode,
      link: link ?? this.link,
      eImg: eImg ?? this.eImg,
      markaIcon: markaIcon ?? this.markaIcon,
      prices: prices ?? this.prices,
      firstPrice: firstPrice ?? this.firstPrice,
      lastPrice: lastPrice ?? this.lastPrice,
      siteMarka: siteMarka ?? this.siteMarka,
      isBilidirimBasarisiz: isBilidirimBasarisiz ?? this.isBilidirimBasarisiz,
      isGosterildi: isGosterildi ?? this.isGosterildi,
      isDeleted: isDeleted ?? this.isDeleted,
      isIslendi: isIslendi ?? this.isIslendi,
      isBildirimAcik: isBildirimAcik ?? this.isBildirimAcik,
      updateDate: updateDate ?? this.updateDate,
      name: name ?? this.name,
    );
  }

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
