import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyCustomClipper(),
  ));
}

class MyCustomClipper extends StatelessWidget {
  const MyCustomClipper({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Opacity(
                opacity: 0.2,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    height: 200,
                  ),
                ),
              ),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              color: Colors.deepPurpleAccent,
              height: 170,
            ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height); //this will take above container size
    //first point of quadratic beizere curve
    var firstStart = Offset(size.width / 5, size.height);
    //second point of quadratic beizere curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50);
    path.quadraticBezierTo(
        firstStart.dx,firstStart.dy,firstEnd.dx, firstEnd.dy , );

    var secondStart=Offset(size.width-(size.width/3.24),size.height-105);
    var secondEnd=Offset(size.width,size.height-10);
    path.quadraticBezierTo(
        secondStart.dx,secondStart.dy,  secondEnd.dx,secondEnd.dy );
    path.lineTo(size.width, 0);//path end
   path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>false;


}
//https://medium.com/flutter-community/flutter-custom-clipper-28c6d380fdd6
//x represents a horizontal axis and y represents the vertical axis.
// The drawing path starts from the top-left corner and it is (0,0).
//reference
//https://miro.medium.com/v2/resize:fit:750/format:webp/1*zcRNhxW7P_GdxLZOY8h9Tg.png