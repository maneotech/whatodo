import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../services/toast.dart';

class AdTimer extends StatefulWidget {
  final Function endCallback;

  const AdTimer({super.key, required this.endCallback});

  @override
  State<AdTimer> createState() => _AdTimerState();
}

class _AdTimerState extends State<AdTimer> {
  late Timer _timer;
  int _timeRemaining = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTimer();
  }

  @override
  void dispose() {
    _timer.cancel();

    if (_timeRemaining > 1) {
      ToastService.showError(
          "Il faut regarder la vidéo en entière pour bénéficier d'un jeton gratuit");
    }

    super.dispose();
  }

  setTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeRemaining <= 0) {
          widget.endCallback();
        } else {
          setState(() {
            _timeRemaining -= 1;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey,
      ),
      child: Text(_timeRemaining.toString(),
          style: Constants.activityHeaderTextStyle),
    );
  }
}
