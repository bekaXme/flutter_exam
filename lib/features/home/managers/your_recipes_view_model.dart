import 'package:flutter/material.dart';
import 'package:flutter_exam/core/services/client.dart';
import '../../../data/models/your_recipes_model.dart';

class YourRecipesVM extends ChangeNotifier {
  bool isMyRecipesLoading = true;
  String? myRecipesError;
  List<YourRecipesModel> yourRecipesList = [];

  Future<void> fetchMyRecipes() async {
    print('Starting fetchMyRecipes...');
    try {
      isMyRecipesLoading = true;
      notifyListeners();

      final result = await ApiClient().get<List<dynamic>>('recipes/list');
      print('API Response: $result');

      if (result.isSuccess && result.data != null) {
        yourRecipesList = result.data!.map((e) => YourRecipesModel.fromJson(e as Map<String, dynamic>)).toList();
        isMyRecipesLoading = false;
        myRecipesError = null;
        notifyListeners();
      } else {
        throw Exception('API call failed: ${result.error?.toString() ?? 'No data'}');
      }
    } catch (e) {
      print('Error in fetchMyRecipes: $e');
      myRecipesError = e.toString();
      isMyRecipesLoading = false;
      notifyListeners();
    }
  }
}