/**
   * 数据层
   * Data
   */
class IndexViewModelData {
  // 索引值，判断处于的页面
  int _index = 0;

  set index(var value) {
    _index = value;
  }

  int get index {
    return _index;
  }
}
