import 'package:flutter/material.dart';

class InkWellSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InkWell'),
      ),
      body: Center(
        ///如果想更换InkWell中child的背景颜色，则需要将InkWell包含在Material Widget中
        ///否则，InkWell的点按涟漪效果，不会生效。
        child: Material(
          color: Colors.blue,
          child: InkWell(
            ///设置涟漪的颜色
            splashColor: Colors.red,
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Text('button'),
            ),
          ),
        ),
      ),
    );
  }
}
