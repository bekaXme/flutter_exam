class CommunityMainModel {
  final int id;
  final String userPhoto;
  final String userName;
  final DateTime date;
  final String productPhoto;
  final String productTitle;
  final String productDescription;
  final int rating;
  final int timeRequired;

  CommunityMainModel({
    required this.id,
    required this.userPhoto,
    required this.userName,
    required this.date,
    required this.productPhoto,
    required this.productTitle,
    required this.productDescription,
    required this.rating,
    required this.timeRequired,
  });

  factory CommunityMainModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};

    return CommunityMainModel(
      id: json['id'] ?? 0,
      userPhoto: user['profilePhoto']?.toString() ?? '',
      userName: user['username']?.toString() ?? 'Unknown',
      date: DateTime.tryParse(json['created']?.toString() ?? '') ?? DateTime.now(),
      productPhoto: json['photo']?.toString() ?? '',
      productTitle: json['title']?.toString() ?? '',
      productDescription: json['description']?.toString() ?? '',
      rating: int.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      timeRequired: int.tryParse(json['timeRequired']?.toString() ?? '0') ?? 0,
    );
  }
}
