import 'package:flutter/material.dart';
//import 'package:practice_advanced_topic/storages/sqflite_example/login_andregistration/sqflite_functions.dart';

class UserHomePage extends StatefulWidget {
  final data;

  UserHomePage({super.key, required this.data});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
//if passing parameter name and instance variable name ins ame we use this
  var cEmail = TextEditingController();

  var cName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var name = widget.data[0]['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text("welcome $name"),
      ),
      body: Card(
          child: ListTile(
        trailing: IconButton(
          onPressed: () {
            editData(widget.data[0]['id'], context);
          },
          icon: const Icon(Icons.delete),
        ),
        title: Text('${widget.data[0]['name']}',
            style: const TextStyle(fontSize: 20)),
        subtitle: Text(widget.data[0]['email']),
      )),
    );
  }

  void editData(int id, BuildContext context) {
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
                TextField(
                  controller: cEmail,
                  decoration: const InputDecoration(
                      hintText: "Edit email", border: OutlineInputBorder()),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // await SQL_Functions. updateUser(id,cName.text,cEmail.text);
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
}
