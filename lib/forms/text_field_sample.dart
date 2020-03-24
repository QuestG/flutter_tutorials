import 'package:flutter/material.dart';

class TextFieldSample extends StatefulWidget {
  @override
  _TextFieldSampleState createState() => _TextFieldSampleState();
}

class _TextFieldSampleState extends State<TextFieldSample> {
  var _controller = TextEditingController();

  var _textInControl = '';

  var _textInChange = '';

  var _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField练习'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
            ),
            Text(_textInControl),
            TextField(
              focusNode: _focusNode,
              onChanged: (text) {
                setState(() {
                  _textInChange = text;
                });
              },
            ),
            Text(_textInChange),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(_focusNode);
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _textInControl = _controller.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
