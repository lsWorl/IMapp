import 'package:dio/dio.dart';

class Request {
  // 配置实例
  static final BaseOptions _options = BaseOptions(
      // 手机测试用ip 192.168.48.67
      // 宽带测试用ip 169.254.226.185
      baseUrl: 'http://192.168.201.67:3001/',
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
