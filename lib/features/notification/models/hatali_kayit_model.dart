class HataliKayitModel {
  final int id;
  final String phoneCode;
  final String link;
  final String updateDate;

  String getParsedDate() {
    String truncatedDateString = updateDate.substring(0, 23);
    DateTime parsedDate = DateTime.parse(truncatedDateString);

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String formattedDate =
        '${twoDigits(parsedDate.day)}.${twoDigits(parsedDate.month)}.${parsedDate.year} '
        '${twoDigits(parsedDate.hour)}:${twoDigits(parsedDate.minute)}';
    return formattedDate;
  }

  HataliKayitModel({
    required this.id,
    required this.phoneCode,
    required this.link,
    required this.updateDate,
  });

  factory HataliKayitModel.fromJson(Map<String, dynamic> json) =>
      HataliKayitModel(
        id: json["id"],
        phoneCode: json["phoneCode"],
        link: json["link"],
        updateDate: json["updateDate"],
      );
}
