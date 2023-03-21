import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:whatodo/screens/place_result.dart';

import '../constants/constant.dart';
import 'package:audioplayers/audioplayers.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    loadingData(context);
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Constants.openingImage),
              fit: BoxFit.cover,
            ),
          ),
          child:
              getSpinner() /*SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getSpinner(),
                getSpinner(),
              ],
            )),*/
          ),
    );
  }

  loadingData(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    playSound();
    await Future.delayed(const Duration(milliseconds: 2500), () {});

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PlaceResultScreen()),
      );
    }
  }

  playSound() {
    AudioPlayer audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    Source url = UrlSource(Constants.successSound);
    audioPlayer.play(url);
  }

  getSpinner() {
    return const SpinKitRipple(
      color: Constants.primaryColor,
      size: 400.0,
    );
  }

  /*getSpinner() {
    return SpinKitCubeGrid(
      size: 50.0,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index % 3 == 0 ? Constants.secondaryColor : index % 2 == 0 ? Constants.primaryColor : Colors.green,
          ),
        );
      },
    );
  }*/
}
