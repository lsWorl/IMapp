import 'package:flutter/material.dart';
import 'package:imapp/view/indexChildren/chatList_view.dart';
import 'package:imapp/view/indexChildren/contacts_view.dart';
import 'package:imapp/view/indexChildren/discover_view.dart';
import 'package:imapp/view/indexChildren/my_center_view.dart';

import '../viewmodel/index_viewmodel.dart';
// import 'indexChildren/contacts_view.dart';

// 首页入口
class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  IndexViewModelData data = new IndexViewModelData();
  List<Widget> widgets = [
    ChatListView(),
    ContactsListView(),
    DiscoverView(),
    MyCenterView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      body: widgets[data.index],
    );
  }

  BottomNavigationBar BottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: '聊天'),
        BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: '联系人'),
        BottomNavigationBarItem(icon: Icon(Icons.camera), label: '发现'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
      ],
      currentIndex: data.index,
      onTap: (value) {
        setState(() {
          data.index = value;
        });
      },
    );
  }
}
