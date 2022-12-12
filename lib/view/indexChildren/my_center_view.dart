import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imapp/convert/user/user.dart';
import 'package:imapp/model/login_model.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/viewmodel/index_viewmodel.dart';
import 'package:provider/provider.dart';

class MyCenterView extends StatelessWidget {
  const MyCenterView({super.key});
  @override
  Widget build(BuildContext context) {
    // 保存全局的context
    BuildContext _context = context;
    LoginModel loginModel = LoginModel();
    // 密码
    String _password = '';
    // 序列化用户
    var user = User.fromJson(Provider.of<UserProvider>(context).userInfo);

    // 显示弹窗
    _showDialog() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('退出登录'),
              content: Text('确认要退出当前账号吗？'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("取消"),
                ),
                TextButton(
                    onPressed: () {
                      loginModel.logOutUser(user.id).then((value) {
                        print(json.decode(value.toString()));
                        var result = json.decode(value.toString());
                        if (result['code'] == 200) {
                          Provider.of<IndexViewModelData>(context,
                                  listen: false)
                              .index = 0;
                          Navigator.pushNamedAndRemoveUntil(
                              _context, 'login', (route) => false);
                        }
                      });
                    },
                    child: const Text("确定")),
              ],
            );
          });
    }

    // 修改密码
    _showModifyDialog() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('修改密码'),
              content: Container(
                height: 50,
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
                          },
                          // style: const TextStyle(fontSize: 20),
                          // decoration: const InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     labelText: '请输入验证码'),
                          onChanged: (value) {
                            _password = value;
                          },
                        ))
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("取消"),
                ),
                TextButton(
                    onPressed: () {
                      // 密码不为空发送
                      if (_password != '') {
                        loginModel
                            .modifyPassword(user.id, _password)
                            .then((value) {
                          var result = jsonDecode(value.toString());
                          print(result);
                          if (result['code'] == 200) {
                            Fluttertoast.showToast(
                                msg: "修改密码成功！",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "密码有误，请稍后再试！",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    child: const Text("确定")),
              ],
            );
          });
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 70,
                    width: 70,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image:
                            DecorationImage(image: NetworkImage(user.avatar)))),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(
                        user.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Id:${user.id}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 120, 120, 120)),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 10,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('个人信息'),
              onTap: () {
                Navigator.pushNamed(context, 'myInfoSettingView');
              },
            ),
            ListTile(
              leading: Icon(Icons.cached_sharp),
              title: Text('修改密码'),
              onTap: () {
                _showModifyDialog();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('退出登录'),
              onTap: () {
                _showDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
