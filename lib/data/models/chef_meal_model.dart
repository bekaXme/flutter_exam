class ChefMealModel {
  final String mealName;
  final String mealPhoto;
  final String description;

  ChefMealModel({
    required this.mealName,
    required this.mealPhoto,
    required this.description,
  });

  factory ChefMealModel.fromJson(Map<String, dynamic> json) {
    return ChefMealModel(
      mealName: json['title'],
      mealPhoto: json['photo'],
      description: json['description'],
    );
  }
}
