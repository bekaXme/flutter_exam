import 'package:flutter/material.dart';

class TrendingRecipesModel {
  String title;
  String description;
  String photo;
  int timeRequired;
  double rating;
  String difficulty;
  String userProfilePhoto;
  String username;
  String firstName;
  String lastName;

  TrendingRecipesModel({
    required this.title,
    required this.description,
    required this.photo,
    required this.timeRequired,
    required this.rating,
    required this.difficulty,
    required this.userProfilePhoto,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  factory TrendingRecipesModel.fromJson(Map<String, dynamic> json) {
    return TrendingRecipesModel(
      title: json['title'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String,
      timeRequired: json['timeRequired'] as int,
      rating: (json['rating'] as num).toDouble(),
      difficulty: json['difficulty'] as String,
      userProfilePhoto: json['user']['profilePhoto'] as String,
      username: json['user']['username'] as String,
      firstName: json['user']['firstName'] as String,
      lastName: json['user']['lastName'] as String,
    );
  }
}