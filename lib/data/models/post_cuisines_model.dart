class CuisineModel {
  final String image;
  final String title;
  final String description;
  final String time;
  final List<String> ingredients;
  final List<String> instructions;

  CuisineModel({
    required this.image,
    required this.title,
    required this.description,
    required this.time,
    required this.ingredients,
    required this.instructions,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'time': time,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
      image: json['image'],
      title: json['title'],
      description: json['description'],
      time: json['time'],
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }
}
