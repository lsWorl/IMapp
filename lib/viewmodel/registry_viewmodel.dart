// ignore: slash_for_doc_comments
/**
   * 数据层
   * Data
   */
class RegistryViewModelData {
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
  }

  String get account {
    return _account;
  }

  set pwd(var value) {
    _pwd = value;
  }

  String get pwd {
    return _pwd;
  }

  set confirmPwd(var value) {
    _confirmPwd = value;
  }

  String get confirmPwd {
    return _confirmPwd;
  }

  set validCode(var value) {
    _validCode = value;
  }

  String get validCode {
    return _validCode;
  }

  set isShowPwd(var value) {
    _isShowPwd = value;
  }

  bool get isShowPwd {
    return _isShowPwd;
  }

  set isShowConfirmPwd(var value) {
    _isShowConfirmPwd = value;
  }

  bool get isShowConfirmPwd {
    return _isShowConfirmPwd;
  }
}
