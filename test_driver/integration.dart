import 'package:flutter_driver/driver_extension.dart';
import 'package:tutorials/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  // Call the `main()` function of the app or call `runApp` with
  // any widget you are interested in testing.
  //这里由于official_tutorials包含的内容很多，这是直接使用app.main是不对的。
  app.main();
}
