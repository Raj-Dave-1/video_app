// 🚩 Dada Ki Jay Ho 🚩

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    const MaterialApp(
      title: "My Video App",
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VideoPlayerController _videoController;
  List<String> images = ["sea.jpg", "sunrise.jpg", "tree.jpg"];

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/MyDemoVideo.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 4 / 5,
          enableInfiniteScroll: false,
          clipBehavior: Clip.antiAlias,
          onPageChanged: (index, reason) {
            if (index != 0 && _videoController.value.isPlaying) {
              _videoController.pause();
            } else if (_videoController.value.isPlaying == false &&
                index == 0) {
              _videoController.play();
            }
          },
        ),
        items: [
          // Don't know why but Video was flickring hence, i used ClipRect
          ClipRect(child: VideoPlayer(_videoController)),
          ...(List.generate(
            images.length,
            (index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: Colors.amber),
                child: Image.asset(
                  "assets/images/${images[index]}",
                  fit: BoxFit.cover,
                ),
              );
            },
          ).toList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _videoController.value.isPlaying
                ? _videoController.pause()
                : _videoController.play();
          });
        },
        child: Icon(
          _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
