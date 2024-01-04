import 'package:flutter/material.dart';
//import 'package:practice_advanced_topic/storages/shared_preferences/login_and_registration/login_page.dart';
import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/sqflite_login_page.dart';

import 'sqflite_functions.dart';
class Sqflite_Registration extends StatelessWidget {
  Sqflite_Registration({super.key});
  var formKey = GlobalKey<FormState>();
  var name_cntrl = TextEditingController();
  var eName_cntrl = TextEditingController();
  var pass_cntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void registerUser(String name, String email, String password) async {
      //as we are accessing the db classname.method so it create as static there
      //usually we access obj.method
      var id = await SQL_Functions.addUser(
          name, email, password); //id we get when we add user
      print(id); //to check whether id is creating or not
      if (id != null) {
        //if id is not null it goes to another page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Sqflite_Login()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registration failed")));
      }
    }

    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name_cntrl,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: eName_cntrl,
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
                  controller: pass_cntrl,
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
              ElevatedButton(
                  onPressed: () {
                    var valid = formKey.currentState!.validate();
                    if (valid == true) {
                      registerUser(name_cntrl.text,
                          eName_cntrl.text, pass_cntrl.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("please verify all the fields given..")));
                    }
                  },
                  child: const Text("Register Now")),
            ],
          ),
        ),
      ),
    );
  }
}
