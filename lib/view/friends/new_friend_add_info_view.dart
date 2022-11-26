import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imapp/convert/userContacts/user_contacts.dart';
import 'package:imapp/model/contacts_model.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:provider/provider.dart';

class NewFriendAddInfoView extends StatelessWidget {
  NewFriendAddInfoView({super.key, required this.arguments});
  final Map<String, dynamic> arguments;
  // 输入框控制器
  final TextEditingController _controller = TextEditingController();
  // 发送请求
  final ContactsModel contactsModel = ContactsModel();
  // 获取当前正文
  late BuildContext _context;
  // 获取当前想添加用户的id
  late int contactId;
  @override
  Widget build(BuildContext context) {
    // 用户焦点
    FocusNode userFocusNode = FocusNode();
    UserContacts userContacts = UserContacts.fromJson(arguments);
    _context = context;
    contactId = userContacts.contact_id!;
    // print(userContacts.avatar);
    return Scaffold(
      appBar: AppBar(
        title: const Text('发送好友请求'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击其他地方就取消焦点
          userFocusNode.unfocus();
        },
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    color: Colors.blueAccent,
                  ),
                  Positioned(
                      top: 140,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white12,
                                  offset: Offset(1.0, -6), //阴影y轴偏移量
                                  blurRadius: 2, //阴影模糊程度
                                  spreadRadius: 0 //阴影扩散程度
                                  )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                      )),
                  Positioned(
                    top: 50,
                    left: 50,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              border: Border.all(color: Colors.white, width: 4),
                              image: DecorationImage(
                                  image: NetworkImage(userContacts.avatar)))),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  userContacts.name,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      focusNode: userFocusNode,
                      controller: _controller,
                      maxLines: 10,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        hintText: '请输入些介绍信息吧~',
                        hintStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: ElevatedButton(
                      onPressed: _sendFriendReq,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 140.0, vertical: 12.0)),
                      ),
                      child: const Text(
                        '确认添加好友',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 227, 227, 227)),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  _sendFriendReq() async {
    // 获取当前用户id
    int currentUserId =
        Provider.of<UserProvider>(_context, listen: false).userInfo['id'];
    late Map<String, dynamic> result;
    await contactsModel
        .addFriends(currentUserId, contactId, _controller.text)
        .then((value) {
      result = json.decode(value.toString());
    });
    print(result);
    if (result['code'] == 200) {
      Fluttertoast.showToast(
          msg: '成功发送好友请求！',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          fontSize: 20);
    }
    print('发送加好友请求');
  }
}
