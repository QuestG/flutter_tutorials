import 'package:flutter/material.dart';
import 'package:tutorials/gesture/ink_well.dart';
import 'package:tutorials/images/cached_image.dart';
import 'package:tutorials/images/faded_image.dart';

class NaviImages extends StatelessWidget {
  var titles = ['CachedNetworkImage', 'InkWell', 'FadeInImage'];

  var widgets = [CachedImage(), InkWellSample(), FadeInImageSample()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture'),
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
