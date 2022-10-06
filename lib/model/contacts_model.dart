import 'package:imapp/http/request.dart';

class ContactsModel {
  Request http = Request();
  Future getContactsInfo(int userId) {
    return http.get('/userContacts', params: {"userId": userId});
  }
}
