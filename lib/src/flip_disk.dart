import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlipDisk extends StatefulWidget {
  final Color onColor;
  final Color offColor;
  final bool isOn;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Size size;

  const FlipDisk({
    @required this.onColor,
    @required this.offColor,
    @required this.size,
    this.isOn = false,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    Key key,
  }) : super(
          key: key,
        );

  @override
  FlipDiskState createState() {
    return FlipDiskState(
      isOn: isOn,
      onColor: onColor,
      offColor: offColor,
    );
  }
}

class FlipDiskState extends State<FlipDisk> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  bool isOn = false;
  Color onColor;
  Color offColor;

  FlipDiskState({
    @required this.isOn,
    @required this.onColor,
    @required this.offColor,
  });

  bool get needsAnimation => widget.isOn != isOn;
  bool get needsOnColorUpdate => widget.onColor != onColor;
  bool get needsOffColorUpdate => widget.offColor != offColor;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        duration: Duration(milliseconds: 335), vsync: this)
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
            isOn = isOn != true;
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
        .chain(CurveTween(curve: Curves.easeIn))
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
        margin: widget.margin,
        padding: widget.padding,
        width: widget.size.width,
        height: widget.size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isOn ? onColor : offColor,
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
    setEntry(3, 2, 0.0001);
    rotateX(rotation);
    rotateY(rotation * .5 * -1);
  }
}
