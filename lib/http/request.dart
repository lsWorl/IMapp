import 'package:dio/dio.dart';

class Request {
  // 配置实例
  static final BaseOptions _options = BaseOptions(
      baseUrl: 'http://169.254.226.185:3001/',
      connectTimeout: 5000,
      receiveTimeout: 5000);

  // 创建Dio实例
  static Dio _dio = Dio(_options);

  Future get(String path, {Map<String, dynamic>? params}) {
    if (params != null) {
      return _dio.get(path, queryParameters: params);
    }
    return _dio.get(path);
  }

  Future post(String path, {Map<String, dynamic>? params}) {
    if (params != null) {
      return _dio.post(path, queryParameters: params);
    }
    return _dio.post(path);
  }
}