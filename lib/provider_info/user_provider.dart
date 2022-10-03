import 'package:flutter/foundation.dart';

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
}
