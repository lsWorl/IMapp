import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatContentView extends StatefulWidget {
  ChatContentView({super.key, this.arguments});
  Map? arguments;
  @override
  State<ChatContentView> createState() => _ChatContentViewState();
}

class _ChatContentViewState extends State<ChatContentView> {
  Map? params;
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
      body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: ListView(
            children: const [
              BubbleSpecialThree(
                text: '消息内容',
                color: Color(0xFF1B97F3),
                // tail: false,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              BubbleSpecialThree(
                text: 'Sure',
                color: Color(0xFFE8E8EE),
                // tail: false,
                isSender: false,
              ),
              SizedBox(
                height: 10,
              ),
              BubbleSpecialThree(
                text: 'Sure',
                color: Color(0xFFE8E8EE),
                // tail: false,
                isSender: false,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }
}
