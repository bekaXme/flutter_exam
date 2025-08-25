class YourRecipesModel {
  final String? productImage;
  final String? productName;
  final String? productDescription;
  final int rating;
  final int timeRequired;

  YourRecipesModel({
    this.productImage,
    this.productName,
    this.productDescription,
    required this.rating,
    required this.timeRequired,
  });

  factory YourRecipesModel.fromJson(Map<String, dynamic> json) {
    return YourRecipesModel(
      productImage: json['productImage'] as String? ?? '',
      productName: json['productName'] as String? ?? '',
      productDescription: json['productDescription'] as String? ?? '',
      rating: (json['rating'] is double ? (json['rating'] as double).toInt() : json['rating'] as int?) ?? 0,
      timeRequired: (json['timeRequired'] is double ? (json['timeRequired'] as double).toInt() : json['timeRequired'] as int?) ?? 0,
    );
  }
}