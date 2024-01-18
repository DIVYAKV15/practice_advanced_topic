import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyBj-VjV_vD-mxwM03Gk0aZjH5EN0stuCYY",
    appId: "1:1088459541617:android:6816283fada20fec75dfd0",
    messagingSenderId: "",
    //it not mandatory so can give as null
    projectId: "fir-newoperation",
    storageBucket: "fir-newoperation.appspot.com",
  ));
  // to get the currently logged in user

  runApp(MaterialApp(
    home: FirebaseCrud(),
  ));
}

class FirebaseCrud extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  var name_controller = TextEditingController();
  var email_controller = TextEditingController();
  late CollectionReference
      _userCollection; //collection reference is to ref to our collection name where we get the data we storing
  @override
  void initState() {
    _userCollection =
        FirebaseFirestore.instance.collection("users"); //collection name
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Fire base Crud Operations"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: name_controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter Your name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: email_controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Youremail",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addUser();
            },
            child: Text("Add User"),
          ),
          //snapshot is object for async snapshot class
          // the given is user is there in firebase or not
          //check and if it is there then show the widget
          //or else show the error
          //What is a StreamBuilder?
          // A StreamBuilder in Flutter is used to listen to a stream of data and
          // rebuild its widget subtree whenever new data is emitted by the stream
          StreamBuilder<QuerySnapshot>(
              stream: getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("error ${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final user = snapshot.data!
                    .docs; //all the documents from the collection of firebase
                return Expanded(
                    child: ListView.builder(
                        itemCount: user.length,
                        itemBuilder: (context, index) {
                          final users = user[
                              index]; //to get each collection we are seperating in a index
                          //first one second one like this index
                          final usersId = users.id;
                          final userName = users['name'];
                          final userEmail = users['email'];

                          return ListTile(
                            title: Text('$userName'),
                            subtitle: Text('$userEmail'),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      editUser(usersId);
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                  onPressed: () {
                                    deleteUSer(usersId);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        }));
              }),
        ],
      ),
    );
  }

//create user
  Future<void> addUser() async {
    return _userCollection.add({
      'name': name_controller.text,
      'email': email_controller.text
    }).then((value) {
      print("user added successfully");
      name_controller.clear();
      email_controller.clear();
    }).catchError((error) {
      print("failed to add user $error");
    });
  }

//read user
  Stream<QuerySnapshot> getUser() {
    return _userCollection.snapshots();
  }

  void editUser(var id) {
    final newNameCntrller = TextEditingController();
    final newEmailCntrller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("update USer"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newNameCntrller,
                  decoration: InputDecoration(
                      hintText: "enter name", border: OutlineInputBorder()),
                ),
                TextField(
                  controller: newEmailCntrller,
                  decoration: InputDecoration(
                      hintText: "enter email", border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    updateUSer(id, newNameCntrller.text, newEmailCntrller.text)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Update")),
            ],
          );
        });
  }

  Future<void> updateUSer(var id, String newName, String newEmail) {
    return _userCollection
        .doc(id)
        .update({'name': newName, 'email': newEmail}).then((value) {
      print("User updated successfully");
    }).catchError((error) {
      print("USer data updation failed");
    });
  }

  Future<void> deleteUSer(var id) {
    return _userCollection.doc(id).delete().then((value) {
      print("user deleted successfully");
    }).catchError((error) {
      print("user deletion failed $error");
    });
  }
}
//we can do it seperate class for firebase like create user ,add user and create firebase instance there too
