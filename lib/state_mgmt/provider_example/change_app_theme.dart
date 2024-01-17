import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/state_mgmt/provider_example/controller/themeController.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => ThemeProvider(), child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Provider.of<ThemeProvider>(context).isDarkTheme
            ? ThemeData.dark()
            : ThemeData.light(),
       //if no changes need in theme then we can set like this either dark or light
       // darkTheme: ThemeData.dark(), //basically app theme is dark so defining here once button clicked it change to light
        home: ChangeAppTheme());
  }
}

class ChangeAppTheme extends StatelessWidget {
  const ChangeAppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .switchTheme();
              },
              child: Icon(Icons.nightlight_outlined))),
    );
  }
}
