import 'package:flutter/cupertino.dart';
import 'package:flutter_exam/data/models/recently_recipes_model.dart';
import '../../../core/services/client.dart';

class RecentRecipesVM extends ChangeNotifier {
  RecentRecipesVM() {
    fetchRecentRecipes();
  }

  String? error;
  bool isLoading = true;
  List<RecentlyRecipesModel> RecentRecipesList = [];

  Future<void> fetchRecentRecipes() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await ApiClient().get('recipes/list', queryParameters: {'Limit': 2});
      result.fold(
        onError: (exception) {
          error = exception.toString();
        },
        onSuccess: (data) {
          error = null;
          List<dynamic> listData = data is List ? data : (data['data'] as List? ?? []);
          RecentRecipesList = listData.map((e) => RecentlyRecipesModel.fromJson(e)).toList();
        },
      );
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}