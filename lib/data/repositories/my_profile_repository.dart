import 'package:flutter/material.dart';
import '../../core/result/result.dart';
import '../../core/services/client.dart';

class MyProfileRepository{
  MyProfileRepository({required ApiClient client}) : _client = client;

  final ApiClient _client;

  Future<Result<String>> myProfile(Map<String, dynamic> data) async{
    final result = await _client.post("auth/details/1", data: data);
    return result.fold(
      onError: (error) => Result.error(error),
      onSuccess: (success) => Result.success(success['accessToken']),
    );
  }
}