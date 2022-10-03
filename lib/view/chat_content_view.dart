import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:imapp/component/chat_input.dart';
import 'package:imapp/provider_info/socket_provider.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/utils/socket.dart';
import 'package:provider/provider.dart';

class ChatContentView extends StatefulWidget {
  ChatContentView({super.key, this.arguments});
  Map? arguments;
  @override
  State<ChatContentView> createState() => _ChatContentViewState();
}

class _ChatContentViewState extends State<ChatContentView> {
  Map? params;
  ClientSocket clientSocket = new ClientSocket();
  // 对话内容
  List messageList = [
    {
      "msg": 'Hello world',
      "isSender": false,
    },
    {
      "msg": 'yeap',
      "isSender": true,
    },
  ];
  @override
  void initState() {
    params = widget.arguments;

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
          Expanded(
              child: ListView.builder(
            // 数量
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: BubbleNormal(
                  text: messageList[index]['msg'],
                  isSender: messageList[index]['isSender'],
                  color: messageList[index]['isSender']
                      ? const Color(0xFF1B97F3)
                      : const Color(0xFFE8E8EE),
                  tail: true,
                ),
              );
            },
          )),
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
      clientSocket.sendPrivateMsg(
          context, {'name': '名字', 'sendId': id, 'to': '2', 'content': value});

      Provider.of<SocketProvider>(context, listen: false)
          .socket
          .on('private message', (data) {
        print('私发接收到的data消息：${data}');
        setState(() {
          messageList.add({
            'msg': data['content'],
            'isSender': data['from'] ==
                    Provider.of<SocketProvider>(context, listen: false).socketId
                ? true
                : false
          });
        });
      });

      setState(() {
        messageList.add({'msg': value, 'isSender': true});
      });
    }
  }
}
