import 'package:flutter/material.dart';

/// 实现一个Logo从无到全屏到动画效果
class LogoAnimationWidget extends StatefulWidget {
  @override
  _LogoAnimationWidgetState createState() => _LogoAnimationWidgetState();
}

class _LogoAnimationWidgetState extends State<LogoAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
