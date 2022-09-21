import 'package:flutter/material.dart';

// 图片按钮
class ImageButton extends StatelessWidget {
  const ImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // 点击后打开弹窗
        Scaffold.of(context).openDrawer();
      },
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(80)),
              image: DecorationImage(
                  image: AssetImage('assets/images/logo.png')))),
    );
  }
}
