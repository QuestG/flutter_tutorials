import 'package:flutter/material.dart';
import 'package:tutorials/user_interfaces/adding_interactivity.dart';

class NaviUi extends StatelessWidget {
  var itemTitles = ['添加互动'];

  var routes = [FavoriteWidget()];

  @override
  Widget build(BuildContext context) {
    var divider = Divider(color: Colors.grey);

    return Scaffold(
      appBar: AppBar(
        title: Text('用户界面'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ListTile(
                title: Text(itemTitles[index]),
              ),
              onTap: () {
                if (index < routes.length) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => routes[index]));
                } else {
                  Navigator.pushNamed(context, '/${itemTitles[index]}',
                      arguments: true);
                }
              },
            );
          },
          separatorBuilder: (context, index) => divider,
          itemCount: itemTitles.length),
    );
  }
}
