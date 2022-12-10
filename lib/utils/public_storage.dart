// 公用的本地存储
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PublicStorage {
  // 设置聊天记录
  setHistoryList(String key, List value, {isSearch}) async {
    // 使用发送与接收的id来作为key，避免登录账号不同来获取相同的聊天数据
    try {
      String str = jsonEncode(value);
      final prefs = await SharedPreferences.getInstance();
      print('-------------保存到本地数据----------------');
      print('原始获得的key:${key}');
      // 把传入的数据转为字符串
      var result = await prefs.setString(key, str);
      print('查看数据存储本地的结果：${result}');
    } catch (e) {
      print(e);
    }
  }

  Future getHistoryList(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? result = await prefs.getString(key) as String;
      // print('-------------获取本地数据----------------');
      // print('本地存储获取到的数据：${result}');
      return jsonDecode(result);
    } catch (e) {
      print('获取本地数据出错：');
      print('报错:${e}');
    }
  }

  removeHistoryList(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('-------------删除数据----------------');
      final success = await prefs.remove(key);
    } catch (e) {
      print(e);
    }
  }
}
