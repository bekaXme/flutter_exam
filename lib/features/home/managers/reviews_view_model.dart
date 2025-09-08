import 'package:flutter/widgets.dart';
import 'package:flutter_exam/core/services/client.dart';
import 'package:flutter_exam/core/result/result.dart';
import '../../../data/models/review_model.dart';

class ReviewsVM extends ChangeNotifier {
  ReviewsVM() {
    fetchMyReviews();
  }

  bool isMyReviewsLoading = true;
  String? myReviewsError;
  List<ReviewsModel> reviewerList = [];

  Future<void> fetchMyReviews() async {
    print('Starting fetchMyReviews...');
    try {
      isMyReviewsLoading = true;
      myReviewsError = null;
      notifyListeners();

      print('Calling API...');
      final Result<dynamic> result = await ApiClient().get('reviews/list');

      if (result.isSuccess) {
        final responseData = result.value;
        if (responseData is Map<String, dynamic> && responseData['data'] is List) {
          reviewerList = (responseData['data'] as List)
              .map((json) => ReviewsModel.fromJson(json as Map<String, dynamic>))
              .toList();
          myReviewsError = null;
          print('Successfully parsed reviews: $reviewerList');
        } else {
          myReviewsError = 'Unexpected response format: ${responseData.runtimeType}';
          reviewerList = [];
        }
      } else {
        myReviewsError = result.error?.toString() ?? 'Unknown error';
        reviewerList = [];
      }
    } catch (e) {
      print('Error in fetchMyReviews: $e');
      myReviewsError = 'Failed to fetch reviews: $e';
      reviewerList = [];
    } finally {
      isMyReviewsLoading = false;
      notifyListeners();
    }
  }
}