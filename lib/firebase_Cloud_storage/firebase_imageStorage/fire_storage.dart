import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; //type casting path

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
    home: FireMediaStorage(),
  ));
}

class FireMediaStorage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FireMediaStorageState();
}

class _FireMediaStorageState extends State {
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Storage")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => upload("camera"),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text("Camers"),
                ),
                ElevatedButton.icon(
                  onPressed: () => upload("Gallery"),
                  icon: const Icon(Icons.photo_album_outlined),
                  label: const Text("Gallery"),
                ),
              ],
            ),
          ),
          Expanded(
            // if firebase connection is success load data or media from firebase
            child: FutureBuilder(

                ///images returned from method
                future: loadmedia(), // list of map images will be return here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          /// each map value from list images stored in map image
                          final image = snapshot.data![index];
                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                image['imageUrl'],
                              ),
                              title: Text(image['uploaded_by']),
                              subtitle: Text(image['time']),
                              trailing: IconButton(
                                  onPressed: () {
                                    deleteMedia(image['path']);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ),
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }

  Future<void> upload(String imgFrom) async {
    final ImagePicker picker = ImagePicker();
    XFile? PickedImage;
    try {
      PickedImage = await picker.pickImage(
          source:
              imgFrom == "camera" ? ImageSource.camera : ImageSource.gallery);
      final String filename = path.basename(PickedImage!.path); //
      File imageFile = File(PickedImage.path);
      try {
        //to upload our image in cloud storage
        //instead of adding phone name
        //add one text field with the name and give controller.text to change name according to person
        //ref=>is to create image reference in storage
        await storage.ref(filename).putFile(
            imageFile,
            SettableMetadata(
              //meta date means below while taking photo we get name time and all w
              customMetadata: {
                'uploaded_by': "phone_name", //the name of images
                'time': "${DateTime.now()}" //time taken
              },
            ));
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (error) {
      //while file
      print(error);
    }
  }

  ///load images from firebase
  // we stored there as map uploaded by  and time and all so have to use map to load
  //list of images we receive from storage
  Future<List<Map<String, dynamic>>> loadmedia() async {
    List<Map<String, dynamic>> images = []; //empty to store images
    //listResult is a builtin class from  fireStorage to get the list of result
    final ListResult result = await storage.ref().list();
//reference is for images like collections/document is for cloud storage
    final List<Reference> allFiles =
        result.items; // all the data from firebase stored as a reference
    //here we receive all the images as map
    //from reference  going to take singleFile
    //using foreach is to iterate all the files and make it as singlefile
    await Future.forEach(allFiles, (singleFile) async {
      final String fileUrl = await singleFile
          .getDownloadURL(); // to fetch image path(path as network image path)
      //to upload metadata using customMetaData and to get metadata using FullMetaDate
      final FullMetadata metadata =
          await singleFile.getMetadata(); // to fetch metadata from firebase
      //adding the received images in our empty list as one by one
      images.add({
        //to add images in our gallery
        'imageUrl': fileUrl,
        'path': singleFile.fullPath,
        //to delete we need this full path as we taking as fullpath
        'uploaded_by':
            metadata.customMetadata?['uploaded_by'] ?? metadata.fullPath,
        //metadata.fullpath is to get the same name which we stored for images
        //give same key value like above
        "time": metadata.customMetadata?['time'] ?? "No time found",
      });
    });
    return images;
  }

  Future<void> deleteMedia(String imagePath) async {
    await storage.ref(imagePath).delete();
    setState(() {}); //to refresh
  }
}
