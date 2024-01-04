import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: CounterExample(),
  ));
}

class CounterExample extends StatefulWidget {
  const CounterExample({super.key});

  @override
  State<CounterExample> createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  late SharedPreferences prefs;
  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences Example.."),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip:
              "increment", //this will show when the user log press the button
          onPressed: () {
            incrementcounter();
          },
          child: const Icon(Icons.add)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You have pushed the buttons this many times"),
            Text('$counter'), //need to add the counter number
          ],
        ),
      ),
    );
  }

  // Incrementing counter after click
  void incrementcounter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', counter);
    });
  }

// Loading counter value on start
  void loadCounter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt('counter') ?? 0);
    });
  }
}
