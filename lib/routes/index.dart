import 'package:flutter/material.dart';
import 'package:imapp/view/friends/add_friend_view.dart';
import 'package:imapp/view/chat_content_view.dart';
import 'package:imapp/view/friends/friend_info_view.dart';
import 'package:imapp/view/friends/new_friend_add_info_view.dart';
import 'package:imapp/view/index_view.dart';
import 'package:imapp/view/login_view.dart';
import 'package:imapp/view/my/my_info_setting_view.dart';
import 'package:imapp/view/registry_view.dart';

// 路由
Map<String, WidgetBuilder> routes = {
  "/": (context) => const LoginView(),
  "login": (context) => const LoginView(),
  'registry': (context) => const RegistryView(),
  "index": (context) => const IndexView(),
  "chatContent": (context, {arguments}) =>
      ChatContentView(arguments: arguments),
  "addFriendView": (context) => const AddFriendView(),
  "friendInfoView": (context, {arguments}) =>
      FriendInfoView(arguments: arguments),
  "newFriendAddInfoView": (context, {arguments}) =>
      NewFriendAddInfoView(arguments: arguments),
  'myInfoSettingView': (context) => MyInfoSettingView()
};

// 配置传参
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;

  final Function pageContentBuilder = routes[name] as Function;

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      print('路由带参跳转');
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
