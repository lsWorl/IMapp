import 'package:imapp/http/request.dart';

// 有两个以上页面公用的接口
class ReqApi {
  Request http = Request();

  //获取验证码
  Future GetValidCode() async {
    return await http.get('/users/validCode');
  }
}
