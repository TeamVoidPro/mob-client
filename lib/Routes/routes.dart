// Define Routes
import 'package:flutter/material.dart';
import 'package:mob_client/pages/AddVehicle.dart';
import 'package:mob_client/pages/BookingPage.dart';
import 'package:mob_client/pages/ChatPage.dart';
import 'package:mob_client/pages/ErrorPage.dart';
import 'package:mob_client/pages/LoginPage.dart';
import 'package:mob_client/pages/ReservationPage.dart';
import 'package:mob_client/pages/SignUpPage.dart';
import 'package:mob_client/pages/SuccessPage.dart';
// import 'package:mob_client/pages/Test.dart';
import 'package:mob_client/pages/ThankYou.dart';
import 'package:mob_client/pages/WelcomePage.dart';

import '../pages/BookingPaymentPage.dart';
import '../pages/HomePage.dart';



final Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginPage(),
  '/welcome': (context) => WelcomePage(),
  '/register': (context) => SignUpPage(),
  '/add-vehicle': (context) => AddVehiclePage(),
  '/home': (context) => HomePage(),
  // '/test' : (context) => Test(),
  '/book' : (context) => BookingPage(),
  '/book/payment' : (context) => BookingPaymentPage(),
  '/success' : (context) => SuccessPage(),
  '/error' : (context) => ErrorPage(errorString: 'Error'),
  '/thankyou' : (context) => ThankYou(msgString: 'UCSC Car Park',),
  '/chat' : (context) => ChatPage(),
  '/reservation' : (context) => ReservationPage(),
};