import 'package:flutter/cupertino.dart';

class TrendRecipesModel {
  String TrendingRecipesImage;
  String TrendingRecipesTitle;
  String TrendingRecipesDescription;
  int TrendingRecipesTime;
  int TrendingRecipesRating;

  TrendRecipesModel({
    required this.TrendingRecipesImage,
    required this.TrendingRecipesTitle,
    required this.TrendingRecipesDescription,
    required this.TrendingRecipesTime,
    required this.TrendingRecipesRating,
  });

  factory TrendRecipesModel.fromJson(Map<String, dynamic> json) {
    return TrendRecipesModel(
      TrendingRecipesImage: json['photo'],
      TrendingRecipesTitle: json['title'],
      TrendingRecipesDescription: json['description'],
      TrendingRecipesTime: json['timeRequired'],
      TrendingRecipesRating: json['rating'],
    );
  }
}
