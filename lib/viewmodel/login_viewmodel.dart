import 'package:imapp/model/login_model.dart';
import 'package:flutter/cupertino.dart';

/**
   * 数据层
   * Data
   */
class LoginViewModelData extends ChangeNotifier {
  // 账号
  String _account = '';
  // 密码
  String _pwd = '';
  // 验证码
  String _validCode = '';
  // 控制密码框是否显示 true为不显示
  bool _isShowPwd = true;

  set account(var value) {
    _account = value;
    // 更新后通知
    notifyListeners();
  }

  String get account {
    return _account;
  }

  set pwd(var value) {
    _pwd = value;
    // 更新后通知
    notifyListeners();
  }

  String get pwd {
    return _pwd;
  }

  set validCode(var value) {
    _validCode = value;
    // 更新后通知
    notifyListeners();
  }

  String get validCode {
    return _validCode;
  }

  set isShowPwd(var value) {
    _isShowPwd = value;
    // 更新后通知
    notifyListeners();
  }

  bool get isShowPwd {
    return _isShowPwd;
  }
}
