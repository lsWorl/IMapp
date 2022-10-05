// 公用的本地存储
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PublicStorage {
  // 设置聊天记录
  setHistoryList(String key, List value, {isSearch}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('-------------保存数据----------------');
      // 把传入的数据转为字符串
      var result = await prefs.setString(key, jsonEncode(value));
      print('查看数据存储本地的结果：${result}');
    } catch (e) {
      print(e);
    }
  }

  Future getHistoryList(key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('-------------获取数据----------------');
      String result = await prefs.getString(key) as String;
      print('本地存储获取到的数据：${result}');
      return jsonDecode(result);
    } catch (e) {
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
