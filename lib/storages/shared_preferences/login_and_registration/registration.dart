import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/storages/shared_preferences/login_and_registration/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisteredShared extends StatefulWidget {
  const RegisteredShared({super.key});

  @override
  State<RegisteredShared> createState() => _RegisteredSharedState();
}

class _RegisteredSharedState extends State<RegisteredShared> {
  //entir forms state validation we need key
  var formKey = GlobalKey<FormState>();
  var unameController = TextEditingController();
  var pwdController = TextEditingController();
  var phoneController = TextEditingController();
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                validator: (username) {
                  if (username!.isEmpty || !username.contains('@')) {
                    return "Invalid username";
                  } else {
                    return null;
                  }
                },
                controller: unameController,
                decoration: const InputDecoration(
                    hintText: "UserNAme", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                validator: (passsword) {
                  if (passsword!.isEmpty || passsword.length < 6) {
                    return "password should not be empty and it must be greater than 6 digit";
                  } else {
                    return null;
                  }
                },
                controller: pwdController,
                decoration: const InputDecoration(
                    hintText: "password", border: OutlineInputBorder()),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                validator: (phonenumber) {
                  if (phonenumber!.isEmpty || phonenumber.length < 10) {
                    return "phonenumber should not be empty and it must be 10 digit";
                  } else {
                    return null;
                  }
                },
                controller: phoneController,
                decoration: const InputDecoration(
                    hintText: "phonenumber", border: OutlineInputBorder()),
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  //can add async here but below if we have anything which doesn't need async operation means then its not good to put here
                  var valid = formKey.currentState!.validate();
                  if (valid == true) {
                    storeData();
                  }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invlid Inputs!!"), ));
                    }
                },
                child: const Text("Register")),
          ],
        ),
      ),
    );
  }

//shared preferences value can be stored in async
//so we can create the async funtionalaity seperate
  void storeData() async {
    String email = unameController.text;
    String pwd = pwdController.text;
    //int phone_num=phoneController.text as int;
    int phone_num=int.parse(phoneController.text);
    prefs = await SharedPreferences.getInstance(); //single instance
    prefs.setString('username', email);
    prefs.setString('password', pwd);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginShared()));
  }
}
