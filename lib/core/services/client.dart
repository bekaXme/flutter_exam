import 'package:dio/dio.dart';
import 'package:flutter_exam/core/result/result.dart';
import '../interceptor/auth_interceptor.dart';

class ApiClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.0.103:8888/api/v1/",
      validateStatus: (status) => true,
    ),
  );

  Future<Result<dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return Result.success(response.data);
      } else {
        return Result.error(Exception('Failed to get data: ${response.statusCode}'));
      }
    } catch (e) {
      return Result.error(Exception('Network error: $e'));
    }
  }

  Future<Result<T>> post<T>(String path,
      {required Map<String, dynamic> data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(path, data: data, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.success(response.data as T);
      } else {
        return Result.error(Exception('Failed to post data: ${response.data}'));
      }
    } catch (e) {
      return Result.error(Exception('Network error: $e'));
    }
  }
}
