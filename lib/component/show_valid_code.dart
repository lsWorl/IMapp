// 弹窗显示验证码
import 'package:flutter/material.dart';

void showAlertMsg(BuildContext context, String text) async {
  String showText = '验证码';
  // 判断输入的是验证码还是其他文字
  if (text.length != 6) {
    showText = '错误信息';
  }
  var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(showText),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                // 判断是否是注册成功
                if (text == '注册成功！请点击确定按钮跳转到登录界面进行登录！') {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'login', (router) => router == null);
                } else {
                  Navigator.of(context).pop(true);
                }
              },
              child: const Text('确认'),
            ),
          ],
        );
      });

  print(result);
}
