import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _logggedIn = false;
  bool get loogedIn => _logggedIn;
  void logIn() {
    _logggedIn = true;
    notifyListeners();
  }

  void logOut() {
    _logggedIn = false;
    notifyListeners();
  }
}
