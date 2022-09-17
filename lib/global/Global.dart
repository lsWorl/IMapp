import 'dart:io';

import 'package:dio/dio.dart';

class Global{
  static Global? _instance;
  late Dio dio;

  

  static Global? getInstance(){
    if(_instance ==null) _instance = new Global();
    return _instance;
  }

  Global(){
    // 配置请求
    dio = new Dio();
    dio.options = BaseOptions(
      baseUrl: 'http://10.60.161.44:3001/',
      // 连接超时
      connectTimeout: 5000,
      // 发送超时
      sendTimeout: 5000,
      // 接收超时
      receiveTimeout: 5000,
      headers: {

      },
      // json类型
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        print('请求拦截'+options.path);
      },
      onResponse: (e, handler) {
        print('响应拦截' + e.data.toString());
      },
      onError: (e, handler) {
        print('错误拦截' + e.type.toString());
      },
    ));

  }
}