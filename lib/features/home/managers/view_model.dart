import 'package:flutter/material.dart';
import 'package:flutter_exam/core/services/client.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  bool isActive = true;
  String token = '';

  void registerEvent({
    required AuthModel authModel,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    isActive = true;
    notifyListeners();
    final data = await AuthenticationRepository(client: ApiClient())
        .register(authModel.toJson());
    data.fold(
      onError: (error) {
        onError(error.toString());
        isActive = false;
        notifyListeners();
      },
        onSuccess: (success) {
          token = success;
          onSuccess();
          isActive = false;
          notifyListeners();
        },
    );
  }
  void loginEvent({
    required AuthModel authModel,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    isActive = true;
    notifyListeners();
    final data = await AuthenticationRepository(client: ApiClient())
        .login(authModel.toJson());
    data.fold(
      onError: (error) {
        onError(error.toString());
        isActive = false;
        notifyListeners();
      },
      onSuccess: (success) {
        token = success;
        onSuccess();
        isActive =false;
        notifyListeners();
      },
    );
  }
}