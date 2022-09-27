import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:imapp/component/chat_input.dart';

class ChatContentView extends StatefulWidget {
  ChatContentView({super.key, this.arguments});
  Map? arguments;
  @override
  State<ChatContentView> createState() => _ChatContentViewState();
}

class _ChatContentViewState extends State<ChatContentView> {
  Map? params;
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
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
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
      setState(() {
        messageList.add({'msg': value, 'isSender': true});
      });
    }
  }
}
