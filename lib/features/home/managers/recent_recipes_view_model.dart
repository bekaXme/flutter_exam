import 'package:flutter/material.dart';
import '../../../core/result/result.dart';
import '../../../core/services/client.dart';
import '../../../data/models/recently_recipes_model.dart';
import '../../../data/repositories/recent_recipes_repository.dart';

class RecentRecipesVM extends ChangeNotifier {
  final RecentRecipesRepository _repository;

  RecentRecipesVM({RecentRecipesRepository? repository})
      : _repository = repository ?? RecentRecipesRepository(client: ApiClient()) {
    fetchRecentRecipes();
  }

  String? error;
  bool isLoading = true;
  List<RecentlyRecipesModel> recentRecipesList = [];

  Future<void> fetchRecentRecipes() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final Result<List<RecentlyRecipesModel>> result = await _repository.fetchRecentRecipes(limit: 2);

      result.fold(
        onError: (err) {
          error = err.toString();
          recentRecipesList = [];
        },
        onSuccess: (data) {
          error = null;
          recentRecipesList = data;
        },
      );
    } catch (e) {
      error = e.toString();
      recentRecipesList = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void retryFetch() {
    fetchRecentRecipes();
  }
}
