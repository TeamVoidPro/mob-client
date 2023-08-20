import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mob_client/providers/dataProvider.dart';
import 'package:mob_client/Routes/routes.dart';
import 'package:mob_client/providers/userProvider.dart';
import 'package:mob_client/theme/theme.dart';
import 'package:mob_client/utils/Navigation.dart';
import 'package:mob_client/utils/Request.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => dataProvider()),
          ChangeNotifierProvider(create: (_) => userProvider()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigation.navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: routes,
      // initialRoute: '/reservation',
      initialRoute: '/welcome',
      title: 'Flutter Demo',
      theme: myAppTheme,
    );
  }
}

