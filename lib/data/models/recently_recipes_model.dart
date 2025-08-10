import 'package:flutter/cupertino.dart';

class RecentlyRecipesModel {
  String photo;
  String title;
  String description;
  int timeRequired;
  int rating;

  RecentlyRecipesModel({
    required this.photo,
    required this.title,
    required this.description,
    required this.timeRequired,
    required this.rating,
  });
  factory RecentlyRecipesModel.fromJson(Map<String, dynamic> json) {
    return RecentlyRecipesModel(
      photo: json['photo'],
      title: json['title'],
      description: json['description'],
      timeRequired: (json['timeRequired'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
    );
  }
}