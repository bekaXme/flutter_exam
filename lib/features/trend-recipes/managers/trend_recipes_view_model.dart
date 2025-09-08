import 'package:flutter/cupertino.dart';
import '../../../core/services/client.dart';
import '../../../data/models/trend_recipes_model.dart';

class TrendRecipesVM extends ChangeNotifier {
  TrendRecipesVM() {
    fetchTrendRecipes();
  }

  String? error;
  bool isLoading = false;
  List<TrendRecipesModel> trendRecipes = [];

  Future<void> fetchTrendRecipes() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await ApiClient().get<List<dynamic>>('recipes/community/list');

      if (result.isSuccess) {
        final data = result.data ?? [];
        trendRecipes = data.map((e) => TrendRecipesModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        error = result.error?.toString() ?? 'Failed to load trend recipes';
      }
    } catch (e) {
      error = 'Failed to load trend recipes: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}