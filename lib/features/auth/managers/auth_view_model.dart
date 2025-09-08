import 'package:flutter/material.dart';
import 'package:flutter_exam/core/result/result.dart';
import 'package:flutter_exam/data/models/auth/auth_model.dart';
import 'package:flutter_exam/core/services/client.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiClient _apiClient;

  AuthViewModel({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registerEvent({
    required AuthModel authModel,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _apiClient.post(
      'auth/register',
      data: authModel.toJson(),
    );

    _isLoading = false;
    notifyListeners();

    result.fold(
      onSuccess: (data) {
        onSuccess();
      },
      onError: (error) {
        onError(error.toString());
      },
    );
  }
}