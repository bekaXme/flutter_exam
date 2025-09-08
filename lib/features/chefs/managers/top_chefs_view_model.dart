import 'package:flutter/material.dart';
import '../../../core/result/result.dart';
import '../../../data/models/top_chefs_model.dart';
import '../../../data/repositories/top_chefs_repository.dart';
import '../../../core/services/client.dart';

class TopChefsVM extends ChangeNotifier {
  final TopChefsRepository _repository;

  TopChefsVM({TopChefsRepository? repository})
      : _repository = repository ?? TopChefsRepository(client: ApiClient()) {
    fetchChefs();
  }

  String? error;
  bool isLoading = true;
  List<TopChefsModel> topChefsList = [];

  Future<void> fetchChefs() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final Result<List<TopChefsModel>> result = await _repository.fetchTopChefs();

      result.fold(
        onError: (err) {
          error = err.toString();
          topChefsList = [];
        },
        onSuccess: (data) {
          topChefsList = data;
          error = null;
        },
      );
    } catch (e) {
      error = 'Failed to load top chefs: $e';
      topChefsList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void retryFetch() {
    fetchChefs();
  }
}
