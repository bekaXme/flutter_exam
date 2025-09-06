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
  List<ReviewsModel> myReviewsList = [];

  bool isReviewerLoading = true;
  String? reviewerError;
  List<ReviewsModel> reviewerList = [];

  Future<void> fetchMyReviews() async {
    print('Starting fetchMyReviews...');
    try {
      isMyReviewsLoading = true;
      myReviewsError = null;
      notifyListeners();

      print('Calling API...');
      final Result<dynamic> result =
      await ApiClient().get('recipes/community/list');

      if (result.isSuccess) {
        final responseData = result.value;

        if (responseData is List) {
          myReviewsList = responseData
              .map((json) => ReviewsModel.fromJson(json as Map<String, dynamic>))
              .toList();
          myReviewsError = null;
          print('Successfully parsed reviews: $myReviewsList');
        } else {
          myReviewsError =
          'Unexpected response format: ${responseData.runtimeType}';
          myReviewsList = [];
        }
      } else {
        myReviewsError = result.error?.toString() ?? 'Unknown error';
        myReviewsList = [];
      }
    } catch (e) {
      print('Error in fetchMyReviews: $e');
      myReviewsError = e.toString();
      myReviewsList = [];
    } finally {
      isMyReviewsLoading = false;
      notifyListeners();
    }
  }
}
