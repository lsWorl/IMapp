import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imapp/component/show_valid_code.dart';
import 'package:imapp/http/api.dart';
import 'package:imapp/model/contacts_model.dart';
import 'package:imapp/model/login_model.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:provider/provider.dart';

import '../utils/reg.dart';
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
      body: SingleChildScrollView(
          child: Column(
        children: const [LogoWidget(), LoginText(), SubTitle(), AccountInput()],
      )),
    );
  }
}

// logo
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

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
class LoginText extends StatelessWidget {
  const LoginText({super.key});

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
class SubTitle extends StatelessWidget {
  const SubTitle({super.key});

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
class AccountInput extends StatefulWidget {
  const AccountInput({super.key});

  @override
  State<AccountInput> createState() => _AccountInputState();
}

class _AccountInputState extends State<AccountInput> {
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
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
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
                      });
                    },
                  ))
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  // 验证
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '输入内容不能为空！';
                    }
                  },
                  style: const TextStyle(fontSize: 20),
                  maxLength: 20,
                  obscureText: data.isShowPwd,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '请输入密码',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            data.isShowPwd = !data.isShowPwd;
                          });
                        },
                        icon: Icon(data.isShowPwd
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: Theme.of(context).primaryColorDark,
                      )),
                  onChanged: (value) {
                    setState(() {
                      data.pwd = value;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                      },
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
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
                              minimumSize: MaterialStateProperty.all(
                                  const Size(100, 60))),
                          child: const Text('获取验证码')),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.only(top: 20),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: _loginPressed,
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
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _loginPressed() async {
    if (_formKey.currentState!.validate()) {
      late Map<String, dynamic> result;
      await sendData
          .sendUserInfo(data.account, data.pwd, data.validCode)
          .then((value) {
        result = json.decode(value.toString());
      });
      print(result);
      if (result['ok'] == 1) {
        if (!mounted) return;
        // 设置用户信息
        Provider.of<UserProvider>(context, listen: false).userInfo =
            result['data'];

        // 设置用户联系人信息
        ContactsModel contactsModel = new ContactsModel();
        late Map<String, dynamic> contactsResult;

        // 获取联系人
        await contactsModel
            .getContactsInfo(Provider.of<UserProvider>(context, listen: false)
                .userInfo['id'])
            .then((value) {
          print('------------联系人数据----------');
          contactsResult = json.decode(value.toString());
          if (contactsResult['ok'] == 1) {
            // print(contactsResult['data']);
            Provider.of<ContactsViewModel>(context, listen: false)
                .setfriendsList(contactsResult['data']);
          }
        });

        // 跳转后并销毁路由
        if (!mounted) return;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('index', (router) => false);
      } else if (result['ok'] == 2) {
        if (!mounted) return;
        showAlertMsg(context, '验证码错误');
      } else if (result['ok'] == 3) {
        if (!mounted) return;
        showAlertMsg(context, '账号或密码错误！');
      } else if (result['ok'] == 4) {
        if (!mounted) return;
        showAlertMsg(context, '用户已经登录！');
      } else {
        if (!mounted) return;
        showAlertMsg(context, '服务器繁忙中，请稍后再试...');
      }
    }
  }
}
