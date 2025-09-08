import 'package:dio/dio.dart';
import 'package:flutter_exam/core/result/result.dart';
import '../interceptor/auth_interceptor.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.0.103:8888/api/v1/",
      connectTimeout: const Duration(seconds: 10), // Add timeout
      receiveTimeout: const Duration(seconds: 10),
      validateStatus: (status) => status != null && status >= 200 && status < 300, // Validate 2xx statuses
    ),
  ) {
    // Add AuthInterceptor if authentication is needed
    _dio.interceptors.add(AuthInterceptor());
  }

  Future<Result<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return Result.success(response.data as T);
      } else {
        return Result.error(Exception('Failed to get data: ${response.statusCode} - ${response.statusMessage}'));
      }
    } on DioException catch (e) {
      return Result.error(Exception('Network error: ${e.message}'));
    } catch (e) {
      return Result.error(Exception('Unexpected error: $e'));
    }
  }

  Future<Result<T>> post<T>(String path,
      {required Map<String, dynamic> data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path, data: data, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.success(response.data as T);
      } else {
        return Result.error(Exception('Failed to post data: ${response.statusCode} - ${response.data}'));
      }
    } on DioException catch (e) {
      return Result.error(Exception('Network error: ${e.message}'));
    } catch (e) {
      return Result.error(Exception('Unexpected error: $e'));
    }
  }
}