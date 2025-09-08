import 'package:flutter/cupertino.dart';
import '../../../core/services/client.dart';
import '../../../data/models/allergy/allergy_page_model.dart';

class AllergyPageViewModel extends ChangeNotifier {
  AllergyPageViewModel() {
    fetchAllergyModel();
  }

  String? error;
  bool isLoading = false;
  List<AllergyModel> allergy = [];

  Future<void> fetchAllergyModel() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await ApiClient().get<List<dynamic>>('allergic/list');

      if (result.isSuccess) {
        final data = result.data ?? [];
        allergy = data.map((e) => AllergyModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        error = result.error?.toString() ?? 'Failed to load allergies';
      }
    } catch (e) {
      error = 'Failed to load allergies: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}