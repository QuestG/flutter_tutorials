import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

///模拟物理效果的动画
class AnimationPhysicsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('animation mock physics'),
      ),
      body: AnimationPhysics(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AnimationPhysics extends StatefulWidget {
  Widget child;

  AnimationPhysics({this.child});

  @override
  _AnimationPhysicsState createState() => _AnimationPhysicsState();
}

class _AnimationPhysicsState extends State<AnimationPhysics>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Alignment _dragAlignment = Alignment.center;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(details.delta.dx / (size.width / 2),
              details.delta.dy / (size.height / 2));
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }

  Animation<Alignment> _animation;

  /// 模拟弹簧的效果
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller
        .drive(AlignmentTween(begin: _dragAlignment, end: Alignment.center));

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    //
    const spring = SpringDescription(mass: 30, stiffness: 5, damping: 5);
    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    ///AnimationController的animateWith方法可以执行各种模拟动画效果。
    _controller.animateWith(simulation);
  }
}
