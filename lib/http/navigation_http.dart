import 'package:flutter/material.dart';
import 'package:tutorials/http/http_delete_sample.dart';
import 'package:tutorials/http/http_isolate_sample.dart';
import 'package:tutorials/http/websocket_sample.dart';

class NaviHttp extends StatelessWidget {
  var titles = ['删除网络数据', '在后台解析json数据', '发起WebScoket请求'];

  var widgets = [HttpDeleteSample(), IsolateSample(), WebSocketSample()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${titles[index]}'),
              onTap: () {
                if (index >= widgets.length) {
                  Navigator.pushNamed(context, '/${titles[index]}',
                      arguments: true);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return widgets[index];
                  }));
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              color: Colors.grey,
            );
          },
          itemCount: titles.length),
    );
  }
}
