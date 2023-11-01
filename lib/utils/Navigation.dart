import 'package:flutter/material.dart';

class Navigation {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void push(String path) {
    navigatorKey.currentState!.pushNamed(path);
  }
}
