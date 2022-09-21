import 'package:flutter/material.dart';
import 'package:imapp/view/index_view.dart';
import 'package:imapp/view/login_view.dart';
import 'package:imapp/view/registry_view.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => LoginView(),
  "login": (context) => LoginView(),
  'registry': (context) => RegistryView(),
  "index": (context) => IndexView()
};
