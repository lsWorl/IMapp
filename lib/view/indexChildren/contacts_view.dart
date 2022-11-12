import 'package:flutter/material.dart';
import 'package:imapp/convert/userContacts/user_contacts.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';

class ContactsListView extends StatelessWidget {
  const ContactsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('联系人'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.grey,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // 通用功能列表
            Column(
              children: [
                commonList(Icons.people_alt_rounded, '添加新好友', context),
                commonList(Icons.chat_bubble, '加入群聊', context)
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              color: const Color.fromARGB(255, 205, 205, 205),
              width: double.infinity,
              height: 40,
              child: const Text(
                '好友',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Consumer<ContactsViewModel>(
              builder: (context, value, child) {
                return value.friendsList.isEmpty
                    ? const Center(
                        heightFactor: 2,
                        child: Text('目前无好友，请去添加好友...',
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      )
                    : Expanded(
                        child: ListView.builder(
                        itemCount: value.friendsList.length,
                        itemBuilder: (context, index) {
                          // 序列化好友
                          var userContacts =
                              UserContacts.fromJson(value.friendsList[index]);
                          // 判断是否是好友
                          return userContacts.is_out == '1'
                              ? GestureDetector(
                                  onTap: () {
                                    print("点击${userContacts.contact_id}");
                                    Navigator.of(context).pushNamed(
                                        'friendInfoView',
                                        arguments: {
                                          "info": userContacts.toJson(),
                                          "isFriend": true
                                        });
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
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      userContacts.avatar))),
                                          height: 50,
                                          width: 50,
                                        ),
                                        Text(
                                          userContacts.name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container();
                        },
                      ));
              },
            )
          ],
        ),
      ),
    );
  }

  GestureDetector commonList(IconData icon, String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('addFriendView');
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.orange,
              ),
              height: 50,
              width: 50,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
