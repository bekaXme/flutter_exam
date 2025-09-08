import 'package:flutter/cupertino.dart';
import '../../../core/services/client.dart';
import '../../../data/models/appbar_bottom_model.dart';

class AppbarBottomVM extends ChangeNotifier {
  String? error;
  bool isLoading = false;
  List<AppBarBottomModel> appBarBottomList = [];
  String? selectedCategory;

  AppbarBottomVM() {
    fetchAppBar();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchAppBar() async {
    try {
      isLoading = true;
      error = null;
      appBarBottomList = []; // Clear previous data
      notifyListeners();

      final result = await ApiClient().get<List<dynamic>>('categories/list');

      if (result.isSuccess) {
        final data = result.data ?? [];
        appBarBottomList = data.map((e) => AppBarBottomModel.fromJson(e as Map<String, dynamic>)).toList();
        // Auto-select first category if list is not empty
        if (appBarBottomList.isNotEmpty) {
          selectedCategory = appBarBottomList.first.title;
        } else {
          selectedCategory = null; // Reset if no categories
        }
      } else {
        error = result.error?.toString() ?? 'Failed to load categories';
      }
    } catch (e) {
      error = 'Failed to load categories: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}