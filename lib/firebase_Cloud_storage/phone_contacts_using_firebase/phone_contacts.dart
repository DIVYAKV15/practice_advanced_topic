import 'package:cloud_firestore/cloud_firestore.dart';
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
  runApp(const MaterialApp(
    home: PhoneContacts(),
  ));
}

class PhoneContacts extends StatefulWidget {
  const PhoneContacts({super.key});

  @override
  State<PhoneContacts> createState() => _PhoneContactsState();
}

class _PhoneContactsState extends State<PhoneContacts> {
  var name_cntrl = TextEditingController();
  var phone_cntrl = TextEditingController();
  late CollectionReference
      _contactsCollection; //collection reference is to ref to our collection name where we get the data we storing
  @override
  void initState() {
    // TODO: implement initState
    _contactsCollection =
        FirebaseFirestore.instance.collection('contacts'); //collection name
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: getContacts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final contacts = snapshot.data!.docs;
            return Expanded(
              child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final newContact = contacts[index];
                    final userId = newContact.id;
                    final nameContact = newContact['name'];
                    final phoneContact = newContact['phone'];
                    return ListTile(
                      leading: const CircleAvatar(),
                      title: Text(nameContact),
                      subtitle: Text(phoneContact),
                      trailing: Wrap(children: [
                        IconButton(
                          onPressed: () {
                            editcontacts(userId);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteContacts(userId);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ]),
                    );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: name_cntrl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: phone_cntrl,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              String name = name_cntrl.text.trim();
                              var phone = phone_cntrl.text.trim();
                              createContact(name, phone);
                            },
                            child: const Text("Add")),
                      ],
                    ),
                  );
                });
          },
          child: const Icon(Icons.add_circle)),
    );
  }

  Future<void> createContact(String name, String phone) async {
    try {
      _contactsCollection.add({
        'name': name,
        'phone': phone,
      }).then((value) => print("User added successfully"));
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> getContacts() {
    return _contactsCollection.snapshots();
  }

  void editcontacts(String userId) {}

  void deleteContacts(String userId) {}
}
