import 'package:flutter/material.dart';
import '../../../data/models/your_recipes_model.dart';
import '../../../data/repositories/your_recipes_repository.dart';

class YourRecipesVM extends ChangeNotifier {
  bool isMyRecipesLoading = false;
  String? myRecipesError;
  List<YourRecipesModel> yourRecipesList = [];

  final YourRecipesRepository _repository;

  YourRecipesVM({YourRecipesRepository? repository})
      : _repository = repository ?? YourRecipesRepository();

  Future<void> fetchMyRecipes() async {
    isMyRecipesLoading = true;
    myRecipesError = null;
    notifyListeners();

    try {
      final result = await _repository.getMyRecipes();

      if (result.isSuccess) {
        yourRecipesList = result.value ?? [];
      } else {
        myRecipesError = result.error?.toString() ?? 'Failed to fetch recipes';
        yourRecipesList = [];
      }
    } catch (e) {
      myRecipesError = e.toString();
      yourRecipesList = [];
    } finally {
      isMyRecipesLoading = false;
      notifyListeners();
    }
  }

  void retryFetch() {
    fetchMyRecipes();
  }
}
