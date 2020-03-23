import 'package:flutter/material.dart';

class AnimatedOpacityWidget extends StatefulWidget {
  @override
  _AnimatedOpacityWidgetState createState() => _AnimatedOpacityWidgetState();
}

class _AnimatedOpacityWidgetState extends State<AnimatedOpacityWidget> {
  var _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedOpacity'),
      ),
      body: AnimatedOpacity(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(seconds: 1)),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.flip),
          onPressed: () {
            setState(() {
              _visible = !_visible;
            });
          }),
    );
  }
}
