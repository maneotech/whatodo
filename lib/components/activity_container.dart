import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import '../constants/constant.dart';

class ActivityContainer extends StatefulWidget {
  final String title;
  final Color color;
  final String iconPath;
  final Function onTap;

  const ActivityContainer(
      {super.key,
      required this.title,
      required this.color,
      required this.iconPath,
      required this.onTap});

  @override
  State<ActivityContainer> createState() => _ActivityContainerState();
}

class _ActivityContainerState extends State<ActivityContainer> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTouchContainer(),
      child: getContent(),
    );

    /*Container(
        decoration: getGradientBackground(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Constants.activityTitleTextStyle,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: ImageIcon(AssetImage(widget.iconPath),
                    size: 32, color: Colors.white),
              )
            ],
          ),
        ),
      ),*/
  }

  onTouchContainer() {
    setState(() {
      isActive = !isActive;
    });
    widget.onTap();
  }

  Widget getContent() {
    if (isActive == false) {
      return getOutlineGradientButton(
        getChildContent(),
      );
    } else {
      return Container(
        decoration: getGradientBackground(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: getChildContent(),
        ),
      );
    }
  }

  Column getChildContent() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: isActive
                ? Constants.activityTitleTextStyle
                : Constants.normalBlackTextStyle,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ImageIcon(AssetImage(widget.iconPath),
                size: 32, color: isActive ? Colors.white : Colors.black),
          )
        ]);
  }

  OutlineGradientButton getOutlineGradientButton(Widget child) {
    double radius = 8.0;
    double stokeWidth = 1.0;
    LinearGradient gradient = const LinearGradient(
      colors: [Color(0xffFF693D), Color(0xffA25CFF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return OutlineGradientButton(
        radius: Radius.circular(radius),
        gradient: gradient,
        strokeWidth: stokeWidth,
        child: child);
  }

  getGradientBackground() {
    BoxDecoration kGradientBoxDecoration;
    if (isActive == false) {
      kGradientBoxDecoration = BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xffA25CFF), Color(0xffFF693D)]),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white);
    } else {
      kGradientBoxDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: widget.color);
    }

    return kGradientBoxDecoration;
  }
}
