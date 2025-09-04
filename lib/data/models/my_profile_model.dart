import 'package:hive/hive.dart';
@HiveType(typeId: 1)
class MyProfileModel {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String profilePhoto;

  @HiveField(2)
  final String presentation;

  @HiveField(3)
  final int recipesCount;

  @HiveField(4)
  final int followingCount;

  @HiveField(5)
  final int followersCount;

  MyProfileModel({
    required this.username,
    required this.profilePhoto,
    required this.presentation,
    required this.recipesCount,
    required this.followingCount,
    required this.followersCount,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) {
    return MyProfileModel(
      username: json['username'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      presentation: json['presentation'] ?? '',
      recipesCount: json['recipesCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      followersCount: json['followersCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'profilePhoto': profilePhoto,
      'presentation': presentation,
      'recipesCount': recipesCount,
      'followingCount': followingCount,
      'followersCount': followersCount,
    };
  }
}
