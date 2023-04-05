import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:whatodo/components/ad_timer.dart';
import 'package:whatodo/models/ad.video.model.dart';
import 'package:whatodo/providers/locale.dart';
import 'package:whatodo/screens/home.dart';
import 'package:whatodo/services/base_api.dart';
import 'package:whatodo/services/toast.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../constants/constant.dart';
import '../providers/user.dart';

class AdVideoPlayer extends StatefulWidget {
  const AdVideoPlayer({super.key});

  @override
  State<AdVideoPlayer> createState() => _AdVideoPlayerState();
}

class _AdVideoPlayerState extends State<AdVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Future<AdVideoDocument?> _futureVideo;

  @override
  void initState() {
    super.initState();

    _futureVideo = getVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<AdVideoDocument?>(
        future: _futureVideo,
        builder:
            (BuildContext context, AsyncSnapshot<AdVideoDocument?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final url = snapshot.data!.adContent.urlSrc.toString();
            const sample =
                "https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4";
            setPlayer(sample);
            return getContainer(
                snapshot.data!.id, snapshot.data!.adContent.redirectTo);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<AdVideoDocument?> getVideo() async {
    String platform = "web";
    if (!kIsWeb) {
      platform = Platform.isIOS ? 'ios' : 'android';
    }
    String lang =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    final response = await BaseAPI.startVideo(platform, lang);
    if (response.statusCode == 200) {
      return AdVideoDocument.fromReqBody(response.body);
    } else {
      ToastService.showError("Une erreur est survenue, merci de réessayer");
      if (mounted) {
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      }
      return null;
    }
  }

  setPlayer(String urlSrc) {
    _controller = VideoPlayerController.asset(urlSrc);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
  }

  stopPub(String docId) async {
    final res = await BaseAPI.endVideo(docId);
    if (res.statusCode == 200) {
      if (mounted) {
        await Provider.of<UserProvider>(context, listen: false).earnOneToken();
        await Provider.of<UserProvider>(context, listen: false).setGetHomeResponse(false);

      } else {
        ToastService.showError("Une erreur est survenue. Merci de réessayer");
      }
    } else {
      ToastService.showError("Une erreur est survenue. Merci de réessayer");
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  clickVideo(String docId, String redirectTo) async {
    await BaseAPI.clickVideo(docId);
    if (await canLaunchUrl(Uri.parse(redirectTo))) {
      await launchUrl(Uri.parse(redirectTo));
    }
  }

  Stack getContainer(String docId, String redirectTo) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => clickVideo(docId, redirectTo),
          child: AbsorbPointer(
            child: getContent(docId, redirectTo),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: AdTimer(
            endCallback: () => stopPub(docId),
          ),
        ),
      ],
    );
  }

  FutureBuilder getContent(String docId, String redirectTo) {
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
