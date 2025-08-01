class UrunModel {
  final int id;
  final String iden;
  final String phoneCode;
  final String link;
  final String? eImg;
  final String? markaIcon;
  final String? prices;
  final String? pricesDates;
  final double? firstPrice;
  final double? lastPrice;
  final String? siteMarka;
  final bool? isBilidirimBasarisiz;
  final bool? isGosterildi;
  final bool? isDeleted;
  final bool isHatali;
  final bool isTestData;
  final bool isBildirimAcik;
  final DateTime updateDate;
  final String? name;

  late final List<String> priceList;
  late final List<String> priceDateList;

  bool get isIndirim => lastPrice! < firstPrice!;
  bool get isZamli => lastPrice! > firstPrice!;
  bool get isFiyatAyni => lastPrice! == firstPrice!;
  String get filterMarkaNameBirlesik => '$siteMarka $name';

  bool get isSonBirSaat =>
      DateTime.now().difference(updateDate).inMinutes <= 60;

  UrunModel({
    required this.id,
    required this.iden,
    required this.phoneCode,
    required this.link,
    this.eImg,
    this.markaIcon,
    this.prices,
    this.pricesDates,
    this.firstPrice,
    this.lastPrice,
    this.siteMarka,
    this.isBilidirimBasarisiz,
    this.isGosterildi,
    this.isDeleted,
    required this.isHatali,
    required this.isTestData,
    required this.isBildirimAcik,
    required this.updateDate,
    this.name,
  }) {
    priceList = prices?.split('>') ?? [];
    priceDateList = pricesDates?.split('>') ?? [];
  }

  factory UrunModel.fromJson(Map<String, dynamic> json) => UrunModel(
    id: json["id"],
    iden: json["iden"],
    phoneCode: json["phoneCode"],
    link: json["link"],
    eImg: json["eImg"] as String?,
    markaIcon: json["markaIcon"] as String?,
    prices: json["prices"] as String?,
    pricesDates: json["pricesDates"] as String?,
    firstPrice: _toDouble(json["firstPrice"]),
    lastPrice: _toDouble(json["lastPrice"]),
    siteMarka: json["siteMarka"] as String?,
    isBilidirimBasarisiz: json["isBilidirimBasarisiz"] as bool?,
    isGosterildi: json["isGosterildi"] as bool?,
    isDeleted: json["isDeleted"] as bool?,
    isHatali: json["isHatali"],
    isTestData: json["isTestData"],
    isBildirimAcik: json["isBildirimAcik"] == true,
    updateDate: _parseDate(json["updateDate"]),
    name: json["name"] as String?,
  );

  // Yardımcı metotlar:
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
    try {
      return DateTime.parse(value);
    } catch (e) {
      return DateTime.fromMillisecondsSinceEpoch(0); // fallback değer
    }
  }

  UrunModel copyWith({
    int? id,
    String? iden,
    String? phoneCode,
    String? link,
    String? eImg,
    String? markaIcon,
    String? prices,
    String? pricesDates,
    double? firstPrice,
    double? lastPrice,
    String? siteMarka,
    bool? isBilidirimBasarisiz,
    bool? isGosterildi,
    bool? isDeleted,
    bool? isHatali,
    bool? isTestData,
    bool? isBildirimAcik,
    DateTime? updateDate,
    String? name,
  }) {
    return UrunModel(
      id: id ?? this.id,
      iden: iden ?? this.iden,
      phoneCode: phoneCode ?? this.phoneCode,
      link: link ?? this.link,
      eImg: eImg ?? this.eImg,
      markaIcon: markaIcon ?? this.markaIcon,
      prices: prices ?? this.prices,
      pricesDates: pricesDates ?? this.pricesDates,
      firstPrice: firstPrice ?? this.firstPrice,
      lastPrice: lastPrice ?? this.lastPrice,
      siteMarka: siteMarka ?? this.siteMarka,
      isBilidirimBasarisiz: isBilidirimBasarisiz ?? this.isBilidirimBasarisiz,
      isGosterildi: isGosterildi ?? this.isGosterildi,
      isDeleted: isDeleted ?? this.isDeleted,
      isHatali: isHatali ?? this.isHatali,
      isTestData: isTestData ?? this.isTestData,
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
    "pricesDates": pricesDates,
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
