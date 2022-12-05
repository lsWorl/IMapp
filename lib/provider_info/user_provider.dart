import 'package:flutter/foundation.dart';
import 'package:imapp/convert/user/user.dart';

class UserProvider with ChangeNotifier {
  // 用户的信息
  late Map _userInfo;

  set userInfo(var value) {
    _userInfo = value;
    // 更新后通知
    notifyListeners();
  }

  get userInfo {
    return _userInfo;
  }

  // 修改头像
  modifyAvatar(String avatar) {
    _userInfo['avatar'] = avatar;
    // 更新后通知
    notifyListeners();
  }
}
