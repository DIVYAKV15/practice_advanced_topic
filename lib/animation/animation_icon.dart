import 'package:flutter/material.dart';
void main()
{
  runApp(MaterialApp(home: AnimIcon(),));
}

class AnimIcon extends StatefulWidget {
  const AnimIcon({super.key});

  @override
  State<AnimIcon> createState() => _AnimIconState();
}

//as above classnte state so its coming as _private
class _AnimIconState extends State<AnimIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController
      controller; //to control a animation state eg;start stop and pause
  late Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose(); //completely clear from bg
    super.dispose();
  }

  void startAnimation() {
    if (controller.isDismissed) {
      ///Access various getters to know the state of the animation like:
      /// isAnimating , isCompleted , isDismissed , …etc.
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(///is for click event when the play button click it should change as pause button
            onTap: () => startAnimation(),
            child: AnimatedIcon(
                size: 50, icon: AnimatedIcons.play_pause, progress: animation)),
      ),
    );
  }
}
//to monitor state change of animation we need animation controller
//some functions can't be null as built in classes
//so in that case we use late
//nammalde app le illa animation nammade phone il correct ayitu sync agi varan
//vsync(vertical synchronization) ->inbetween animation and screen synchronization -ticker provider
///the AnimationController allows you to “control” the animation.
/// To do that, it needs a vsync value of type TickerProvider.
/// a Ticker basically keeps track of Flutter’s frames rendering and allows the controller to follow that ticker
/// and “animate” through it within the specified duration,
///while linearly producing values between the lowerBound and the upperBound values which are by default 0 & 1.
