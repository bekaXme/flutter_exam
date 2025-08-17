import 'package:flutter/material.dart';
import '../../../core/services/client.dart';
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
      final result = await ApiClient().get<dynamic>('top-chefs/list');

      if (result.isSuccess) {
        final responseData = result.value;

        if (responseData is List) {
          chefsList = responseData
              .map((e) => ChefsModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format: $responseData');
        }
      } else {
        throw Exception('API Error: ${result.error}');
      }
    } catch (e) {
      error = 'Failed to fetch chefs: $e';
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
