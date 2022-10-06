import 'package:badges/badges.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../component/image_button.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  // 存放列表
  List<Widget> listViewContent = [];
  @override
  void initState() {
    for (var i = 0;
        i <
            Provider.of<ContactsViewModel>(context, listen: false)
                .friendsList
                .length;
        i++) {
      listViewContent.add(listData(i));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.grey,
        leading: Builder(builder: (BuildContext context) {
          return const ImageButton();
        }),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
      drawer: const LeftDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
            itemCount: listViewContent.length,
            itemBuilder: (context, index) {
              return listViewContent[index];
            }),
      ),
    );
  }

  // 存放聊天列表
  Widget listData(int index) {
    return Consumer<ContactsViewModel>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'chatContent', arguments: {
              'id': value.friendsList[index]['contact_id'],
              'name': value.friendsList[index]['contact_name'],
              'room_key': value.friendsList[index]['room_key']
            });
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    value.friendsList[index]['msg_num'] == 0
                        ? avatar(value.friendsList[index]['avatar'])
                        : Badge(
                            badgeContent: Text(
                              value.friendsList[index]['msg_num'].toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            padding: const EdgeInsets.all(6.0),
                            // position: BadgePosition(end: 0, top: 0),
                            child: avatar(value.friendsList[index]['avatar']),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value.friendsList[index]['contact_name'],
                              style: const TextStyle(fontSize: 22)),
                          Text(value.friendsList[index]['last_msg'],
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  // color: Colors.red,
                  child: const Text('11:28 PM'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Card avatar(String img) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        img,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
    );
  }
}

// 左侧弹出层
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          title(context),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('个人信息'),
            onTap: () {
              print('object');
            },
          ),
          const ListTile(
            leading: Icon(Icons.message),
            title: Text('我的消息'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
          ),
        ],
      ),
    );
  }

  // 弹出层的头像展示
  DrawerHeader title(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            // 去除水波纹
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith((states) {
              return Colors.transparent;
            })),
            child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png')),
                )),
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, top: 34),
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Provider.of<UserProvider>(context, listen: false)
                        .userInfo['name'],
                    style: const TextStyle(fontSize: 24),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                      'id:${Provider.of<UserProvider>(context, listen: false).userInfo['id']}'),
                  const Text(
                    '此人很懒，还没有设置个人简介...',
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
