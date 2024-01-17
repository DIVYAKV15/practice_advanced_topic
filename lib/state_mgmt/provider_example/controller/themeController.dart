import 'package:flutter/material.dart';
//changing dark theme into light theme
class ThemeProvider extends ChangeNotifier
{
bool _darkTheme=false;//first setting dark theme as false
bool get isDarkTheme=>_darkTheme;//to access this instance variable outside here we using get
void switchTheme()//when the button clicked it change to light to dark vice versa
{
  _darkTheme=!_darkTheme;//dark theme initially false so make it as true
  notifyListeners();
}

}