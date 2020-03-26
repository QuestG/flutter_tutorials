import 'package:flutter/material.dart';

class FlutterDriverSample extends StatelessWidget {
  final _items = List.generate(100, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Driver'),
      ),
      body: ListView.builder(
        //添加Key，是为了在测试时方便通过Key来找到对应的List
        key: Key('long_list'),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _items[index],
              key: Key('item_${index}_text'),
            ),
          );
        },
        itemCount: _items.length,
      ),
    );
  }
}
