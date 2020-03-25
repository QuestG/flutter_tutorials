import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSample extends StatefulWidget {
  @override
  _SharedPreferencesSampleState createState() =>
      _SharedPreferencesSampleState();
}

class _SharedPreferencesSampleState extends State<SharedPreferencesSample> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    var shared = await SharedPreferences.getInstance();
    setState(() {
      _count = shared.getInt('count') ?? 0;
    });
  }

  _incrementCount() async {
    setState(() {
      _count = _count + 1;
    });
    var shared = await SharedPreferences.getInstance();
    bool success = await shared.setInt('count', _count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences'),
      ),
      body: Center(
        child: Text('$_count'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: _incrementCount),
    );
  }
}
