import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/storages/shared_preferences/login_and_registration/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeShared extends StatefulWidget {
   //HomeShared({super.key});

  @override
  State<HomeShared> createState() => _HomeSharedState();
}

class _HomeSharedState extends State<HomeShared> {
late SharedPreferences prefs;

 String? name;
@override
  void initState() {
    // TODO: implement initState
  fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("hi $name"),elevation: 2),
      body: Center(child: ElevatedButton(onPressed: (){
        prefs.setBool('newUser', true);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginShared()));
      }
          , child: const Text("LOGOUT"))),
    );
  }

  void fetchData() async{
  prefs=await SharedPreferences.getInstance();
  setState(() {
    name=prefs.getString('username')!;//As the user eacch time is different so gave in setState
  });
  }
}
