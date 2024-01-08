import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/sqflite_functions.dart';
//import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/sqflite_functions.dart';

class UserHomePage extends StatefulWidget {
  final data;

  UserHomePage({super.key, required this.data});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var name, email;
  @override
  void initState() {
    //fetching the user details andd assigning it to this instance varibale
    name = widget.data[0]['name'];
        ['name']; //to access this local variable we decalared globally above
    email = widget.data[0]['email'];
    super.initState();
  }

//if passing parameter name and instance variable name ins ame we use this
  var cEmail = TextEditingController();
  var cName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //data is getting from state above
    //to pass our data in stateful widget we have to add widget infront of data

    void editData() {
      //setting the current user details inside the alert box
      setState(() {
        cName.text = name;
        cEmail.text = email;
      });

      //to show dialog
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Edit Data",
                style: TextStyle(fontSize: 20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cName,
                    decoration: const InputDecoration(
                        hintText: "Edit Name", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: cEmail,
                    decoration: const InputDecoration(
                        hintText: "Edit email", border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          name = cName.text;
                          email = cEmail.text;
                        });
                        updateUser();
                        Navigator.of(context).pop();
                        // cName.text = "";
                        // cEmail.text = "";

                        //await SQL_Functions. updateUser(id,cName.text,cEmail.text);
                      },
                      child: const Text("update data"))
                ],
              ),
              // actions: [
              //  //Text("update data")
              //   TextButton(onPressed: (){}, child: Text("yes"),),
              //   TextButton(onPressed: (){}, child: Text("No"),),
              //   TextButton(onPressed: (){}, child: Text("Cancel"),),
              // ],
            );
          });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("welcome $name"),
      ),
      body: Card(
          child: ListTile(
        trailing: IconButton(
          onPressed: () {
            editData();
          },
          icon: const Icon(Icons.edit),
        ),
        title: Text('$name',
            //'${widget.data[0]['name']}',
            style: const TextStyle(fontSize: 20)),
        subtitle: Text(
          '$email',
          //widget.data[0]['email']
        ),
      )),
    );
  }
  void updateUser() async {
   SQL_Functions.update(widget.data[0]['id'], name, email);
  }
}
