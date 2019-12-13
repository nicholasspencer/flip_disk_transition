import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  FlipDiskState createState() {
    return FlipDiskState(
      onColor: onColor,
      offColor: offColor,
    );
  }
}

class FlipDiskState extends State<FlipDisk> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  bool _isOff = false;

  Color onColor;
  Color offColor;

  FlipDiskState({
    @required this.onColor,
    @required this.offColor,
  });

  bool get needsAnimation => widget.isOn == _isOff;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        duration: Duration(milliseconds: 500), vsync: this)
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
            onColor = widget.onColor;
            offColor = widget.offColor;
            _animationController.reverse();
            break;
        }
      })
      ..addListener(() {
        setState(() {});
      });

    _animation = Tween(begin: 0.0, end: pi / 2)
        .chain(CurveTween(curve: Curves.easeInExpo))
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
    } else if (widget.onColor != oldWidget.onColor ||
        widget.offColor != oldWidget.offColor) {
      if (widget.isOn) {
        _animationController.forward();
      } else {
        setState(() {
          onColor = widget.onColor;
          offColor = widget.offColor;
        });
      }
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
          color: _isOff ? offColor : onColor,
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
