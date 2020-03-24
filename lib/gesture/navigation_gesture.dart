import 'package:flutter/material.dart';
import 'package:tutorials/gesture/dismissible_sample.dart';

class NaviGestures extends StatelessWidget {
  var titles = ['Dismissible'];

  var widgets = [DismissibleSample()];

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
