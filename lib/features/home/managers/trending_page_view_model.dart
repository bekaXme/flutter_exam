import 'package:flutter/material.dart';
import '../../../core/services/client.dart';
import '../../../data/models/trending_page_model.dart';

class TrendingRecipesVM extends ChangeNotifier {
  TrendingRecipesVM(){
    fetchTrendingRecipes();
  }
  String? error;
  bool isLoading = true;
  List<TrendingRecipesModel> trendingRecipesList = [];

  Future<void> fetchTrendingRecipes() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      // Request as dynamic to avoid type casting issues
      final result = await ApiClient().get<dynamic>('recipes/list');

      if (result.isSuccess) {
        final responseData = result.value;
        print('Response data: $responseData');

        if (responseData is List) {
          // If API returns a list of recipes
          trendingRecipesList = responseData
              .map((e) => TrendingRecipesModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // If API returns a single recipe
          trendingRecipesList = [TrendingRecipesModel.fromJson(responseData)];
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        throw Exception('API Error: ${result.error}');
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = 'Error: $e';
      isLoading = false;
      notifyListeners();
      print('Error fetching recipes: $e');
    }
  }
}