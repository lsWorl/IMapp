import 'package:flutter/material.dart';
import 'package:imapp/utils/rsa/index.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
        centerTitle: true,
      ),
      body: Container(
        child: ElevatedButton(onPressed: () async{
          String getCode = ''; 
          String decode = '';
          await encodeString('content').then((value) {
            getCode = value;
          });
          print('按钮后的加密数据：'+ getCode);

          await decodeString(getCode).then((value) {
            decode = value;
          });
          print('按钮后的解密数据：' + decode);

        },
        child: Text('加密'),),
      ),
    );
  }
}
