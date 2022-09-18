class RegConfirm {
  // 验证是否为手机
  static bool isPhone(int phone) {
    if (phone == null) return false;
    String regPhone = '0?(13|14|15|18|17)[0-9]{9}';
    return new RegExp(regPhone).hasMatch(phone.toString());
  }
}
