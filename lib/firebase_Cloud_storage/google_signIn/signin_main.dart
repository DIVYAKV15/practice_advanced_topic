import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'authentication_sample.dart';
import 'google_signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SignInGoogle(),
  ));
}

class SignInGoogle extends StatefulWidget {
  @override
  State<SignInGoogle> createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/firebase_logo.png',
                        height: 160,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'FlutterFire',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    const Text(
                      'Authentication',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
