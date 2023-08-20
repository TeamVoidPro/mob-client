// Define Routes
import 'package:animated_splash_screen/animated_splash_screen.dart';
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
import 'package:page_transition/page_transition.dart';

import '../pages/BookingPaymentPage.dart';
import '../pages/HomePage.dart';

Widget _splashScreen (BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width, // Adjust the width and height according to your needs
    height: MediaQuery.of(context).size.height,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/Images/welcome.png'),
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ]
    ),
  );
}

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginPage(),
  // '/welcome': (context) => const WelcomePage(),
  '/welcome': (context) => AnimatedSplashScreen(
      duration: 3000,
      splash: _splashScreen(context),
      nextScreen: const WelcomePage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white,
  ),
  '/register': (context) => SignUpPage(),
  '/add-vehicle': (context) => AddVehiclePage(),
  '/home': (context) => HomePage(),
  // '/test' : (context) => Test(),
  '/book': (context) => BookingPage(),
  '/book/payment': (context) => BookingPaymentPage(),
  '/success': (context) => SuccessPage(),
  '/error': (context) => ErrorPage(errorString: 'Error'),
  '/thankyou': (context) => ThankYou(
        msgString: 'UCSC Car Park',
      ),
  '/chat': (context) => ChatPage(),
  '/reservation': (context) => ReservationPage(),
};
