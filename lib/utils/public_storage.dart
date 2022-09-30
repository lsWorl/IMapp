// 公用的本地存储
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PublicStorage {
  // 设置聊天记录
  setHistoryList(key, value, {isSearch}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('-------------保存数据----------------');
      var result = await prefs.setStringList(key, value);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  getHistoryList(key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('-------------获取数据----------------');
      var result = await prefs.getStringList(key);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  removeHistoryList(key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('-------------删除数据----------------');
      final success = await prefs.remove(key);
    } catch (e) {
      print(e);
    }
  }
}
