import 'package:flutter/material.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:provider/provider.dart';

// 图片按钮
class ImageButton extends StatelessWidget {
  const ImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    String avatar = Provider.of<UserProvider>(context).userInfo['avatar'];
    return TextButton(
        // 去除水波纹
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        })),
        onPressed: () {
          // 点击后打开弹窗
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(80)),
              image: DecorationImage(image: NetworkImage(avatar))),
        ));
  }
}
