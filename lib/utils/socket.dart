import 'dart:async';
import 'dart:io';

import 'package:imapp/socket/socket_provider.dart';
import 'package:imapp/utils/public_storage.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  late IO.Socket socket;

  connect(context) async {
    // 获取token
    // token = await publicStorage.getHistoryList('token');
    print('当前网络状态：${netWorkStatus}');

    // 建立连接
    socket = await IO.io('ws://169.254.226.185:3001', <String, dynamic>{
      'transports': ['websocket'],
    });

    // 将socket挂载到全局
    Provider.of<SocketProvider>(context, listen: false).socket = socket;
    // 连接成功
    socket.on('connect', (data) {
      print('connect...');
    });

    // 断开连接
    socket.on('disconnect', (data) {
      print('disconnect...');
    });
  }

  // 发送给客户端数据
  sendMsg(context, Map sendMsg) {
    // print(socket);
    Map getMsg = {};

    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .emit('sendMsg', sendMsg);

    Provider.of<SocketProvider>(context, listen: false).socket.on('receiveMsg',
        (data) {
      var i = 0;
      print(i);
      // print('接收到的数据' + data.toString());
      print('运行次数' + i.toString());
      i++;
      getMsg = data;
    });
    print('发送');
    // print(getMsg);
    return getMsg;
  }
}
