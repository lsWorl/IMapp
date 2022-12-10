import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:imapp/provider_info/socket_provider.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ClientSocket {
  bool netWorkStatus = true;

  late IO.Socket socket;

  connect(context) async {
    // 获取token
    // token = await publicStorage.getHistoryList('token');
    print('当前网络状态：${netWorkStatus}');

    // 建立连接
    // 手机测试用ip 192.168.87.67
    // 宽带测试用ip 169.254.226.185
    socket = await IO.io(
        'ws://169.254.226.185:3001',
        OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {"Content-Type": Headers.formUrlEncodedContentType}).build());

    //监听私聊消息
    socket.on('private message', (data) {
      print('监听私聊消息');
      // 添加数据到本地
      Provider.of<ContactsViewModel>(context, listen: false)
          .addMsg(data['content'], false, data['room_key']);
      // 从对方收到的最后消息
      Provider.of<ContactsViewModel>(context, listen: false)
          .addLastMsg(data['content'], data['room_key']);
    });

    // 监听图片发送信息
    socket.on('send images', (data) {
      print('接收到对方发来的图片');
      print(data['room_key']);
      print(data['image_path']);
      // 添加数据到本地
      Provider.of<ContactsViewModel>(context, listen: false)
          .addMsg(data['image_path'], false, data['room_key']);
    });
    // 监听接收图片路径
    socket.on('receive images', (data) {
      // 添加数据到本地
      Provider.of<ContactsViewModel>(context, listen: false)
          .addMsg(data['image_path'], true, data['room_key']);
    });
    // 连接成功
    socket.on('connect', (data) {
      print('connect...');
      Map userInfo = Provider.of<UserProvider>(context, listen: false).userInfo;
      // 发送给服务端用户id
      socket.emit('userInfo', {
        "userID": userInfo['id'],
        "userSocketId": socket.id,
        "userName": userInfo['name']
      });

      // 进入聊天房间
      Provider.of<ContactsViewModel>(context, listen: false)
          .friendsList
          .forEach((element) {
        socket.emit('enter room', element['room_key']);
      });

      // 将socket挂载到全局
      Provider.of<SocketProvider>(context, listen: false).socket = socket;
    });

    // 断开连接
    socket.on('disconnect', (data) {
      print('socket断开连接');
    });
  }

  // 发送给客户端数据
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

  // 发送文件给客户端
  sendFile(context, File file, String room_key) async {
    var bytes = await file.readAsBytes();
    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .emit('send images', {"image": bytes, "room_key": room_key});
  }
}
