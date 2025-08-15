import 'package:flutter/material.dart';
import '../../../core/services/client.dart';

class OnBoardingMainModel extends ChangeNotifier{
  bool isLoading = true;
  String? error;
  List onboarding = [];

  Future<void> fetchOnBoardingItems()async{
    isLoading = true;
    notifyListeners();
    var response = await ApiClient().get("onboarding/list");
    if(response != 200){
      error = response.data;
      throw Exception(response.data);
    }else{
      onboarding = response.data;
    }
    isLoading = false;
    notifyListeners();
  }
}