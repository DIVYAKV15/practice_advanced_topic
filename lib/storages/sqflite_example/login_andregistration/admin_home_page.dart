import 'package:flutter/material.dart';

import 'sqflite_functions.dart';
import 'sqflite_login_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Map<String, dynamic>> users = []; //to all the registered users here
  @override
  void initState() {
    // TODO: implement initState
    getAllUsers();
    super.initState();
  }

  ///to read all  the users from db and update the list or ui
  void getAllUsers() async {
    var userFromDb = await SQL_Functions.getALlUSer();
    setState(() {
      users = userFromDb;
    });
  }

  //delete single user from the list and update the ui
  void deleteUSer(int id) async {
    await SQL_Functions.dltUser(id);
    getAllUsers(); //once we deleted we have to call the getalluser to receive the latest user details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Sqflite_Login()));
      }, icon: Icon(Icons.arrow_back)),
        title: const Text("admin Page"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${users[index]['id']}')),
            title: Text(
                users[index]['name']), //these keys are the table column name
            subtitle: Text(
              users[index]['email'],
            ),
            trailing: IconButton(
                onPressed: () {
                  deleteUSer(users[index]['id']);
                },
                icon: const Icon(Icons.delete)),
          ),
        ),
      ),
    );
  }
}
