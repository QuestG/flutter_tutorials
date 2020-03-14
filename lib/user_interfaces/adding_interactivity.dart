import 'package:flutter/material.dart';

///给app添加交互行为

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  var _isFavorite = true;
  var _favorCount = 41;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加交互性'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Image.asset('assets/images/lake.jpg'),
          ),
          buildContainer(),
          OperationWidget(),
          Container(
            margin: EdgeInsets.only(left: 24, top: 24),
            alignment: Alignment.centerLeft,
            child: Text('Lakes ocean...'),
          )
        ],
      ),
    );
  }

  ///构建 显示地点和星标的Widget组合
  Container buildContainer() {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                child: Text('KanDersteg, Switzerland'),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 28,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon:
                      _isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
                  color: Colors.red[500],
                  onPressed: _toggleFavorite,
                ),
              ),
              Text('$_favorCount'),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _favorCount--;
        _isFavorite = false;
      } else {
        _favorCount++;
        _isFavorite = true;
      }
    });
  }
}

/// 图标下方添加文字
class OperationWidget extends StatelessWidget {
  const OperationWidget({
    Key key,
  }) : super(key: key);

  static const names = ['CALL', 'ROUTE', 'SHARE'];

  static const icons = [Icons.phone, Icons.near_me, Icons.share];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: names
              .map((name) => Column(
                    children: <Widget>[
                      Icon(
                        icons[names.indexOf(name)],
                        color: Colors.blue,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ))
              .toList()),
    );
  }
}
