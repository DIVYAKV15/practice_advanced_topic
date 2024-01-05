import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/admin_home_page.dart';
import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/sqflite_functions.dart';
import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/sqflite_registration_page.dart';
import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/sqflite_user_home_page.dart';

void main() {
  runApp(MaterialApp(
    home: Sqflite_Login(),
  ));
}

class Sqflite_Login extends StatelessWidget {
  Sqflite_Login({super.key});

  var formKey = GlobalKey<FormState>();

  var eNameCntrl = TextEditingController();

  var passCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void loginUser(String email, String pwd) async {
      //admin login
      if (email == 'admin@gmail.com' && pwd == 'admin123') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()));
      } else {
        //check if user is exist in db
        var data = await SQL_Functions.checkUserExist(email, pwd);
        //print(data);
        if (data.isNotEmpty) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UserHomePage(
                        data: data,
                      ),),);
        }
      }
    }

    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: eNameCntrl,
                  validator: (email) {
                    if (email!.isEmpty || !email.contains('@')) {
                      return "invalid email";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passCntrl,
                  validator: (pass) {
                    if (pass!.isEmpty || pass.length < 6) {
                      return "invalid password";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    var valid = formKey.currentState!.validate();
                    if (valid) {
                      loginUser(eNameCntrl.text, passCntrl.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("invalid username/password")));
                    }
                  },
                  child: const Text("Login Now")),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sqflite_Registration()));
                  },
                  child: const Text("Register Now")),
            ],
          ),
        ),
      ),
    );
  }
}
