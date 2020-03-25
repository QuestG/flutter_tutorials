import 'package:flutter/material.dart';

class SliverSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Floating App Bar',
              style: TextStyle(color: Colors.blue),
            ),
            floating: true,

            ///flexibleSpace可以设置SliverAppBar的背景
            flexibleSpace: Image.asset(
              'assets/images/lake.jpg',
              fit: BoxFit.fill,
            ),
            expandedHeight: 200,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) => ListTile(
                    title: Text('Item $index'),
                  )))
        ],
      ),
    );
  }
}
