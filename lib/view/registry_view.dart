import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imapp/utils/reg.dart';

import '../component/show_valid_code.dart';
import '../http/api.dart';
import '../model/registry_model.dart';
import '../viewmodel/registry_viewmodel.dart';

class RegistryView extends StatefulWidget {
  const RegistryView({super.key});

  @override
  State<RegistryView> createState() => _RegistryViewState();
}

class _RegistryViewState extends State<RegistryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [registryWidget(), registryText(), accountInput()]),
      ),
    );
  }
}

// logo
class registryWidget extends StatelessWidget {
  const registryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 40),
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
class registryText extends StatelessWidget {
  const registryText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, top: 40),
      child: const Align(
        alignment: Alignment(-1, 0),
        child: Text(
          '注册',
          style: TextStyle(fontSize: 40, fontFamily: '宋体'),
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
  // 唯一标识
  final _formKey = GlobalKey<FormState>();
  RegistryViewModelData data = new RegistryViewModelData();
  @override
  Widget build(BuildContext context) {
    RegistryModel sendData = new RegistryModel();
    // 公用api
    ReqApi api = new ReqApi();
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
                // 限制输入为数字
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                style: const TextStyle(fontSize: 20),
                keyboardType: TextInputType.number,
                maxLength: 11,
                autofocus: true,
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
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  // 验证
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '输入内容不能为空！';
                    } else if (value != data.confirmPwd) {
                      return '两次输入的密码不一致！';
                    } else if (value.length < 6) {
                      return '请输入6位以上的密码！';
                    }
                  },
                  style: const TextStyle(fontSize: 20),
                  maxLength: 20,
                  obscureText: data.isShowPwd,

                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '请输入6-20位密码',
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
                      print(data.pwd);
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  // 验证
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '输入内容不能为空！';
                    } else if (value != data.pwd) {
                      return '两次输入的密码不一致！';
                    } else if (value.length < 6) {
                      return '请输入6位以上的密码！';
                    }
                  },
                  style: const TextStyle(fontSize: 20),
                  maxLength: 20,
                  obscureText: data.isShowConfirmPwd,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '请输入6-20位确认密码',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            data.isShowConfirmPwd = !data.isShowConfirmPwd;
                          });
                        },
                        icon: Icon(data.isShowConfirmPwd
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: Theme.of(context).primaryColorDark,
                      )),
                  onChanged: (value) {
                    data.confirmPwd = value;

                    print(data.confirmPwd);
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
                padding: const EdgeInsets.only(top: 50),
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
                            print(value);
                            result = json.decode(value.toString());
                          });
                          if (result['ok'] == 1) {
                            showAlertMsg(context, '注册成功！请点击确定按钮跳转到登录界面进行登录！');
                          } else if (result['ok'] == 2) {
                            showAlertMsg(context, '验证码错误');
                            print('验证码错误');
                          } else if (result['ok'] == 3) {
                            showAlertMsg(context, '手机号已存在!');
                            print('手机号已存在');
                          }
                        }
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(200, 60))),
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
