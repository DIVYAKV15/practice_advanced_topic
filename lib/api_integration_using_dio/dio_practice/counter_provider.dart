import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  bool _isDark=false;
  bool get isDark=>_isDark;
  void change(){
   _isDark=!_isDark;
    notifyListeners();

  }
}