import 'package:dio/dio.dart';

class Request {
  // 配置实例
  static final BaseOptions _options = BaseOptions(
      // 宽带测试用ip 169.254.226.185
      baseUrl: 'http://192.168.126.67:3001/',
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

  Future post(String path, {dynamic? params, options}) {
    if (params != null) {
      return _dio.post(path, data: params, options: options);
    }
    return _dio.post(path, options: options);
  }
}
