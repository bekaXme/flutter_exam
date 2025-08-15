import 'package:flutter/cupertino.dart';
import 'package:flutter_exam/data/models/my_recipes_model.dart';
import '../../../core/services/client.dart';
import '../../../data/models/allergy/allergy_page_model.dart';
import '../../../data/models/appbar_bottom_model.dart';

class AllergyPageViewModel extends ChangeNotifier {
  AllergyPageViewModel(){
    fetchAllergyModel();
  }
  String? error;
  bool isLoading = true;
  List<AllergyModel> allergy = [];

  Future<void> fetchAllergyModel() async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await ApiClient().get('categories/list');
      if (response != 200) {
        throw Exception('Failed to load categories');
      }
      error = null;
      List data = response.data;
      allergy = data.map((e) => AllergyModel.fromJson(e)).toList();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
