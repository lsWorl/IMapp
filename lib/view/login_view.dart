import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imapp/component/ShowValidCode.dart';
import 'package:imapp/http/api.dart';
import 'package:imapp/model/login_model.dart';

import '../utils/Reg.dart';
import '../viewmodel/login_viewmodel.dart';

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
        children: [
          const logoWidget(),
          const loginText(),
          const subTitle(),
          const accountInput()
        ],
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
        child: Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(80)),
              image:
                  DecorationImage(image: AssetImage('assets/images/logo.png'))),
        ));
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
  LoginViewModelData data = new LoginViewModelData();
  LoginModel sendData = new LoginModel();
  // 公用api
  ReqApi api = new ReqApi();
  // 唯一标识
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
          child: Column(
            children: [
              TextFormField(
                // 验证
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '输入内容不能为空！';
                  }
                  if (!RegConfirm.isPhone(int.parse(value))) {
                    return '输入必须为手机号！';
                  }
                },
                style: const TextStyle(fontSize: 20),
                maxLength: 11,
                keyboardType: TextInputType.phone,
                autofocus: true,
                // 限制输入为数字
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: '请输入手机号'),
                onChanged: (value) {
                  setState(() {
                    data.account = value;
                    print(data.account);
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: TextFormField(
                  // 验证
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '输入内容不能为空！';
                    }
                  },
                  style: const TextStyle(fontSize: 20),
                  maxLength: 20,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: '请输入密码'),
                  onChanged: (value) {
                    setState(() {
                      data.pwd = value;
                      print(data.pwd);
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      width: 230,
                      child: TextFormField(
                        // 验证
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '输入内容不能为空！';
                          }
                        },
                        maxLength: 6,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: '请输入验证码'),
                        onChanged: (value) {
                          data.validCode = value;
                          print(data.validCode);
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          api.GetValidCode().then((value) {
                            Map<String, dynamic> result =
                                json.decode(value.toString());

                            if (result['ok'] == 1) {
                              data.validCode = result['data']['validCode'];
                            }
                            print(data.validCode);
                            showAlertMsg(context, data.validCode);
                          });
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(100, 60))),
                        child: const Text('获取验证码'))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 40),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          late Map<String, dynamic> result;
                          await sendData
                              .sendUserInfo(
                                  data.account, data.pwd, data.validCode)
                              .then((value) {
                            result = json.decode(value.toString());
                          });
                          print(result);
                          if (result['ok'] == 1) {
                            // 跳转后并销毁路由
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                'index', (router) => router == null);
                          } else if (result['ok'] == 2) {
                            showAlertMsg(context, '验证码错误');
                          } else if (result['ok'] == 3) {
                            showAlertMsg(context, '账号或密码错误！');
                          }
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(100, 50))),
                      child: const Text('登录'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('registry');
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(100, 50))),
                      child: const Text('注册'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
