import 'package:flutter/material.dart';
import 'package:imapp/provider_info/user_provider.dart';
import 'package:imapp/routes/index.dart';
import 'package:imapp/provider_info/socket_provider.dart';
import 'package:imapp/viewmodel/contacts_viewmodel.dart';
import 'package:imapp/viewmodel/index_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ContactsViewModel()),
    ChangeNotifierProvider(create: (context) => IndexViewModelData()),
    ChangeNotifierProvider(create: (context) => SocketProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '即时通讯',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.white),
      // routes: routes,
      // 默认路由
      initialRoute: 'login',
      // 路由守卫
      onGenerateRoute: onGenerateRoute,
    );
  }
}
