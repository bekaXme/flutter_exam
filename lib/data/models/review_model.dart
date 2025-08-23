class ReviewsModel {
  final String reviewerPhoto;
  final String reviewerUserName;
  final String reviewerComment;
  final String productPhoto;
  final String productName;
  final int rating;
  final String firstName;
  final String lastName;
  final int reviewsCount;

  ReviewsModel({
    required this.reviewerPhoto,
    required this.reviewerUserName,
    required this.reviewerComment,
    required this.productPhoto,
    required this.productName,
    required this.rating,
    required this.firstName,
    required this.lastName,
    required this.reviewsCount,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      reviewerPhoto: json['user']['profilePhoto'],
      reviewerUserName: json['user']['username'],
      reviewerComment: json['reviewerComment'] ?? '',
      productPhoto: json['photo'],
      productName: json['title'],
      rating: json['rating'],
      firstName: json['user']['firstName'],
      lastName: json['user']['lastName'],
      reviewsCount: json['reviewsCount'],
    );
  }
}