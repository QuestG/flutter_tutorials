import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.lightBlue[800],
            accentColor: Colors.cyan[400],
            textTheme: TextTheme(
              headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(
                  fontSize: 36.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            )),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Custom Theme'),
            ),
            body: ContentWidget(),
            floatingActionButton: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context)
                        .colorScheme
                        .copyWith(secondary: Colors.yellow)),
                child: FloatingActionButton(
                  onPressed: null,
                  child: Icon(Icons.add),
                ))));
  }
}

//这里需要注意BuildContext的作用域
class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 100,
      color: Theme.of(context).accentColor,
      child: Text(
        'Text with a background',
        style: Theme.of(context).textTheme.headline6,
      ),
    ));
  }
}
