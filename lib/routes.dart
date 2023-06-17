// Define Routes
import 'package:flutter/material.dart';
import 'package:mob_client/pages/AddVehicle.dart';
import 'package:mob_client/pages/LoginPage.dart';
import 'package:mob_client/pages/SignUpPage.dart';
import 'package:mob_client/pages/WelcomePage.dart';

import 'pages/HomePage.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginPage(),
  '/welcome': (context) => WelcomePage(),
  '/register': (context) => SignUpPage(),
  '/add-vehicle': (context) => AddVehiclePage(),
  '/home': (context) => HomePage(),
};