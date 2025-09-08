import 'package:flutter/material.dart';
import '../../../core/result/result.dart';
import '../../../data/models/chefs_model.dart';
import '../../../data/repositories/chefs_repository.dart';
import '../../../core/services/client.dart';

class ChefsViewModel extends ChangeNotifier {
  final ChefsRepository _repository;

  ChefsViewModel({ChefsRepository? repository})
      : _repository = repository ?? ChefsRepository(client: ApiClient()) {
    fetchChefs();
  }

  String? error;
  bool isLoading = true;
  List<ChefsModel> chefsList = [];

  Future<void> fetchChefs() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final Result<List<ChefsModel>> result = await _repository.fetchChefs();

      result.fold(
        onError: (err) {
          error = err.toString();
          chefsList = [];
        },
        onSuccess: (data) {
          chefsList = data;
          error = null;
        },
      );
    } catch (e) {
      error = 'Failed to fetch chefs: $e';
      chefsList = [];
      print('Error fetching chefs: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void retryFetch() {
    fetchChefs();
  }
}
