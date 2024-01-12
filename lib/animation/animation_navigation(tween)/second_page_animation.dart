import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);

            ///that means the current screen will close and go back to the previous context(previous screen)
          },
          child: const Text("go back to Main Page"),
        ),
      ),
    );
  }
}
