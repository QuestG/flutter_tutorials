import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

///通过 Flutter 提供的 compute() 方法将解析和转换的工作移交到一个后台 isolate 中。
///这个 compute() 函数可以在后台 isolate 中运行复杂的函数并返回结果。
///Isolates 通过来回传递消息来交流。这些消息可以是任何值，它们可以是 null、num、bool、double 或者 String，
///哪怕是像这个例子中的 List<Photo> 这样简单对象都没问题。
///当你试图传递更复杂的对象时，你可能会遇到错误，例如在 isolates 之间的 Future 或者 http.Response。
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/photos');
  return compute(parsePhotos, response.body);
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class IsolateSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在后台处理json数据解析'),
      ),
      body: FutureBuilder<List<Photo>>(
          future: fetchPhotos(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('isolateerror: ${snapshot.error}');
            }

            return snapshot.hasData
                ? PhotoList(
                    photos: snapshot.data,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class PhotoList extends StatelessWidget {
  final List<Photo> photos;

  PhotoList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: photos.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          print('isolate url:${photos[index].thumbnailUrl}');
          return Image.network(photos[index].thumbnailUrl);
        });
  }
}
