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
    print('Starting fetchMyRecipes...');
    isMyRecipesLoading = true;
    myRecipesError = null;
    notifyListeners();

    try {
      final result = await _repository.getMyRecipes();
      if (result.isSuccess) {
        yourRecipesList = result.value ?? [];
        print('Fetched ${yourRecipesList.length} recipes');
        yourRecipesList.forEach((recipe) => print('Recipe: ${recipe.productName}, ID: ${recipe.id}'));
      } else {
        throw Exception(result.error ?? 'Failed to fetch recipes');
      }
    } catch (e) {
      print('Error in fetchMyRecipes: $e');
      myRecipesError = e.toString();
    } finally {
      isMyRecipesLoading = false;
      notifyListeners();
    }
  }
}