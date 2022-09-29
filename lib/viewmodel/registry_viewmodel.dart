// ignore: slash_for_doc_comments
import 'package:flutter/cupertino.dart';

/**
   * 数据层
   * Data
   */
class RegistryViewModelData extends ChangeNotifier {
  // 账号
  late String _account;
  // 密码
  late String _pwd;
  // 确认密码
  late String _confirmPwd;
  // 验证码
  late String _validCode;
  // 控制密码框是否显示 true为不显示
  bool _isShowPwd = true;
  bool _isShowConfirmPwd = true;

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

  set confirmPwd(var value) {
    _confirmPwd = value;
    // 更新后通知
    notifyListeners();
  }

  String get confirmPwd {
    return _confirmPwd;
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

  set isShowConfirmPwd(var value) {
    _isShowConfirmPwd = value;
    // 更新后通知
    notifyListeners();
  }

  bool get isShowConfirmPwd {
    return _isShowConfirmPwd;
  }
}
