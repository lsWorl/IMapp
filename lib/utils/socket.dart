import 'dart:async';
import 'dart:io';

import 'package:imapp/provider_info/socket_provider.dart';
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
  Map getMsg = {};
  connect(context) async {
    // 获取token
    // token = await publicStorage.getHistoryList('token');
    print('当前网络状态：${netWorkStatus}');

    // 建立连接
    socket = await IO.io('ws://169.254.226.185:3001', <String, dynamic>{
      'transports': ['websocket'],
    });

    // 连接成功
    socket.on('connect', (data) {
      print('connect...');
      // 接收服务端发来的socket.id
      socket.emit('userId', '1');

      // 将socket挂载到全局
      Provider.of<SocketProvider>(context, listen: false).socket = socket;
      // 保存socketid
      Provider.of<SocketProvider>(context, listen: false).socketId = socket.id;
    });

    // 断开连接
    socket.on('disconnect', (data) {
      print('disconnect...');
    });
  }

  // 发送给客户端数据
  Map sendMsg(context, Map sendMsg) {
    // print(socket);

    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .emit('sendMsg', sendMsg);

    Provider.of<SocketProvider>(context, listen: false).socket.on('receiveMsg',
        (data) {
      print('接收到的数据' + data.toString());

      getMsg = data;
    });
    print('发送');
    return getMsg;
  }

  sendPrivateMsg(context, Map sendMsg) {
    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .emit('private message', sendMsg);
    print('成功发送了消息！');
  }

  receivePrivateMsg(context) {
    print('接收消息,id：' +
        Provider.of<SocketProvider>(context, listen: false).socketId);

    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .on('private message', (data) {
      print('私发接收到的data消息：${data}');
    });
  }
}
