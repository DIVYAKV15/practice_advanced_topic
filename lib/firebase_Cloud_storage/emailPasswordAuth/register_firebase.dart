
import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/firebase_Cloud_storage/emailPasswordAuth/fire_functions.dart';
import 'package:practice_advanced_topic/firebase_Cloud_storage/emailPasswordAuth/login_firbase.dart';
class RegisterFirebase extends StatelessWidget {
  RegisterFirebase({super.key});

  var email_controller = TextEditingController();
  var pass_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        titleTextStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register here!!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: email_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter Your EMail",
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
              onPressed: () {
                String email = email_controller.text.trim();
                String password = pass_controller.text.trim();

                //then using when the async operation completed then proceed with the process
                //result which we get from registerUer method
                FireBaseHelper()
                    .registerUser(email: email, pwd: password)
                    .then((result) {
                  if (result == null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginFirebase()));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(result)));
                  }
                });
              },
              child: const Text("Register",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
