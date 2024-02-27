import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_provider.dart';

void main() {
  runApp(MaterialApp(
    home:
        ChangeNotifierProvider(create: (context) => Counter(), child: Myapp()),
  ));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Provider.of<Counter>(context).isDark
            ? ThemeData.dark()
            : ThemeData.light(),home: NewAPp(),);

  }
}

class NewAPp extends StatelessWidget {
  const NewAPp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ElevatedButton(onPressed: (){
          Provider.of<Counter>(context,listen: false).change();
        },child: Text("Hi ",style: TextStyle(color: Colors.red),)),
      ),
    );
  }
}
