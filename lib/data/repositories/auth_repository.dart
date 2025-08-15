import 'package:flutter_exam/core/services/client.dart';
import 'package:flutter_exam/core/result/result.dart';
import '../models/auth_model.dart';

class AuthenticationRepository {
  AuthenticationRepository({required ApiClient client}) : _client = client;
  final ApiClient _client;

  Future<Result<String>> register(Map<String, dynamic> data) async {
    final result = await _client.post("auth/register", data: data);
    return result.fold(
      onError: (Exception error) {
        return Result.error(error);
      },
      onSuccess: (data) {
        return Result.success(data['accessToken']);
      },
    );
  }

  Future<Result<String>> login(Map<String, dynamic> data) async {
    final result = await _client.post("auth/login", data: data);
    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) => Result.success(success['accessToken']),
    );
  }
}
