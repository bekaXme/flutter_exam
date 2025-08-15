import 'package:flutter/cupertino.dart';
import 'package:flutter_exam/data/models/my_recipes_model.dart';
import 'package:flutter_exam/data/models/recently_recipes_model.dart';
import '../../../core/services/client.dart';

class RecentRecipesVM extends ChangeNotifier{
  RecentRecipesVM() {
    fetchRecentRecipes();
  }
  String? error;
  bool isLoading = true;
  List<RecentlyRecipesModel> RecentRecipesList = [];

  Future<void> fetchRecentRecipes() async {
    isLoading = true; // start loading
    notifyListeners();

    try {
      var response = await ApiClient().get('recipes/list?Limit=2');
      if (response != 200) {
        throw Exception('Failed to load recent recipes');
      } else {
        error = null;
        List data = response.data;
        RecentRecipesList = data
            .map((e) => RecentlyRecipesModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false; // finished loading
    notifyListeners();
  }
}