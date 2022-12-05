import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imapp/convert/user/user.dart';
import 'package:imapp/model/upload_model.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:provider/provider.dart';

class MyInfoSettingView extends StatefulWidget {
  const MyInfoSettingView({super.key});

  @override
  State<MyInfoSettingView> createState() => _MyInfoSettingViewState();
}

class _MyInfoSettingViewState extends State<MyInfoSettingView> {
  //实例化选择图片
  final ImagePicker _picker = ImagePicker();
  // 请求
  UploadModel uploadModel = UploadModel();
  @override
  Widget build(BuildContext context) {
    //用户本地图片
    XFile _userImage; //存放获取到的本地路径
    // 序列化用户
    var user = User.fromJson(Provider.of<UserProvider>(context).userInfo);
    return Scaffold(
      appBar: AppBar(
        title: const Text('详细'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.grey,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 21,
          ),
          InkWell(
            onTap: () async {
              late Map result;
              await getImage().then((value) async {
                print('获取图片');
                if (value != null) {
                  _userImage = value;
                  print(File(_userImage.path));
                  await uploadModel
                      .imageUpload(File(_userImage.path), user.id)
                      .then((res) {
                    print('请求接收');
                    result = json.decode(res.toString());
                    print(result);
                    if (result['code'] == 200) {
                      Provider.of<UserProvider>(context, listen: false)
                          .modifyAvatar(result['data']['avatarPath']);
                    }
                  });
                  // print(_userImage);
                }
              });
            },
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        '头像',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(user.avatar))),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                  size: 40,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _item('签名', user.described),
          const SizedBox(
            height: 16,
          ),
          Divider(),
          const SizedBox(
            height: 16,
          ),
          _item('昵称', user.name),
          const SizedBox(
            height: 16,
          ),
          _item('性别', user.sex == '0' ? '男' : '女'),
          const SizedBox(
            height: 16,
          ),
          _item('电话', user.phone),
          const SizedBox(
            height: 16,
          ),
          _item('地址', user.address),
        ],
      ),
    );
  }

  Future getImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Widget _item(String title, String subInfo) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 300,
              child: Text(
                subInfo,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        const Icon(
          Icons.arrow_right_rounded,
          size: 40,
        )
      ],
    );
  }
}
