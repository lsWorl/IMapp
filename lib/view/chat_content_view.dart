import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:imapp/component/chat_input.dart';
import 'package:imapp/provider_info/socket_provider.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/utils/public_storage.dart';
import 'package:imapp/utils/socket.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatContentView extends StatefulWidget {
  ChatContentView({super.key, this.arguments});
  Map? arguments;
  @override
  State<ChatContentView> createState() => _ChatContentViewState();
}

class _ChatContentViewState extends State<ChatContentView> {
  // 获取到的参数
  Map? params;
  ClientSocket clientSocket = new ClientSocket();

  PublicStorage publicStorage = new PublicStorage();

  @override
  void initState() {
    params = widget.arguments;
    // 清除提示
    Provider.of<ContactsViewModel>(context, listen: false)
        .cleanUnRead(params!['id']);

    publicStorage.getHistoryList(params!['id']).then((value) {
      if (value != null) {
        Provider.of<ContactsViewModel>(context, listen: false)
            .replaceMsgContent(value);
      } else {
        Provider.of<ContactsViewModel>(context, listen: false).cleanMsg();
      }
    });

    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .emit('enter room', params!['id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(params!['name']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Expanded(child:
              Consumer<ContactsViewModel>(builder: (context, value, child) {
            return ListView.builder(
              // 数量
              itemCount: value.friendsContactContent.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: BubbleNormal(
                    text: value.friendsContactContent[index]['msg'],
                    isSender: value.friendsContactContent[index]['isSender'],
                    color: value.friendsContactContent[index]['isSender']
                        ? const Color(0xFF1B97F3)
                        : const Color(0xFFE8E8EE),
                    tail: true,
                  ),
                );
              },
            );
          })),
          ChatInput(sendMessage: _sendMessage)
        ],
      ),
    );
  }

  _sendMessage(String value) async {
    // 获取provider的用户信息
    Map userInfo = Provider.of<UserProvider>(context, listen: false).userInfo;
    if (value != '') {
      // 发送消息给后端
      clientSocket.sendPrivateMsg(context, {
        'name': userInfo['name'],
        'sendId': userInfo['id'].toString(),
        'to': params!['id'],
        'content': value
      });

      Provider.of<ContactsViewModel>(context, listen: false)
          .addMsg(value, true, widget.arguments!['id'].toString());
    }
  }

  @override
  void deactivate() {
    // 关闭聊天界面时将聊天数据存入本地

    super.deactivate();
  }
}
