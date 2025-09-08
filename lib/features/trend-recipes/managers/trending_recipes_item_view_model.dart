import 'package:flutter/material.dart';
import 'package:flutter_exam/core/result/result.dart';
import 'package:flutter_exam/data/models/trending_items_model.dart';
import '../../../core/services/client.dart';

class TrendingRecipesItemVM extends ChangeNotifier {
  TrendingRecipesItemVM() {
    fetchTrendingRecipesItem();
  }

  String? error;
  bool isLoading = true;
  List<TrendingItems> trendingRecipesItemsList = [];

  Future<void> fetchTrendingRecipesItem() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final Result<dynamic> result =
      await ApiClient().get('recipes/community/list');

      if (result.isSuccess) {
        final responseData = result.value;
        print('Response data: $responseData');

        if (responseData is List) {
          trendingRecipesItemsList = responseData
              .map((e) => TrendingItems.fromJson(e as Map<String, dynamic>))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          trendingRecipesItemsList = [
            TrendingItems.fromJson(responseData)
          ];
        } else {
          error = 'Unexpected response format: ${responseData.runtimeType}';
          trendingRecipesItemsList = [];
        }
      } else {
        error = result.error?.toString() ?? 'Unknown API error';
        trendingRecipesItemsList = [];
      }
    } catch (e) {
      error = 'Error: $e';
      trendingRecipesItemsList = [];
      print('Error fetching recipes: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
