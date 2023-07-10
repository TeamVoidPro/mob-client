import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mob_client/providets/dataProvider.dart';
import 'package:mob_client/Routes/routes.dart';
import 'package:mob_client/theme/theme.dart';
import 'package:provider/provider.dart';

import 'providets/chatProvider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => dataProvider()),
      ChangeNotifierProvider(create: (_) => chatProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: '/chatList',
      title: 'Flutter Demo',
      theme: myAppTheme,
    );
  }
}
