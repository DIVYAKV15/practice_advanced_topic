import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'controller/counter_controller.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
        create: (context) =>
            CounterProvider(), //is to connect bewtween provider check the changes
        child: Counter_Example()),
  ));
}

class Counter_Example extends StatelessWidget {
  //const ({super.key});

  @override
  Widget build(BuildContext context) {
    var counterController = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider example"),
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
            Text("Counter value :${counterController.counter_value.value}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  counterController
                      .increment_counter(); //invoking the method from other class
                },
                child: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
//using consumer to listen changes in changeNotifier
