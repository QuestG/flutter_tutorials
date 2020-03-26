import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tutorials/testing/unit_test.dart';

//MockClient 类会实现 http.Client 类。如此一来，我们就可以把 MockClient 传给 fetchPost 函数，
//还可以在每个测试中返回不同的 http 请求结果。
class MockClient extends Mock implements http.Client {}

main() {
  group('fetchPost', () {
    test('如果请求成功，返回解析结果', () async {
      final mockClient = MockClient();
      when(mockClient.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer(
              (realInvocation) async => http.Response('{"title":"Test"}', 200));

      expect(await fetchPost(mockClient), TypeMatcher<Post>());
    });

    test('如果请求失败，抛出异常', () {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((realInvocation) async => http.Response('NotFound', 404));
      expect(fetchPost(client), throwsException);
    });
  });
}
