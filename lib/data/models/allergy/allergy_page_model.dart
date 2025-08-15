class AllergyModel {
  final int id;
  final String title;
  final String image;

  AllergyModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory AllergyModel.fromJson(Map<String, dynamic> json) {
    return AllergyModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
