import 'package:flutter/material.dart';

///滑动清除效果
class DismissibleSample extends StatefulWidget {
  @override
  _DismissibleSampleState createState() => _DismissibleSampleState();
}

class _DismissibleSampleState extends State<DismissibleSample> {
  final items = List.generate(20, (index) => 'item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('滑动清除'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var item = ListTile(
            title: Text(items[index]),
          );

          ///每个Dismissible实例都必须包含一个Key。Key让Flutter能够对Widgets做唯一标识
          ///我们还需要提供一个函数，告诉应用，在项目被移出后，要做什么。
          return Dismissible(
            key: Key(items[index]),
            child: item,
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('item $index dismissed')));
            },

            ///滑动时的滞留背景色
            background: Container(
              color: Colors.red,
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
