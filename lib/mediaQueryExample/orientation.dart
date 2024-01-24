import 'dart:math';

import 'package:flutter/material.dart';
//Change or lock device orientation
// void main() {
//     WidgetsFlutterBinding.ensureInitialized();
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     runApp(MaterialApp(home: Run()));
// }
void main() {
  runApp(MyScreen());
}

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //theme of our mobile device
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MaterialApp(
      theme: isDark == true ? ThemeData.dark() : ThemeData.light(),
      home: OrientationExample(),
    );
  }
}

class OrientationExample extends StatelessWidget {
  OrientationExample({super.key});

  var orientation;

  @override
  Widget build(BuildContext context) {
    // getting the orientation of the app
    orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: orientation == Orientation.portrait ? Listscreen() : GridScreen(),
    );
  }
}

class GridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Grid Screen")),
      body: GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(
            20,
            (index) => Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)]),
              child: Text(
                "Grid $index",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )),
    );
  }
}

class Listscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("LIst Screen")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://unsplash.com/photos/a-window-with-a-bunch-of-green-leaves-on-it-CdIN-5Dm7ec"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
