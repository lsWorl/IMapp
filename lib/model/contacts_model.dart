import 'package:imapp/http/request.dart';

class ContactsModel {
  Request http = Request();
  // 获取用户好友信息
  Future getContactsInfo(int userId) {
    return http.get('/userContacts', params: {"userId": userId});
  }

  // 添加好友
  Future addFriends(int userId, int contactId, String introduction,
      [String? roomKey]) {
    print('${userId},contactId:${contactId}');
    print('用户输入请求的信息：${introduction}');
    return http.post('/userContacts', params: {
      "userId": userId,
      "contactId": contactId,
      "introduction": introduction,
      "roomKey": roomKey
    });
  }
}
