import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:imapp/component/chat_input.dart';
import 'package:imapp/provider_info/socket_provider.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/utils/public_storage.dart';
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

  PublicStorage publicStorage = new PublicStorage();
  // 获取provider的用户信息
  late Map userInfo;

  @override
  void initState() {
    params = widget.arguments;
    userInfo = Provider.of<UserProvider>(context, listen: false).userInfo;

    // 清除未读消息提示
    Provider.of<ContactsViewModel>(context, listen: false)
        .cleanUnRead(params!['id']);

    // 设置为聊天状态
    Provider.of<ContactsViewModel>(context, listen: false)
        .changeContactState(true);

    // 获取目前聊天记录
    publicStorage.getHistoryList(params!['room_key']).then((value) {
      if (value != null) {
        Provider.of<ContactsViewModel>(context, listen: false)
            .replaceMsgContent(value);
      } else {
        Provider.of<ContactsViewModel>(context, listen: false).cleanMsg();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
                        isSender: value.friendsContactContent[index]
                            ['isSender'],
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
        ),
        onWillPop: () async {
          // 设置为聊天状态
          Provider.of<ContactsViewModel>(context, listen: false)
              .changeContactState(false);
          return true;
        });
  }

  _sendMessage(String value) async {
    if (value != '') {
      // 发送消息给后端
      clientSocket.sendPrivateMsg(context, {
        'name': userInfo['name'],
        'from': userInfo['id'],
        'to': params!['id'],
        'toSocketId':
            Provider.of<SocketProvider>(context, listen: false).socket.id,
        'content': value,
        "room_key": params!['room_key']
      });

      Provider.of<ContactsViewModel>(context, listen: false)
          .addMsg(value, true, params!['room_key']);
    }
  }
}
