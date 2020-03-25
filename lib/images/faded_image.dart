import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

///FadeInImage 适用于任何类型的图片：内存中的，本地存储的，抑或是网络上的。
class FadeInImageSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FadeInImage'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
          Center(
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1585099172&di=4a48d7cee021bab77bae7141a869474b&src=http://a3.att.hudong.com/68/61/300000839764127060614318218_950.jpg'),
          )
        ],
      ),
    );
  }
}
