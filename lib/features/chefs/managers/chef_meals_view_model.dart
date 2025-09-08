import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_exam/core/result/result.dart';
import '../../../core/services/client.dart';
import '../../../data/models/chef_meal_model.dart';

class ChefMealsVM extends ChangeNotifier {
  ChefMealsVM() {
    fetchChefMeals();
  }

  bool isLoading = true;
  String? error;
  List<ChefMealModel> chefMealsList = [];

  Future<void> fetchChefMeals() async {
    try {
      dev.log('Fetching chef meals data...');
      final Result<dynamic> result = await ApiClient().get('recipes/list');
      dev.log('API Result: $result');

      if (result.isSuccess) {
        final data = result.value;
        if (data is List) {
          chefMealsList = data
              .map((json) => ChefMealModel.fromJson(json))
              .toList()
              .cast<ChefMealModel>();
          dev.log('Parsed meals: $chefMealsList');
          error = null;
        } else {
          error = 'Invalid data format: ${data.runtimeType}';
          chefMealsList = [];
          dev.log('Invalid data format: $data');
        }
      } else {
        error = result.error?.toString() ?? 'Unknown error';
        chefMealsList = [];
        dev.log('Error: $error');
      }
    } catch (e) {
      error = 'Error: $e';
      chefMealsList = [];
      dev.log('Error fetching meals: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
