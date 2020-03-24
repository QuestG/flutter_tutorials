import 'package:flutter/material.dart';
import 'package:tutorials/design/drawer.dart';
import 'package:tutorials/design/orientation.dart';
import 'package:tutorials/design/tab.dart';
import 'package:tutorials/design/theme.dart';

class NaviDesign extends StatelessWidget {
  var titles = [
    'Theme设置全局或局部主题风格',
    '使用tab',
    'Drawer和Snackbar',
    '适配Orientation'
  ];

  var widgets = [
    ThemeSample(),
    TabSample(),
    DrawerSample(),
    OrientationBuilderSample()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义Theme'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(titles[index]),
              onTap: () {
                if (index >= widgets.length) {
                  Navigator.pushNamed(context, "/${titles[index]}",
                      arguments: true);
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => widgets[index]));
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
