import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatodo/screens/home.dart';
import 'package:whatodo/services/toast.dart';

import '../constants/constant.dart';

class AdVideoPlayer extends StatefulWidget {
  const AdVideoPlayer({super.key});

  @override
  State<AdVideoPlayer> createState() => _AdVideoPlayerState();
}

class _AdVideoPlayerState extends State<AdVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _timer;

  int _timeRemaining = 30;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      Constants.sampleVideo,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);

    setTimer();
  }

  setTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeRemaining <= 0) {
          stopPub();
        } else {
          setState(() {
            _timeRemaining -= 1;
          });
        }
      },
    );
  }

  stopPub() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    _timer.cancel();
    
    if (_timeRemaining > 1){
      ToastService.showError("Il faut regarder la vidéo en entière pour bénéficier d'un jeton gratuit");
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          getContent(),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),

                color: Colors.grey,
              ),
              child: Text(_timeRemaining.toString(),
                  style: Constants.activityHeaderTextStyle),
            ),
          )
        ],
      ),
    );
  }

  FutureBuilder getContent() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          _controller.play();
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Use the VideoPlayer widget to display the video.
            child: VideoPlayer(_controller),
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
