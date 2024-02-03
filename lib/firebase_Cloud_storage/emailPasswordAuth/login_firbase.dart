import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/firebase_Cloud_storage/emailPasswordAuth/fire_functions.dart';
import 'package:practice_advanced_topic/firebase_Cloud_storage/emailPasswordAuth/home_firebase.dart';
import 'package:practice_advanced_topic/firebase_Cloud_storage/emailPasswordAuth/register_firebase.dart';

// WidgetFlutterBinding is used to interact with the Flutter engine.
// Firebase.initializeApp() needs to call native code to initialize Firebase,
// and since the plugin needs to use platform channels to call the native code,
// which is done asynchronously therefore you have to call ensureInitialized() to make sure
// that you have an instance of the WidgetsBinding.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBj-VjV_vD-mxwM03Gk0aZjH5EN0stuCYY",
    appId: "1:1088459541617:android:6816283fada20fec75dfd0",
    messagingSenderId: "", //it not mandatory so can give as null
    projectId: "fir-newoperation",
  ));
  // to get the currently logged in user
  User? user=FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home:user==null? LoginFirebase():const HomeFirebase(),
  ));
}

class LoginFirebase extends StatelessWidget {
  LoginFirebase({super.key});

  var email_controller = TextEditingController();
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
                String pwd = pass_controller.text.trim();
                FireBaseHelper()
                    .loginUser(email: email, pwd: pwd)
                    .then((result) {
                  if (result == null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeFirebase()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("email incorrect")));
                  }
                });
              },
              child: const Text("Login",
                  style: TextStyle(
                      fontSize: 24,
                      backgroundColor: Colors.pinkAccent,
                      fontWeight: FontWeight.bold)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterFirebase()));
                },
                child: const Text("Don't have an account?? Register Here"))
          ],
        ),
      ),
    );
  }
}
