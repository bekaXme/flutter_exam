import 'package:flutter/material.dart';
import '../../../core/result/result.dart';
import '../../../core/services/client.dart';
import '../../../data/models/allergy/allergy_page_model.dart';
import '../../../data/repositories/allergy_repository.dart';

class AllergyPageViewModel extends ChangeNotifier {
  final AllergyRepository _repository;

  AllergyPageViewModel({AllergyRepository? repository})
      : _repository = repository ?? AllergyRepository(client: ApiClient()) {
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

      final Result<List<AllergyModel>> result =
      await _repository.fetchAllergies();

      result.fold(
        onError: (err) {
          error = err.toString();
          allergy = [];
        },
        onSuccess: (data) {
          allergy = data;
          error = null;
        },
      );
    } catch (e) {
      error = 'Failed to load allergies: $e';
      allergy = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void retryFetch() {
    fetchAllergyModel();
  }
}
