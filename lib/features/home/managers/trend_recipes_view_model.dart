import 'package:flutter/cupertino.dart';
import '../../../core/services/client.dart';
import '../../../data/models/trend_recipes_model.dart';

class TrendRecipesVM extends ChangeNotifier {
  TrendRecipesVM() {
    fetchTrendRecipes();
  }
  String? error;
  bool isLoading = true;
  List<TrendRecipesModel> trendRecipes = [];

  Future<void> fetchTrendRecipes() async {
    isLoading = true;
    notifyListeners();
    var response = await ApiClient().get('recipes/trending-recipe');
    if (response != 200) {
      throw Exception('Failed to load trend recipes');
    } else {
      error = null;
      // Wrap the single object in a list
      var data = [response.data]; // Assuming response.data is a single object
      trendRecipes = data.map((e) => TrendRecipesModel.fromJson(e)).toList();
    }
    isLoading = false;
    notifyListeners();
  }
}

