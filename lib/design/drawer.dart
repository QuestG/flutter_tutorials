import 'package:flutter/material.dart';

class DrawerSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer Sample'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('点击关闭drawer'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
            child: Icon(Icons.share),
            onPressed: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('I\'m snackbar'),
                action: SnackBarAction(label: 'action', onPressed: () {}),
              ));
            });
      }),
    );
  }
}
