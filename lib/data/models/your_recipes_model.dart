import 'package:flutter/cupertino.dart';

class YourRecipesModel {
  final int id; // Added for navigation
  final String? productImage;
  final String? productName;
  final String? description;
  final int? timeRequired;
  final double? rating;

  YourRecipesModel({
    required this.id,
    this.productImage,
    this.productName,
    this.description,
    this.timeRequired,
    this.rating,
  });

  factory YourRecipesModel.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Debug JSON parsing
    return YourRecipesModel(
      id: json['id'] ?? 0, // Ensure API provides an 'id'
      productImage: json['photo'] ?? json['productImage'] ?? '',
      productName: json['title'] ?? json['productName'] ?? '',
      description: json['description'] ?? '',
      timeRequired: (json['timeRequired'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}