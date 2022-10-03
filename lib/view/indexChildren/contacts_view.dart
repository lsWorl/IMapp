import 'package:flutter/material.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';

class ContactsListView extends StatelessWidget {
  const ContactsListView({super.key});

  @override
  Widget build(BuildContext context) {
    ContactsViewModel data = ContactsViewModel();
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
                commonList(Icons.people_alt_rounded, '添加新好友'),
                commonList(Icons.chat_bubble, '加入群聊')
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
                return Expanded(
                    child: ListView.builder(
                  itemCount: value.friendsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('点击${index}');
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          value.friendsList[index]['img']))),
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              value.friendsList[index]['name'],
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  GestureDetector commonList(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        print('点击');
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