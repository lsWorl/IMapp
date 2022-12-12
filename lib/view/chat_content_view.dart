import 'dart:convert';
import 'dart:io';

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
  const ChatContentView({super.key, this.arguments});
  final Map? arguments;

  @override
  State<ChatContentView> createState() => _ChatContentViewState();
}

class _ChatContentViewState extends State<ChatContentView> {
  // 聊天类
  ContactsViewModel _contactsViewModel = new ContactsViewModel();
  // 获取到的参数
  Map? params;
  ClientSocket clientSocket = ClientSocket();

  PublicStorage publicStorage = PublicStorage();
  // 获取provider的用户信息
  late Map userInfo;

  @override
  void initState() {
    params = widget.arguments;
    userInfo = Provider.of<UserProvider>(context, listen: false).userInfo;
    // print(params);
    // print(userInfo);
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
                    bool isImage = false;
                    bool isTime = false;
                    // print(newnow);
                    dynamic msg = value.friendsContactContent[index]['msg'];
                    // print(msg);
                    try {
                      msg = DateTime.parse(msg);
                      isTime = true;
                    } catch (e) {
                      // 判断消息是不是图片
                      if (msg is String) {
                        isImage = msg.contains('communications');
                      }
                      // print('报错');
                      // print(e);
                    }

                    // 判断是不是时间
                    // 判断是否包含图片路径或者是文件路径
                    return isImage
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              // 判断是不是自己发送的消息
                              alignment: value.friendsContactContent[index]
                                      ['isSender']
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10)),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  value.friendsContactContent[index]['msg'],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : isTime
                            ? Center(
                                child: DateChip(
                                  date: msg,
                                  color: Color(0x558AD3D5),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: BubbleNormal(
                                  text: value.friendsContactContent[index]
                                      ['msg'],
                                  isSender: value.friendsContactContent[index]
                                      ['isSender'],
                                  color: value.friendsContactContent[index]
                                          ['isSender']
                                      ? const Color(0xFF1B97F3)
                                      : const Color(0xFFE8E8EE),
                                  tail: true,
                                ),
                              );
                  },
                );
              })),
              ChatInput(
                sendMessage: _sendMessage,
                room_key: params!['room_key'],
              ),
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
      // 设置发送的当前时间 如果用户有超过30分钟没有互相发送消息或者第一次发送消息就进行添加
      final now = new DateTime.now();
      // 如果等于这个时间说明第一次开始聊天或者重新登录了
      if (_contactsViewModel.timeDifferent.toString() ==
          '2017-09-07 17:30:00.000') {
        _contactsViewModel.timeDifferent = now;
        Provider.of<ContactsViewModel>(context, listen: false)
            .setCommunicationTime(now, params!['room_key']);
      } else {
        print('添加时间');
        // 如果不是则时间相减看相差是否大于1天 大于1天就重新赋值现在时间
        if (now.difference(_contactsViewModel.timeDifferent).inDays > 0) {
          Provider.of<ContactsViewModel>(context, listen: false)
              .setCommunicationTime(now, params!['room_key']);
        }
      }
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
