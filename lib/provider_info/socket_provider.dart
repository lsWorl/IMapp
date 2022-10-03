import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider with ChangeNotifier {
  late IO.Socket socket;
  // 网络状态
  String netWorkState = 'none';
  List records = [];
  // socketId
  late String _socketId;
  // 储存socket实例
  setSocket(value) {
    this.socket = value;
    notifyListeners();
  }

  // 设置id
  set socketId(value) {
    _socketId = value;
  }

  get socketId {
    return _socketId;
  }

  // 清除消息
  clearRecords() {}

  // 设置网络状态
  setNetWorkState(value, context) async {
    // var socket = new ClientSocket();
  }
}
