import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/firebase_Cloud_storage/emailPasswordAuth/fire_functions.dart';
import 'package:practice_advanced_topic/firebase_Cloud_storage/emailPasswordAuth/login_firbase.dart';

class HomeFirebase extends StatelessWidget {
  const HomeFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "HOme Page",
          ),
          titleTextStyle: const TextStyle(
              backgroundColor: Colors.pinkAccent,
              fontSize: 20,
              fontWeight: FontWeight.w700),
          backgroundColor: Colors.yellow),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              FireBaseHelper().logout().then((value) => Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => LoginFirebase())));
            },
            child: const Text("signOut")),
      ),
    );
  }
}
