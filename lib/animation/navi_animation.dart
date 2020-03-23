import 'package:flutter/material.dart';
import 'package:tutorials/animation/adding_interactivity.dart';
import 'package:tutorials/animation/animated_container.dart';
import 'package:tutorials/animation/animated_opacity.dart';
import 'package:tutorials/animation/animation_physics.dart';
import 'package:tutorials/animation/samples_animation.dart';

class NaviAnimation extends StatelessWidget {
  var itemTitles = [
    '添加互动',
    'LogoAnimation',
    'AnimatedContainer',
    'AnimatedOpacity',
    'AnimationMockPhysics'
  ];

  var routes = [
    FavoriteWidget(),
    LogoAnimationWidget(),
    AnimatedContainerWidget(),
    AnimatedOpacityWidget(),
    AnimationPhysicsDemo()
  ];

  @override
  Widget build(BuildContext context) {
    var divider = Divider(color: Colors.grey);

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ListTile(
                title: Text(itemTitles[index]),
              ),
              onTap: () {
                if (index < routes.length) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => routes[index]));
                } else {
                  Navigator.pushNamed(context, '/${itemTitles[index]}',
                      arguments: true);
                }
              },
            );
          },
          separatorBuilder: (context, index) => divider,
          itemCount: itemTitles.length),
    );
  }
}
