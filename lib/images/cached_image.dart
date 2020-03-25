import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cached Image'),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl:
              'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1585099172&di=4a48d7cee021bab77bae7141a869474b&src=http://a3.att.hudong.com/68/61/300000839764127060614318218_950.jpg',
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
