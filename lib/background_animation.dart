import 'package:flutter/material.dart';

class BackgroundAnimationWidget extends StatefulWidget {
  const BackgroundAnimationWidget(
      {Key key,
      this.backgroundAnimationController,
      this.animation,
      this.isComplete})
      : super(key: key);

  final AnimationController backgroundAnimationController;
  final Animation<double> animation;
  final bool isComplete;

  @override
  _BackgroundAnimationWidgetState createState() =>
      _BackgroundAnimationWidgetState();
}

class _BackgroundAnimationWidgetState extends State<BackgroundAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isComplete ? Color.fromRGBO(31, 27, 36, 1) : Colors.white,
      body: Container(
        child: Center(
          child: AnimatedBuilder(
            animation: widget.backgroundAnimationController,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.animation.value,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.isComplete
                        ? Colors.white
                        : Color.fromRGBO(31, 27, 36, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
