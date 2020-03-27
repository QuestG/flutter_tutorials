import 'package:flutter/material.dart';
import 'package:tutorials/animation/navi_animation.dart';
import 'package:tutorials/design/navigation_design.dart';
import 'package:tutorials/forms/navigation_forms.dart';
import 'package:tutorials/gesture/navigation_gesture.dart';
import 'package:tutorials/http/navigation_http.dart';
import 'package:tutorials/images/navigation_images.dart';
import 'package:tutorials/lists/navigation_lists.dart';
import 'package:tutorials/persistence/navigatioin_persistence.dart';
import 'package:tutorials/plugins/navigation_plugins.dart';
import 'package:tutorials/testing/navigation_testing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorials',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Tutorials Home Page'),
      onGenerateRoute: (settings) {
        print('settings.arguments: ${settings.arguments}');
        if (settings.arguments) {
          return MaterialPageRoute(builder: (context) => NotImplementedRoute());
        }
        return null;
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var divider = Divider(color: Colors.grey);

  var itemTitles = [
    'Animation',
    'Design',
    'Forms',
    'Gestures',
    'Images',
    'Lists',
    'Persistence',
    'Plugins',
    'Testing',
    'Http'
  ];

  var routes = [
    NaviAnimation(),
    NaviDesign(),
    NaviForms(),
    NaviGestures(),
    NaviImages(),
    NaviLists(),
    NaviPersistence(),
    NaviPlugins(),
    NaviTesting(),
    NaviHttp()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                child: ListTile(
                  title: Text(itemTitles[index]),
                ),
                onTap: () {
                  if (index >= routes.length) {
                    print("route name /${itemTitles[index]}");
                    //如果路由名没在路由表中注册，则触发onGenerateRoute
                    Navigator.pushNamed(context, "/${itemTitles[index]}",
                        arguments: true);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => routes[index],
                        ));
                  }
                },
              );
            },
            separatorBuilder: (context, index) => divider,
            itemCount: itemTitles.length));
  }
}

class NotImplementedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Not Implemented"),
      ),
      body: Center(
        child: Text("尚未实现"),
      ),
    );
  }
}
