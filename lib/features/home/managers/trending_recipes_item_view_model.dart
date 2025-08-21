import 'package:flutter/material.dart';
import 'package:flutter_exam/data/models/trending_items_model.dart';
import '../../../core/services/client.dart';
import '../../../data/models/trending_page_model.dart';

class TrendingRecipesItemVM extends ChangeNotifier {
  TrendingRecipesItemVM(){
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
      final result = await ApiClient().get<dynamic>('recipes/community/list');

      if (result.isSuccess) {
        final responseData = result.value;
        print('Response data: $responseData');

        if (responseData is List) {
          trendingRecipesItemsList = responseData.map((e) => TrendingItems.fromJson(e as Map<String, dynamic>)).toList();
        } else if (responseData is Map<String, dynamic>) {
          trendingRecipesItemsList = [TrendingItems.fromJson(responseData)];
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