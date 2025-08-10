import 'package:flutter/cupertino.dart';

class MyRecipes {
  String photo;
  String title;
  String description;
  int timeRequired;
  double rating;

  MyRecipes({
    required this.photo,
    required this.title,
    required this.description,
    required this.timeRequired,
    required this.rating,
  });

  factory MyRecipes.fromJson(Map<String, dynamic> json) {
    return MyRecipes(
      photo: json['photo'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      timeRequired: (json['timeRequired'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
