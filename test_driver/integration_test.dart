import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart' as testLibrary;

//FlutterDriver 类为滚动列表提供了三个方法：
//scroll() 方法允许我们按给定的数量滚动特定的列表。
//方法找到已经被渲染的特定的 Widget，并将它完全滚动到视图中，某些 widget 比如 ListView.builder，只有在将要显示的时候才会去渲染列表项。
//scrollUntilVisible() 方法会滚动列表直到特定的 widget 显示出来。
//当我们遇到三种方法同时使用的情况时，scrollUntilVisible 方法通常来说是最优的方式，为什么呢？
//如果只使用 scroll() 方法，我们可能错误地假定列表中每一项的高度，这可能导致滚动的太多或太少。
//如果使用 scrollIntoView() 方法，我们假定 Widget 已被实例化和渲染。为了验证 app 在不同的设备了能够很好的运行，我们可以对具有不同屏幕大小的设备运行集成测试。
//因为 ListView.builder 是只有在需要的时候才会渲染列表项，所以是否渲染特定的 Widget 取决于屏幕的大小。
//所以，我们既不需要知道所有列表项的高度，也不需要知道一个特定的 Widget 在不同的屏幕大小的设备上是否被渲染，
//我们只需要调用 scrollUntilVisible() 方法反复滚动列表直到找到要查找的列表项。
void main() {
  testLibrary.group('Tutorials Testing', () {
    FlutterDriver driver;
    //在执行任何测试之前，都要保证先连接FlutterDriver
    testLibrary.setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    //在所有测试结束之后，关闭driver
    testLibrary.tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    testLibrary.test('Verifies the list containts a specific item', () async {
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      /// FlutterDriver 类中的 traceAction()将应用程序性能的详细信息记录在 Timeline 中
      /// 性能分析
      var timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(listFinder, itemFinder,
            dyScroll: -300.0);

        testLibrary.expect(await driver.getText(itemFinder), 'Item 50');
      });

      //Timeline 对象提供所有已发生事件的相关详细信息，但它不提供快捷方式查看结果。
      //因此，我们可以将 Timeline 转换成 TimelineSummary， TimelineSummary 通过执行两个任务可以使我们更容易的检查结果：
      //1)writeSummaryToFile: 将一个 json 文件写入磁盘，它包含了 Timeline 中包含的数据的摘要。此摘要包括掉帧数量，最慢构建时间等的信息。
      //2)writeTimelineToFile: 它可以将完整的 Timeline 以 json 文件的形式存储在磁盘上，可以使用 Chrome 浏览器的追踪工具打开此文件。追踪工具在这里: chrome://tracing。
      final summary = TimelineSummary.summarize(timeline);

      //在测试代码运行成功以后，在项目根目录下的 build 文件夹里包含以下两个文件：
      //scrolling_summary.timeline_summary.json 包含摘要。可以使用任何文本编辑器打开它并查看其中包含的信息。
      //通过更高级的设置，我们可以在每次测试时保存摘要并创建一个结果图。
      //scrolling_timeline.timeline.json 包含完整的时间轴数据。使用 Chorme 浏览器的追踪工具打开这个文件。
      //追踪工具在这里： chrome://tracing。追踪工具提供了一个便捷的用户界面，用以检测时间轴数据并发现其中导致性能问题的源头。
      summary.writeSummaryToFile('scrolling_summary', pretty: true);
      summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
