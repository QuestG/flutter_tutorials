import 'package:flutter/material.dart';

class OrientationBuilderSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientation'),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.landscape ? 3 : 2,
          children: List.generate(
              30,
              (index) => Center(
                    child: Text(
                      'item $index',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )),
        );
      }),
    );
  }
}
