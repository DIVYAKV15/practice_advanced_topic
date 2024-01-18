import 'package:flutter/material.dart';

class Phone_number_Login extends StatelessWidget {
Phone_number_Login({super.key});

var phone_controller = TextEditingController();
var pass_controller = TextEditingController();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Login"),
      titleTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      backgroundColor: Colors.pinkAccent,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login Here!!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: phone_controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter Your phone number",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: pass_controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Your password",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},

            child: const Text("Login",
                style: TextStyle(
                    fontSize: 24,
                    backgroundColor: Colors.pinkAccent,
                    fontWeight: FontWeight.bold)),
          ),

        ],
      ),
    ),
  );
}
}
