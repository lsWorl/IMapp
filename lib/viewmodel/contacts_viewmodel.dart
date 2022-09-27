/**
   * 数据层
   * Data
   */
class ContactsViewModel {
  // 通用的列表
  List _commoList = [{}];
  // 好友列表
  List _friendsList = [];
  set commoList(var value) {
    _commoList = value;
  }

  List get commoList {
    return _commoList;
  }

  set friendsList(var value) {
    _friendsList = value;
  }

  List get friendsList {
    return _friendsList;
  }
}
