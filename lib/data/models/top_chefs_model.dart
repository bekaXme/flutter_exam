import 'package:flutter/cupertino.dart';

class TopChefsModel {
  String photo;
  String name;
  TopChefsModel({
    required this.photo,
    required this.name,
  });
  factory TopChefsModel.fromJson(Map<String, dynamic> json) {
    return TopChefsModel(
      photo: json['profilePhoto'],
      name: json['firstName']
    );
  }
}