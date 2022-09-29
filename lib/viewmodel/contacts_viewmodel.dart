import 'package:flutter/cupertino.dart';

/**
   * 数据层
   * Data
   */
class ContactsViewModel extends ChangeNotifier {
  // 好友列表
  List _friendsList = [
    {
      "img":
          "https://pic2.zhimg.com/v2-d2aba0f0e32c3462d74bd1c801a81e79_r.jpg?source=1940ef5c",
      "name": "张三",
      "id": "1"
    },
    {
      "img":
          "https://tse1-mm.cn.bing.net/th/id/OIP-C._xbmyprGLEovhHf79ojIawHaHa?pid=ImgDet&rs=1",
      "name": "李四",
      "id": "2"
    }
  ];
  // 添加好友
  void addFriend() {
    _friendsList.add({
      "img":
          "https://tse1-mm.cn.bing.net/th/id/OIP-C._xbmyprGLEovhHf79ojIawHaHa?pid=ImgDet&rs=1",
      "name": "李四",
      "id": _friendsList.length + 1
    });
    // 更新后通知
    notifyListeners();
  }

  set friendsList(var value) {
    _friendsList = value;
  }

  List get friendsList {
    return _friendsList;
  }
}
