import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/storages/shared_preferences/login_and_registration/home.dart';
import 'package:practice_advanced_topic/storages/shared_preferences/login_and_registration/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: LoginShared(),
  ));
}

class LoginShared extends StatefulWidget {
  const LoginShared({super.key});

  @override
  State<LoginShared> createState() => _LoginSharedState();
}

class _LoginSharedState extends State<LoginShared> {
  //entire forms state validation we need key
  late bool newUser;
  @override
  void initState() {
    // TODO: implement initState
    check_if_already_loggedIn(); //whenever we open the app it should check whether the user is loggedin or not
    super.initState();
  }

  void check_if_already_loggedIn() async {
    prefs = await SharedPreferences.getInstance();
//?? means if the given condition is null then second stmt will execute
    //newuser creates only when we click on log in button..before that it will be null
    newUser = prefs.getBool('newUser') ?? true;
    if (newUser == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeShared()));
    }
  }

  var formKey = GlobalKey<FormState>();
  var unameController = TextEditingController();
  var pwdController = TextEditingController();
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        //validation we are using form
        key: formKey,
        child: Center(
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
              ElevatedButton(
                  onPressed: () {
                    var valid = formKey.currentState!.validate();
                    if (valid == true) {
                      validateInput();
                    }
                  },
                  child: const Text("Login")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisteredShared()));
                  },
                  child: const Text("Not a registered user???SignUp here!!"))
            ],
          ),
        ),
      ),
    );
  }

  void validateInput() async {
    String uname = unameController.text;
    String pass =
        pwdController.text; //iif we wnat to trim the space can add trim();
    prefs = await SharedPreferences.getInstance();
    //if user is logged in then mark it as not a new user
    //this condition is to determine whether it should be login or logout
    //when we click the login button then only this key will create
    prefs.setBool('newUser',
        false); //when i logout it should come out of the home page or else it should directly goes to home page
    //read the registered values
    String? storedUname = prefs.getString('username');
    //either ? or at the end ('username')! null check can be given
    //keys must be give properly
    String storedPwd = prefs.getString('password')!;
    if (storedUname == uname && storedPwd == pass) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeShared()));
    }
    // else
    //   {
    //     return 'invalid username/password';
    //   }
  }
}
