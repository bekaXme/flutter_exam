import 'package:flutter/material.dart';
import '../../../core/services/client.dart';
import '../../../core/result/result.dart';
import '../../../data/models/chefs_model.dart';

class ChefsViewModel extends ChangeNotifier {
  ChefsViewModel() {
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
      final Result<dynamic> result = await ApiClient().get('top-chefs/list');

      if (result.isSuccess) {
        final responseData = result.value;

        if (responseData is List) {
          chefsList = responseData
              .map((e) => ChefsModel.fromJson(e as Map<String, dynamic>))
              .toList();
          error = null;
        } else {
          error = 'Unexpected response format: ${responseData.runtimeType}';
          chefsList = [];
        }
      } else {
        error = result.error?.toString() ?? 'Unknown error';
        chefsList = [];
      }
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
