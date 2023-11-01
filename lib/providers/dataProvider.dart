import 'package:flutter/material.dart';

class dataProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}