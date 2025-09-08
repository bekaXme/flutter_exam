import 'package:flutter/material.dart';
import 'package:flutter_exam/data/models/top_chefs_model.dart';
import '../../../core/services/client.dart';

class TopChefsVM extends ChangeNotifier {
  TopChefsVM() {
    fetchChefs();
  }

  String? error;
  bool isLoading = true;
  List<TopChefsModel> topChefsList = [];

  Future<void> fetchChefs() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await ApiClient().get<List<dynamic>>('top-chefs/list');

      if (result.isSuccess) {
        error = null;
        final data = result.data ?? [];
        topChefsList = data.map((e) => TopChefsModel.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      error = 'Failed to load top chefs: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}