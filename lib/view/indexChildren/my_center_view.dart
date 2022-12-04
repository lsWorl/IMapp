import 'package:flutter/material.dart';
import 'package:imapp/convert/user/user.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:provider/provider.dart';

class MyCenterView extends StatelessWidget {
  const MyCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    // 序列化用户
    var user = User.fromJson(Provider.of<UserProvider>(context).userInfo);
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
            const ListTile(
              leading: Icon(Icons.cached_sharp),
              title: Text('修改密码'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
            ),
          ],
        ),
      ),
    );
  }
}
