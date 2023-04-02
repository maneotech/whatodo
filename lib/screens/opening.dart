import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:whatodo/providers/user.dart';
import 'package:whatodo/screens/place_result.dart';
import 'package:whatodo/services/toast.dart';

import '../constants/constant.dart';
import 'package:audioplayers/audioplayers.dart';

import '../models/request_place.dart';
import '../models/result_place.dart';
import '../providers/auth.dart';
import '../services/base_api.dart';

class OpeningScreen extends StatefulWidget {
  final RequestPlace requestPlace;

  const OpeningScreen({super.key, required this.requestPlace});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  late Timer _timer;
  ResultPlaceModel? _resultPlaceModel;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
    const int timeBeforeSound = 500;
    await Future.delayed(const Duration(milliseconds: timeBeforeSound), () {});
    playSound();
    // during play sound, start Timer and then call API Request

    // if Timer is over and also API Request is done, then forward data to next page
    const int minimumTimeToWait = 2500;
    const oneSec = Duration(milliseconds: 500);
    int start = 0;

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == minimumTimeToWait) {
          if (_resultPlaceModel != null) {
            timer.cancel();
            goToPlaceResultScreen(_resultPlaceModel!);
          }
        } else {
          start += 500;
        }
      },
    );

    var res = await BaseAPI.getRequestedPlace(widget.requestPlace);
    if (res.statusCode == 200) {
      //if not error
      if (mounted) {
        await Provider.of<UserProvider>(context, listen: false).spendOneToken();
      }

      _resultPlaceModel = ResultPlaceModel.fromReqBody(res.body);
      if (_timer.isActive == false && _resultPlaceModel != null) {
        goToPlaceResultScreen(_resultPlaceModel!);
      }
    } else {
      ToastService.showError(
          "Une erreur est survenue. Votre token n'a pas été débité. Merci de réessayer");

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  playSound() {
    AudioPlayer audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    Source url = UrlSource(Constants.successSound);
    audioPlayer.play(url);
  }

  goToPlaceResultScreen(ResultPlaceModel resultPlaceModel) {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PlaceResultScreen(resultPlaceModel: resultPlaceModel),
        ),
      );
    }
  }

  getSpinner() {
    return const SpinKitRipple(
      color: Constants.primaryColor,
      size: 400.0,
    );
  }
}
