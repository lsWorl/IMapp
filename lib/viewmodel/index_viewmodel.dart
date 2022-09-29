import 'package:flutter/cupertino.dart';

/**
   * 数据层
   * Data
   */
class IndexViewModelData extends ChangeNotifier {
  // 索引值，判断处于的页面
  int _index = 0;

  set index(var value) {
    _index = value;
    // 更新后通知
    notifyListeners();
  }

  int get index {
    return _index;
  }
}
