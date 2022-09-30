import 'dart:async';
import 'dart:io';

import 'package:imapp/utils/public_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ClientSocket {
  var gl_sock;

  var response;

  var gl_context;

  var token;

  int commandTime = 15;

  late Timer timer;

  bool netWorkStatus = true;

  bool socketStatus = false;

  PublicStorage publicStorage = new PublicStorage();
  Connect(context) async {
    // 获取token
    // token = await publicStorage.getHistoryList('token');
    print('当前网络状态：${netWorkStatus}');
    // IO.Socket socket = IO.io('ws://169.254.226.185:3001/');
    Socket socket = io(
        'ws://169.254.226.185:3001',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.onConnectError((data) {
      print('连接失败');
      print('失败原因' + data);
    });
    socket.onConnectTimeout((data) {
      print('超时');
    });
    socket.onConnect((data) {
      print('连接中');
      socket.emit('msg', '消息');
    });
  }
}
