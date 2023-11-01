import 'package:flutter/material.dart';
import 'package:mob_client/models/Driver.dart';

class userProvider extends ChangeNotifier {
  Driver? _user;
  String? _token;

  Driver? get user => _user;
  String? get token => _token;

  void setUser(Driver user) {
    _user = user;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void clearAll(){
    _user =null;
    _token=null;
  }

  bool IsLoggedIn(){
    return user != null;
  }


}