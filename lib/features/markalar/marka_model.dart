class MarkaModel {
  String name;
  String link;
  String orjName;

  MarkaModel({required this.name, required this.orjName, required this.link});

  factory MarkaModel.fromJson(Map<String, dynamic> json) => MarkaModel(
    name: json["name"],
    orjName: json["orjName"],
    link: json["link"],
  );
}
