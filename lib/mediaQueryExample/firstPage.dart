import 'package:flutter/material.dart';
// Media Query Widget- Used to Create responsive UI's
//Similar to the Expanded Widget
// Can be used by calling its builder -MediaQuery.of
// Doesn't need any additional dependencies
void main() {
  runApp(MaterialApp(
    home: mainPageMedia(),
  ));
}

class mainPageMedia extends StatelessWidget {
  mainPageMedia({super.key});

  @override
  Widget build(BuildContext context) {
    var width =
        MediaQuery.of(context).size.width; //we get whole screen  width size
    return Scaffold(
      body: width > 600 ? bigScreen() : MobileScreen(),
    );
  }
}
//youTube app templates

class bigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Big screen"),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(// youtube video
                    height: 300,
                    decoration:
                        const BoxDecoration(color: Colors.deepPurpleAccent),
                  ),
                ),
                // comment section & recommended videos
                Expanded(
                    child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: Colors.green.shade50,
                      child: Text("Video $index"),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.orange.shade50,
                child: Text("Video $index"),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class MobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Mobile Screen")),
      body: Column(
        children: [
          //currently playing video
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 300,
              decoration: const BoxDecoration(color: Colors.greenAccent),
            ),
          ),
          //list of videos
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: Colors.pink.shade50,
                  child: Text("Video $index"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//mobile maximum range width is 600
//above is for web
//responsive builder/layout/sizer/framework/flutter screenutils=> another plugins for responsive ui
//when our project has to be in both screen and web then we have to create in responsive ui
// Container(
// color: Colors.yellow,
// height: height * 0.6, //half of the height size
// width: width * 0.5, //half of the width size
// ),
