import 'package:flutter/material.dart';

class StateLessScreen extends StatelessWidget {
  // const StateFulscreen({super.key, required String name});//as we cant access the varaible which is inside the constructor
  //so we are assigning as instance variable
  String name;
  String? designation;//if we didnt give null aware? then have to give required
  int experience;
  StateLessScreen({super.key, required this. name,this.designation, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome $name,$designation To stateless widget,your experiemce is ${experience}"),),
    );
  }
}
