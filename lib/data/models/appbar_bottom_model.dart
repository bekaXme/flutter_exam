import 'package:flutter/cupertino.dart';

class AppBarBottomModel {
  String title;
  String? imageUrl;

  AppBarBottomModel({required this.title, this.imageUrl});

  factory AppBarBottomModel.fromJson(Map<String, dynamic> json) {
    return AppBarBottomModel(title: json['title'], imageUrl: json['image']);
  }
}