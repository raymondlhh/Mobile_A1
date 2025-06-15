import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/login_success.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setVolume(1.0); // 确保有声音
        _controller.play();
      });
    // 12秒后自动跳转
    Future.delayed(const Duration(seconds: 12), () {
      if (mounted) {
        _controller.pause();
        Navigator.pushReplacementNamed(context, '/bottomNav');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child:
                _controller.value.isInitialized
                    ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                    : const CircularProgressIndicator(),
          ),
          // Skip按钮
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                _controller.pause();
                Navigator.pushReplacementNamed(context, '/bottomNav');
              },
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
