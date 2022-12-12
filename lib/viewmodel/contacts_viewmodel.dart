import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:imapp/convert/userContacts/user_contacts.dart';
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

  //记录聊天相差时间
  DateTime _timeDifferent = DateTime(2017, 9, 7, 17, 30);

  // 修改是否同为好友状态
  void stateHandler(int index) {
    _friendsList[index]['is_out'] = '1';
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

  // 设置聊天时间
  void setCommunicationTime(DateTime time, String roomKey) {
    print('设置时间');
    // 通过房间来实现存储到一个相同位置
    PublicStorage publicStorage = new PublicStorage();
    _friendsContactContent.add({'msg': time.toString()});
    print(_friendsContactContent);
    // 将数据存储到本地
    publicStorage.setHistoryList(roomKey, _friendsContactContent);
    notifyListeners();
  }

  // 添加消息
  void addMsg(dynamic content, bool isSelf, String roomKey) {
    // 通过房间来实现存储到一个相同位置
    PublicStorage publicStorage = new PublicStorage();
    _friendsContactContent.add({'msg': content, 'isSender': isSelf});
    print('添加消息');
    // 将数据存储到本地
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

  // 获取最近一次聊天时间
  DateTime get timeDifferent {
    return _timeDifferent;
  }

  set timeDifferent(DateTime time) {
    _timeDifferent = time;
    notifyListeners();
  }
}
