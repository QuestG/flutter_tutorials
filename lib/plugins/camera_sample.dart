import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//在选择了一个相机后，你需要创建并初始化 CameraController。在这个过程中，与设备相机建立了连接并允许你控制相机并展示相机的预览帧流。
//实现这个过程，请依照以下步骤：
//1)创建一个带有 State 类的 StatefulWidget 组件
//2)添加一个变量到 State 类来存放 CameraController
//3)添加另外一个变量到 State 类中来存放 CameraController.initialize() 返回的 Future
//4)在 initState() 方法中创建并初始化控制器
//5)在 dispose() 方法中销毁控制器

class TakePicScreen extends StatefulWidget {
  @override
  _TakePicScreenState createState() => _TakePicScreenState();
}

class _TakePicScreenState extends State<TakePicScreen> {
  //如果没有初始化 CameraController，就不能使用相机预览和拍照
  CameraController _controller;
  Future<Void> _initialControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future _initCamera() async {
    //确保plugin已被初始化
    WidgetsFlutterBinding.ensureInitialized();

    //获取可用摄像头
    var cameras = await availableCameras();
    var firstCamera = cameras.first;
    //创建并初始化CameraController
    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    _initialControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('take a pic'),
      ),
      body: FutureBuilder<void>(builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _initialControllerFuture;
          var path = join(
              (await getTemporaryDirectory()).path, '${DateTime.now()}.png');
          //拍照
          await _controller.takePicture(path);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DisplayPicScreen(path)));
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPicScreen extends StatelessWidget {
  final String imagePath;

  DisplayPicScreen(this.imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display picture screen'),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
