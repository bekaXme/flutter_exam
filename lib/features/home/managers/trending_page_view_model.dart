import 'package:flutter/material.dart';
import '../../../core/services/client.dart';
import '../../../core/result/result.dart';
import '../../../data/models/trending_page_model.dart';

class TrendingRecipesVM extends ChangeNotifier {
  TrendingRecipesVM() {
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
      final Result<dynamic> result =
      await ApiClient().get('recipes/list');

      if (result.isSuccess) {
        final responseData = result.value;
        print('Response data: $responseData');

        if (responseData is List) {
          trendingRecipesList = responseData
              .map((e) =>
              TrendingRecipesModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          trendingRecipesList = [
            TrendingRecipesModel.fromJson(responseData)
          ];
        } else {
          error = 'Unexpected response format: ${responseData.runtimeType}';
          trendingRecipesList = [];
        }
      } else {
        error = result.error?.toString() ?? 'Unknown API error';
        trendingRecipesList = [];
      }
    } catch (e) {
      error = 'Error: $e';
      trendingRecipesList = [];
      print('Error fetching recipes: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
