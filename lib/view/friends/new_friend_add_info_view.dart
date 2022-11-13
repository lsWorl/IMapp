import 'package:flutter/material.dart';
import 'package:imapp/convert/userContacts/user_contacts.dart';

class NewFriendAddInfoView extends StatelessWidget {
  const NewFriendAddInfoView({super.key, required this.arguments});
  final Map<String, dynamic> arguments;
  @override
  Widget build(BuildContext context) {
    UserContacts userContacts = UserContacts.fromJson(arguments);
    print(userContacts.avatar);
    return Scaffold(
      appBar: AppBar(
        title: const Text('发送好友请求'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
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
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              alignment: Alignment.topLeft,
              child: Text(
                userContacts.name,
                style: TextStyle(fontSize: 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}
