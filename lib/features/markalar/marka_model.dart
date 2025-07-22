class MarkaModel {
  String name;
  String link;
  String orjName;
  String homeLink;

  MarkaModel({
    required this.name,
    required this.orjName,
    required this.homeLink,
    required this.link,
  });

  factory MarkaModel.fromJson(Map<String, dynamic> json) => MarkaModel(
    name: json["name"],
    orjName: json["orjName"],
    link: json["link"],
    homeLink: json["homeLink"],
  );
}
