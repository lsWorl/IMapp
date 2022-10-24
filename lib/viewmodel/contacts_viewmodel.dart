import 'package:flutter/cupertino.dart';
import 'package:imapp/utils/public_storage.dart';

/**
   * 数据层
   * Data
   */
class ContactsViewModel extends ChangeNotifier {
  // 好友列表
  List _friendsList = [];

  //判断是否在聊天界面
  bool _isContact = false;

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

  void setfriendsList(List value) {
    _friendsList = value;
    // 更新后通知
    notifyListeners();
  }

  List get friendsList {
    return _friendsList;
  }

  // 添加消息
  void addMsg(String content, bool isSelf, String roomKey) {
    // 通过房间来实现存储到一个相同位置
    PublicStorage publicStorage = new PublicStorage();
    _friendsContactContent.add({'msg': content, 'isSender': isSelf});
    publicStorage.setHistoryList(roomKey, _friendsContactContent);
    notifyListeners();
  }

  // 用于显示用户最后发的信息
  void addLastMsg(String content, String roomKey) {
    for (var element in _friendsList) {
      if (element['room_key'] == roomKey) {
        element['last_msg'] = content;
        // 如果正在聊天则不会显示未读消息
        if (_isContact) return;
        element['msg_num']++;
        notifyListeners();
      }
    }
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
  void cleanUnRead(int userId) {
    for (var element in _friendsList) {
      if (element['contact_id'] == userId && element['msg_num'] != 0) {
        element['msg_num'] = 0;
      }
    }
  }

  // 改变聊天状态
  void changeContactState(bool isContact) {
    _isContact = isContact;
  }

  List get friendsContactContent {
    return _friendsContactContent;
  }
}
