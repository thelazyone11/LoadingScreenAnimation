import 'dart:async';

import 'package:loading_screen_animation/background_animation.dart';
import 'package:loading_screen_animation/spin_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController backgroundAnimationController;
  Animation<double> _animation;
  AnimationController spinAnimationController;
  AnimationController translateAnimationController;
  Animation<Offset> translateDownAnimation;
  Animation<Offset> translateUpAnimation;
  Animation<double> rotateAnimation;

  bool isComplete = false;
  Timer timer;

  void initState() {
    super.initState();
    backgroundAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(CurvedAnimation(
        parent: backgroundAnimationController, curve: Curves.fastOutSlowIn));

    spinAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    translateAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    translateDownAnimation =
        Tween<Offset>(end: Offset(80.0, 0.0), begin: Offset(80.0, 80.0))
            .animate(translateAnimationController);
    translateUpAnimation =
        Tween<Offset>(end: Offset(80.0, 164.0), begin: Offset(80.0, 80.0))
            .animate(translateAnimationController);

    rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: spinAnimationController, curve: Curves.fastOutSlowIn));

    spinAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        translateAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {}
    });

    translateAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
      } else if (status == AnimationStatus.dismissed) {
        if (isComplete) {
          setState(() {
            isComplete = false;
          });
        } else {
          setState(() {
            isComplete = true;
          });
        }
        backgroundAnimationController.reset();
        backgroundAnimationController.forward();

        Future.delayed(const Duration(milliseconds: 2000), () {
          translateAnimationController.forward();
        });
      }
    });

    timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
      spinAnimationController.reset();
      spinAnimationController.forward();
    });

    translateAnimationController.forward();
  }

  @override
  void dispose() {
    backgroundAnimationController.dispose();
    spinAnimationController.dispose();
    translateAnimationController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAnimationWidget(
          animation: _animation,
          backgroundAnimationController: backgroundAnimationController,
          isComplete: isComplete,
        ),
        SpinAimationWidget(
          isComplete: isComplete,
          rotateAnimation: rotateAnimation,
          spinAnimationController: spinAnimationController,
          translateAnimationController: translateAnimationController,
          translateDownAnimation: translateDownAnimation,
          translateUpAnimation: translateUpAnimation,
        ),
      ],
    );
  }
}
