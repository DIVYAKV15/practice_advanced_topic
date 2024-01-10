import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/passing_data_between_screen_using_constructor/to_stateful/stateful_screen.dart';
import 'package:practice_advanced_topic/passing_data_between_screen_using_constructor/to_stateless/stateless_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  Home({super.key});
  String name = "LUMINAR";
  String designation = "Intern";
  var experience = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Passing")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StateLessScreen(
                            name: name,
                            designation: designation,
                            experience: experience)));
              },
              child: const Text("TO Stateless Widget"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StateFulscreen(
                            name: name,
                            designation: designation,
                            experience: experience)));
              },
              child: const Text("TO Stateful Widget"),
            ),
          ],
        ),
      ),
    );
  }
}
