import 'package:flutter/material.dart';
import 'package:flutter_exam/core/services/client.dart';
import 'package:flutter_exam/data/models/onboarding/onboarding_page1_model.dart';

class OnBoardingImproveViewModel extends ChangeNotifier {
  bool isLoading = true;
  String? error;
  List<OnboardingPageFirst> onboarding = [];

  OnBoardingImproveViewModel() {
    fetchOnBoardingItems();
  }

  Future<void> fetchOnBoardingItems() async {
    isLoading = true;
    notifyListeners();

    final result = await ApiClient().get("onboarding/skills");

    result.fold(
      onError: (e) {
        error = e.toString();
        onboarding = [];
      },
      onSuccess: (data) {
        try {
          if (data is List) {
            onboarding =
                data.map((e) => OnboardingPageFirst.fromJson(e)).toList();
            error = null;
          } else {
            error = "Unexpected response format: $data";
            onboarding = [];
          }
        } catch (e) {
          error = "Parsing error: $e";
          onboarding = [];
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
