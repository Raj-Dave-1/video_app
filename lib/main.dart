
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_app/constants/utils.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Make it personal",
      theme: ThemeData(useMaterial3: true),
      home: const MyApp(),
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
        setState(() {
          _videoController.play();
        });
      });
    _videoController.setLooping(true);
  }

  int currentIndex = 0;
  double currentValue = 0;
  double gauss = 1;

  @override
  Widget build(BuildContext context) {
    // size will be used to set the size of Container for Title and Text
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // AppBar with Make it Personal Title
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            "Make it personal",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              // aspectRation is set to 4/5 so that video and images can have same width and height
              aspectRatio: 4 / 5,
              enableInfiniteScroll: false,
              clipBehavior: Clip.antiAlias,
              onScrolled: (value) {
                currentValue = value!;
                //  Gaussian Value is used here to achieve the desired animation
                gauss = 1 -
                    math.exp(-(math.pow(
                            ((currentIndex - currentValue).abs() - 0.5), 2) /
                        0.08));
                setState(() {});
              },
              onPageChanged: (index, reason) {
                // if we are not at 0'th page and video is playing, then we should pause it
                if (index != 0 && _videoController.value.isPlaying) {
                  _videoController.pause();
                } else if (_videoController.value.isPlaying == false &&
                    index == 0) {
                  _videoController.play();
                }
                currentIndex = index;
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
          VSpace.lg,
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ...(List.generate(
                  images.length + 1,
                  (index) {
                    return Align(
                      // Align Widget is used to set the Alignment animation (Top to Down and Down to Top)
                      alignment: Alignment(0, -1 * gauss),
                      // when the currentIndex == index then Opacity should be 1 otherwise it should be 0
                      child: Opacity(
                        opacity: currentIndex != index ? 0 : gauss,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 36.0),
                          child: Column(
                            // mainAxisSize should be minimum otherwise you will not be able to see the Align Animation
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titleList[index],
                                style: const TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.w300),
                              ),
                              VSpace.sm,
                              Text(
                                textList[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
