import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:imapp/utils/Reg.dart';

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
      body: Column(
        children: [registryWidget(), registryText(), accountInput()],
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
        child: Center(child: Image.asset('assets/images/logo.png')));
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
  @override
  Widget build(BuildContext context) {
    late int _account;
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: '请输入密码'),
                ),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: '确认密码'),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
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
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(100, 60))),
                        child: const Text('获取验证码'))
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('通过了验证');
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
