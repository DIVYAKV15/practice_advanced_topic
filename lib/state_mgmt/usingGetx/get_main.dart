import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

void main() {
  runApp(GetMaterialApp(
    home: CounterMain(),
  ));
}

class CounterMain extends StatelessWidget {
  const CounterMain({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the GetX controller
    final countController countcontroller = Get.put(countController());
    return Scaffold(
      appBar: AppBar(title: Text("Getx Controller example")),
      body: Center(
        child: Column(
          children: [
            Obx(() => Text("count ${countcontroller.count}")),
            ElevatedButton(
              onPressed: () => countcontroller.increment(),
              child: Icon(Icons.add_circle),
            ),
            ElevatedButton(
              onPressed: () => countcontroller.decrement(),
              child: Text("DEcreement"),
            ),
          ],
        ),
      ),
    );
  }
}
