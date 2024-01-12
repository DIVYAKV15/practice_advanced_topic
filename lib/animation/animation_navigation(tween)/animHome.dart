import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'second_page_animation.dart';

void main() {
  runApp(MaterialApp(
    home: AnimHome(),
  ));
}

class AnimHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondAnimation) =>
                          const SecondPage(),
                      transitionsBuilder:
                          (context, animation, animation2, child) {
                        return FadeTransition(
                          opacity: animation, //how much it as to fade
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
                child: const Text("Fade Animation"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const SecondPage();
                      }, transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return ScaleTransition(
                          // scale: animation,
                          // child: Container(color: Colors.red),
                          scale: Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).animate(
                            CurvedAnimation(
                                parent: animation, curve: Curves.fastOutSlowIn),

                            // ScaleTransition(
                            //   scale: scale,
                          ),
                          child: Container(color: Colors.red),
                        );
                      }),
                    );
                  },
                  child: const Text("Scale Animation")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const SecondPage();
                      },
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1.0, 0.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          )),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text("Slide animation"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(duration: const Duration(milliseconds: 1000),
                          type: PageTransitionType.topToBottomJoined,
                          child: SecondPage(),
                          childCurrent: this));
                },
                child: const Text("using page transition package"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//pagebuilder is to which page it has to go as animation
//to work on the animation we need transitionanimation
