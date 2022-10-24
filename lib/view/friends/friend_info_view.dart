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
  Map? info;
  @override
  void initState() {
    params = widget.arguments;
    super.initState();
    print(params);
    info = params!['info'];
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
                image: NetworkImage(info!['avatar']), fit: BoxFit.cover),
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
                              image: NetworkImage(info!['avatar']))),
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Center(
                    child: Text(
                      info!['contact_name'],
                      style: const TextStyle(
                          fontSize: 26, color: Color(0xFF272832)),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'chatContent', arguments: {
                          'id': info!['contact_id'],
                          'name': info!['contact_name'],
                          'room_key': info!['room_key']
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 140.0, vertical: 12.0)),
                      ),
                      child: const Text(
                        '发送消息',
                        style: TextStyle(
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
