import 'package:flutter/material.dart';

class MyCenterView extends StatelessWidget {
  const MyCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Text('我的'),
      ),
    );
  }
}
