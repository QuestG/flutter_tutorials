import 'dart:convert';

import 'package:http/http.dart' as http;

///“单元”是一个抽象的名称，它可以表示一个函数、方法或者类。使用单元测试可轻松地验证单个函数、方法或类的行为。
///test 这个 package 提供了写单测的核心框架， flutter_test 包则提供了额外的功能来测试 widget。
class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

class Post {
  dynamic data;

  Post.fromJson(this.data);
}

Future<Post> fetchPost(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
