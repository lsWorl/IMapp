import 'dart:io';
import 'package:flutter/foundation.dart';

class SocketProvider with ChangeNotifier {
  late Socket socket;
  // 网络状态
  String netWorkState = 'none';
  List records = [];
  // 储存socket实例
  setSocket(value) {
    this.socket = value;
    notifyListeners();
  }

  // 清除消息
  clearRecords() {}

  // 设置网络状态
  setNetWorkState(value, context) async {
    // var socket = new ClientSocket();
  }
}
