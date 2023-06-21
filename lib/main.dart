import 'package:flutter/material.dart';
import 'package:mob_client/providets/dataProvider.dart';
import 'package:mob_client/Routes/routes.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => dataProvider()),
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
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: '/book',
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 153, 125, 0)),
        useMaterial3: true,
      ),
    );
  }
}

