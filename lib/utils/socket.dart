import 'dart:async';
import 'dart:io';

import 'package:imapp/provider_info/socket_provider.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/utils/public_storage.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ClientSocket {
  bool netWorkStatus = true;

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

    //监听私聊消息
    socket.on('private message', (data) {
      print('私发接收到的data消息：${data}');
      Provider.of<ContactsViewModel>(context, listen: false)
          .addMsg(data['content'], false, data['to'].toString());
      Provider.of<ContactsViewModel>(context, listen: false)
          .addLastMsg(data['content'], data['to'].toString());
    });

    // 连接成功
    socket.on('connect', (data) {
      print('connect...');
      // 接收服务端发来的socket.id
      socket.emit(
          'userId',
          Provider.of<UserProvider>(context, listen: false)
              .userInfo['id']
              .toString());

      // 将socket挂载到全局
      Provider.of<SocketProvider>(context, listen: false).socket = socket;
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
    Provider.of<SocketProvider>(context, listen: false).socket.on('notice',
        (data) {
      print('接收到私聊消息' + data);
    });
  }

  receivePrivateMsg(context) {
    print('接收消息,id：' +
        Provider.of<SocketProvider>(context, listen: false)
            .socket
            .id
            .toString());

    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .on('private message', (data) {
      print('私发接收到的data消息：${data}');
    });
  }
}
