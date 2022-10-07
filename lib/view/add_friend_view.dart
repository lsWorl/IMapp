import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddFriendView extends StatelessWidget {
  const AddFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加新好友'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.grey,
      ),
      body: Container(
        child: Column(
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
                              onPressed: () {
                                print(_controller.text);
                              },
                              icon: Icon(Icons.search))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
