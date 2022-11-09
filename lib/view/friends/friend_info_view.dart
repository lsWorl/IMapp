import 'dart:ui';

import 'package:flutter/material.dart';

class FriendInfoView extends StatefulWidget {
  const FriendInfoView({super.key, this.arguments});
  final Map? arguments;
  @override
  State<FriendInfoView> createState() => _FriendInfoViewState();
}

class _FriendInfoViewState extends State<FriendInfoView> {
  // 获取到的参数
  Map? params;
  late Map info;
  // 按钮的文字
  String buttonText = '发送消息';
  @override
  void initState() {
    params = widget.arguments;
    super.initState();
    print(params);
    info = params!['info'];
    // 判断当前用户是否是好友
    buttonText = info['is_out'] == '1' ? buttonText : '添加好友';
    print(info);
  }

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
                  icon: const Icon(Icons.arrow_back));
            },
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(info['avatar']), fit: BoxFit.cover),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(
                              image: NetworkImage(info['avatar']))),
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Center(
                    child: Text(
                      info['name'],
                      style: const TextStyle(
                          fontSize: 30, color: Color(0xFF272832)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 400,
                      child: Text(
                        info['described'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, color: Color(0xFF272832)),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'chatContent', arguments: {
                          'id': info['contact_id'],
                          'name': info['name'],
                          'room_key': info['room_key']
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 140.0, vertical: 12.0)),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 227, 227, 227)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
