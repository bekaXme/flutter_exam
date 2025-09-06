// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'your_recipes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YourRecipesModel _$YourRecipesModelFromJson(Map<String, dynamic> json) =>
    YourRecipesModel(
      productImage: json['productImage'] as String?,
      productName: json['productName'] as String?,
      productDescription: json['productDescription'] as String?,
      rating: (json['rating'] as num).toInt(),
      timeRequired: (json['timeRequired'] as num).toInt(),
    );

Map<String, dynamic> _$YourRecipesModelToJson(YourRecipesModel instance) =>
    <String, dynamic>{
      'productImage': instance.productImage,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'rating': instance.rating,
      'timeRequired': instance.timeRequired,
    };
