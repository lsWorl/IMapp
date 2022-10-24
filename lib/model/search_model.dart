import 'package:imapp/http/request.dart';
import 'package:imapp/utils/reg.dart';

class Search {
  Request http = Request();
  // 传入id或手机号进行查找
  Future searchUser(int search) {
    //验证输入的是手机号还是id
    bool isPhone = RegConfirm.isPhone(search);
    if (isPhone) {
      return http.get('/users/searchPhone', params: {"phone": search});
    } else {
      return http.get('/users/searchId', params: {"id": search});
    }
  }
}
