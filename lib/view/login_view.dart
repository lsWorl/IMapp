import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    // 视图层
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [logoWidget(), loginText(), subTitle(), accountInput()],
      ),
    );
  }
}

// logo
class logoWidget extends StatelessWidget {
  const logoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 100),
        child: Center(child: Image.asset('assets/images/logo.png')));
  }
}

// title
class loginText extends StatelessWidget {
  const loginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, top: 40),
      child: const Align(
        alignment: Alignment(-1, 0),
        child: Text(
          '登录',
          style: TextStyle(fontSize: 40, fontFamily: '宋体'),
        ),
      ),
    );
  }
}

// subtitle
class subTitle extends StatelessWidget {
  const subTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50),
      child: const Align(
        alignment: Alignment(-1, 0),
        child: Text(
          '欢迎来到我的app！',
          style: TextStyle(fontSize: 24, fontFamily: '宋体', color: Colors.grey),
        ),
      ),
    );
  }
}

// input 输入框
class accountInput extends StatefulWidget {
  const accountInput({super.key});

  @override
  State<accountInput> createState() => _accountInputState();
}

class _accountInputState extends State<accountInput> {
  @override
  Widget build(BuildContext context) {
    var account = '';
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
      child: Column(
        children: [
          const TextField(
            style: TextStyle(fontSize: 20),
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: '请输入账号'),
          ),
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: const TextField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: '请输入密码'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 80, right: 80, top: 40),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('登录'),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(100, 50))),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('注册'),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(100, 50))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
