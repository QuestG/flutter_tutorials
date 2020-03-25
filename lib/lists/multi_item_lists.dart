import 'package:flutter/material.dart';

///拥有不同列表项的列表
class MultiItemsList extends StatelessWidget {
  final items = List<ListItem>.generate(
      30,
      (index) => index % 6 == 0
          ? HeadingItem('Heading $index')
          : MessageItem('Sender $index', 'Message body $index'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('不同列表项的列表'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: items[index].buildTitle(context),
            subtitle: items[index].buildSubtitle(context),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);
}

///自定义标题的样式
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildSubtitle(BuildContext context) {
    return null;
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

///自定义内容项的样式
class MessageItem implements ListItem {
  final String body;
  final String sender;

  MessageItem(this.sender, this.body);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);
}
