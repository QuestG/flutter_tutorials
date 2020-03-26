import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  final String title;
  final String message;

  TestWidget({Key key, @required this.title, @required this.message})
      : super(key: key);

  //如果没有WidgetsApp或materialApp的包裹，在进行Widget测试时会不通过。
  //这里的疑问时MediaQuery的作用是什么？

  //The following assertion was thrown building TestWidget:
  //MediaQuery.of() called with a context that does not contain a MediaQuery.
  //No MediaQuery ancestor could be found starting from the context that was passed to MediaQuery.of().
  //This can happen because you do not have a WidgetsApp or MaterialApp widget (those widgets introduce
  //a MediaQuery), or it can happen if the context you use comes from a widget above those widgets.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Test Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    child: ListTile(title: Text(todo)),
                    background: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
