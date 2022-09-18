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
}
