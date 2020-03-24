import 'package:flutter/material.dart';

class TextFormFieldSample extends StatefulWidget {
  @override
  _TextFormFieldSampleState createState() => _TextFormFieldSampleState();
}

///一般情况下，推荐使用 GlobalKey 来访问一个表单。嵌套组件且组件树比较复杂的情况下，可以使用 Form.of() 方法访问表单。
class _TextFormFieldSampleState extends State<TextFormFieldSample> {
  ///注意GlobalKey的创建是GlobalKey<FormState>()
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextFormField'),
      ),

      ///Form 表单容器，承载各种表单操作。
      body: Form(
          key: _globalKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (content) {
                  if (content.isEmpty) {
                    return '请输入内容';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Builder(builder: (context) {
                  return RaisedButton(
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('submit data'),
                        ));
                      }
                    },
                    child: Text('提交'),
                  );
                }),
              )
            ],
          )),
    );
  }
}
