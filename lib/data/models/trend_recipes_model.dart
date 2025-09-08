import 'package:flutter_exam/data/models/user/user_model.dart';

class TrendRecipesModel {
  final int recipeId;
  final String TrendingRecipesImage;
  final String TrendingRecipesTitle;
  final String TrendingRecipesDescription;
  final double TrendingRecipesTime;
  final double TrendingRecipesRating;
  final User user;

  TrendRecipesModel({
    required this.recipeId,
    required this.TrendingRecipesImage,
    required this.TrendingRecipesTitle,
    required this.TrendingRecipesDescription,
    required this.TrendingRecipesTime,
    required this.TrendingRecipesRating,
    required this.user,
  });

  factory TrendRecipesModel.fromJson(Map<String, dynamic> json) {
    return TrendRecipesModel(
      recipeId: json['id'] as int,
      TrendingRecipesImage: json['photo'] as String,
      TrendingRecipesTitle: json['title'] as String,
      TrendingRecipesDescription: json['description'] as String,
      TrendingRecipesTime: (json['timeRequired'] as num).toDouble(),
      TrendingRecipesRating: (json['rating'] as num).toDouble(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
