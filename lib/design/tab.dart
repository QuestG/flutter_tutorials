import 'package:flutter/material.dart';

class TabSample extends StatefulWidget {
  @override
  _TabSampleState createState() => _TabSampleState();
}

class _TabSampleState extends State<TabSample> {
  var _tabs = <Tab>[
    Tab(
      text: 'Java',
    ),
    Tab(
      text: 'Kotlin',
    ),
    Tab(
      text: 'Dart',
    )
  ];

  @override
  Widget build(BuildContext context) {
    //创建出一个可供所有子 widgets 使用的 TabController，默认可以使用DefaultTabController，也可以自定义TabController。
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Sample'),
          bottom: TabBar(tabs: _tabs),
        ),
        body: TabBarView(
            children: _tabs
                .map((e) => Center(
                      child: Text(e.text),
                    ))
                .toList()),
      ),
    );
  }
}
