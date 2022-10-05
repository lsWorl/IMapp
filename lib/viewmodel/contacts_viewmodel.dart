import 'package:flutter/cupertino.dart';
import 'package:imapp/utils/public_storage.dart';

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
      "id": "1",
      "lastMsg": "",
      "msgNum": 0
    },
    {
      "img":
          "https://tse1-mm.cn.bing.net/th/id/OIP-C._xbmyprGLEovhHf79ojIawHaHa?pid=ImgDet&rs=1",
      "name": "李四",
      "id": "2",
      "lastMsg": "",
      "msgNum": 0
    }
  ];

  // 与好友聊天信息
  List _friendsContactContent = [];

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
    // 更新后通知
    notifyListeners();
  }

  List get friendsList {
    return _friendsList;
  }

  // 添加消息
  void addMsg(String content, bool isSelf, String userId) {
    PublicStorage publicStorage = new PublicStorage();
    _friendsContactContent.add({'msg': content, 'isSender': isSelf});
    publicStorage.setHistoryList(userId, _friendsContactContent);
    notifyListeners();
  }

  // 用于显示用户最后发的信息
  void addLastMsg(String content, String userId) {
    _friendsList.forEach((element) {
      if (element['id'] == userId) {
        element['lastMsg'] = content;
        element['msgNum']++;
        notifyListeners();
      }
    });
  }

  // 获取本地消息后替换
  void replaceMsgContent(List content) {
    _friendsContactContent = content;
    notifyListeners();
  }

  // 清空聊天信息
  void cleanMsg() {
    _friendsContactContent = [];
    notifyListeners();
  }

  // 清空未读消息提示
  void cleanUnRead(String userId) {
    _friendsList.forEach((element) {
      if (element['id'] == userId) {
        element['msgNum'] = 0;
      }
    });
  }

  List get friendsContactContent {
    return _friendsContactContent;
  }
}
