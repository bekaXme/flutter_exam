import 'package:dio/dio.dart';

final Dio request = Dio(
  BaseOptions(
    baseUrl: 'http://192.168.0.108:8888/api/v1/',
  ),
);