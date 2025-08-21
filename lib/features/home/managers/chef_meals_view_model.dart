import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_exam/core/result/result.dart'; // Adjust import
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
      Result<List<dynamic>> result = await ApiClient().get<List<dynamic>>('recipes/list');
      dev.log('API Result: $result');

      if (result.isSuccess) {
        if (result.value is List) {
          chefMealsList = (result.value as List)
              .map((json) => ChefMealModel.fromJson(json))
              .toList();
          dev.log('Parsed meals: $chefMealsList');
        } else {
          error = 'Invalid data format: ${result.value.runtimeType}';
          dev.log('Invalid data format: ${result.value}');
        }
      } else {
        error = result.error?.toString() ?? 'Unknown error';
        dev.log('Error: $error');
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = 'Error: $e';
      dev.log('Error fetching meals: $e');
      notifyListeners();
    }
  }
}