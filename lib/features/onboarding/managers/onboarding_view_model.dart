import 'package:flutter/material.dart';
import 'package:flutter_exam/data/models/onboarding/onboarding_page2_model.dart';
import '../../../core/services/client.dart';

class OnBoardingMainViewModel extends ChangeNotifier {
  bool isLoading = true;
  String? error;
  List<OnboardingPageSecond> onboarding = [];

  OnBoardingMainViewModel() {
    fetchOnBoardingItems();
  }

  Future<void> fetchOnBoardingItems() async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await ApiClient().get("onboarding/inspired");

      if (response.statusCode != 200) {
        throw Exception('Failed to load onboarding items');
      }

      List data = response.data;
      onboarding = data.map((e) => OnboardingPageSecond.fromJson(e)).toList();
      error = null;
    } catch (e) {
      error = e.toString();
      onboarding = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}