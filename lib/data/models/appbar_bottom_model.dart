import 'package:flutter/cupertino.dart';

class AppBarBottomModel {
  String title;

  AppBarBottomModel({required this.title});

  factory AppBarBottomModel.fromJson(Map<String, dynamic> json) {
    return AppBarBottomModel(title: json['title']);
  }
}