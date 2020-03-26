import 'package:flutter/material.dart';
import 'package:tutorials/testing/flutter_driver_sample.dart';

///integration test并不会和待测应用运行在同一个进程内。因此，我们需要同一个文件夹下创建两份文件。
///为了方便，把文件夹命名为 test_driver。
///第一个文件包含了应用的 “待检测” 版本号。这个检测允许我们利用测试套件驱动应用并记录运行概况。这个文件可以被命名成任何名字。
///第二个文件包含了测试套件，用于驱动应用程序并验证应用的运行状况是否与预期一致。测试套件也可以记录运行概况。
///这个测试文件的命名有严格要求，必须是待测应用的名称并在名称尾部加上 _test。

///集成测试 测试一个完整的应用或者一个应用的大部分功能。集成测试的目标是验证正在测试的所有 widget 和服务是否按照预期的方式一起工作。
///此外，还可以使用集成测试来验证应用的性能。
///通常情况下，一个 集成测试 运行在真机或 OS 模拟器上，如 iOS 模拟器 (iOS Simulator) 或 Android 模拟器 (Android Emulator) 。
///测试中的应用通常与测试驱动程序代码隔离，以避免结果出现偏差。
///
/// 编写测试文件包含了四个步骤：
///1）创建 SerializableFinders 定位指定组件
///2）在 setUpAll() 函数中运行测试案例前，先与待测应用建立连接
///3）测试重要场景
///4）完成测试后，在 teardownAll() 函数中与待测应用断开连接

class NaviTesting extends StatelessWidget {
  var titles = ['集成测试：滚动列表的测试用例', 'Video'];

  var widgets = [FlutterDriverSample()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${titles[index]}'),
              onTap: () {
                if (index >= widgets.length) {
                  Navigator.pushNamed(context, '/${titles[index]}',
                      arguments: true);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return widgets[index];
                  }));
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              color: Colors.grey,
            );
          },
          itemCount: titles.length),
    );
  }
}
