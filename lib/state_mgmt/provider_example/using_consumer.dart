import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'controller/counter_controller.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
        create: (context) => CounterProvider(), child: Counter_Example()),
  ));
}

class Counter_Example extends StatelessWidget {
  //const ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Using consumer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(' You have pushed the button this many times:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 20,
            ),

//using consumer to listen changes in changeNotifier
            Consumer<CounterProvider>(
              builder: (context, CounterProvider, child) => Text(
                  "Counter value :${CounterProvider.counter_value.value}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  //using consumer to call this increment method
                  //here no changes is going to happen in this widget
                  //so set this as false
                  //just monitor the changes no need to do changes
                  Provider.of<CounterProvider>(context, listen: false)
                      .increment_counter();
                  //invoking the method from other class
                },
                child: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
