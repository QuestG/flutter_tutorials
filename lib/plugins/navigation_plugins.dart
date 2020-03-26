import 'package:flutter/material.dart';
import 'package:tutorials/plugins/camera_sample.dart';
import 'package:tutorials/plugins/video_player_sample.dart';

class NaviPlugins extends StatelessWidget {
  var titles = ['Camera', 'Video'];

  var widgets = [TakePicScreen(), VideoDisplayScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persistence'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${titles[index]}'),
              onTap: () {
                if (index >= widgets.length) {
                  Navigator.pushNamed(context, '/${titles[index]}',
                      arguments: true);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return widgets[index];
                  }));
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              color: Colors.grey,
            );
          },
          itemCount: titles.length),
    );
  }
}
