class OnboardingPageModel {
  final int id;
  final String resim;
  final String baslik;
  final String description;

  OnboardingPageModel({
    required this.id,
    required this.resim,
    required this.baslik,
    required this.description,
  });

  factory OnboardingPageModel.fromJson(Map<String, dynamic> json) =>
      OnboardingPageModel(
        id: json["id"],
        resim: json["resim"],
        baslik: json["baslik"],
        description: json["description"],
      );
}
