import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tutorials/testing/widget_test_sample.dart';

///flutter_test package 提供了以下工具用于 widget 的测试：
///1) WidgetTester，使用该工具可在测试环境下建立 widget 并与其交互。
///2) testWidgets() 函数，此函数会自动为每个测试创建一个 WidgetTester，用来代替普通的 test 函数。
///3) Finder 类，可以方便我们在测试环境下查找 widgets。
///4) Widget-specific Matcher 常量，该常量在测试环境下帮助我们验证 Finder 是否定位到一个或多个 widgets。
///
/// 步骤：
///添加一个 flutter_test 依赖
///创建一个测试用的 widget
///创建一个 testWidgets 测试方法
///使用 WidgetTester 建立 widget
///使用 Finder 查找 widget
///使用 Matcher 验证 widget 是否正常工作
void main() {
  testWidgets('This widget has a title and message',
      (WidgetTester tester) async {
    //创建一个要测试的Widget，并让WidgetTester去构建它。
    //初次调用 pumpWidget() 之后，WidgetTester 会提供其他方式来重建相同的 widget。这对使用 StatefulWidget 或者动画会非常有用。
    //例如，如果我们点击调用 setState() 的按钮，在测试环境中，Flutter 并不会自动重建你的 widget。我们需要用以下列举的方法来让 Flutter 再一次建立我们的 widget。
    //tester.pump()：在一段给定时间后重建 widget。
    //tester.pumpAndSettle()：在给定期间内不断重复调用 pump 直到完成所有绘制帧。一般需要等到所有动画全部完成。
    await tester.pumpWidget(TestWidget(title: 'T', message: 'M'));

    var titleFinder = find.text('T');
    var messageFinder = find.text('M');

    //Matcher 类是 test 包里的核心部分，它提供一种通用方法来验证给定值是否符合我们的预期。
    //在这个示例中，我们要确保 Widget 只在屏幕中出现一次。因此，可以使用 findsOneWidget Matcher。
    //flutter_test 还为常见情况提供了其他的 matchers。
    //findsNothing
    //验证没有可被查找的 widgets。
    //findsWidgets
    //验证一个或多个 widgets 被找到。
    //findsNWidgets
    //验证特定数量的 widgets 被找到。
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  ///定位到目标Widget的三种方法：
  ///1）查找含有特定文本的Widget，使用find.text()
  ///2) 如果有多个相同的Widget，可以使用Key查找指定的Widget，find.byKey()
  ///3) 查找Widget的具体实例，可以使用find.byWidget()
  ///更多情况可以参考CommonFinders的方法。
  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('H'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('H'), findsOneWidget);
  });

  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    final testKey = Key('K');

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('finds a specific instance', (WidgetTester tester) async {
    final childWidget = Padding(padding: EdgeInsets.zero);

    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  ///WidgetTester 提供了文本输入、点击、拖动的相关方法：
  ///enterText()
  ///tap()
  ///drag()
  testWidgets('添加和删除待办事项', (WidgetTester tester) async {
    await tester.pumpWidget(TodoList());
    //向TextField中输入文本'hi'
    await tester.enterText(find.byType(TextField), 'hi');
    //点击添加按钮
    await tester.tap(find.byType(FloatingActionButton));
    //在测试环境中，Flutter 并不会自动重建widget。需要用pump或pumAndSettle再一次建立widget。
    await tester.pump();
    //确认屏幕上的清单项中是否有内容为'hi'的Widget
    expect(find.text('hi'), findsOneWidget);

    //确保滑动删除操作能正常从列表中移除清单项
    //1）模拟滑动删除操作
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
    //2) 重建Widget 直到动画结束。
    await tester.pumpAndSettle();
    //3) 验证指定item已被删除
    expect(find.text('hi'), findsNothing);
  });
}
