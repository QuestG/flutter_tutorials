import 'package:test/test.dart';
import 'package:tutorials/testing/unit_test.dart';

void main() {
  ///如果多个测试之间互相关联，可以使用 test 这个 package 提供的 group 函数将他们整合到一起。
  group('Test Counter', () {
    test('counter value start at 0', () {
      expect(Counter().value, 0);
    });

    test('counter value increment', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });

    test('counter value decrement', () {
      var counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });
  });
}
