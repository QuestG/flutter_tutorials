//创建和初始化 VideoPlayerController 时，请遵循以下步骤：
//1）创建一个 StatefulWidget 组件和 State 类
//2）在 State 类中增加一个变量来存放 VideoPlayerController
//3）在 State 类中增加另外一个变量来存放 VideoPlayerController.initialize 返回的 Future
//4）在 initState 方法里创建和初始化控制器
//5）在 dispose 方法里销毁控制器
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplayScreen extends StatefulWidget {
  @override
  _VideoDisplayScreenState createState() => _VideoDisplayScreenState();
}

class _VideoDisplayScreenState extends State<VideoDisplayScreen> {
  VideoPlayerController _controller;
  Future<void> _initialVideoFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _initialVideoFuture = _controller.initialize();
    _controller.setLooping(true);
    super.initState();
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
        title: Text('Video Player'),
      ),
      body: FutureBuilder(
          future: _initialVideoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //VideoPlayer 组件嵌进一个 AspectRatio 组件中，保证视频播放保持正确的比例.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
