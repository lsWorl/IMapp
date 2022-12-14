import 'package:imapp/http/request.dart';

class LoginModel {
  Request http = Request();
  // 登录
  Future sendUserInfo(String phone, String pwd, String validCode) {
    return http.post('/users/login',
        params: {'phone': phone, 'password': pwd, 'validCode': validCode});
  }

  // 登出
  Future logOutUser(int id) {
    return http.get('/users/logOut', params: {'id': id});
  }

  // 修改密码
  Future modifyPassword(int id, String password) {
    return http
        .post('/users/modifyPwd', params: {'id': id, 'password': password});
  }
}
