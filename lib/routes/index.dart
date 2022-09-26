import 'package:flutter/material.dart';
import 'package:imapp/view/chat_content_view.dart';
import 'package:imapp/view/index_view.dart';
import 'package:imapp/view/login_view.dart';
import 'package:imapp/view/registry_view.dart';

// 路由
Map<String, WidgetBuilder> routes = {
  "/": (context) => LoginView(),
  "login": (context) => LoginView(),
  'registry': (context) => RegistryView(),
  "index": (context) => IndexView(),
  "chatContent": (context, {arguments}) => ChatContentView(arguments: arguments)
};

// 配置传参
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
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
