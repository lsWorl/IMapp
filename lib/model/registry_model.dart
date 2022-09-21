import 'package:imapp/http/request.dart';

class RegistryModel {
  Request http = Request();
  Future sendUserInfo(String phone, String pwd, String validCode) {
    return http.post('/users/registry',
        params: {'phone': phone, 'password': pwd, 'validCode': validCode});
  }
}
