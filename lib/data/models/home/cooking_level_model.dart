import 'package:flutter/material.dart';
import '../../../core/services/client.dart';

class CookingLevelModel extends ChangeNotifier {
  CookingLevelModel() {
    getCuisines();
  }

  String? error;
  bool isLoading = true;
  List cuisines = [];

  Future<void> getCuisines() async {
    isLoading = true;
    notifyListeners();
    var response = await ApiClient().get("cuisines/list");
    if (response != 200) {
      isLoading = false;
      error = response.data;
      notifyListeners();
      throw Exception(response.data);
    } else {
      isLoading = false;
      cuisines = response.data;
      notifyListeners();
    }
  }

}