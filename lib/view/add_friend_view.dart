import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imapp/model/search_model.dart';

class AddFriendView extends StatefulWidget {
  const AddFriendView({super.key});

  @override
  State<AddFriendView> createState() => _AddFriendViewState();
}

class _AddFriendViewState extends State<AddFriendView> {
  final TextEditingController _controller = TextEditingController();
  Search search = Search();
  Map<String, dynamic> searchResult = {};
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
                            onPressed: () async {
                              int text = int.parse(_controller.text);
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
                                Map<String, dynamic> result =
                                    json.decode(value.toString());
                                print(result);
                                if (result['code'] == 200) {
                                  setState(() {
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
                            },
                            icon: Icon(Icons.search))
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
                  onTap: () {
                    print("点击");
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
                )
        ],
      ),
    );
  }
}
