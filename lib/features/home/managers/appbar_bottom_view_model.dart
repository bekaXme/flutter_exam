import 'package:flutter/cupertino.dart';
import 'package:flutter_exam/data/models/my_recipes_model.dart';
import '../../../core/services/client.dart';
import '../../../data/models/appbar_bottom_model.dart';

class AppbarBottomVM extends ChangeNotifier {
  String? error;
  bool isLoading = true;
  List<AppBarBottomModel> appBarBottomList = [];
  String? selectedCategory;
  void updateSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchAppBar() async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await ApiClient().get('categories/list');
      if (response != 200) {
        throw Exception('Failed to load categories');
      }
      error = null;
      List data = response.data;
      appBarBottomList = data.map((e) => AppBarBottomModel.fromJson(e)).toList();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
