class ReviewsModel {
  final int reviewId;
  final String productPhoto;
  final String productName;
  final int rating;
  final int reviewsCount;
  final String reviewerPhoto;
  final String reviewerUserName;
  final String firstName;
  final String lastName;
  final String reviewerComment;

  ReviewsModel({
    required this.reviewId,
    required this.productPhoto,
    required this.productName,
    required this.rating,
    required this.reviewsCount,
    required this.reviewerPhoto,
    required this.reviewerUserName,
    required this.firstName,
    required this.lastName,
    required this.reviewerComment,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      reviewId: json['reviewId'] ?? json['id'] ?? 0,
      productPhoto: json['productPhoto'] ?? '',
      productName: json['productName'] ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
      reviewerPhoto: json['reviewerPhoto'] ?? '',
      reviewerUserName: json['reviewerUserName'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      reviewerComment: json['reviewerComment'] ?? '',
    );
  }
}