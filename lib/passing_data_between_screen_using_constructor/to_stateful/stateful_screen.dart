import 'package:flutter/material.dart';

class StateFulscreen extends StatefulWidget {
  // const StateFulscreen({super.key, required String name});//as we cant access the varaible which is inside the constructor
  //so we are assigning as instance variable
  String name;
  String? designation;
  int experience;

  StateFulscreen(
      {super.key,
      required this.name,
      this.designation,
      required this.experience});
  @override
  State<StateFulscreen> createState() => _StateFulscreenState();
}

class _StateFulscreenState extends State<StateFulscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text('${widget.name},${widget.designation},${widget.experience}'),
      ),
    );
  }
}
