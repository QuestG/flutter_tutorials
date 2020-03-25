import 'package:flutter/material.dart';
import 'package:tutorials/lists/multi_item_lists.dart';

class NaviLists extends StatelessWidget {
  var titles = [
    '拥有不同列表项的列表',
  ];

  var widgets = [MultiItemsList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lists'),
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
