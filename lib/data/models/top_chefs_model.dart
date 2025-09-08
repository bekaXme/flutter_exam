import 'package:flutter/cupertino.dart';

class TopChefsModel {
  final int id;
  String photo;
  String name;
  TopChefsModel({
    required this.id,
    required this.photo,
    required this.name,
  });
  factory TopChefsModel.fromJson(Map<String, dynamic> json) {
    return TopChefsModel(
      id: json['id'],
      photo: json['profilePhoto'],
      name: json['firstName']
    );
  }
}