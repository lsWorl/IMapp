import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:imapp/component/chat_input.dart';
import 'package:imapp/provider_info/socket_provider.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/utils/socket.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    params = widget.arguments;
    print(Provider.of<SocketProvider>(context, listen: false).socket.ids);
    print(Provider.of<SocketProvider>(context, listen: false)
        .socket
        .receiveBuffer);

    Provider.of<SocketProvider>(context, listen: false)
        .socket
        .on('private message', (data) {
      print('私发接收到的data消息：${data}');
      // Provider.of<ContactsViewModel>(context, listen: false)
      //     .addMsg(data['content'], false);
    });
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

  _sendMessage(String value) {
    if (value != '') {
      String id = Provider.of<UserProvider>(context, listen: false)
          .userInfo['id']
          .toString();

      // 发送消息给后端
      clientSocket.sendPrivateMsg(
          context, {'name': '名字', 'sendId': id, 'to': '2', 'content': value});

      Provider.of<ContactsViewModel>(context, listen: false)
          .addMsg(value, true);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
