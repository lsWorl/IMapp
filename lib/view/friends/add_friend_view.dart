import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imapp/convert/userContacts/user_contacts.dart';
import 'package:imapp/model/contacts_model.dart';
import 'package:imapp/model/search_model.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';

class AddFriendView extends StatefulWidget {
  const AddFriendView({super.key});

  @override
  State<AddFriendView> createState() => _AddFriendViewState();
}

class _AddFriendViewState extends State<AddFriendView> {
  final TextEditingController _controller = TextEditingController();
  Search search = Search();
  ContactsModel contactsModel = ContactsModel();
  // 搜索结果
  Map<String, dynamic> searchResult = {};
  // 添加好友
  // 这里可以把是否申请作为一个全局的数组来显示，这里就懒得优化了
  List<dynamic> receiveResult = [];
  // 记录是数组的第几位，后面前端修改可以减少一次循环
  Map<String, int> arrNum = {};
  @override
  void initState() {
    int count = 0;
    // print(object)
    for (var element
        in Provider.of<ContactsViewModel>(context, listen: false).friendsList) {
      // 序列化好友
      var userContacts = UserContacts.fromJson(element);
      if (userContacts.is_out == '0') {
        arrNum[userContacts.contact_id.toString()] = count;
        receiveResult.add(userContacts);
      }
      count++;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加新好友'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.grey,
      ),
      body: Column(
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
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: '请输入手机号或者用户id',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        )),
                        IconButton(
                            onPressed: _searchPressed, icon: Icon(Icons.search))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          searchResult.isEmpty
              ? Container()
              : GestureDetector(
                  onTap: _userClicked,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(searchResult['avatar']))),
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          searchResult['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              '好友请求',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Divider(),
          listData()
        ],
      ),
    );
  }

  // 存放申请好友列表
  Widget listData() {
    return Consumer<ContactsViewModel>(
        builder: ((context, contactsViewModel, child) {
      return Column(
        children: receiveResult
            .map((e) => GestureDetector(
                  onTap: () {
                    // print(e.toJson()['contact_id']);
                    _showDialog(e);
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(e.toJson()['avatar']))),
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          e.toJson()['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );
    }));
  }

  // 显示弹窗
  _showDialog(e) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('好友请求'),
            content: Text('确认要添加好友吗？'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("取消"),
              ),
              TextButton(
                  onPressed: () {
                    // 点击后确认添加好友
                    contactsModel
                        .confirmFriend(e.toJson()['user_id'],
                            e.toJson()['contact_id'], e.toJson()['room_key'])
                        .then((value) {
                      Map<String, dynamic> result =
                          json.decode(value.toString());
                      if (result['code'] == 200) {
                        print('修改成功');
                        setState(() {
                          receiveResult = [];
                        });
                        Provider.of<ContactsViewModel>(context, listen: false)
                            .stateHandler(
                                arrNum[e.toJson()['contact_id'].toString()]!);
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: "好友添加成功！",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: const Text("确定")),
            ],
          );
        });
  }

  // 点击搜索按钮
  _searchPressed() async {
    try {
      // 捕获异常，如果输入的不是数字将报错
      var text = int.parse(_controller.text);
      // ignore: unnecessary_type_check
      if (text is! int) {
        Fluttertoast.showToast(
            msg: "没有找到用户数据，请输入id或者手机号！",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _controller.text = '';
          searchResult = {};
        });
        return;
      }
      await search.searchUser(text).then((value) {
        Map<String, dynamic> result = json.decode(value.toString());
        print(result);
        if (result['code'] == 200) {
          setState(() {
            // 如果为200将用户显示出来
            searchResult = result['data'][0];
          });
        } else if (result['code'] == 406) {
          Fluttertoast.showToast(
              msg: "没有找到用户数据，请输入id或者手机号！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            _controller.text = '';
            searchResult = {};
          });
          return;
        }
      });
    } catch (e) {
      // 输出错误信息
      Fluttertoast.showToast(
          msg: '请输入数字信息！',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER);
      return;
    }
  }

  _userClicked() {
    bool isFriend = false;
    String? isOut = "0";
    // 循环判断是否为好友
    for (var element
        in Provider.of<ContactsViewModel>(context, listen: false).friendsList) {
      var userContacts = UserContacts.fromJson(element);
      if (userContacts.contact_id == searchResult['id'] &&
          userContacts.is_out == '1') {
        isFriend = true;
        isOut = userContacts.is_out;
        break;
      }
      // print(searchResult);
    }
    // 如果用户搜索到的信息是自己本人就跳到我的界面
    if (searchResult['id'] ==
        Provider.of<UserProvider>(context, listen: false).userInfo['id']) {
      Navigator.of(context).pushNamed('index');
      return;
    }
    // 补全信息后跳转
    Navigator.of(context).pushNamed('friendInfoView', arguments: {
      "info": {
        ...searchResult,
        "user_id": -1,
        "contact_id": searchResult['id'],
        "last_msg": "",
        "msg_num": 0,
        "room_key": "",
        "is_out": isOut
      },
      "isFriend": isFriend
    });
  }
}
