import 'dart:math';

import 'package:flutter/material.dart';

class SpinAimationWidget extends StatefulWidget {
  const SpinAimationWidget(
      {Key key,
      this.isComplete,
      this.spinAnimationController,
      this.translateAnimationController,
      this.translateDownAnimation,
      this.translateUpAnimation,
      this.rotateAnimation})
      : super(key: key);

  final AnimationController spinAnimationController;
  final AnimationController translateAnimationController;
  final Animation<Offset> translateDownAnimation;
  final Animation<Offset> translateUpAnimation;
  final Animation<double> rotateAnimation;

  final bool isComplete;

  @override
  _SpinAimationWidgetState createState() => _SpinAimationWidgetState();
}

class _SpinAimationWidgetState extends State<SpinAimationWidget> {
  // void initState() {
  //   super.initState();

  //   translateAnimationController.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       // translateAnimationController.reverse();
  //     } else if (status == AnimationStatus.dismissed) {
  //       Future.delayed(const Duration(seconds: 2), () {
  //         translateAnimationController.forward();
  //       });
  //     }
  //   });

  //   spinAnimationController.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       translateAnimationController.reverse();
  //     } else if (status == AnimationStatus.dismissed) {
  //       // translateAnimationController.forward();
  //       // print("dis");
  //     }
  //   });

  //   timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
  //     // translateAnimationController.reset();
  //     // translateAnimationController.forward();

  //     spinAnimationController.reset();
  //     spinAnimationController.forward();
  //   });

  //   Future.delayed(const Duration(seconds: 2), () {
  //     translateAnimationController.forward();
  //   });

  //   Future.delayed(const Duration(seconds: 2), () {
  //     timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
  //       // translateAnimationController.reset();
  //       // translateAnimationController.forward();

  //       if (isComplete) {
  //         setState(() {
  //           isComplete = false;
  //         });
  //       } else {
  //         setState(() {
  //           isComplete = true;
  //         });
  //       }
  //     });
  //   });

  //   timer = Timer.periodic(Duration(seconds: 6), (Timer t) {
  //     // translateAnimationController.reset();
  //     // translateAnimationController.forward();

  //     if (isComplete) {
  //       setState(() {
  //         isComplete = false;
  //       });
  //     } else {
  //       setState(() {
  //         isComplete = true;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AnimatedBuilder(
          animation: widget.rotateAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: widget.rotateAnimation.value * 2 * pi,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      builder: (context, child) {
                        return Transform.translate(
                          offset: widget.translateDownAnimation.value,
                          child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.isComplete
                                    ? Color.fromRGBO(31, 27, 36, 1)
                                    : Colors.white,
                              )),
                        );
                      },
                      animation: widget.translateDownAnimation,
                    ),
                    AnimatedBuilder(
                      builder: (context, child) {
                        return Transform.translate(
                          offset: widget.translateUpAnimation.value,
                          child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.isComplete
                                    ? Color.fromRGBO(31, 27, 36, 1)
                                    : Colors.white,
                              )),
                        );
                      },
                      animation: widget.translateUpAnimation,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
