import 'package:imapp/http/request.dart';

class LoginModel {
  Request http = Request();
  Future sendUserInfo(String phone, String pwd, String validCode) {
    return http.post('/users/login',
        params: {'phone': phone, 'password': pwd, 'validCode': validCode});
  }
}
