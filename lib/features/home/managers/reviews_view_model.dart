import 'package:flutter/widgets.dart';
import 'package:flutter_exam/core/services/client.dart';
import '../../../data/models/review_model.dart';

class ReviewsVM extends ChangeNotifier {
  ReviewsVM() {
    fetchMyReviews();
  }

  bool isMyReviewsLoading = true;
  String? myReviewsError;
  List<ReviewsModel> myReviewsList = [];

  bool isReviewerLoading = true;
  String? reviewerError;
  List<ReviewsModel> reviewerList = [];

  Future<void> fetchMyReviews() async {
    print('Starting fetchMyReviews...');
    try {
      isMyReviewsLoading = true;
      notifyListeners();

      print('Calling API...');
      final result = await ApiClient().get<List<dynamic>>('recipes/community/list'); // Updated to expect List
      print('API Response: $result');

      if (result.isSuccess && result.data != null) {
        isMyReviewsLoading = false;
        myReviewsError = null;
        reviewerList = result.data!.map((json) => ReviewsModel.fromJson(json as Map<String, dynamic>)).toList();
        print('Successfully parsed reviews: $reviewerList');
      } else {
        throw Exception('API call failed: ${result.error?.toString() ?? 'No data'}');
      }

    } catch (e) {
      print('Error in fetchMyReviews: $e');
      myReviewsError = e.toString();
    } finally {
      isMyReviewsLoading = false;
      notifyListeners();
    }
  }
}