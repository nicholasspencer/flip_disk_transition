import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const halfPi = pi * .5;

class FlipDiscTransition extends AnimatedWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FlipDisk extends StatefulWidget {
  final Color onColor;
  final Color offColor;
  final bool isOn;

  FlipDisk({
    this.onColor = Colors.white,
    Color offColor,
    this.isOn = true,
    Key key,
  })  : this.offColor = offColor ?? Colors.grey.withOpacity(0.15),
        super(
          key: key,
        );

  @override
  FlipDiskState createState() => FlipDiskState();
}

class FlipDiskState extends State<FlipDisk> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  bool _isOff = false;

  bool get needsAnimation => widget.isOn == _isOff;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        duration: Duration(milliseconds: 200), vsync: this)
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.dismissed:
            if (needsAnimation) {
              _animationController.forward();
            }
            break;
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.completed:
            _isOff = _isOff != true;
            _animationController.reverse();
            break;
        }
      })
      ..addListener(() {
        setState(() {});
      });

    _animation = Tween(begin: 0.0, end: pi / 2)
        .chain(CurveTween(curve: Curves.easeInCubic))
        .animate(_animationController);

    if (needsAnimation) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(FlipDisk oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (needsAnimation) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlipDiskTransform(
      rotation: _animation.value,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isOff ? widget.offColor : widget.onColor,
          // boxShadow: [
          //   BoxShadow(color: Colors.grey, blurRadius: 1.0, offset: Offset(1, 1))
          // ],
        ),
      ),
    );
  }
}

class FlipDiskTransform extends StatelessWidget {
  final Widget child;
  final double rotation;

  const FlipDiskTransform({
    Key key,
    @required this.rotation,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..flip(rotation),
      alignment: Alignment.center,
      child: child,
    );
  }
}

extension _Matrix4Extension on Matrix4 {
  void flip(double rotation) {
    // rotation = rotation >= halfPi ? pi - rotation : rotation;
    setEntry(3, 2, 0.0001);
    rotateX(rotation);
    rotateY(rotation * .5 * -1);
  }
}
