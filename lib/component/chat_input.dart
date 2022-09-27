import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  // 传入一个要发送的消息
  final Function sendMessage;
  const ChatInput({super.key, required this.sendMessage});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool _emojiShowing = false;
  final TextEditingController _controller = TextEditingController();

  _onEmojiSelected(Emoji emoji) {
    print('拼接中...');

    // 拼接emoji和文字
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    print('删除emoji');
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                // 设置阴影
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          color: Colors.grey)
                    ]),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _emojiShowing = !_emojiShowing;
                          });
                        },
                        highlightColor: Colors.transparent, // 透明色
                        splashColor: Colors.transparent, // 透明色
                        icon: const Icon(
                          Icons.face,
                          color: Colors.blue,
                        )),
                    Expanded(
                        child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                          hintText: '请输入消息...',
                          hintStyle: TextStyle(color: Colors.blue),
                          border: InputBorder.none),
                    )),
                    sendButton(),
                  ],
                ),
              ))
            ],
          ),
        ),
        // 弹出emoji
        Visibility(
          visible: _emojiShowing,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 80),
            height: _emojiShowing ? 250 : 0,
            child: emojiDisplay(),
          ),
        ),
      ],
    );
  }

  IconButton sendButton() {
    return IconButton(
      onPressed: () {
        // 输入不为空则发送
        if (_controller.text != '') {
          widget.sendMessage(_controller.text);
          setState(() {
            _controller.text = '';
          });
        }
      },
      icon: const Icon(Icons.send),
      color: Colors.blue,
      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent, // 透明色
    );
  }

  Widget emojiDisplay() {
    return SizedBox(
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          _onEmojiSelected(emoji);
        },
        onBackspacePressed: _onBackspacePressed,
        config: Config(
            columns: 10,
            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            initCategory: Category.RECENT,
            bgColor: const Color(0xFFF2F2F2),
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            progressIndicatorColor: Colors.blue,
            backspaceColor: Colors.blue,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            showRecentsTab: true,
            recentsLimit: 28,
            noRecents: DefaultNoRecentsWidget,
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL),
      ),
    );
  }
}
