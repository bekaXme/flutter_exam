import 'package:flutter/cupertino.dart';
import '../../../core/services/client.dart';
import '../../../data/models/my_recipes_model.dart';

class MyRecipesVM extends ChangeNotifier {
  MyRecipesVM() {
    fetchMyRecipes();
  }

  String? error;
  bool isLoading = true;
  List<MyRecipes> myRecipesList = [];

  Future<void> fetchMyRecipes() async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await request.get('recipes/list?Limit=2');

      if (response.statusCode != 200) {
        throw Exception('Failed to load recipes');
      }

      error = null;

      // Since API returns a pure array
      List data = response.data;
      myRecipesList = data.map((e) => MyRecipes.fromJson(e)).toList();

    } catch (e) {
      error = e.toString();
      myRecipesList = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
