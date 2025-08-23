import 'package:flutter/widgets.dart';
import 'package:flutter_exam/core/services/client.dart';
import '../../../data/models/review_model.dart';

class ReviewsVM extends ChangeNotifier {
  bool isMyReviewsLoading = true;
  String? myReviewsError;
  List<ReviewsModel> myReviewsList = [];

  bool isReviewerLoading = true;
  String? reviewerError;
  List<ReviewsModel> reviewerList = [];

  Future<void> fetchMyReviews() async {
    try {
      isMyReviewsLoading = true;
      notifyListeners();
      var response = await ApiClient().get('recipes/reviews/detail/1');
      if (response.statusCode != 200) {
        throw Exception('Failed to load reviews');
      }
      isMyReviewsLoading = false;
      myReviewsError = null;
      reviewerList = (response.data as List).map((e) => ReviewsModel.fromJson(e)).toList();
    } catch (e) {
      myReviewsError = e.toString();
    } finally {
      isMyReviewsLoading = false;
      notifyListeners();
    }
  }
}