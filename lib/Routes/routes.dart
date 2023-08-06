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
import '../pages/ChatListPage.dart';
import '../pages/HomePage.dart';



final Map<String, WidgetBuilder> routes = {
  '/login': (context) => const LoginPage(),
  '/welcome': (context) => const WelcomePage(),
  '/register': (context) => const SignUpPage(),
  '/add-vehicle': (context) => const AddVehiclePage(),
  '/home': (context) => const HomePage(),
  '/book' : (context) => const BookingPage(),
  '/book/payment' : (context) => const BookingPaymentPage(),
  '/success' : (context) => const SuccessPage(),
  '/error' : (context) => const ErrorPage(errorString: 'Error'),
  '/thankyou' : (context) => const ThankYou(msgString: 'UCSC Car Park',),
  '/chat' : (context) => const ChatPage(),
  '/reservation' : (context) => const ReservationPage(),
  '/chatList' : (context) => const ChatListPage(),
};