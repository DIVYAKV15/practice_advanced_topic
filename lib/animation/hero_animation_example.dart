import 'package:flutter/material.dart';
void main()
{
  runApp(MaterialApp(home: HeroExample(),));
}

class HeroExample extends StatelessWidget {
  const HeroExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Hero Main Page"),
          elevation: 0,
          backgroundColor: Colors.red),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HeroDetails()));
        },
        child: Hero(
          tag:
              'imageHero', //tag is to identifictaion purpose which hero it has to go
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.pink),
            height: 100,
            width: 100,
            child: Icon(Icons.tour),
          ),
        ),
      ),
    );
  }
}

class HeroDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text("Hero Details Page"),
            elevation: 0,
            backgroundColor: Colors.red),
        body: Center(
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HeroExample())),
            child: Hero(
              tag: 'imageHero', //same name must be given for connection between
              child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Icon(
                    Icons.ac_unit,
                    size: 100,
                    color: Colors.black,
                  )),
            ),
          ),
        ));
  }
}
