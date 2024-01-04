import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
 final data;

  const UserHomePage({super.key,  required this.data});
//if passing parameter name and instance variable name ins ame we use this
  @override
  Widget build(BuildContext context) {
    var name = data[0]['name'];
    return Scaffold(
      appBar: AppBar(
        title:  Text("welcome $name"),
      ),
    );
  }
}
