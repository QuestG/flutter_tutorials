import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

///1)在 Flutter 中，只用一行代码就可以创建一个连接到服务器的 WebSocketChannel。需要先引入web_socket_channel包。
///建立了连接之后，你就可以监听来自服务器的消息了。
///当你向测试服务器发送一条消息之后，它会将同样的消息发送回来。
///2)WebSocketChannel 提供了一个来自服务器的 Stream 类消息。
///这个 Stream 类是 dart:async 包的基本组成部分，它提供了一个从数据源监听异步事件的方法。
///和 Future 不一样的是，Future 只能返回一个单独的异步响应，而 Stream 类可以随着时间的推移传递很多事件。
///StreamBuilder widget 会和 Stream 建立起连接，并且每当它接收到一个使用给定 builder() 函数的事件时，就会通知 Flutter 去 rebuild。
///3)要向服务器发送数据，可以使用 WebSocketChannel 提供的 sink 下的 add() 方法来发送信息。
///4)当你使用完 WebSocket 之后，记得关闭这个连接。要关闭这个 WebSocket 连接，只需要关闭 sink。
class WebSocketSample extends StatefulWidget {
  @override
  _WebSocketSampleState createState() => _WebSocketSampleState();
}

class _WebSocketSampleState extends State<WebSocketSample> {
  TextEditingController _controller = TextEditingController();
  WebSocketChannel _channel =
      IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
